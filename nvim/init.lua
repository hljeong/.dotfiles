-- set leader before requiring plugins
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- [[ plugins ]]

-- bootstrap lazy
-- https://github.com/folke/lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
---@diagnostic disable-next-line: undefined-field
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

  -- automatically detect tab size
  "tpope/vim-sleuth",

  {
    "navarasu/onedark.nvim",
    opts = {
      transparent = true,
      colors = {
        fg = "#cda2b7", -- pink foreground :D
      },
      highlights = {
        ["@markup.heading.1.markdown"] = { fg = "$blue" },
        ["@markup.heading.2.markdown"] = { fg = "$green" },
        ["@markup.heading.4.markdown"] = { fg = "$blue" },
        ["@markup.heading.5.markdown"] = { fg = "$green" },
        ["@type"] = { fg = "$green" },
        ["@variable"] = { fg = "$yellow" },
        ["@variable.parameter"] = { fg = "$cyan" },
        ["@lsp.type.parameter"] = { fg = "$cyan" },
        ["Special"] = { fg = "#75e6fa" },
        ["@string"] = { fg = "$fg" },
        ["@number"] = { fg = "$fg" },
      }, --[5]
    },
  },

  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      -- 'TmuxNavigatePrevious',
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      -- { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
    },
  },

  -- '<leader>c' to comment visual regions
  {
    "numToStr/Comment.nvim",
    opts = {
      toggler = {
        line = "<leader>cc",
        block = "<leader>bb",
      },
      opleader = {
        line = "<leader>c",
        block = "<leader>b",
      },
    },
  },

  -- add git related signs to gutter
  { "lewis6991/gitsigns.nvim", opts = {} },

  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        keymaps = {
          normal = "<leader>s",
          visual = "<leader>s",
        },
      })
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
      "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
      local actions = require("telescope.actions")
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
          },
        },
      })

      pcall(require("telescope").load_extension, "fzf")
      pcall(require("telescope").load_extension, "ui-select")

      local builtin = require("telescope.builtin")
      vim.keymap.set(
        "n",
        "<leader>sh",
        builtin.help_tags,
        { desc = "[s]earch [h]elp" }
      )
      vim.keymap.set(
        "n",
        "<leader>sk",
        builtin.keymaps,
        { desc = "[s]earch [k]eymaps" }
      )
      vim.keymap.set(
        "n",
        "<leader>sf",
        builtin.find_files,
        { desc = "[s]earch [f]iles" }
      )
      vim.keymap.set(
        "n",
        "<leader>ss",
        builtin.builtin,
        { desc = "[s]earch [s]elect telescope" }
      )
      vim.keymap.set(
        "n",
        "<leader>sw",
        builtin.grep_string,
        { desc = "[s]earch current [w]ord" }
      )
      vim.keymap.set(
        "n",
        "<leader>sg",
        builtin.live_grep,
        { desc = "[s]earch by [g]rep" }
      )
      vim.keymap.set(
        "n",
        "<leader>sd",
        builtin.diagnostics,
        { desc = "[s]earch [d]iagnostics" }
      )
      vim.keymap.set(
        "n",
        "<leader>sr",
        builtin.resume,
        { desc = "[s]earch [r]esume" }
      )
      vim.keymap.set(
        "n",
        "<leader>s.",
        builtin.oldfiles,
        { desc = '[s]earch recent files ("." for repeat)' }
      )
      -- vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] find existing buffers' })

      vim.keymap.set("n", "<leader>z", function()
        builtin.current_buffer_fuzzy_find(
          require("telescope.themes").get_dropdown({
            winblend = 10,
            previewer = false,
          })
        )
      end, { desc = "fu[z]zily search in current buffer" })

      vim.keymap.set("n", "<leader>s/", function()
        builtin.live_grep({
          grep_open_files = true,
          prompt_title = "live grep in open files",
        })
      end, { desc = "[s]earch [/] in open files" })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      { "folke/lazydev.nvim", opts = {} },
    },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup(
          "kickstart-lsp-attach",
          { clear = true }
        ),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set(
              "n",
              keys,
              func,
              { buffer = event.buf, desc = "lsp: " .. desc }
            )
          end

          -- <c-t> to jump back
          map(
            "gd",
            require("telescope.builtin").lsp_definitions,
            "[g]oto [d]efinition"
          )
          map("gD", vim.lsp.buf.declaration, "[g]oto [d]eclaration")
          map(
            "gr",
            require("telescope.builtin").lsp_references,
            "[g]oto [r]eferences"
          )
          map(
            "gi",
            require("telescope.builtin").lsp_implementations,
            "[g]oto [i]mplementation"
          )
          map(
            "gtd",
            require("telescope.builtin").lsp_type_definitions,
            "type [d]efinition"
          )
          map("<leader>rn", vim.lsp.buf.rename, "[r]e[n]ame")
          map("<leader>ca", vim.lsp.buf.code_action, "[c]ode [a]ction")
          map("<leader>d", vim.lsp.buf.hover, "hover [d]ocumentation")
          -- map('gds', require('telescope.builtin').lsp_document_symbols, '[d]ocument [s]ymbols')
          -- map('gws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[w]orkspace [s]ymbols')

          -- highlight references on cursor hold
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if
            client and client.server_capabilities.documentHighlightProvider
          then
            local highlight_augroup = vim.api.nvim_create_augroup(
              "kickstart-lsp-highlight",
              { clear = false }
            )
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
              group = vim.api.nvim_create_augroup(
                "kickstart-lsp-detach",
                { clear = true }
              ),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({
                  group = "kickstart-lsp-highlight",
                  buffer = event2.buf,
                })
              end,
            })
          end

          -- if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
          --   map('<leader>th', function()
          --     vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
          --   end, '[t]oggle inlay [h]ints')
          -- end
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- capabilities = vim.tbl_deep_extend(
      -- 'force',
      -- capabilities,
      -- require('cmp_nvim_lsp').default_capabilities()
      -- )
      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = "Replace",
              },
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      require("mason").setup()

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        "stylua",
        "pyright",
        "black",
        "clang-format",
        "clangd",
      })
      require("mason-tool-installer").setup({
        ensure_installed = ensure_installed,
      })

      require("mason-lspconfig").setup({
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend(
              "force",
              {},
              capabilities,
              server.capabilities or {}
            )
            require("lspconfig")[server_name].setup(server)
          end,
        },
      })
    end,
  },

  {
    "stevearc/conform.nvim",
    lazy = false,
    opts = {
      notify_on_error = false,
      -- format_on_save = {
      --   timeout_ms = 500,
      --   lsp_fallback = true,
      -- },
      formatters = {
        stylua = {
          -- todo: move .stylua.toml
          prepend_args = { "--config-path", "/home/mphillotry/.stylua.toml" },
        },
      },
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
        cpp = { "clang-format" },
      },
    },
  },

  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
      },
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      local ts = require("nvim-treesitter.configs")

      ts.setup({
        auto_install = true,
        sync_install = false,
        build = ":TSUpdate",
        event = { "BufReadPre", "BufNewFile" },
        indent = { enable = true },
        highlight = { enable = true },
        ensure_installed = {
          "bash",
          "c",
          "cpp",
          "css",
          "csv",
          "diff",
          "dockerfile",
          "gitignore",
          "html",
          "java",
          "javascript",
          "json",
          "lua",
          "make",
          "markdown",
          "markdown_inline",
          "python",
        },
        modules = {},
        ignore_install = {},
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "zv",
            node_incremental = "zv",
            scope_incremental = false,
            node_decremental = "<leader>zv",
          },
        },
      })
    end,
  },
})

