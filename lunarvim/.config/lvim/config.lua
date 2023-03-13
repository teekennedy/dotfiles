--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- general
lvim.log.level = "warn"
-- Use swapfiles
lvim.swapfile = true
lvim.format_on_save.enabled = true
-- Set colorscheme. If lualine theme with matching name is found, it will automatically be used too.
lvim.colorscheme = "gruvbox-material"
-- Colorscheme settings
vim.g.gruvbox_material_background = "hard"
vim.g.gruvbox_material_foreground = "original"
vim.g.gruvbox_material_statusline_style = vim.g.gruvbox_material_foreground
-- Reduce loading times by loading part of the colorscheme's code on-demand.
vim.g.gruvbox_material_better_performance = 1

-- Tab-complete the longest prefix common to all matches, then tab again will
-- provide a list, and further tabs will cycle through completion options.
vim.opt.wildmode = "longest:list,full"

-- Undo LunarVim's default (unnamedplus) that uses the clipboard for all operations that normally use the unnamed register.
vim.opt.clipboard = ''

-- lualine settings
lvim.builtin.lualine.options.section_separators = { left = '', right = '' }
lvim.builtin.lualine.on_config_done = function(lualine)
  local config = lualine.get_config()

  config.sections.lualine_a[1].separator = { left = '' }
  config.sections.lualine_z[1].separator = { right = '' }
  lualine.setup(config)
end

-- Stop LunarVim from automatically changing the working directory
-- from https://github.com/LunarVim/LunarVim/discussions/2238#discussioncomment-2257236
lvim.builtin.nvimtree.setup.update_focused_file.update_cwd = false
lvim.builtin.project.manual_mode = true

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
-- lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
-- override a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  t = { "<cmd>TroubleToggle<cr>", "trouble" },
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
}

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
-- Use Ctrl+\ to open floating terminal
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "beancount",
  "c",
  "go",
  "hcl",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true

-- generic LSP settings

-- make sure server will always be installed even if the server is in skipped_servers list
lvim.lsp.installer.setup.ensure_installed = {
  -- General

  -- -- misspell corrects commonly misspelled english words
  -- -- https://pkg.go.dev/github.com/stephenwilliams/go-clitools/tools/misspell
  -- 'misspell',

  -- Go

  -- gopls is the official go language server
  -- https://pkg.go.dev/golang.org/x/tools/gopls
  -- Config: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#gopls
  'gopls',
  -- golangci-lint-ls provides golangci-lint diagnostics as an lsp server
  -- Be sure to install golangci with `brew install golangci-lint`
  -- https://github.com/nametake/golangci-lint-langserver
  'golangci_lint_ls',
  -- -- Gomodifytags is a tool to modify/update field tags in structs
  -- -- https://pkg.go.dev/github.com/fatih/gomodifytags
  -- 'gomodifytags',
  -- -- Gotests is a tool that generates table driven tests based on its target source files' function and method signatures
  -- -- https://pkg.go.dev/github.com/cweill/gotests
  -- 'gotests',
  -- -- impl generates method stubs for implementing an interface.
  -- -- https://github.com/josharian/impl
  -- 'impl',
  -- -- json-to-struct attempts to generate go struct definitions from json documents
  -- -- https://github.com/tmc/json-to-struct
  -- 'json-to-struct',
  -- -- staticcheck offers extensive analysis of Go code, covering a myriad of categories.
  -- -- It will detect bugs, suggest code simplifications, point out dead code, and more
  -- -- https://github.com/dominikh/go-tools/tree/master/cmd/staticcheck
  -- 'staticcheck',

  -- Json tools

  -- json language server
  -- https://github.com/microsoft/vscode-json-languageservice
  'jsonls',
  -- Lua tools

  -- Lua language server
  -- https://github.com/sumneko/lua-language-server
  'sumneko_lua',
  -- -- luacheck is a static analyzer and linter for lua
  -- -- https://github.com/mpeterv/luacheck
  -- -- This is failing to install via mason with the message "luarocks is not executable"
  -- -- Leaving disabled for now.
  -- -- 'luacheck',
  -- -- stylua is a lua formatter
  -- -- https://github.com/JohnnyMorganz/StyLua
  -- 'stylua',

  -- Markdown tools

  -- -- Style checker and lint tool
  -- -- https://github.com/DavidAnson/markdownlint
  -- 'markdownlint',

  -- -- Syntax-aware linter for prose
  -- -- https://vale.sh/
  -- 'vale',

  -- Shell tools (bash, zsh)

  -- Bash language server
  -- https://github.com/bash-lsp/bash-language-server
  'bashls',
  -- -- Shellcheck is a shell linter
  -- -- https://www.shellcheck.net/
  -- 'shellcheck',
  -- -- shfmt is a shell formatter
  -- -- https://github.com/mvdan/sh
  -- 'shfmt',

  -- Terraform tools
  'terraformls',

  -- Vimscript tools

  -- Vim language server
  -- https://github.com/iamcco/vim-language-server
  'vimls',
  -- -- vint is a vimscript language linter
  -- -- https://github.com/Vimjas/vint
  -- 'vint',
}

