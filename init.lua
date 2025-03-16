-- =============================================================================
-- GREP
-- 1. OPTIONS & GLOBALS
-- 2. BASIC KEYMAPS
-- 3. BASIC AUTOCOMMANDS
--      - filetype indents
-- 4. PLUGIN LIST
-- 5. LAZY (plugin installation)
-- 6. PLUGIN CONFIGURATIONS
-- 7. LSP CONFIGURATION
-- =============================================================================

print("Initializing Config")

-- =============================================================================
-- 1. OPTIONS & GLOBALS
-- =============================================================================
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.breakindent = true
-- vim.opt.undofile = true
vim.opt.numberwidth = 4
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 500
vim.opt.inccommand = 'split'
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10
vim.opt.cmdheight = 2
vim.opt.conceallevel = 0
vim.opt.fileencoding = "utf-8"
vim.opt.hlsearch = true
vim.opt.pumheight = 10
vim.opt.wrap = true
vim.opt.smartindent = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.colorcolumn = '80'
vim.opt.guifont = "monospace:h17"
vim.opt.guicursor = "a:block,i-ci-ve-r:blinkwait1-blinkon350-blinkoff350"
vim.opt.expandtab = true
vim.opt.shiftwidth = 8
vim.opt.tabstop = 8
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.schedule(function()
        vim.opt.clipboard = 'unnamedplus'
end)

--[[ For Reference:
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.wrap = true
vim.opt.swapfile = false
vim.opt.showtabline = 2
vim.opt.backup = false
vim.opt.writebackup = false
-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
--]]

print("Options set")

-- =============================================================================
-- 2. BASIC KEYMAPS
-- =============================================================================

-- Clear highlights on search when pressing <Esc> in normal mode; See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic Keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show [D]iagnostic error messages' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })

-- Exit Terminal Mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Better Page Navigation
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Recenter cursor after page up' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Recenter cursor after page down' })

-- Better Window Navigation
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Explore Left
vim.keymap.set('n', '<leader>x', ':Lex 30<cr>', { desc = 'Open Left Netrw Explore' })

-- Resize Windows
vim.keymap.set('n', '<C-S-Up>', ':resize -1<CR>', { desc = 'Decrease window height' })
vim.keymap.set('n', '<C-S-Down>', ':resize +1<CR>', { desc = 'Increase window height' })
vim.keymap.set('n', '<C-S-Left>', ':vertical resize +1<CR>', { desc = 'Shift window left' })
vim.keymap.set('n', '<C-S-Right>', ':vertical resize +1<CR>', { desc = 'Shift window right' })

-- Buffers
vim.keymap.set('n', '<S-h>', ':bprevious<CR>', { desc = 'Switch to previous buffer' })
vim.keymap.set('n', '<S-l>', ':bnext<CR>', { desc = 'Switch to previous buffer' })
vim.keymap.set('n', '<leader>bd', ':bd<CR>', { desc = 'Delete current buffer' })

-- Stay in Visual Mode After Indent
vim.keymap.set('v', '<', '<gv', { desc = 'Retain visual mode after left indent' })
vim.keymap.set('v', '>', '>gv', { desc = 'Retain visual mode after right indent' })

-- Move Single Line Up and Down
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==")
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==")

-- Move Visual Selection Up and Down
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

print("Keymaps Initialized")

-- =============================================================================
-- 3. BASIC AUTOCOMMANDS
-- =============================================================================

-- Highlist when yanking
vim.api.nvim_create_autocmd('TextYankPost', {
        desc = 'Highlight when yanking (copying) text',
        group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
        callback = function()
                vim.highlight.on_yank()
        end,
})

-- Filetype Indents; locally scoped to block
do
        local function indent_filetypes(ft, s)
                vim.api.nvim_create_autocmd("Filetype", {
                        pattern = ft,
                        command = "setlocal sw=".. s .. " ts=" .. s .. " sts=" .. s .. " expandtab"
                })
        end

        indent_filetypes("html", "2")
        indent_filetypes("css", "2")
        indent_filetypes("javascript", "8")
        indent_filetypes("python", "4")
        indent_filetypes("c", "8")
        indent_filetypes("ruby", "2")
        indent_filetypes("lua", "8")
end

-- Fix HTML tag indenting; see :h html-indent
vim.api.nvim_create_autocmd("Filetype", {
        pattern = "html",
        callback = function()
                vim.cmd([[
                let g:html_indent_script1 = "inc"
                let g:html_indent_style1 = "inc"
                let g:html_indent_inctags = "p,style,script"
                call HtmlIndent_CheckUserSettings()
                ]])
                print("html indent formatting fixed")
        end
})

-- =============================================================================
-- 4. PLUGIN LIST
-- =============================================================================

local plugins = require('plugin-specs')

-- =============================================================================
-- 5. LAZY
-- =============================================================================

-- Bootstrap lazy.nvim; see https://lazy.folke.io/installation
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

-- Plugin Installations
require('lazy').setup({
        spec = plugins,
        rocks = {
                enabled = false,
        }
})


-- =============================================================================
-- 6. PLUGIN CONFIGURATIONS
-- =============================================================================

vim.cmd.colorscheme 'vscode'
