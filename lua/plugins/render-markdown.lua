return {
  'MeanderingProgrammer/render-markdown.nvim',
  -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
  -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
  ---@module 'render-markdown'
  ---@type render.mdUserConfig
  opts = {},
  config = function()
    require("render-markdown").setup({
      checkbox = { 
        checked = { scope_highlight = '@markup.strikethrough' },
        -- position = 'overlay'
      },
      code = {
        style = 'normal',
        border = 'thick',
        position = 'right',
        width = 'block',
        right_pad = 10,
      },
      indent = {
        enabled = true,
        skip_heading = true,
      }
    })

  end
}

