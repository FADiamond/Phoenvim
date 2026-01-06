return {
  {
    "rcasia/neotest-java",
    ft = "java",
    dependencies = {
      "mfussenegger/nvim-jdtls",
      "mfussenegger/nvim-dap", -- for the debugger
      "rcarriga/nvim-dap-ui", -- recommended
      "theHamsta/nvim-dap-virtual-text", -- recommended
    },
  },
 {
  "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-java")({
        }),
      },
    })
    local neotest = require("neotest")

    vim.keymap.set("n", "<leader>Tt", function() neotest.run.run() end, { desc = "Run nearest test" })
    vim.keymap.set("n", "<leader>Tf", function() neotest.run.run(vim.fn.expand("%")) end, { desc = "Run file tests" })
    vim.keymap.set("n", "<leader>Td", function() neotest.run.run({ strategy = "dap" }) end, { desc = "Debug nearest test" })
    vim.keymap.set("n", "<leader>Ts", function() neotest.summary.toggle() end, { desc = "Toggle summary" })
    vim.keymap.set("n", "<leader>Tp", function() neotest.output_panel.toggle() end, { desc = "Toggle output panel" })
    vim.keymap.set("n", "<leader>To", function() neotest.output.open({ enter = true }) end, { desc = "Open test output" })
    vim.keymap.set("n", "<leader>Tn", function() neotest.jump.next({ status = "failed" }) end, { desc = "Next failed test" })
    vim.keymap.set("n", "<leader>TN", function() neotest.jump.prev({ status = "failed" }) end, { desc = "Prev failed test" })
    vim.keymap.set("n", "<leader>TS", function() neotest.run.stop() end, { desc = "Stop test run" })
  end,
}
}
