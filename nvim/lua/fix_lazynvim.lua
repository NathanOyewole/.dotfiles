-- fix_lazynvim.lua
local function remove_old_lazy()
  -- Remove the old Lazy.nvim package folder if it exists
  local lazy_path = vim.fn.stdpath("config") .. "/.dotfiles/nvim/site/pack/lazy"
  if vim.fn.isdirectory(lazy_path) == 1 then
    print("Removing old Lazy.nvim packages...")
    vim.fn.delete(lazy_path, "rf")
  else
    print("No old Lazy.nvim packages found.")
  end
end

local function install_lazy()
  -- Ensure Lazy.nvim is installed
  local lazypath = vim.fn.stdpath("config") .. "/.dotfiles/nvim/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    print("Installing Lazy.nvim...")
    vim.fn.system({
      "git", "clone", "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      lazypath
    })
  else
    print("Lazy.nvim is already installed.")
  end
end

local function setup_plugins()
  -- Setup Lazy.nvim and load plugins
  local success, err = pcall(require, "lazy")
  if not success then
    print("Lazy.nvim not found. Please ensure Lazy.nvim is properly installed.")
    return
  end

  require("lazy").setup({
    -- Treesitter Setup
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      config = function()
        require("nvim-treesitter.configs").setup {
          ensure_installed = { "lua", "javascript", "html", "css", "json", "markdown" },
          highlight = { enable = true },
        }
      end,
    },

    -- Telescope Setup
    {
      "nvim-telescope/telescope.nvim",
      tag = "0.1.4",
      config = function()
        local telescope = require("telescope")
        telescope.setup {
          defaults = {
            file_ignore_patterns = { "node_modules", ".git" },
          },
        }
        vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { noremap = true, silent = true })
      end,
    },

    -- Catppuccin Theme Setup
    {
      "catppuccin/nvim",
      name = "catppuccin",
      priority = 1000,
      config = function()
        vim.cmd [[colorscheme catppuccin]]
      end,
    },

    -- NvimTree Setup
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
              show = {
                file = true,
                folder = true,
                folder_arrow = true,
              },
            },
          },
        }
        vim.api.nvim_set_keymap("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { noremap = true, silent = true })
      end,
    },

    -- Devicons Setup for NvimTree
    {
      "nvim-tree/nvim-web-devicons",
      config = function()
        require'nvim-web-devicons'.setup {}
      end,
    },
  })
end

-- Run all the steps
remove_old_lazy()
install_lazy()
setup_plugins()
print("Lazy.nvim and plugins setup completed.")

