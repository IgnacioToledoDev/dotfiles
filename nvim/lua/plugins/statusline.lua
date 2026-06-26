return {
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        theme = "ayu_dark",
        section_separators = "",
        component_separators = "│",
        globalstatus = true,
      },
      sections = {
        lualine_a = {
          {
            "mode",
            fmt = function(s)
              local c = vim.fn.nr2char
              local icons = {
                NORMAL      = c(0xF015) .. " N",  -- home
                INSERT      = c(0xF040) .. " I",  -- pencil
                VISUAL      = c(0xF06E) .. " V",  -- eye
                ["V-LINE"]  = c(0xF06E) .. " VL",
                ["V-BLOCK"] = c(0xF06E) .. " VB",
                TERMINAL    = c(0xF120) .. " T",  -- terminal
                COMMAND     = c(0xF054) .. " C",  -- chevron-right
                REPLACE     = c(0xF021) .. " R",  -- refresh
              }
              return icons[s] or s:sub(1, 1)
            end,
          },
        },
        lualine_b = { "branch" },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "diagnostics" },
        lualine_y = { "filetype" },
        lualine_z = { "location" },
      },
    },
  },
}
