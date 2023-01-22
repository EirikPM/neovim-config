return {
  {
    "github/copilot.vim",
    lazy = true,
  },

  {
    "folke/trouble.nvim",
    opts = { use_diagnostic_signs = true },
  },

  {
    "neovimhaskell/haskell-vim",
    lazy = true,
  },

  {
    "alx741/vim-hindent",
    enabled = true,
  },

  {
    "ThePrimeagen/harpoon",
    opts = function()
      local mark = require("harpoon.mark")
      local ui = require("harpoon.ui")

      vim.keymap.set("n", "<leader>a", mark.add_file)
      vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

      vim.keymap.set("n", "<C-h>", function()
        ui.nav_file(1)
      end)
      vim.keymap.set("n", "<C-t>", function()
        ui.nav_file(2)
      end)
      vim.keymap.set("n", "<C-n>", function()
        ui.nav_file(3)
      end)
      vim.keymap.set("n", "<C-s>", function()
        ui.nav_file(4)
      end)
    end,
  },
}
