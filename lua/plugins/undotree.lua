return {
  "mbbill/undotree",
  event = "VeryLazy",
  config = function()
    vim.keymap.set("n", "<leader>ut", "<cmd>UndotreeToggle<cr>", { desc = "Toggle Undotree" })
  end,
}