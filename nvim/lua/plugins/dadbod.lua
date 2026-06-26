-- lua/plugins/dadbod.lua
-- Overrides LazyVim sql extra dadbod-ui spec.
-- Adds SSH tunnel manager + 1Password/fallback credential resolver + server picker.

local TUNNEL_PORT = "5433"
local active_tunnels = {} -- { server_name = job_id }

-- Read and decode a JSON file. Returns nil if file missing or invalid.
local function read_json(path)
  local expanded = vim.fn.expand(path)
  local f = io.open(expanded, "r")
  if not f then return nil end
  local content = f:read("*a")
  f:close()
  local ok, decoded = pcall(vim.fn.json_decode, content)
  if not ok then return nil end
  return decoded
end

-- Fetch password from 1Password CLI. Returns password or nil + error string.
local function get_password_op(op_ref)
  if vim.fn.executable("op") == 0 then
    return nil, "op CLI not found in PATH"
  end
  local result = vim.fn.system({ "op", "read", op_ref })
  if vim.v.shell_error ~= 0 then
    return nil, vim.trim(result)
  end
  return vim.trim(result), nil
end

-- Fetch password from ~/.config/nvim/.db-secrets.json by server name.
local function get_password_secrets(server_name)
  local path = vim.fn.stdpath("config") .. "/.db-secrets.json"
  local secrets = read_json(path)
  if not secrets then return nil end
  return secrets[server_name]
end

-- Resolve password: try 1Password first, fall back to secrets file.
local function resolve_password(server)
  if server.op_ref then
    local pass, err = get_password_op(server.op_ref)
    if pass and pass ~= "" then return pass end
    vim.notify(
      "[dadbod] 1Password failed for " .. server.name .. ": " .. (err or "empty result") .. ". Trying .db-secrets.json.",
      vim.log.levels.WARN
    )
  end
  local pass = get_password_secrets(server.name)
  if pass then return pass end
  return nil
end

-- Kill an active SSH tunnel by server name.
local function kill_tunnel(name)
  if active_tunnels[name] then
    vim.fn.jobstop(active_tunnels[name])
    active_tunnels[name] = nil
  end
end

-- Start SSH tunnel for server, then call callback() after 600ms.
local function start_tunnel(server, callback)
  -- Kill all active tunnels — only one port (5433) is available.
  for name, _ in pairs(active_tunnels) do
    kill_tunnel(name)
  end

  local args = {
    "ssh", "-N",
    "-o", "StrictHostKeyChecking=accept-new",
    "-o", "ExitOnForwardFailure=yes",
    "-p", server.ssh_port or "22",
    "-L", TUNNEL_PORT .. ":127.0.0.1:" .. server.db_port,
  }

  if server.ssh_key then
    table.insert(args, "-i")
    table.insert(args, vim.fn.expand(server.ssh_key))
  end

  table.insert(args, server.ssh_user .. "@" .. server.ssh_host)

  local job_id = vim.fn.jobstart(args, {
    on_stderr = function(_, data)
      if data and data[1] ~= "" then
        vim.schedule(function()
          vim.notify("[dadbod] SSH: " .. table.concat(data, " "), vim.log.levels.WARN)
        end)
      end
    end,
  })

  if job_id <= 0 then
    vim.notify("[dadbod] Failed to start SSH tunnel (job_id=" .. job_id .. "). Is ssh in PATH?", vim.log.levels.ERROR)
    return
  end

  active_tunnels[server.name] = job_id
  vim.defer_fn(callback, 600)
end

-- Build dadbod URL and open DBUI for server.
local function open_dbui(server, host, port, password)
  local url = string.format(
    "%s://%s:%s@%s:%s/%s",
    server.db_type,
    server.db_user,
    password,
    host,
    port,
    server.db_name
  )

  local dbs = vim.g.dbs or {}
  if type(dbs) ~= "table" then dbs = {} end
  dbs[server.name] = url
  vim.g.dbs = dbs

  -- Close DBUI if open to force connection list refresh, then reopen.
  pcall(vim.cmd, "DBUIClose")
  vim.cmd("DBUI")
  vim.notify("[dadbod] Connected to " .. server.name, vim.log.levels.INFO)
end

-- Resolve password then connect (with or without SSH tunnel).
local function connect(server)
  local password = resolve_password(server)
  if not password then
    vim.notify(
      "[dadbod] No password found for " .. server.name .. ". Set op_ref or add to .db-secrets.json.",
      vim.log.levels.ERROR
    )
    return
  end

  if server.ssh_host then
    vim.notify("[dadbod] Opening SSH tunnel to " .. server.name .. "...", vim.log.levels.INFO)
    start_tunnel(server, function()
      open_dbui(server, "127.0.0.1", TUNNEL_PORT, password)
    end)
  else
    open_dbui(server, server.db_host or "127.0.0.1", server.db_port, password)
  end
end

-- Open picker to choose a server from db-connections.json.
local function pick_server()
  local config_path = vim.fn.stdpath("config") .. "/db-connections.json"
  local config = read_json(config_path)

  if not config or not config.servers or #config.servers == 0 then
    vim.notify("[dadbod] No servers found in " .. config_path, vim.log.levels.ERROR)
    return
  end

  vim.ui.select(config.servers, {
    prompt = "Connect to DB server:",
    format_item = function(s)
      local icon = s.ssh_host and "  " or "  "
      return icon .. s.name .. "  " .. s.db_type .. " / " .. s.db_name
    end,
  }, function(choice)
    if choice then
      connect(choice)
    end
  end)
end

return {
  -- Override dadbod-ui to add picker keymap.
  {
    "kristijanhusak/vim-dadbod-ui",
    keys = {
      { "<leader>dc", pick_server, desc = "DB Connect (picker)" },
    },
  },
  -- Attach VimLeavePre cleanup to vim-dadbod.
  {
    "tpope/vim-dadbod",
    init = function()
      vim.api.nvim_create_autocmd("VimLeavePre", {
        callback = function()
          for name, _ in pairs(active_tunnels) do
            kill_tunnel(name)
          end
        end,
      })
    end,
  },
}
