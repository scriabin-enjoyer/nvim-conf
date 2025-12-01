-- =============================================================================
-- CONTENTS
-- 1. OPTIONS & GLOBALS
-- 2. BASIC KEYMAPS
-- 3. BASIC AUTOCOMMANDS & USERCOMMANDS
-- 4. LAZY
-- 5. LSP
-- 6. AUTOCOMPLETE
-- X. EXTRAS
-- =============================================================================

print("INITIALIZING CONFIG")

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
vim.opt.termguicolors = false
vim.opt.wrap = true
vim.schedule(function()
    vim.opt.clipboard = 'unnamedplus'
end)

-- DISABLED:
-- vim.opt.undofile = true
-- vim.opt.swapfile = false
-- vim.opt.showtabline = 2
-- vim.opt.backup = false
-- vim.opt.writebackup = false

print("Initialized: Options")

-- =============================================================================
-- 2. BASIC KEYMAPS
-- =============================================================================

-- Leave insert
vim.keymap.set('i', '<C-]>', '<Esc>', { desc = 'Leave Insert Mode' })

-- Better navigation inside Insert Mode
vim.keymap.set('i', '<C-h>', '<Left>',  { desc = 'Move left' })
vim.keymap.set('i', '<C-j>', '<Down>',  { desc = 'Move down' })
vim.keymap.set('i', '<C-k>', '<Up>',    { desc = 'Move up' })
vim.keymap.set('i', '<C-l>', '<Right>', { desc = 'Move right' })

-- Insert Mode Word motions
vim.keymap.set('i', '<C-b>', '<C-o>b', { desc = 'Jump back one word' })
vim.keymap.set('i', '<C-w>', '<C-o>w', { desc = 'Jump forward to next word start' })

-- Insert Mode Line Motions
vim.keymap.set('i', '<C-e>', '<C-o>$', { desc = 'Jump to line end' })
vim.keymap.set('i', '<C-a>', '<C-o>_', { desc = 'Jump to line start' })

-- Clear highlights on search when pressing <Esc> in normal mode; See `:h hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic Keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show [D]iagnostic error messages' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>`', function()
        vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = 'Toggle Diagnostics' })

-- Exit Terminal Mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Better Page Navigation
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Recenter cursor after page up' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Recenter cursor after page down' })

-- Better Window Navigation (I never use windows so may just get rid of these)
-- vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
-- vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
-- vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

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

-- Toggle LSP
vim.keymap.set('n', '<leader>tl', function()
    local buf = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients({ bufnr = buf })
    if buf then
        if not vim.tbl_isempty(clients) then
            vim.cmd("LspStop")
            print("Lsp Stopped")
        else
            vim.cmd("LspStart")
            print("Lsp Started")
        end
    else
        vim.print('No Lsp clients attached!')
    end
end, { desc = '[T]oggle LSP Client' })

-- Insert newline above and below cursor
vim.keymap.set("n", "<leader>o", "o<Esc>k", { desc = 'Insert newline below cursor' })
vim.keymap.set("n", "<leader>O", "O<Esc>j", { desc = 'Insert newline above cursor' })

print("Initialized: Basic Keymaps")

-- =============================================================================
-- 3. BASIC AUTOCOMMANDS & USERCOMMANDS
-- =============================================================================

-- Highlist when yanking
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Filetype Indents
local function indent_filetypes(ft, s)
    vim.api.nvim_create_autocmd("Filetype", {
        group = vim.api.nvim_create_augroup('set-ft-indent-opts', { clear = true }),
        pattern = ft,
        command = "setlocal sw=".. s .. " ts=" .. s .. " sts=" .. s .. " expandtab"
    })
end

indent_filetypes("eruby", "2")
indent_filetypes("html", "2")
indent_filetypes("css", "2")
indent_filetypes("javascript", "8")
indent_filetypes("python", "4")
indent_filetypes("c", "8")
indent_filetypes("ruby", "2")
indent_filetypes("lua", "4")

-- Adds format on save with erb-formatter gem cli program.
-- NOTE: must have erb-format on path
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "eruby" },
    callback = function()
        vim.keymap.set("n", "<leader>f", function()
            vim.cmd("write")
            vim.fn.system({ "erb-format", vim.fn.expand("%:p"), "--write" })
            vim.cmd("edit")
        end, { desc = "Format ERB file" })
    end
})

-- Switch all ERB open tags to comments
vim.api.nvim_create_autocmd("Filetype", {
    group = vim.api.nvim_create_augroup('erb-comment-insert', { clear = true }),
    pattern = { "eruby" },
    callback = function()
        vim.keymap.set('v', '<leader>gci', ":s/<%/<%#/g<CR>", { desc = "Insert ERB comments" })
    end
})

-- Switch all ERB comments to regular tags
vim.api.nvim_create_autocmd("Filetype", {
    group = vim.api.nvim_create_augroup('erb-comment-remover', { clear = true }),
    pattern = { "eruby" },
    callback = function()
        vim.keymap.set('v', '<leader>gcr', ":s/<%#/<%/g<CR>", { desc = "Remove ERB comments" })
    end
})

