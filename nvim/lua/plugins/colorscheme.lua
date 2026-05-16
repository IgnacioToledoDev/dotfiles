return {
  {
    "Shatur/neovim-ayu",
    name = "ayu",
    priority = 1000,
    opts = function()
      local ayu = require("ayu")
      ayu.setup({
        mirage = false,
        terminal = true,
        overrides = {
          Normal = { bg = "#0D1017" },
          NormalNC = { bg = "#0D1017" },
        },
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "ayu-dark",
    },
  },
}