-- [[ onedark ]]

require("onedark").load()

-- [[ gitsigns ]]

vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
  pattern = "*",
  command = "highlight clear SignColumn",
})
vim.cmd("highlight GitSignsAdd guibg=NONE")
vim.cmd("highlight GitSignsChange guibg=NONE")
vim.cmd("highlight GitSignsDelete guibg=NONE")

-- [[ luasnip ]]

local cmp = require("cmp")
local ls = require("luasnip")
require("luasnip.loaders.from_lua").load({
  paths = { "~/.config/nvim/luasnip" },
})
ls.setup({
  delete_check_events = "TextChanged",
  enable_autosnippets = true,
})

-- eliminates resurrecting tabstops when expanding a snippet inside a completed snippet
vim.api.nvim_create_autocmd("User", {
  pattern = "LuasnipExitNodeEnter",
  callback = function()
    -- ls.session.jump_active prevents unlinking during active tab traversal, and
    -- ls.jumpable() ensures we only unlink when there's nowhere else to jump
    if not ls.session.jump_active and not ls.jumpable() then
      ls.unlink_current()
    end
  end,
})

cmp.setup({
  sources = {
    { name = "nvim_lsp" },
    { name = "nvim_lsp_signature_help" },
  },
  completion = { completeopt = "menu,menuone" },
  mapping = {
    ["<tab>"] = cmp.mapping(function(fallback)
      -- if cmp.visible() then
      --   cmp.confirm()
      -- elseif ls.expand_or_locally_jumpable() then
      if ls.expand_or_locally_jumpable() then
        ls.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<s-tab>"] = cmp.mapping(function(fallback)
      if ls.locally_jumpable(-1) then
        ls.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
})

-- [[ options ]]

local set = vim.opt

-- mouse mode
set.mouse = "a"

-- search
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true

-- indent and wrap
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.breakindent = true
vim.opt.showbreak = "↳ "
vim.opt.linebreak = true

-- whitespace
--   `:help 'list'`
--   `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- line numbers
vim.wo.number = true
vim.wo.relativenumber = true
vim.opt.cursorline = true

-- command line
set.shortmess = "atI"
set.shellcmdflag = "-ic" --[2]

-- miscellaneous
vim.opt.scrolloff = 5
vim.opt.signcolumn = "yes"

-- [[ keymaps ]]

-- set space to nop
vim.keymap.set(
  { "n", "v", "o" },
  "<space>",
  "<nop>",
  { noremap = true, silent = true }
)

-- escape
vim.keymap.set({ "i" }, "jk", "<esc>", { noremap = true })
vim.keymap.set({ "c" }, "jk", "<c-c>", { noremap = true }) --[1]
vim.keymap.set({ "x" }, "<leader>jk", "<esc>", { noremap = true })

-- wrap-aware movement
vim.keymap.set(
  { "n", "x", "o" },
  "j",
  "v:count == 0 ? 'gj' : 'j'",
  { noremap = true, expr = true, silent = true }
)
vim.keymap.set(
  { "n", "x", "o" },
  "k",
  "v:count == 0 ? 'gk' : 'k'",
  { noremap = true, expr = true, silent = true }
)
vim.keymap.set({ "n", "x", "o" }, "gj", "j", { noremap = true, silent = true })
vim.keymap.set({ "n", "x", "o" }, "gk", "k", { noremap = true, silent = true })

-- navigation
vim.keymap.set({ "n", "x", "o" }, "<leader>j", "G", { noremap = true })
vim.keymap.set({ "n", "x", "o" }, "<leader>k", "gg", { noremap = true })
vim.keymap.set({ "n", "x", "o" }, "<leader>h", "^", { noremap = true })
vim.keymap.set({ "n", "x", "o" }, "<leader>l", "$", { noremap = true })

-- find
vim.keymap.set({ "n", "x" }, "f", "/", { noremap = true })
vim.keymap.set({ "n", "x" }, "<leader>f", "?", { noremap = true })
vim.keymap.set({ "n", "x" }, "F", "?", { noremap = true })
vim.keymap.set({ "n", "x", "o" }, "/", "f", { noremap = true })
vim.keymap.set({ "n", "x", "o" }, "<leader>/", "F", { noremap = true })
vim.keymap.set({ "n", "x" }, "<leader>n", "N", { noremap = true })

-- leader mapping
vim.keymap.set({ "n" }, "<leader>i", "I", { noremap = true })
vim.keymap.set({ "n" }, "<leader>a", "A", { noremap = true })
vim.keymap.set({ "n" }, "<leader>v", "V", { noremap = true })
vim.keymap.set({ "n" }, "<leader>o", "O", { noremap = true })
vim.keymap.set({ "n" }, "<leader>p", "P", { noremap = true })
vim.keymap.set({ "n" }, "<leader>m", "@q", { noremap = true })
vim.keymap.set({ "n" }, "<leader>u", "<c-r>", { noremap = true })
vim.keymap.set({ "n", "x" }, "<leader><leader>", ":", { noremap = true })
vim.keymap.set({ "n", "x" }, "<leader>y", '"+y', { noremap = true })

-- diagnostic
vim.keymap.set(
  "n",
  "<leader>e",
  vim.diagnostic.open_float,
  { desc = "Show diagnostic [e]rror messages" }
)

-- save and quit
vim.keymap.set({ "n" }, "<leader>w", ":w<cr>", { noremap = true })
vim.keymap.set({ "n" }, "<leader>q", ":wq<cr>", { noremap = true })
vim.keymap.set({ "n" }, "<leader>xq", ":q!<cr>", { noremap = true })

-- move cursor to last position when opening file
vim.cmd('autocmd BufReadPost * silent! normal! g`"zvzz')

-- temp fix for pink floating windows --[4]
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#3B4252", fg = "#5E81AC" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#3B4252" })

-- [[ references ]]

--[[

[0] https://github.com/nvim-lua/kickstart.nvim

[1] https://github.com/neovim/neovim/issues/21585#issuecomment-1367204136

[2] https://stackoverflow.com/a/14841641

[3] https://www.reddit.com/r/neovim/comments/yiimig/comment/iuizlig

[4] https://neovim.discourse.group/t/how-to-configure-floating-window-colors-highlighting-in-0-8/3193

[5] https://github.com/navarasu/onedark.nvim/blob/master/lua/onedark/highlights.lua

--]]
