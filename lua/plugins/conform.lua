return {
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					javascript = { "prettier", "eslint" },
					typescript = { "prettier", "eslint" },
					javascriptreact = { "prettier", "eslint" },
					typescriptreact = { "prettier", "eslint" },
					css = { "prettier" },
					html = { "prettier" },
					json = { "prettier" },
					yaml = { "prettier" },
					markdown = { "prettier" },
					lua = { "stylua" },
					java = { "google-java-format" },
					sql = { "sql-formatter" },
					dockerfile = { "dockerfmt" },
					toml = { "taplo" },
				},
				format_on_save = {
					timeout_ms = 500,
					lsp_format = "fallback",
				},
			})
		end,
	},
}