-- Fix HTML tag indenting; see :h html-indent
vim.api.nvim_create_autocmd("Filetype", {
    group = vim.api.nvim_create_augroup('html-indent-fix', { clear = true }),
    pattern = { "html", }, --"eruby", "*.html.erb"},
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

-- Print Server Capabilities of first attached Language Server
vim.api.nvim_create_user_command(
    'LspCapabilities',
    'lua =vim.lsp.get_active_clients()[1].server_capabilities',
    {}
)

-- Hot Reload Nvim Conf
-- NOTE: Can't resource lazy-related features (plugin configs, etc.). It will
-- say not supported, but fails gracefully 
vim.api.nvim_create_user_command(
    'Soconf',
    'source ~/.config/nvim/init.lua',
    {}
)

print("Initialized: Auto and User Commands")

-- =============================================================================
-- 4. LAZY
-- =============================================================================

-- Load plugins table
local plugins = require('plugin-specs')

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

-- Plugin Installations; see https://lazy.folke.io/configuration for options
require('lazy').setup({
    spec = plugins,
    rocks = {
        enabled = false,
    }
})

print("Initialized: Plugins")

-- =============================================================================
-- 5. LSP
-- =============================================================================

-- Load LspAttach Autocommand
require('lsp')
print("Initialized: LspAttach Callback")

-- Setup Mason before everything else
require('mason').setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    },
})

-- Load nvim-lspconfig helper module
local nvim_lspconfig = require('lspconfig')

-- EXTEND NEOVIM'S CLIENT CAPABILITIES:
-- Load nvim-lspconfig default config
local lspconfig_defaults = nvim_lspconfig.util.default_config
-- Generate (extended) clientCapabilities table from cmp
local cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Override and extend default neovim clientCapabilities with the cmp one
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lspconfig_defaults.capabilities,
    cmp_capabilities
)

-- Load and Setup Mason Servers
local mason_servers = require('mason-server-configs')
require('mason-lspconfig').setup({
    ensure_installed = vim.tbl_keys(mason_servers or {}),
    automatic_installation = false,
    handlers = {
        function(server_name)
            local server_config = mason_servers[server_name] or {}
            nvim_lspconfig[server_name].setup(server_config)
        end,
    },
})

-- Load and Setup Custom Servers
local custom_servers = require('custom-server-configs')
for server_name, server_config in pairs(custom_servers) do
    nvim_lspconfig[server_name].setup(server_config)
end

-- This is for a custom project
-- require('scheme_lsp')

print("Initialized: Mason and Language Servers")

-- =============================================================================
-- 6. CMP 
-- =============================================================================

local cmp = require 'cmp'
cmp.setup({
    snippet = {
        expand = function(args)
            vim.snippet.expand(args.body)
        end,
    },
    completion = { completeopt = 'menu,menuone,noinsert' },
    mapping = cmp.mapping.preset.insert {
        -- Select the [n]ext item
        ['<Tab>'] = cmp.mapping.select_next_item(),
        -- Select the [p]revious item
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        -- Scroll the documentation window [b]ack / [f]orward
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        -- Abort selection, close completion menu, stays in insert
        ['<C-e>'] = cmp.mapping.abort(),
        -- Accept ([y]es) the completion.
        ['<C-y>'] = cmp.mapping.confirm { select = true },
    },
    sources = {
        {
            name = 'lazydev',
            -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
            group_index = 0,
        },
        { name = 'nvim_lsp', },
        { name = 'buffer'},
        { name = 'path'},
        { name = 'nvim_lsp_signature_help'},
        { name = 'omni' },
    },
    formatting = {
        format = function(entry, item)
            local lspserver_name = nil
            if entry.source.name == 'nvim_lsp' then
                local ok, _ = pcall(function()
                    lspserver_name = entry.source.source.client.name
                end)
                if not ok then lspserver_name = 'LSP' end
            else
                lspserver_name = 'LSP'
            end
            local menu_icon = {
                lazydev = 'lazy',
                nvim_lsp = lspserver_name,
                buffer = 'Buff',
                path = 'Path',
            }
            item.menu = menu_icon[entry.source.name]
            return item
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
})

print("Initialized: CMP")

-- =============================================================================
-- X. EXTRAS
-- =============================================================================

vim.cmd [[ colo vscode ]]

-- set @comment hl group to grey (tree sitter)
-- Dark grey1: #4a5057
-- lighter grey1: #5f6163
-- lightest grey1: #939699
-- vim.api.nvim_set_hl(0, "@comment", { fg = "#939699", bg = 'NONE', italic = true })

-- Custom color for the color column
-- vim.cmd [[:highlight colorcolumn guibg=#496157]]

-- root directory query: https://github.com/neovim/nvim-lspconfig/issues/320

print("CONFIG INITIALIZED")
