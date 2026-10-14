return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
  },

  -- LazyVim's stock LSP `g*` keymaps call vim.lsp.buf.* directly (no picker,
  -- jumps blind to the first match). Route them through fzf-lua instead so
  -- multiple candidates show in a fuzzy list. Same lhs as LazyVim defaults;
  -- `opts_extend` appends this array, last registration for a given lhs wins.
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ["*"] = {
          keys = {
            { "gd", function() require("fzf-lua").lsp_definitions() end, desc = "Goto Definition", has = "definition" },
            { "gD", function() require("fzf-lua").lsp_declarations() end, desc = "Goto Declaration", has = "declaration" },
            { "gr", function() require("fzf-lua").lsp_references() end, desc = "References", nowait = true },
            { "gI", function() require("fzf-lua").lsp_implementations() end, desc = "Goto Implementation" },
            { "gy", function() require("fzf-lua").lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
          },
        },
      },
    },
  },
}
