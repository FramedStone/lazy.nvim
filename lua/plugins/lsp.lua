return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({})
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer",
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
					"eslint_d",
					"prettierd",
					"checkstyle",
					"google-java-format",
					"luacheck",
					"stylua",
					"markdownlint",
					-- Java
					"java-debug-adapter",
					"java-test",
					"graphql-language-service-cli",
				},
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			-- Set global capabilities for ALL servers using the special "*" name
			vim.lsp.config("*", {
				capabilities = require("blink.cmp").get_lsp_capabilities(),
			})

			-- Only configure servers that need custom settings
			vim.lsp.config("lua_ls", {
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

			-- Enable all LSP servers (can pass a table to enable multiple at once)
			-- Note: jdtls is managed separately by ftplugin/java.lua using nvim-jdtls
			vim.lsp.enable({ "lua_ls", "ts_ls", "sqlls", "marksman", "yamlls", "taplo", "dockerls", "graphql" })
		end,
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"mfussenegger/nvim-jdtls",
			"igorlfs/nvim-dap-view",
			"theHamsta/nvim-dap-virtual-text",
		},
		config = function()
			require("nvim-dap-virtual-text").setup()

			local dap = require("dap")

			-- Configure terminal for integrated terminal output
			-- Following nvim-dap documentation for terminal configuration
			dap.defaults.fallback.terminal_win_cmd = "belowright new"
			dap.defaults.fallback.focus_terminal = true

			-- Setup dap-view to show debugger UI
			require("dap-view").setup()
			-- See `:help dap-configuration` for more information
		end,
	},
}
