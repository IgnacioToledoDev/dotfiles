return {
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    keys = {
      { "<leader>on", "<cmd>ObsidianNew<cr>", desc = "New note" },
      { "<leader>oo", "<cmd>ObsidianQuickSwitch<cr>", desc = "Quick switch" },
      { "<leader>os", "<cmd>ObsidianSearch<cr>", desc = "Search vault" },
      { "<leader>ot", "<cmd>ObsidianToday<cr>", desc = "Today's note" },
      { "<leader>ob", "<cmd>ObsidianBacklinks<cr>", desc = "Backlinks" },
      { "<leader>or", "<cmd>ObsidianRename<cr>", desc = "Rename note" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-mini/mini.pick",
    },
    opts = {
      workspaces = {
        {
          name = "nova",
          path = "~/Documents/nova",
        },
      },
      notes_subdir = "notas",
      new_notes_location = "notes_subdir",
      picker = {
        name = "mini",
      },
      completion = {
        nvim_cmp = false,
        min_chars = 2,
      },
      mappings = {
        ["gf"] = {
          action = function()
            return require("obsidian").util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
        ["<leader>ch"] = {
          action = function()
            return require("obsidian").util.toggle_checkbox()
          end,
          opts = { buffer = true },
        },
        ["<cr>"] = {
          action = function()
            return require("obsidian").util.smart_action()
          end,
          opts = { buffer = true, expr = true },
        },
      },
      ui = {
        enable = true,
        checkboxes = {
          [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
          ["x"] = { char = "", hl_group = "ObsidianDone" },
        },
      },
    },
  },
}
