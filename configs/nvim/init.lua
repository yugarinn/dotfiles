-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Core Settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showmatch = true

-- Core bindings
vim.g.mapleader = ' '
vim.g.maplocalleader = "\\"

-- Remaps
vim.keymap.set('n', '<leader>.', vim.cmd.Ex)

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    {
      "nvim-telescope/telescope.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
      },
      config = function()
        local telescope = require('telescope')
        telescope.setup({
          defaults = {
            file_ignore_patterns = {"node_modules"},
            path_display = {"smart"},
          }
        })

        -- Keymaps
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader> ', builtin.find_files, { desc = 'Telescope find files' })
        vim.keymap.set('n', '<leader>,', builtin.buffers, { desc = 'Telescope buffers' })
      end,
    },
  },
  install = { colorscheme = { "habamax" } },
  checker = { enabled = true },
})
