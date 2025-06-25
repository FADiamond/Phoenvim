return {
  "wa11breaker/flutter-bloc.nvim",
  dependencies = {
    "nvimtools/none-ls.nvim", -- Required for code actions
  },
  config = function()
    require("flutter-bloc").setup({
      bloc_type = "default", -- Choose from: 'default', 'equatable', 'freezed'
      use_sealed_classes = false,
      enable_code_actions = true,
    })

    -- Create BLoC quickly
    vim.keymap.set("n", "<Leader>fcb", "<cmd>lua require('flutter-bloc').create_bloc()<cr>", {
      desc = "[F]lutter [C]reate [B]loc",
    })

    -- Create Cubit quickly
    vim.keymap.set("n", "<Leader>fcc", "<cmd>lua require('flutter-bloc').create_cubit()<cr>", {
      desc = "[F]lutter [C]reate [C]ubit",
    })
  end,
}
