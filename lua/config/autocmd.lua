-- Autocommands

-- Disable automatic comment continuation for all filetypes
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function()
		vim.opt_local.formatoptions:remove("c")
		vim.opt_local.formatoptions:remove("r")
		vim.opt_local.formatoptions:remove("o")
	end,
})

-- jdtls
vim.api.nvim_create_autocmd("FileType", {
	pattern = "java",
	callback = function(args)
		require("jdtls.jdtls_setup").setup()
	end,
})