-- ---@usage disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "golangci_lint_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
local null_ls = require "null-ls"
local formatters = require "lvim.lsp.null-ls.formatters"
-- For a full list of built-in formatters,
-- see https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
formatters.setup {
  -- More opinionated version of gofmt
  -- https://pkg.go.dev/mvdan.cc/gofumpt
  null_ls.builtins.formatting.gofumpt,
  -- Golines is a golang formatter that shortens long lines. Install with goimports to use it as the base formatter
  -- https://pkg.go.dev/github.com/wrype/golines
  null_ls.builtins.formatting.golines,
  -- A formatter and fixer for JSON files.
  -- https://github.com/rhysd/fixjson
  null_ls.builtins.formatting.fixjson,
  { command = "bean-format", filetypes = { "beancount" } },
  -- { command = "black", filetypes = { "python" } },
  -- { command = "isort", filetypes = { "python" } },
  -- {
  --   -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
  --   command = "prettier",
  --   ---@usage arguments to pass to the formatter
  --   -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
  --   extra_args = { "--print-with", "100" },
  --   ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
  --   filetypes = { "typescript", "typescriptreact" },
  -- },
}

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }

-- Additional Plugins
lvim.plugins = {
  { 'sainnhe/gruvbox-material' },
  { "christoomey/vim-tmux-navigator" },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  -- Git plugin for vim
  { 'tpope/vim-fugitive' },
  -- Support using '.' to repeat extra actions
  { 'tpope/vim-repeat' },
  -- Autodetect filetype indentation settings
  { 'tpope/vim-sleuth' },
  -- Add / delete / replace surroundings of a sandwiched textobject
  -- Docs: https://github.com/machakann/vim-sandwich/wiki
  { 'machakann/vim-sandwich' },
  -- Runs lsp format on modifications only
  { 'joechrisellis/lsp-format-modifications.nvim',
    config = function()
      -- Silence error when language server does not support ranged formatting (most don't)
      vim.g.lsp_format_modifications_silence = true

      local lsp_format_modifications = require "lsp-format-modifications"
      lvim.lsp.on_attach_callback = function(client, bufnr)
        lsp_format_modifications.attach(client, bufnr, { format_on_save = true })
      end
    end
  },
  -- Golang plugin
  -- https://github.com/ray-x/go.nvim
  {
    'ray-x/go.nvim',
    ft = "go",
    requires = {
      "ray-x/guihua.lua",
    },
    -- config function runs _after_ plugin is loaded.
    config = function()
      -- https://github.com/ray-x/go.nvim#configuration
      require('go').setup({ gotests_template = "testify" })
      -- Use <leader>c to toggle test coverage
      vim.api.nvim_set_keymap(
        'n', '<leader>c', ":GoCoverage -p -t<cr>",
        { noremap = true, desc = 'Toggle coverage for current package' }
      )
    end
  },
  -- Test runner supporting multiple languages
  -- https://github.com/nvim-neotest/neotest
  {
    "nvim-neotest/neotest",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-neotest/neotest-go",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim"
    },
    config = function()
      -- get neotest namespace (api call creates or returns namespace)
      local neotest_ns = vim.api.nvim_create_namespace("neotest")
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            local message =
            diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, neotest_ns)
      require("neotest").setup({
        -- your neotest config here
        adapters = {
          require("neotest-go"),
        },
      })
    end,
  },
}

vim.filetype.add({
  extension = {
    ['zsh-theme'] = 'zsh',
  },
  filename = {
    -- Waf scripts are python
    ['wscript'] = 'python',
  },
  pattern = {
    -- Set Jenkinsfiles as groovy
    ['.*[jJ]enkinsfile.*'] = 'groovy',
    -- Some repos use dockerfile as a prefix
    ['[Dd]ockerfile.*'] = 'dockerfile'
  }
})

-- Use 'gp' to select last pasted text in visual mode
vim.api.nvim_set_keymap('n', 'gp', "'`[' . strpart(getregtype(), 0, 1) . '`]'",
  { noremap = true, expr = true, desc = 'Select last pasted' })

-- list_snips lists all snippets for the current filetype
local list_snips = function()
  local ft_list = require("luasnip").available()[vim.o.filetype]
  local ft_snips = {}
  for _, item in pairs(ft_list) do
    ft_snips[item.trigger] = item.name
  end
  print(vim.inspect(ft_snips))
end

vim.api.nvim_create_user_command("ListSnips", list_snips, {})

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- Named group for autocommands
-- Force recreation of autocmd group to overwrite previously defined autocommands.
-- Allows for realoading this config without duplicating autocommands.
-- Must run :LVimCacheReset for changes to take effect.
local my_autocmd_group = vim.api.nvim_create_augroup("tkennedy-custom", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = my_autocmd_group,
  pattern = "*.zsh",
  callback = function()
    -- let treesitter use bash highlight for zsh files as well
    require("nvim-treesitter.highlight").attach(0, "bash")
  end,
})
-- when saving a buffer that starts with a shebang, make it executable
vim.api.nvim_create_autocmd("BufWritePost", {
  group = my_autocmd_group,
  pattern = "*",
  callback = function()
    if string.match(vim.fn.getline(1), "^#!.*/bin/") then
      vim.fn.execute("!chmod a+x %", "silent")
    end
  end,
})
