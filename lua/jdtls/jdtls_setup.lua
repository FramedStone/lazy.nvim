local M = {}

function M:setup()
	-- Find the actual Java project root by prioritizing project-specific markers
	-- This ensures proper monorepo support where each Java project gets its own LSP instance
	local root_dir = require("jdtls.setup").find_root({
		-- Java project files (highest priority for monorepo support)
		"pom.xml",
		"build.gradle",
		"build.gradle.kts",
		"settings.gradle",
		"settings.gradle.kts",
		-- Build wrapper scripts
		"mvnw",
		"gradlew",
		-- Git repository (lowest priority, fallback)
		".git",
	})

	-- Use the Java project root directory name for workspace isolation
	-- This prevents workspace conflicts in monorepos
	local project_name = vim.fn.fnamemodify(root_dir or vim.fn.getcwd(), ":p:h:t")
	local workspace_dir = vim.fn.stdpath("data")
		.. package.config:sub(1, 1)
		.. "jdtls-workspace"
		.. package.config:sub(1, 1)
		.. project_name
	local os_name = vim.loop.os_uname().sysname
	local config = {
		-- The command that starts the language server
		-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
		cmd = {

			-- 💀
			"/usr/lib/jvm/java-21-openjdk/bin/java", -- or '/path/to/java17_or_newer/bin/java'
			-- depends on if `java` is in your $PATH env variable and if it points to the right version.

			"-Declipse.application=org.eclipse.jdt.ls.core.id1",
			"-Dosgi.bundles.defaultStartLevel=4",
			"-Declipse.product=org.eclipse.jdt.ls.core.product",
			"-Dlog.protocol=true",
			"-Dlog.level=ALL",
			"-Xmx1g",
			"--add-modules=ALL-SYSTEM",
			"--add-opens",
			"java.base/java.util=ALL-UNNAMED",
			"--add-opens",
			"java.base/java.lang=ALL-UNNAMED",

			-- 💀
			"-jar",
			-- Use vim.fn.glob to automatically find the launcher jar
			vim.fn.glob(
				vim.fn.stdpath("data")
					.. package.config:sub(1, 1)
					.. "mason"
					.. package.config:sub(1, 1)
					.. "packages"
					.. package.config:sub(1, 1)
					.. "jdtls"
					.. package.config:sub(1, 1)
					.. "plugins"
					.. package.config:sub(1, 1)
					.. "org.eclipse.equinox.launcher_*.jar"
			),
			-- Must point to the eclipse.jdt.ls installation

			-- 💀
			"-configuration",
			vim.fn.stdpath("data")
				.. package.config:sub(1, 1)
				.. "mason"
				.. package.config:sub(1, 1)
				.. "packages"
				.. package.config:sub(1, 1)
				.. "jdtls"
				.. package.config:sub(1, 1)
				.. "config_"
				.. (os_name == "Windows_NT" and "win" or os_name == "Linux" and "linux" or "mac"),
			-- eclipse.jdt.ls installation            Depending on your system.

			-- 💀
			-- See `data directory configuration` section in the README
			"-data",
			workspace_dir,
		},

		-- 💀
		-- This is the default if not provided, you can remove it. Or adjust as needed.
		-- One dedicated LSP server & client will be started per unique root_dir
		root_dir = root_dir,

		-- Here you can configure eclipse.jdt.ls specific settings
		-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
		-- for a list of options
		settings = {
			java = {},
		},

		-- Language server `initializationOptions`
		-- You need to extend the `bundles` with paths to jar files
		-- if you want to use additional eclipse.jdt.ls plugins.
		--
		-- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
		--
		-- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
		init_options = {
			bundles = vim.list_extend(
				{
					-- java-debug-adapter jar
					vim.fn.glob(
						vim.fn.stdpath("data")
							.. package.config:sub(1, 1)
							.. "mason"
							.. package.config:sub(1, 1)
							.. "packages"
							.. package.config:sub(1, 1)
							.. "java-debug-adapter"
							.. package.config:sub(1, 1)
							.. "extension"
							.. package.config:sub(1, 1)
							.. "server"
							.. package.config:sub(1, 1)
							.. "com.microsoft.java.debug.plugin-*.jar"
					),
				},
				vim.split(
					vim.fn.glob(
						vim.fn.stdpath("data")
							.. package.config:sub(1, 1)
							.. "mason"
							.. package.config:sub(1, 1)
							.. "packages"
							.. package.config:sub(1, 1)
							.. "java-test"
							.. package.config:sub(1, 1)
							.. "extension"
							.. package.config:sub(1, 1)
							.. "server"
							.. package.config:sub(1, 1)
							.. "*.jar"
					),
					"\n"
				)
			),
		},

		-- Keymaps for Java-specific features
		on_attach = function(client, bufnr)
			local opts = { buffer = bufnr, noremap = true, silent = true }

			-- Debug keymaps
			vim.keymap.set("n", "<leader>bp", require("dap").toggle_breakpoint, opts)
			vim.keymap.set("n", "<leader>dc", require("dap").continue, opts)
			vim.keymap.set("n", "<leader>dt", function()
				require("dap").terminate()
				require("dapui").close()
			end, opts)
			vim.keymap.set("n", "<leader>dj", require("dap").step_over, opts)
			vim.keymap.set("n", "<leader>dk", require("dap").step_into, opts)
			vim.keymap.set("n", "<leader>do", require("dap").step_out, opts)

			-- Test keymaps
			vim.keymap.set("n", "<leader>tc", require("jdtls").test_class, opts)
			vim.keymap.set("n", "<leader>tm", require("jdtls").test_nearest_method, opts)
		end,
	}
	-- This starts a new client & server,
	-- or attaches to an existing client & server depending on the `root_dir`.
	require("jdtls").start_or_attach(config)
end

return M
