-- move line of codes
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("x", "p", '"_dP') -- doesn't copy the pasted line

-- find and replace for all strings within the file
vim.keymap.set("n", "<leader>s", ":%s///g<Left><Left><Left><Left>")

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

-- LSP keymaps (global)
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Goto Definition" })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "References", nowait = true })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP Rename" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Actions" })
vim.keymap.set("v", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Actions" })
vim.keymap.set("n", "gf", "<cmd>e <cfile><CR>", { desc = "Goto File" })
vim.keymap.set("n", "gF", "<cmd>e <cfile>:<cWORD><CR>", { desc = "Goto File at line" })

-- Java test keymaps (nvim-jdtls)
vim.keymap.set("n", "<leader>tc", function()
	require("jdtls").test_class()
end, { desc = "Test Class" })
vim.keymap.set("n", "<leader>tm", function()
	require("jdtls").test_nearest_method()
end, { desc = "Test Nearest Method" })
