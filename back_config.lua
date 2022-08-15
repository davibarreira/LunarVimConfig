--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.log.level = "warn"
vim.opt.shiftwidth = 4
lvim.format_on_save = false
lvim.lint_on_save = false
-- lvim.colorscheme = "onedarker"
-- lvim.colorscheme = "sonokai"
-- vim.cmd("let g:sonokai_style = 'andromeda'")
-- vim.cmd("let g:sonokai_enable_italic_comment = 1")

-- vim.cmd("let g:slime_target = 'kitty'")

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = false
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"
vim.opt.wrap = true -- display lines as one long line
vim.opt.spelllang = "en" -- default spell check language
lvim.keys.normal_mode["<F2>"] = ":set spell!<CR>" -- toggle spell check
lvim.keys.normal_mode["<F4>"] = ":set spelllang=en<CR>"
lvim.keys.normal_mode["<F3>"] = ":set spelllang=pt_br<CR>"


lvim.keys.normal_mode["<C-b>"] = ":KittySendLines<CR>"
lvim.keys.visual_mode["<C-b>"] = ":KittySendLines<CR>"
-- lvim.keys.visual_mode["<leader-t-j>"] = ":KittyOpenRunner<CR>"
-- vim.cmd("let g:floaterm_keymap_toggle = '<C-j>'")
-- vim.cmd("let g:floaterm_position = 'right'")
-- vim.cmd("let g:floaterm_wintype = 'float'")
-- vim.cmd("let g:floaterm_height = 1.0")
-- vim.cmd("let g:floaterm_width = 0.5")
-- vim.cmd("let g:floaterm_shell = 'kitty'")
-- lvim.keys.normal_mode["<C-b>"] = ":FloatermSend<CR><esc>j:FloatermToggle<CR>"
-- lvim.keys.visual_mode["<C-b>"] = ":'<,'>FloatermSend<CR>:FloatermToggle<CR>"

-- lvim.keys.normal_mode["<C-b>"] = ":FloatermSend<CR><esc>j:FloatermToggle<CR>"
-- lvim.keys.visual_mode["<C-b>"] = ":'<,'>FloatermSend<CR>:FloatermToggle<CR>"
-- -- lvim.keys.normal_mode["<F9>"] = ":%FloatermSend<CR>:FloatermToggle<CR>"
-- lvim.keys.normal_mode["<A-S-l>"] = ":FloatermNew<CR>"
-- lvim.keys.normal_mode["<A-S-]>"] = ":FloatermNext<CR>"
-- lvim.keys.normal_mode["<F9>"] = ":FloatermSend!;clear<CR>:FloatermToggle<CR><BS>"
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
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
-- }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
    "bash",
    "c",
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
lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings
require 'lspconfig'.julials.setup {
    on_new_config = function(new_config, _)
        local julia = vim.fn.expand("~/.julia/environments/nvim-lspconfig/bin/julia")
        if require 'lspconfig'.util.path.is_file(julia) then
            new_config.cmd[1] = julia
        end
    end
}

-- ---@usage disable automatic installation of servers
lvim.lsp.automatic_servers_installation = false

-- ---@usage Select which servers should be configured manually. Requires `:LvimCacheReset` to take effect.
-- See the full default list `:lua print(vim.inspect(lvim.lsp.override))`
-- vim.list_extend(lvim.lsp.override, { "pyright" })

-- ---@usage setup a server -- see: https://www.lunarvim.org/languages/#overriding-the-default-configuration
local opts = {} -- check the lspconfig documentation for a list of all possible options
require("lvim.lsp.manager").setup("pylsp", opts)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
    --     { command = "black", filetypes = { "python" } },
    --     -- { command = "isort", filetypes = { "python" } },
    --     {
    --         -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    command = "Prettier", filetypes = { "html" },
    --         ---@usage arguments to pass to the formatter
    --         -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
    --         extra_args = { "--print-with", "100" },
    --         ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    --         filetypes = { "typescript", "typescriptreact" },
    -- },
}

-- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--     { command = "flake8", filetypes = { "python" } },
-- {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
-- },
-- {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
-- },
-- }

-- Additional Plugins
lvim.plugins = {
    {
        "folke/trouble.nvim",
        cmd = "TroubleToggle",
    },
    { "lervag/vimtex" },
    { "JuliaEditorSupport/julia-vim" },
    { "projekt0n/github-nvim-theme" },
    {
        "iamcco/markdown-preview.nvim",
        run = "cd app && yarn install",
        ft = "markdown",
        config = function()
            vim.g.mkdp_auto_start = 1
        end,
    },
    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup({ "*" }, {
                RGB = true, -- #RGB hex codes
                RRGGBB = true, -- #RRGGBB hex codes
                RRGGBBAA = true, -- #RRGGBBAA hex codes
                rgb_fn = true, -- CSS rgb() and rgba() functions
                hsl_fn = true, -- CSS hsl() and hsla() functions
                css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
                css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
            })
        end,
    },
    {
        "rktjmp/lush.nvim",
    },
    { "rafi/awesome-vim-colorschemes" },
    { "voldikss/vim-floaterm" },
    {
        -- Plugin for quickly changing parenthesis, brackets and others
        "tpope/vim-surround",
        keys = { "c", "d", "y" }
    },
    { "tpope/vim-eunuch" },
    {
        'jghauser/kitty-runner.nvim',
        config = function()
            require('kitty-runner').setup()
        end
    },
    {
        "turbio/bracey.vim",
        cmd = { "Bracey", "BracyStop", "BraceyReload", "BraceyEval" },
        run = "npm install --prefix server",
    },
    { "sbdchd/neoformat" },
    {
        "prettier/vim-prettier",
        run = "npm install --frozen-lockfile --production"
    },

    -- {"L3MON4D3/LuaSnip"},
    -- {"rafamadriz/friendly-snippets"}
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }
lvim.autocommands.custom_groups = {
    { "BufWinEnter", "*.tex", "setlocal ts=2 sw=2" },
    { "BufWinEnter", "*.css", "setlocal ts=2 sw=2" },
    { "BufWinEnter", "*.html", "setlocal ts=2 sw=2" },
}
require("lvim.lsp.manager").setup("emmet_ls")

local cmp = require 'cmp'
lvim.builtin.cmp.mapping["<ESC>"] = cmp.mapping(function(fallback)
    cmp.close()
    fallback()
end)
