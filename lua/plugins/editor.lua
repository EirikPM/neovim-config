return {
  -- { "neo-tree.nvim", enabled = false },
  { "ggandor/flit.nvim", enabled = false },
  {
    "folke/zen-mode.nvim",
    lazy = true,
    init = function()
      vim.keymap.set("n", "<leader>zz", function()
        require("zen-mode").toggle()
      end, { desc = "ZenMode" })
    end,
    opts = {
      window = {
        width = 0.85,
        options = {
          number = true,
          relativenumber = true,
        },
      },
    },
  },
}
