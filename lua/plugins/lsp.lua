return {
  -- Rust
  {
  'mrcjkb/rustaceanvim',
  version = '^5', -- Recommended
  lazy = false, -- This plugin is already lazy
},
  -- nvim-cmp completion
  {'hrsh7th/nvim-cmp',
    dependencies = {
      'neovim/nvim-lspconfig', 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path', 'hrsh7th/cmp-cmdline', 'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip', 'rafamadriz/friendly-snippets',
    'hrsh7th/cmp-nvim-lsp-document-symbol', 'hrsh7th/cmp-nvim-lsp-signature-help', 'ray-x/lsp_signature.nvim'},
    config = function()

      -- -- create borders around lsp popups
      -- local orig_fun = vim.lsp.util.open_floating_preview
      -- function vim.lsp.open_floating_preview(contents, syntax, opts, ...)
      --   opts = opts or {}
      --   opts.border = opts.border or 'single'
      --   opts.max_width = opts.max_width or 80
      --   return orig_fun(contents, syntax, opts, ...)
      -- end
      --
      -- vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
      --   vim.lsp.handlers.hover, {
      --     border = "single",
      --   }
      -- )

      vim.keymap.set('n', '<c-k>', function() 
        vim.lsp.buf.signature_help()
      end)
      local luasnip = require('luasnip')
      local cmp = require('cmp')
      require('luasnip.loaders.from_vscode').lazy_load()
      cmp.setup({
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
          {name = 'nvim_lsp'},
          {name = 'luasnip'},
          -- {name = 'nvim_lsp_signature_help'},

        }, {{name = 'buffer'},}),
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
                              select = true,
                          })
                      end
                  else
                      fallback()
                  end
              end),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.locally_jumpable(1) then
              luasnip.jump(1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
      })
    end
  },
  -- Mason
  {'williamboman/mason.nvim',
    dependencies = {'neovim/nvim-lspconfig', 'williamboman/mason-lspconfig.nvim'},
    config = function()
      require('mason').setup()
      require('mason-lspconfig').setup()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require('lspconfig')
      -- set borders around signature and hover
      -- Has to be after 'require("lspconfig")' !!
      local handlers = {
        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded"}),
        ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded"}),
      }

      lspconfig.lua_ls.setup({
      handlers = handlers,
      capabilities = capabilities,

      settings = {
        Lua = {
          workspace = {
              library = {vim.env.RUNTIME},
            },
          diagnostics = {
            globals = {"vim"}
            },
          }
        }
      })
      --lspconfig.rust_analyzer.setup({
      --capabilities = capabilities})
      lspconfig.rust_analyzer.setup({
        handlers = handlers,
        settings = {
          ['rust_analyzer'] = {
            diagnostics = {
              enable = false
            }
          }
        },
      capabilities = capabilities
      })

      lspconfig.zls.setup({
      handlers = handlers,
      })

      require('lsp_signature').setup({
      bind = true,
      handler_opts = {
        border = "rounded"}
      })
    end
  },

  -- Treesitter
  {'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    config = function() 
      require('nvim-treesitter.configs').setup({
      ensure_installed = {"c", "lua", "rust", "zig", "ocaml"},
      highlight = {enable=true},
      indent = {enable = true},
      incremental_selection = {enable = true},
      textobjects = {enable = true},
    })
    end,
  }
}
