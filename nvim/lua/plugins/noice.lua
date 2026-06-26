return {
  {
    "folke/noice.nvim",
    opts = {
      cmdline = {
        enabled = true,
        view = "cmdline_popup",
        format = {
          cmdline     = { icon = ">", title = "" },
          search_down = { icon = "/", title = "" },
          search_up   = { icon = "?", title = "" },
          filter      = { icon = "$", title = "" },
          lua         = { icon = "=", title = "" },
          help        = { icon = "?", title = "" },
        },
      },
      views = {
        cmdline_popup = {
          position = { row = "30%", col = "50%" },
          size = { width = 60, min_width = 40, height = "auto" },
          border = { style = "single", padding = { 0, 1 } },
          win_options = {
            winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
          },
        },
      },
      popupmenu = {
        enabled = true,
        backend = "nui",
      },
    },
  },
}
