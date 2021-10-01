-- IMPORTANT TO REMEMBER
-- When inside the terminal, one can go into normal mode
-- by pressing <C-\><C-n>. This command is actually
-- native from Neovim.

-- Latex configuration
-- The snippets from Latex are inside the file
-- /~/.local/share/lunarvim/site/pack/packer/start/latex.json
-- The following snippets were deleted:
-- "nonumber": {
-- 	"prefix": "@,",
-- 	"body": "\\nonumber",
-- 	"description": "nonumber"
-- },
-- "etc": {
--   "prefix": "...",
--   "body": "\\dots",
--   "description": "\\dots"
-- },
-- "cdot": {
--   "prefix": "@.",
--   "body": "\\cdot",
--   "description": "\\cdot"
-- },

-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
-- vim.cmd("let g:vimtex_compiler_latexmk = {'continuous' : 0}")
lvim.keys.normal_mode["<F6>"] = ":VimtexCompile<CR>" -- toggle spell check 

-- DAVI - this is here to block the autocompletion on Latex to run after pressing Enter.
lvim.builtin.cmp.confirm_opts.select = false

vim.cmd("let g:latex_to_unicode_tab = 'off'")
vim.cmd("let g:latex_to_unicode_keymap = 1")
vim.opt.wrap = true -- display lines as one long line
vim.opt.spelllang = "en" -- default spell check language
lvim.keys.normal_mode["<F2>"] = ":set spell!<CR>" -- toggle spell check 
lvim.keys.normal_mode["<F4>"] = ":set spelllang=en<CR>"
lvim.keys.normal_mode["<F3>"] = ":set spelllang=pt_br<CR>"

-- vim.cmd("let g:floaterm_keymap_new = '<C-j>'")

-- Davi - Configurando Floating Terminal
-- lvim.keys.normal_mode["<C-'>"] = ":FloatermNew!julia<CR>"
vim.cmd("let g:floaterm_keymap_toggle = '<C-j>'")
vim.cmd("let g:floaterm_position = 'right'")
vim.cmd("let g:floaterm_wintype = 'float'")
vim.cmd("let g:floaterm_height = 1.0")
vim.cmd("let g:floaterm_width = 0.5")
-- vim.cmd("let g:floaterm_shell = 'kitty'")
lvim.keys.normal_mode["<C-b>"] = ":FloatermSend<CR><esc>j:FloatermToggle<CR>"
lvim.keys.visual_mode["<C-b>"] = ":'<,'>FloatermSend<CR>:FloatermToggle<CR>"
lvim.keys.normal_mode["<F9>"] = ":%FloatermSend<CR>:FloatermToggle<CR>"
lvim.keys.normal_mode["<A-S-l>"] = ":FloatermNew<CR>"
lvim.keys.normal_mode["<A-S-]>"] = ":FloatermNext<CR>"
lvim.keys.normal_mode["<C-a>"] = ":FloatermSend!;clear<CR>:FloatermToggle<CR><BS>"

-- general
vim.opt.shiftwidth = 4
lvim.format_on_save = true
lvim.lint_on_save = true
-- lvim.colorscheme = "onedarker"
-- lvim.colorscheme = "onedark"
lvim.colorscheme = "sonokai"
vim.cmd("let g:sonokai_style = 'andromeda'")
vim.cmd("let g:sonokai_enable_italic_comment = 1")

lvim.lsp.diagnostics.virtual_text = false

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = ""
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- lvim.builtin.telescope.on_config_done = function()
--   local actions = require "telescope.actions"
--   -- for input mode
--   lvim.builtin.telescope.defaults.mappings.i["<C-j>"] = actions.move_selection_next
--   lvim.builtin.telescope.defaults.mappings.i["<C-k>"] = actions.move_selection_previous
--   lvim.builtin.telescope.defaults.mappings.i["<C-n>"] = actions.cycle_history_next
--   lvim.builtin.telescope.defaults.mappings.i["<C-p>"] = actions.cycle_history_prev
--   -- for normal mode
--   lvim.builtin.telescope.defaults.mappings.n["<C-j>"] = actions.move_selection_next
--   lvim.builtin.telescope.defaults.mappings.n["<C-k>"] = actions.move_selection_previous
-- end

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnosticss" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnosticss" },
-- }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {}
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings
-- you can set a custom on_attach function that will be used for all the language servers
-- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end
-- you can overwrite the null_ls setup table (useful for setting the root_dir function)
-- lvim.lsp.null_ls.setup = {
--   root_dir = require("lspconfig").util.root_pattern("Makefile", ".git", "node_modules"),
-- }
-- or if you need something more advanced
-- lvim.lsp.null_ls.setup.root_dir = function(fname)
--   if vim.bo.filetype == "javascript" then
--     return require("lspconfig/util").root_pattern("Makefile", ".git", "node_modules")(fname)
--       or require("lspconfig/util").path.dirname(fname)
--   elseif vim.bo.filetype == "php" then
--     return require("lspconfig/util").root_pattern("Makefile", ".git", "composer.json")(fname) or vim.fn.getcwd()
--   else
--     return require("lspconfig/util").root_pattern("Makefile", ".git")(fname) or require("lspconfig/util").path.dirname(fname)
--   end
-- end

require'lspconfig'.julials.setup{
    on_new_config = function(new_config, _)
        local julia = vim.fn.expand("~/.julia/environments/nvim-lspconfig/bin/julia")
        if require'lspconfig'.util.path.is_file(julia) then
            new_config.cmd[1] = julia
        end
    end
}

-- set a formatter if you want to override the default lsp one (if it exists)
-- lvim.lang.python.formatters = {
--   {
--     exe = "black",
--     args = {}
--   }
-- }
-- set an additional linter
-- lvim.lang.python.linters = {
--   {
--     exe = "flake8",
--     args = {}
--   }
-- }

-- Additional Plugins
lvim.plugins = {
    {"folke/tokyonight.nvim"},
    -- {
    --     "ray-x/lsp_signature.nvim",
    --     config = function() require"lsp_signature".on_attach() end,
    --     event = "InsertEnter"
    -- },
    {"KeitaNakamura/neodark.vim"},
    {"rakr/vim-one"},
    {"joshdick/onedark.vim"},
    {"lervag/vimtex"},
    {"JuliaEditorSupport/julia-vim"},
    {"projekt0n/github-nvim-theme"},
    {
      "iamcco/markdown-preview.nvim",
      run = "cd app && npm install",
      ft = "markdown",
      config = function()
        vim.g.mkdp_auto_start = 0
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
    {"rafi/awesome-vim-colorschemes"},
    {"voldikss/vim-floaterm"},
    {
    -- Plugin for quickly changing parenthesis, brackets and others
      "tpope/vim-surround",
      keys = {"c", "d", "y"}
    },
    {"tpope/vim-eunuch"}
    -- Plugin for autoparing parenthesis and others
    -- {"windwp/nvim-autopairs"}
}



-- Autocommands (https://neovim.io/doc/user/autocmd.html)
lvim.autocommands.custom_groups = {
  { "BufWinEnter", "*", ":PackerLoad nvim-autopairs" },
  { "BufWinEnter", "*.tex", "setlocal ts=2 sw=2" },
}
