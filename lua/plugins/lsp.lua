return {
  -- nvim-cmp completion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'neovim/nvim-lspconfig', 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path', 'hrsh7th/cmp-cmdline', 'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip', 'rafamadriz/friendly-snippets',
      'hrsh7th/cmp-nvim-lsp-document-symbol', 'hrsh7th/cmp-nvim-lsp-signature-help', 'ray-x/lsp_signature.nvim' },
    config = function()
      local luasnip = require('luasnip')
      local cmp = require('cmp')
      -- load snippets
      require('luasnip.loaders.from_vscode').lazy_load()

      vim.keymap.set('n', '<c-k>', function()
        vim.lsp.buf.signature_help()
      end)

      -- Setup
      cmp.setup({
        preselect = cmp.PreselectMode.None,
        formatting = {
          format = function(entry, vim_item)
            -- Make menus smaller, remove space
            vim_item.menu = ""
            --vim_item.kind = ""
            return vim_item
          end,
        },
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          -- {name = 'nvim_lsp_signature_help'},

        }, { { name = 'buffer' }, }),
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<CR>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              if luasnip.expandable() then
                luasnip.expand()
              else
                cmp.confirm({
                  select = false,
                })
              end
            else
              fallback()
            end
          end),
          ["<C-j>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item( {behavior = cmp.SelectBehavior.Select} )
            elseif luasnip.locally_jumpable(1) then
              luasnip.jump(1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item({behavior = cmp.SelectBehavior.Select})
            elseif luasnip.locally_jumpable(1) then
              luasnip.jump(1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-k>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item({behavior = cmp.SelectBehavior.Select})
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item({behavior = cmp.SelectBehavior.Select})
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ['<CR>'] = cmp.mapping.confirm({select = false}),
        }),
      })
    end
  },
  -- Mason
  {
    'williamboman/mason.nvim',
    dependencies = { 'neovim/nvim-lspconfig', 'williamboman/mason-lspconfig.nvim' },
    config = function()
      require('mason').setup()
      require('mason-lspconfig').setup({
        ensure_installed = { "rust_analyzer", "lua_ls", "ocamllsp", "clangd", "zls", "marksman", "zk", "hls" },
      })
      require('mason-lspconfig').setup_handlers({
        -- Setup servers for evert sever Mason has
        -- Individual configs can fit in here. See help
        function(servername)
          require('lspconfig')[servername].setup({
            handlers = {
              ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
              ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
            },
            capabilities = require('cmp_nvim_lsp').default_capabilities(),
            on_attach = function(client, bufnr)
              -- Set LSP keymap
              local opts = { buffer = bufnr, remap = false }
              vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts, { desc = "LSP Hover" })
              vim.keymap.set("n", "<leader>ls", function() vim.lsp.buf.workspace_symbol() end, opts,
                { desc = "LSP Workspace Symbol" })
              vim.keymap.set("n", "<leader>ld", function() vim.diagnostic.setloclist() end, opts,
                { desc = "LSP Show Diagnostics" })
              vim.keymap.set("n", "<leader>e", function() vim.diagnostic.open_float(0, {border="rounded"}) end, opts,
                { desc = "LSP Show Diagnostics" })
              vim.keymap.set("n", "<leader>]", function() vim.diagnostic.goto_next() end, opts, { desc = "Next Diagnostic" })
              vim.keymap.set("n", "<leader>[", function() vim.diagnostic.goto_prev() end, opts, { desc = "Previous Diagnostic" })
              vim.keymap.set("n", "<leader>lca", function() vim.lsp.buf.code_action() end, opts,
                { desc = "LSP Code Action" })
              vim.keymap.set("n", "<leader>lr", function() vim.lsp.buf.references() end, opts, { desc = "LSP References" })
              vim.keymap.set("n", "<leader>ln", function() vim.lsp.buf.rename() end, opts, { desc = "LSP Rename" })
              vim.keymap.set("n", "<leader>lh", function() vim.lsp.buf.signature_help() end, opts,
                { desc = "LSP Signature Help" })
              vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts, { desc = "LSP Goto definition" })
            end
          })
        end
      })
      -- -- manual setup servers
      -- local capabilities = require('cmp_nvim_lsp').default_capabilities()
      -- local lspconfig = require('lspconfig')
      -- -- set borders around signature and hover
      -- -- Has to be after 'require("lspconfig")' !!
      -- local handlers = {
      --   ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded"}),
      --   ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded"}),
      -- }
      --
      -- lspconfig.lua_ls.setup({
      -- handlers = handlers,
      -- capabilities = capabilities,
      --
      -- settings = {
      --   Lua = {
      --     workspace = {
      --         library = {vim.env.RUNTIME},
      --       },
      --     diagnostics = {
      --       globals = {"vim"}
      --       },
      --     }
      --   }
      -- })
      -- --lspconfig.rust_analyzer.setup({
      -- --capabilities = capabilities})
      -- lspconfig.rust_analyzer.setup({
      --   handlers = handlers,
      --   settings = {
      --     ['rust_analyzer'] = {
      --       diagnostics = {
      --         enable = false
      --       }
      --     }
      --   },
      -- capabilities = capabilities
      -- })
      --
      -- lspconfig.zls.setup({
      -- handlers = handlers,
      -- })

      require('lsp_signature').setup({
        bind = true,
        handler_opts = {
          border = "rounded" }
      })
    end
  },

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { "c", "lua", "rust", "zig", "ocaml" },
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = { enable = true },
        textobjects = { enable = true },
      })
    end,
  }
}
