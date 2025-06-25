return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    input = { enabled = true },
    picker = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = {
      ---@class snacks.animate.Config
      animate = {
        -- duration = { step = 50, total = 250 },
        easing = "outCirc",
      }
    },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  },
  keys = {
      { "<leader>n",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
  }
}
