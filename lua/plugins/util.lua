return {
  -- maximize 
  {
    "declancm/maximize.nvim",
    config = true
  },
  -- neogit next to lazygit?
  {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",         -- required
    "sindrets/diffview.nvim",        -- optional - Diff integration

    -- Only one of these is needed, not both.
    "nvim-telescope/telescope.nvim", -- optional
    -- "ibhagwan/fzf-lua",              -- optional
  },
  config = true
  },
  -- indent blank lines
  {"lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  ---@module "ibl",
  ---@type ibl.config
  opts = {}
  },
  -- Oil 
  { 'stevearc/oil.nvim',
    dependencies = {'nvim-tree/nvim-web-devicons'},
    config = function ()
      require('oil').setup({
        columns = {'icon'},

        view_options = {
          show_hidden = true
        },
      })
      vim.keymap.set("n", "<leader>f", "<CMD>Oil<CR>", {desc = "Open Oil"})
      vim.keymap.set("n", "<leader><CR>", require('oil').toggle_float, {desc = "Open Oil floating"})
    end
  },
  -- Telescope
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim', { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' } },
    lazy = false,

    config = function()
      require('telescope').setup({
        defaults = {
          mappings = {
            i = {
              ["<C-j>"] = require('telescope.actions').move_selection_next,
              ["<C-k>"] = require('telescope.actions').move_selection_previous,
              ["<C-u>"] = require('telescope.actions').preview_scrolling_up,
              ["<C-d>"] = require('telescope.actions').preview_scrolling_down,
            }
          },
        },
      })
    end,
    keys = {
      { "<leader>tf", "<cmd>Telescope find_files<cr>",  desc = "Telescope find files" },
      { "<leader>tc", "<cmd>Telescope colorscheme<cr>", desc = "Telescope find colorschemes" },
      { "<leader>b",  "<cmd>Telescope buffers<cr>",     desc = "Telescope find buffers" },
    },
  },
  -- markdown
  {
    "MeanderingProgrammer/markdown.nvim",
    name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("render-markdown").setup({
        latex_enabled = true,
        start_enabled = true,
        render_modes = { "n", "c" },
      })
    end,
  },
  -- Zk
  {
    'zk-org/zk-nvim',
    config = function()
      require("zk").setup({
        picker = "telescope",
        lsp = {
          config = {
            cmd = { "zk", "lsp" },
            name = "zk",
          },
          auto_attach = {
            enabled = true,
            filetypes = { 'markdown', },
          }
        }
      })
    end
  },
  -- lazygit
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    }
  },
  -- mini
  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.pairs').setup({})
      require('mini.comment').setup({})
    end
  },
  -- Lua Line
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        -- theme = 'gruvbox',
        theme = 'dracula',
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' }
      },
    },
  },

}
