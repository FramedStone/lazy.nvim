return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup()

		vim.keymap.set("n", "<C-a>", function()
			harpoon:list():add()
		end, { desc = "Add file to harpoon" })
		vim.keymap.set("n", "<C-e>", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "Toggle harpoon quick menu" })
		vim.keymap.set("n", "<C-h>", function()
			harpoon:list():select(1)
		end, { desc = "Select 1st harpoon file" })
		vim.keymap.set("n", "<C-t>", function()
			harpoon:list():select(2)
		end, { desc = "Select 2nd harpoon file" })
		vim.keymap.set("n", "<C-[>", function()
			harpoon:list():prev()
		end, { desc = "Go to previous harpoon file" })
		vim.keymap.set("n", "<C-]>", function()
			harpoon:list():next()
		end, { desc = "Go to next harpoon file" })
	end,
}
