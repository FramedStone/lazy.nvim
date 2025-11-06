# Harpoon Usage Guide

Harpoon is a Neovim plugin for quick file navigation. It allows you to mark files and jump between them with minimal keystrokes.

## Setup
Harpoon requires `harpoon:setup()` to be called in your config. This is already done in your Neovim configuration.

## Keybinds
The following are recommended keybinds for harpoon (add them to your config if not present):

- `<leader>a`: Add current file to harpoon list
- `<C-e>`: Toggle harpoon quick menu
- `<C-h>`: Select 1st file in list
- `<C-t>`: Select 2nd file in list
- `<C-n>`: Select 3rd file in list
- `<C-s>`: Select 4th file in list
- `<C-S-P>`: Go to previous file in list
- `<C-S-N>`: Go to next file in list

## Usage
1. Open a file you want to mark.
2. Press `<leader>a` to add it to the harpoon list.
3. Repeat for other files.
4. Use `<C-h>`, `<C-t>`, etc. to jump directly to marked files.
5. Press `<C-e>` to open the quick menu, where you can:
   - Navigate with arrow keys
   - Press Enter to select
   - Press `<C-v>` for vertical split
   - Press `<C-x>` for horizontal split
   - Press `<C-t>` for new tab
   - Press `d` to delete an item

## Telescope Integration
If you have Telescope installed, you can use `:Telescope harpoon marks` to browse harpoon files via Telescope.

## Notes
- Harpoon lists are saved per project (based on current working directory).
- Files are automatically updated if their content changes.
- The quick menu allows reordering and deleting marks.