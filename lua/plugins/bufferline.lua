return {
  {
    "akinsho/bufferline.nvim",
    version = "*",                -- optional: or pin a specific version
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- for file icons
    },
    opts = {
      options = {
        -- Offset for neo-tree so bufferline doesn't overlap it
        offsets = {
          {
            filetype = "neo-tree",
            text = "File Explorer",
            highlight = "Directory",
            text_align = "left",
            separator = true,
          },
          {
            filetype = "dbui",
            text = "Dadbod UI",
            highlight = "Directory",
            text_align = "left",
            separator = true,
          },
        },
        -- Only show filenames (no paths)
        name_formatter = function(buf)
          return vim.fn.fnamemodify(buf.name, ":t")
        end,

        -- Example diagnostics config (shows error/warn icons)
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level)
          local icon = (level == "error" and " ") or " "
          return " " .. icon .. count
        end,

        -- Hide close icons if you prefer minimal look
        show_close_icon = false,
        show_buffer_close_icons = false,

        -- Style the separators, e.g., "slant", "padded_slant", "thin", etc.
        separator_style = "slant",

        -- Show bufferline even if only one buffer is open
        always_show_bufferline = true,
      },
    },
    config = function(_, opts)
      -- Set up bufferline with the above opts
      require("bufferline").setup(opts)

      -- Keymaps for buffer navigation
      vim.keymap.set("n", "<C-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
      vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })

      -- Keymap to close the current buffer
      vim.keymap.set("n", "<leader>bd", "<cmd>bd<CR>", { desc = "Close buffer" })
    end,
  },
}
