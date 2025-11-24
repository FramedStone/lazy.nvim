return {
	{
		"williamboman/mason.nvim",
		event = "VeryLazy",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer",
		event = "VeryLazy",
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					-- LSPs
					"lua_ls",
					"ts_ls",
					"sqlls",
					"jdtls",
					"marksman",
					"yamlls",
					"taplo",
					"dockerls",
					-- Linters and Formatters
					"eslint",
					"prettier",
					"checkstyle",
					"google-java-format",
					"luacheck",
					"stylua",
					"markdownlint",
				},
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		event = "VeryLazy",
		config = function()
			require("mason-lspconfig").setup({
				automatic_enable = true,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = "VeryLazy",
		dependencies = { "williamboman/mason-lspconfig.nvim", "Saghen/blink.cmp" },
		config = function()
			-- LSP on_attach function
			local on_attach = function(client, bufnr)
				-- Format on save
				if client.server_capabilities.documentFormattingProvider then
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ bufnr = bufnr })
						end,
					})
				end
			end

			-- LSP capabilities
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			-- Configure LSP servers
			vim.lsp.config("lua_ls", {
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
						},
					},
				},
			})
			vim.lsp.config("ts_ls", {
				on_attach = on_attach,
				capabilities = capabilities,
			})
			vim.lsp.config("sqlls", {
				on_attach = on_attach,
				capabilities = capabilities,
			})
			vim.lsp.config("jdtls", {
				on_attach = on_attach,
				capabilities = capabilities,
			})
			vim.lsp.config("marksman", {
				on_attach = on_attach,
				capabilities = capabilities,
			})
			vim.lsp.config("yamlls", {
				on_attach = on_attach,
				capabilities = capabilities,
			})
			vim.lsp.config("taplo", {
				on_attach = on_attach,
				capabilities = capabilities,
			})
			vim.lsp.config("dockerls", {
				on_attach = on_attach,
				capabilities = capabilities,
			})
		end,
	},
}
