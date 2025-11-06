# Lazy.nvim Usage Guide

This guide covers how to use lazy.nvim in your current Neovim setup.

## Updating Plugins

To update all plugins:

```
:Lazy update
```

To update a specific plugin:

```
:Lazy update plugin-name
```

## Reloading Plugins

After editing a plugin spec in `lua/plugins/`, reload it:

```
:Lazy reload plugin-name
```

For example, to reload the theme:

```
:Lazy reload tokyonight.nvim
```

## Other Useful Commands

- `:Lazy sync` - Install missing plugins, clean unused, and update
- `:Lazy check` - Check for updates without installing
- `:Lazy clean` - Remove unused plugins
- `:Lazy log` - Show recent update logs

## Plugin Specs Location

Your plugins are defined in `lua/plugins/*.lua` files.

Edit these files to add or modify plugins, then reload as above.