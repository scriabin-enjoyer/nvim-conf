-- =============================================================================
-- GREP
-- 1. OPTIONS & GLOBALS
-- 2. BASIC KEYMAPS
-- 3. BASIC AUTOCOMMANDS
--      - filetype indents
-- 4. PLUGIN LIST
-- 5. LAZY (plugin installation)
-- 6. LSP
-- 7. AUTOCOMPLETE
-- X. EXTRAS
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
vim.opt.termguicolors = true
vim.opt.wrap = true
vim.schedule(function()
    vim.opt.clipboard = 'unnamedplus'
end)

-- vim.opt.undofile = true
-- vim.opt.swapfile = false
-- vim.opt.showtabline = 2
-- vim.opt.backup = false
-- vim.opt.writebackup = false

print("Options set")

-- =============================================================================
-- 2. BASIC KEYMAPS
-- =============================================================================

-- Leave insert
vim.keymap.set('i', '<C-]>', '<Esc>', { desc = 'Leave Insert Mode' })

-- Clear highlights on search when pressing <Esc> in normal mode; See `:help hlsearch`
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

-- Toggle LSP
vim.keymap.set('n', '<leader>tl', function()
    local buf = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients({ bufnr = buf })
    if not buf then
        if not vim.tbl_isempty(clients) then
            vim.cmd("LspStop")
        else
            vim.cmd("LspStart")
        end
    else
        vim.print('No Lsp clients attached!')
    end
end, { desc = '[T]oggle LSP Client' })

-- Insert newline above and below cursor
vim.keymap.set("n", "<leader>o", "o<Esc>k", { desc = 'Insert newline below cursor' })
vim.keymap.set("n", "<leader>O", "O<Esc>j", { desc = 'Insert newline above cursor' })

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
-- TODO: move to after/ or ftplugin
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

-- Plugin Installations ; see https://lazy.folke.io/configuration for options
require('lazy').setup({
    spec = plugins,
    rocks = {
        enabled = false,
    }
})

print("Plugins Initialized")

-- =============================================================================
-- 6. LSP
-- =============================================================================

-- Setup Mason before everything else so we have servers to work with
require('mason').setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    },
})
-- LspAttach autocmd, Keymaps, diagnostics
require('lsp')

-- Generate (extended) Capabilities Object to extend client/server capabilities
local cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Load nvim-lspconfig default config
local lspconfig_defaults = require('lspconfig').util.default_config
-- Override client capabilities in nvim-lspconfig for servers it configures
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lspconfig_defaults.capabilities,
    cmp_capabilities
)
-- Load vim.lsp client capabilities
local vim_lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
-- Store extended client capabilities to use for servers not configured with lspconfig
local extended_capabilities = vim.tbl_deep_extend('force', vim_lsp_capabilities, cmp_capabilities)
-- Load servers and their configs
local servers = require('server-configs')
local ensure_installed_servers = vim.tbl_keys(servers or {})

-- Setup handler for each server ; pass the server and its config to the callback
require('mason-lspconfig').setup({
    ensure_installed = ensure_installed_servers,
    automatic_installation = false,
    handlers = {
        function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, extended_capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
        end,
    },
})
vim.api.nvim_create_user_command(
    'LspCapabilities',
    'lua =vim.lsp.get_active_clients()[1].server_capabilities',
    {}
)

require('scheme_lsp')

-- DON"T RUSE MASON TO INSTALL RUBY_LSP: 
-- https://github.com/williamboman/mason.nvim/issues/1292
-- https://shopify.github.io/ruby-lsp/editors.html#neovim
-- =============================================================================
-- 7. CMP 
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
        ['<C-n>'] = cmp.mapping.select_next_item(),
        -- Select the [p]revious item
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        -- Scroll the documentation window [b]ack / [f]orward
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
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

-- =============================================================================
-- X. EXTRAS
-- =============================================================================
-- root directory query: https://github.com/neovim/nvim-lspconfig/issues/320

vim.cmd [[colo]]
-- ColorSchemeRankings
-- vscode
-- tokyodark
-- material_deepocean
-- moonfly
-- onedark_dark
-- github_dark_defualt
-- kanagawa_wave
-- kanagawa_dragon
