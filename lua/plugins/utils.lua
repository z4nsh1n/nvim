return {
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
  {'echasnovski/mini.nvim',
    config = function ()
      require('mini.pairs').setup({})
      require('mini.comment').setup({})
    end
  },
  -- Telescope
  {'nvim-telescope/telescope.nvim',
  tag = '0.1.5',
  branch = '0.1.x',
  dependencies = {'nvim-lua/plenary.nvim'},

  keys = {
    {"<leader>tf", "<cmd>Telescope find_files<cr>", desc = "Telescope find files"},
    {"<leader>tc", "<cmd>Telescope colorscheme<cr>", desc = "Telescope find files"},
  },
  opts = {
    defaults = {
      mappings = {
        i = {
          ["<C-j>"] = require('telescope.actions').move_selection_next,
          ["<C-k>"] = require('telescope.actions').move_selection_previous,
          ["<C-u>"] = require('telescope.actions').preview_scrolling_up,
          ["<C-d>"] = require('telescope.actions').preview_scrolling_down,
        },
      },
    },
  },
  },
  -- Lua Line
  {'nvim-lualine/lualine.nvim',
    dependencies = {'nvim-tree/nvim-web-devicons'},
    opts = {
      options = {
      theme = 'gruvbox',
      theme = 'dracula',
      section_separators = { left = '', right = '' },
      component_separators = { left = '', right = '' }
    },
    },
  },
}
