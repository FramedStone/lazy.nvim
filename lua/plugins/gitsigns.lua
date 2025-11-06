return {
  "lewis6991/gitsigns.nvim",
  event = "VeryLazy",
  dependencies = {
    "folke/which-key.nvim",
  },
  config = function()
    require("gitsigns").setup({
      on_attach = function(bufnr)
        -- No keymaps defined
      end
    })
  end,
}
