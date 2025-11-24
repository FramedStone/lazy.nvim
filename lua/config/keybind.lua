-- move line of codes
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("x", "p", '"_dP') -- doesn't copy the pasted line

-- find and replace for all strings within the file
vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

-- Toggle netrw function
local function toggle_netrw()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		if vim.api.nvim_buf_get_option(buf, "filetype") == "netrw" then
			vim.cmd("bdelete " .. buf)
			return
		end
	end
	vim.cmd("Explore")
end

-- Keymaps
vim.keymap.set("n", "<leader>bb", "<C-^>", { desc = "Go to last buffer" })
vim.keymap.set("n", "<leader>e", toggle_netrw, { desc = "Toggle file explorer" })
vim.keymap.set("n", "<leader>dh", ":nohl<CR>", { desc = "Clear search highlights" })

-- Diagnostic keymaps
vim.keymap.set("n", "<C-d>", vim.diagnostic.open_float, { desc = "Show diagnostic in floating window" })
vim.keymap.set("n", "D", function()
  -- Check if quickfix window is already open
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.api.nvim_buf_get_option(buf, "buftype") == "quickfix" then
      vim.cmd.cclose() -- Close quickfix window
      return
    end
  end

  -- If not open, show all diagnostics in a 3-line window
  local diagnostics = vim.diagnostic.get(0) -- Get all diagnostics for current buffer
  -- Convert to quickfix format and set quickfix list
  local qf_items = vim.diagnostic.toqflist(diagnostics)
  vim.fn.setqflist(qf_items)
  vim.cmd("copen 3") -- Open quickfix window with 3 lines height
end, { desc = "Toggle all diagnostics in 3-line quickfix window" })