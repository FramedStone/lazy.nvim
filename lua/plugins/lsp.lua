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
					"eslint",
					"prettier",
					"checkstyle",
					"google-java-format",
					"luacheck",
					"stylua",
					"markdownlint",
					-- Java
					"java-debug-adapter",
					"java-test",
				},
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				-- Automatically install servers configured via vim.lsp.config
				-- except for jdtls which we manage manually via ftplugin
				automatic_installation = {
					exclude = { "jdtls" },
				},
			})
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
			vim.lsp.enable({ "lua_ls", "ts_ls", "sqlls", "marksman", "yamlls", "taplo", "dockerls" })
		end,
	},
	{ "mfussenegger/nvim-jdtls" },
	{
		"mfussenegger/nvim-dap",
		config = function()
			-- DAP configuration will be set up in jdtls_setup.lua
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		config = function()
			local dap, dapui = require("dap"), require("dapui")
			dapui.setup()

			-- Auto-open/close dapui when debugging starts/ends
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				-- dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				-- dapui.close()
			end

			-- custom configuration
			dap.configurations.java = {
				{
					name = "Debug Launch (2GB)",
					type = "java",
					request = "launch",
					vmArgs = "" .. "-Xmx2g ",
				},
				{
					name = "Debug Attach (8000)",
					type = "java",
					request = "launch",
					hostName = "127.0.0.1",
					port = 8000,
				},
			}
		end,
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		dependencies = { "mfussenegger/nvim-dap" },
		config = function()
			require("nvim-dap-virtual-text").setup()
		end,
	},
}
