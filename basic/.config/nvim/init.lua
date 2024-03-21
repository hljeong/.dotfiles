-- set leader before requiring plugins
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '



-- [[ plugins ]]

-- bootstrap lazy
-- https://github.com/folke/lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({

  {
    'kylechui/nvim-surround',
    version = '*',
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup({
        keymaps = {
          normal = '<leader>s',
          visual = '<leader>s',
        },
      })
    end,
  },

  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        version = 'v2.*',
        build = 'make install_jsregexp',
      },
      'saadparwaiz1/cmp_luasnip',
    },
  },

})

local cmp = require('cmp')
local ls = require('luasnip')
require('luasnip.loaders.from_lua').load({
  paths = '~/.config/nvim/luasnip'
})
ls.setup({
  delete_check_events = 'TextChanged',
  enable_autosnippets = true,
})

-- eliminates resurrecting tabstops when expanding a snippet inside a completed snippet
vim.api.nvim_create_autocmd("User", {
	pattern = "LuasnipExitNodeEnter",
	callback = function()
    ls.unlink_current()
	end
})

cmp.setup({
  mapping = {
    ['<tab>'] = cmp.mapping(function(fallback)
      if ls.expand_or_locally_jumpable() then
        ls.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<s-tab>'] = cmp.mapping(function(fallback)
      if ls.locally_jumpable(-1) then
        ls.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
})



-- [[ options  ]]

-- mouse mode
vim.o.mouse = 'a'

-- search
vim.o.hlsearch = false
vim.o.ignorecase = true
vim.o.incsearch = true

-- indent
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

-- line numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- scroll
vim.o.scrolloff = 8

-- command line
vim.o.shortmess = 'at'
vim.o.shellcmdflag = '-ic' --[2]



-- [[ keymaps ]]

-- set space to nop
vim.keymap.set({ 'n', 'v' }, '<space>', '<nop>', { noremap = true, silent = true })

-- escape
vim.keymap.set({ 'i' }, 'jk', '<esc>', { noremap = true })
vim.keymap.set({ 'c' }, 'jk', '<c-c>', { noremap = true }) --[1]
vim.keymap.set({ 'x' }, '<leader>jk', '<esc>', { noremap = true })

-- wrap-aware movement
vim.keymap.set({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true} )
vim.keymap.set({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.keymap.set({ 'n', 'x' }, 'gj', 'j', { noremap = true, silent = true} )
vim.keymap.set({ 'n', 'x' }, 'gk', 'k', { noremap = true, silent = true })

-- navigation
vim.keymap.set({ 'n', 'x' }, '<leader>j', 'G', { noremap = true })
vim.keymap.set({ 'n', 'x' }, '<leader>k', 'gg', { noremap = true })
vim.keymap.set({ 'n', 'x' }, '<leader>h', '^', { noremap = true })
vim.keymap.set({ 'n', 'x' }, '<leader>l', '$', { noremap = true })

-- find
vim.keymap.set({ 'n', 'x' }, 'f', '/', { noremap = true })
vim.keymap.set({ 'n', 'x' }, 'F', '?', { noremap = true })
vim.keymap.set({ 'n', 'x' }, '<leader>f', '?', { noremap = true })
vim.keymap.set({ 'n', 'x' }, '/', 'f', { noremap = true })
vim.keymap.set({ 'n', 'x' }, '<leader>/', 'F', { noremap = true })
vim.keymap.set({ 'n', 'x' }, '<leader>n', 'N', { noremap = true })

-- leader mapping
vim.keymap.set({ 'n' }, '<leader>i', 'I', { noremap = true })
vim.keymap.set({ 'n' }, '<leader>a', 'A', { noremap = true })
vim.keymap.set({ 'n' }, '<leader>v', 'V', { noremap = true })
vim.keymap.set({ 'n' }, '<leader>o', 'O', { noremap = true })
vim.keymap.set({ 'n' }, '<leader>p', 'P', { noremap = true })
vim.keymap.set({ 'n' }, '<leader>m', '@q', { noremap = true })
vim.keymap.set({ 'n' }, '<leader>u', '<c-r>', { noremap = true })
vim.keymap.set({ 'n', 'x' }, '<leader><leader>', ':', { noremap = true })
vim.keymap.set({ 'n', 'x' }, '<leader>y', '"+y', { noremap = true })

-- save and quit
vim.keymap.set({ 'n' }, '<leader>w', ':w<cr>', { noremap = true })
vim.keymap.set({ 'n' }, '<leader>q', ':wq<cr>', { noremap = true })
vim.keymap.set({ 'n' }, '<leader>xq', ':q!<cr>', { noremap = true })



-- [[ miscellaneous ]]

-- move cursor to last position when opening file
vim.cmd('autocmd BufReadPost * silent! normal! g`"zvzz')


-- [[ references ]]

--[[

[0] https://github.com/nvim-lua/kickstart.nvim

[1] https://github.com/neovim/neovim/issues/21585#issuecomment-1367204136

[2] https://stackoverflow.com/a/14841641

[3] https://www.reddit.com/r/neovim/comments/yiimig/comment/iuizlig

--]]
