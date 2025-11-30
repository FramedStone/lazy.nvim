-- See `:help vim.lsp.start` for an overview of the supported `config` options.
local config = {
	name = "jdtls",

	-- `cmd` defines the executable to launch eclipse.jdt.ls.
	-- `jdtls` must be available in $PATH and you must have Python3.9 for this to work.
	--
	-- As alternative you could also avoid the `jdtls` wrapper and launch
	-- eclipse.jdt.ls via the `java` executable
	-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
	cmd = { "jdtls" },

	-- `root_dir` must point to the root of your project.
	-- See `:help vim.fs.root`
	-- For multi-module Maven projects, find the nearest pom.xml (module root)
	root_dir = vim.fs.root(0, { "gradlew", ".git", "mvnw" }),

	-- Here you can configure eclipse.jdt.ls specific settings
	-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
	-- for a list of options
	settings = {
		java = {
			signatureHelp = { enabled = true },
			contentProvider = { preferred = "fernflower" },
			completion = {
				favoriteStaticMembers = {
					"org.junit.jupiter.api.Assertions.*",
					"org.junit.jupiter.api.Assumptions.*",
					"org.mockito.Mockito.*",
				},
			},
		},
	},

	-- This sets the `initializationOptions` sent to the language server
	-- If you plan on using additional eclipse.jdt.ls plugins like java-debug
	-- you'll need to set the `bundles`
	--
	-- See https://codeberg.org/mfussenegger/nvim-jdtls#java-debug-installation
	-- See https://codeberg.org/mfussenegger/nvim-jdtls#vscode-java-test-installation
	--
	-- If you don't plan on any eclipse.jdt.ls plugins you can remove this
	init_options = {
		bundles = (function()
			local bundles = {
				vim.fn.glob(
					vim.fn.expand("~/.local/share/nvim/mason/share/java-debug-adapter")
						.. "/com.microsoft.java.debug.plugin-*.jar",
					1
				),
			}

			-- Add vscode-java-test bundles
			local java_test_bundles =
				vim.split(vim.fn.glob(vim.fn.expand("~/.local/share/nvim/mason/share/java-test") .. "/*.jar", 1), "\n")
			local excluded = {
				"com.microsoft.java.test.runner-jar-with-dependencies.jar",
				"jacocoagent.jar",
			}
			for _, java_test_jar in ipairs(java_test_bundles) do
				local fname = vim.fn.fnamemodify(java_test_jar, ":t")
				if not vim.tbl_contains(excluded, fname) then
					table.insert(bundles, java_test_jar)
				end
			end

			return bundles
		end)(),
	},
}

-- Use jdtls.start_or_attach with single_file_support to prevent duplicate clients
local jdtls = require("jdtls")
jdtls.start_or_attach(config)

-- Setup DAP with automatic main class discovery
-- This resolves mainClass, modulePaths, and classPaths automatically
-- Defer to ensure dap is loaded
vim.defer_fn(function()
	local ok, dap_module = pcall(require, "dap")
	if ok and jdtls.dap then
		jdtls.dap.setup_dap()
		jdtls.dap.setup_dap_main_class_configs({ verbose = true })
	end
end, 100)
