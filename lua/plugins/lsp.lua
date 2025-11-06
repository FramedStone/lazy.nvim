return {
  {
    "williamboman/mason.nvim",
    event = "VeryLazy",
    config = function()
      require("mason").setup()
    end,
  },
   {
     "williamboman/mason-lspconfig.nvim",
     event = "VeryLazy",
     config = function()
        require("mason-lspconfig").setup({
          ensure_installed = {
            "lua_ls",
            "pyright",
            "rust_analyzer",
            "clangd",
            "html",
            "cssls",
            "jsonls",
            "yamlls",
            "bashls",
          },
          automatic_enable = true,
        })
     end,
   },
    {
      "neovim/nvim-lspconfig",
      event = "VeryLazy",
       dependencies = { "williamboman/mason-lspconfig.nvim", "Saghen/blink.cmp" },
       config = function()
        -- LSP on_attach function
       local on_attach = function(client, bufnr)
         local opts = { buffer = bufnr, noremap = true, silent = true }

          -- LSP keymaps
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gf", "<cmd>e <cfile><CR>", opts)
          vim.keymap.set("n", "gF", "<cmd>e <cfile>:<cWORD><CR>", opts)
       end

       -- Diagnostic keymaps (global)
       vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
       vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })

        -- LSP capabilities
        local capabilities = require('blink.cmp').get_lsp_capabilities()

        -- Configure LSP servers
        vim.lsp.config('lua_ls', {
          on_attach = on_attach,
          capabilities = capabilities,
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
        vim.lsp.config('pyright', {
          on_attach = on_attach,
          capabilities = capabilities,
        })
        vim.lsp.config('rust_analyzer', {
          on_attach = on_attach,
          capabilities = capabilities,
        })
        vim.lsp.config('clangd', {
          on_attach = on_attach,
          capabilities = capabilities,
        })
        vim.lsp.config('html', {
          on_attach = on_attach,
          capabilities = capabilities,
        })
        vim.lsp.config('cssls', {
          on_attach = on_attach,
          capabilities = capabilities,
        })
        vim.lsp.config('jsonls', {
          on_attach = on_attach,
          capabilities = capabilities,
        })
        vim.lsp.config('yamlls', {
          on_attach = on_attach,
          capabilities = capabilities,
        })
        vim.lsp.config('bashls', {
          on_attach = on_attach,
          capabilities = capabilities,
        })
     end,
   },
}
