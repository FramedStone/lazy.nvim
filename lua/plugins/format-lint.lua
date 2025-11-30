return {
	-- Formatter
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					javascript = { "prettierd", "eslint_d" },
					typescript = { "prettierd", "eslint_d" },
					javascriptreact = { "prettierd", "eslint_d" },
					typescriptreact = { "prettierd", "eslint_d" },
					css = { "prettierd" },
					html = { "prettierd" },
					json = { "prettierd" },
					yaml = { "prettierd" },
					markdown = { "prettierd" },
					lua = { "stylua" },
					java = { "jdtls", "google-java-format" },
					sql = { "sql-formatter" },
					dockerfile = { "dockerfmt" },
					toml = { "taplo" },
				},
				format_on_save = {
					timeout_ms = 500,
					lsp_format = "fallback",
				},
				-- Configure prettierd with default options (used when no project config exists)
				formatters = {
					prettierd = {
						prepend_args = { "--single-quote", "--semi" },
					},
				},
			})
		end,
	},

	-- Linter
	{
		"mfussenegger/nvim-lint",
		event = {
			"BufReadPre",
			"BufNewFile",
		},
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				-- JavaScript/TypeScript (matches your prettierd + eslint_d setup)
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
				javascriptreact = { "eslint_d" },
				typescriptreact = { "eslint_d" },

				-- Java - complementary to JDTLS LSP for Spring Boot
				java = { "checkstyle" },

				-- Lua (matches your stylua setup)
				lua = { "luacheck" },

				-- YAML (matches your prettierd setup)
				yaml = { "yamllint" },

				-- Dockerfile (matches your dockerfmt setup)
				dockerfile = { "hadolint" },

				-- Uncomment these after installing the linters:
				-- markdown = { "markdownlint" },  -- npm install -g markdownlint-cli
				-- sql = { "sqlfluff" },            -- sudo pacman -S sqlfluff
				-- json = { "jsonlint" },           -- npm install -g jsonlint
				-- css = { "stylelint" },           -- npm install -g stylelint
				-- html = { "htmlhint" },           -- npm install -g htmlhint
			}

			-- Set up autocommand to trigger linting
			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},
}
