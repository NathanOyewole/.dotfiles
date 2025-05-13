~/.config/nvim/lua/plugins.lua

return require('lazy').setup({
  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    config = function()
      require'lspconfig'.pyright.setup{}  -- Example for Python, replace with the language you prefer
    end,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",  -- LSP source
      "L3MON4D3/LuaSnip",      -- Snippet support
    },
    config = function()
      local cmp = require('cmp')
      cmp.setup({
        completion = { autocomplete = false },  -- Disable automatic popups
        mapping = {
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        },
      })
    end,
  },

  -- File Explorer (nvim-tree)
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require'nvim-tree'.setup {
        view = {
          width = 30,
          side = 'left',
          adaptive_size = true,
        },
        renderer = {
          highlight_opened_files = "all",
          icons = {
            show = { file = true, folder = true, folder_arrow = true },
          },
        },
      }

      vim.api.nvim_set_keymap("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { noremap = true, silent = true })
    end,
  },

  -- Telescope (Fuzzy Finder)
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      local telescope = require("telescope")
      telescope.setup {
        defaults = {
          file_ignore_patterns = { "node_modules", ".git" },
        },
      }

      -- Keymaps for Telescope
      vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { noremap = true, silent = true })
    end,
  },

  -- Status Line
  {
    "hoob3rt/lualine.nvim",
    config = function()
      require('lualine').setup({
        options = { theme = 'catppuccin' },
      })
    end,
  },

  -- Git Integration (fugitive)
  {
    "tpope/vim-fugitive",
    config = function()
      vim.api.nvim_set_keymap("n", "<leader>gs", "<cmd>Git<cr>", { noremap = true, silent = true })
    end,
  },

  -- Commenting (Comment.nvim)
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },

  -- Bracket Auto-pairing
  {
    "windwp/nvim-autopairs",
    config = function()
      require('nvim-autopairs').setup()
    end,
  },

  -- Markdown Preview
  {
    "iamcco/markdown-preview.nvim",
    run = "cd app && yarn install",  -- Run this to install dependencies
    config = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
  },

  -- Treesitter for Better Syntax Highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = { "lua", "javascript", "python", "html", "css", "json" },
        highlight = { enable = true },
      }
    end,
  },

  -- Toggle terminal
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup {
        size = 20,
        open_mapping = [[<c-\>]],
      }
    end,
  },

  -- Buffer Deletion (vim-bbye)
  {
    "moll/vim-bbye",
    config = function()
      vim.api.nvim_set_keymap("n", "<leader>bd", "<cmd>Bdelete<cr>", { noremap = true, silent = true })
    end,
  },
})
{
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup {
        options = {
          theme = "catppuccin",  -- You can choose another theme
          section_separators = {'', ''},
          component_separators = {'', ''},
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch'},
          lualine_c = {'filename'},
          lualine_x = {'encoding', 'fileformat', 'filetype'},
          lualine_y = {'progress'},
          lualine_z = {'location'}
        }
      }
    end
  }
})
