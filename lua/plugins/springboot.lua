return {
	{
		"syntaxpresso/syntaxpresso.nvim",

		event = "VeryLazy",
		config = function()
			require("syntaxpresso").setup({
				keymap = "<leader>cj",
			})
		end,
	},
}
