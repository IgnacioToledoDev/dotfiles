# Dadbod SSH Connections Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace nvim-dbee with a vim-dadbod-ui setup that reads server configs from JSON, fetches passwords from 1Password (fallback: `.db-secrets.json`), and opens SSH tunnels on demand via a snacks/vim.ui.select picker.

**Architecture:** A single `lua/plugins/dadbod.lua` overrides the LazyVim sql extra's dadbod-ui spec and adds the connection logic (JSON reader, password resolver, SSH tunnel manager, picker). Non-sensitive server metadata lives in `db-connections.json` (commitable). Passwords live in 1Password (via `op read`) with fallback to `.db-secrets.json` (gitignored). One active SSH tunnel at a time on port 5433.

**Tech Stack:** Neovim Lua, vim-dadbod-ui (already installed via LazyVim sql extra), 1Password CLI (`op`), OpenSSH, `vim.fn.jobstart`, `vim.ui.select`

---

## File Map

| File | Action | Purpose |
|---|---|---|
| `~/.config/nvim/lua/plugins/dbee.lua` | Delete | Remove nvim-dbee |
| `~/.config/nvim/lua/plugins/dadbod.lua` | Create | Plugin spec + all connection logic |
| `~/.config/nvim/db-connections.json` | Create | Public server metadata (no passwords) |
| `~/.config/nvim/.db-secrets.json` | Create | Local password fallback (gitignored) |
| dotfiles `.gitignore` | Modify | Add `.db-secrets.json` |

---

### Task 1: Remove nvim-dbee

**Files:**
- Delete: `~/.config/nvim/lua/plugins/dbee.lua`

- [ ] **Step 1: Delete the file**

```bash
rm ~/.config/nvim/lua/plugins/dbee.lua
```

- [ ] **Step 2: Verify removed from Neovim**

Open Neovim and run `:Lazy`. Confirm `nvim-dbee` is no longer in the spec (it will still appear in the lockfile as installed — that's OK for now, `Lazy clean` will remove it).

- [ ] **Step 3: Run Lazy clean**

In Neovim: `:Lazy clean` → confirm removal of `nvim-dbee` and `nui.nvim` (if not used by other plugins — check first).

> Note: `nui.nvim` is also a dependency of `noice.nvim`. Do NOT remove it if noice is active.

---

### Task 2: Create db-connections.json

**Files:**
- Create: `~/.config/nvim/db-connections.json`

- [ ] **Step 1: Create the file**

```bash
cat > ~/.config/nvim/db-connections.json << 'EOF'
{
  "servers": [
    {
      "name": "prod",
      "ssh_host": "45.55.23.110",
      "ssh_port": "22",
      "ssh_user": "deploy",
      "ssh_key": "~/.ssh/prod_key.pem",
      "db_type": "postgresql",
      "db_name": "mydb",
      "db_user": "admin",
      "db_port": "5432",
      "op_ref": "op://Private/prod-db/password"
    },
    {
      "name": "local",
      "db_type": "postgresql",
      "db_name": "myapp_dev",
      "db_user": "postgres",
      "db_port": "5432",
      "op_ref": "op://Private/local-db/password"
    }
  ]
}
EOF
```

> `ssh_host` absent → direct connection (no tunnel). `ssh_key` absent → use SSH agent. `op_ref` is the 1Password secret reference path.

- [ ] **Step 2: Verify JSON is valid**

```bash
python3 -c "import json; json.load(open('/home/nocti/.config/nvim/db-connections.json')); print('OK')"
```

Expected: `OK`

---

### Task 3: Create .db-secrets.json and update gitignore

**Files:**
- Create: `~/.config/nvim/.db-secrets.json`
- Modify: dotfiles repo `.gitignore`

- [ ] **Step 1: Create secrets fallback file**

```bash
cat > ~/.config/nvim/.db-secrets.json << 'EOF'
{
  "prod": "your-prod-password-here",
  "local": "postgres"
}
EOF
```

Keys must match the `name` field in `db-connections.json`.

- [ ] **Step 2: Set restrictive permissions**

```bash
chmod 600 ~/.config/nvim/.db-secrets.json
```

- [ ] **Step 3: Add to dotfiles gitignore**

Find the dotfiles repo root and add the entry:

```bash
# Find the dotfiles repo that tracks nvim config
git -C ~/.config/nvim rev-parse --show-toplevel 2>/dev/null || echo "Check dotfiles repo location"
```

Then add to the appropriate `.gitignore`:

```
.db-secrets.json
```

- [ ] **Step 4: Verify file is ignored**

```bash
git -C ~/.config/nvim status --short
```

`.db-secrets.json` must NOT appear in the output.

---

### Task 4: Create dadbod.lua

**Files:**
- Create: `~/.config/nvim/lua/plugins/dadbod.lua`

- [ ] **Step 1: Create the file with full implementation**

```lua
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
  kill_tunnel(server.name)

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

  active_tunnels[server.name] = vim.fn.jobstart(args, {
    on_stderr = function(_, data)
      if data and data[1] ~= "" then
        vim.schedule(function()
          vim.notify("[dadbod] SSH: " .. table.concat(data, " "), vim.log.levels.WARN)
        end)
      end
    end,
  })

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
    open_dbui(server, "127.0.0.1", server.db_port, password)
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
```

- [ ] **Step 2: Verify Neovim loads without errors**

Open Neovim. Run `:checkhealth` or simply check that no startup errors appear. Run `:Lazy` and confirm `vim-dadbod-ui` and `vim-dadbod` are loaded without errors.

---

### Task 5: Verify end-to-end

- [ ] **Step 1: Test picker opens**

In Neovim, press `<leader>dc`. A `vim.ui.select` picker should appear listing servers from `db-connections.json`.

- [ ] **Step 2: Test direct connection (no SSH)**

Select the `local` server. Confirm:
- 1Password is tried first (or graceful fallback to `.db-secrets.json`)
- DBUI opens with `local` in the connection list
- No error notifications

- [ ] **Step 3: Test SSH tunnel connection**

Select the `prod` server. Confirm:
- "Opening SSH tunnel..." notification appears
- After ~600ms, DBUI opens
- Check tunnel is running: `ss -tlnp | grep 5433` (should show a listening port)

- [ ] **Step 4: Test cleanup on exit**

With a tunnel active, exit Neovim. Confirm the tunnel port is released:

```bash
ss -tlnp | grep 5433
```

Expected: no output (port freed).

- [ ] **Step 5: Test 1Password fallback**

Temporarily sign out of `op` (`op signout`), then trigger a connection. Confirm the WARN notification says "1Password failed" and falls back to `.db-secrets.json`.

---

## Limitations (v1)

- One active SSH tunnel at a time (port 5433). Selecting a second SSH server kills the first tunnel.
- No automatic reconnect if the SSH tunnel drops mid-session.
- `vim.ui.select` uses whatever picker is active (snacks, telescope, built-in). Appearance depends on user config.
