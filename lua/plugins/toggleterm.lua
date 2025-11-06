return {
  "akinsho/toggleterm.nvim",
  event = "VeryLazy",
  config = function()
    require("toggleterm").setup({
      open_mapping = [[<c-/>]],
      direction = "float",
      float_opts = {
        border = "curved",
      },
    })
  end,
}