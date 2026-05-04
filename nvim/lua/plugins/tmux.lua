return {
  "christoomey/vim-tmux-navigator",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
  },
  keys = {
    { "<ctrl-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Go to Left Window" },
    { "<ctrl-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Go to Lower Window" },
    { "<ctrl-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Go to Upper Window" },
    { "<ctrl-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Go to Right Window" },
    { "<ctrl-\\>", "<cmd>TmuxNavigatePrevious<cr>", desc = "Go to Previous Window" },
  },
}
