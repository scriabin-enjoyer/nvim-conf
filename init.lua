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
-- vim.keymap.set('n', '<leader>x', ':Lex 30<cr>', { desc = 'Open Left Netrw Explore' })

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

print("Keymaps Initialized")

-- =============================================================================
-- 3. BASIC AUTOCOMMANDS
-- =============================================================================

-- Highlist when yanking
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

-- Filetype Indents; locally scoped to block
-- TODO: move to after/ or ftplugin
do
    local function indent_filetypes(ft, s)
        vim.api.nvim_create_autocmd("Filetype", {
            group = vim.api.nvim_create_augroup('set-ft-indent-opts', { clear = true }),
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
    indent_filetypes("lua", "4")
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

-- Ensure installed servers here. Configure server-specific settings later
-- DON"T RUSE MASON TO INSTALL RUBY_LSP: 
-- https://github.com/williamboman/mason.nvim/issues/1292
-- https://shopify.github.io/ruby-lsp/editors.html#neovim
require('mason-lspconfig').setup({
    ensure_installed = {
        'lua_ls', 'clangd', 'html',
    },
})

-- Add more client capabilities from cmp_nvim_lsp
-- Neovim does not implement entire LSP spec in core
-- We must add on these left-out capabilities and advertise them to our servers
local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lspconfig_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
)

-- Create autocommand to enable LSP features when the LspAttach event is triggered
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
    callback = function(event)
        -- Keymap Helper
        local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end
        map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
        map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
        map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
        map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
        map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
        map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
        ---@param client vim.lsp.Client
        ---@param method vim.lsp.protocol.Method
        ---@param bufnr? integer some lsp support methods only in specific files
        ---@return boolean
        local function client_supports_method(client, method, bufnr)
            if vim.fn.has 'nvim-0.11' == 1 then
                return client:supports_method(method, bufnr)
            else
                return client.supports_method(method, { bufnr = bufnr })
            end
        end

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            --Highlight word under symbol
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
            })
            -- Remove highlight on move
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
            })
            -- Cleanup
            vim.api.nvim_create_autocmd('LspDetach', {
                group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
                callback = function(event2)
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
                end,
            })
        end

        -- The following code creates a keymap to toggle inlay hints in your
        -- code, if the language server you are using supports them
        -- This may be unwanted, since they displace some of your code
        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>th', function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
        end
    end,
})

vim.diagnostic.config {
    severity_sort = true,
    float = { border = 'rounded', source = 'if_many' },
    underline = { severity = vim.diagnostic.severity.ERROR },
    virtual_text = {
        source = 'if_many',
        spacing = 2,
        format = function(diagnostic)
            local diagnostic_message = {
                [vim.diagnostic.severity.ERROR] = diagnostic.message,
                [vim.diagnostic.severity.WARN] = diagnostic.message,
                [vim.diagnostic.severity.INFO] = diagnostic.message,
                [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
        end,
    },
}

-- =============================================================================
-- X. EXTRAS
-- =============================================================================

-- root directory query: https://github.com/neovim/nvim-lspconfig/issues/320

vim.cmd [[colo]]
-- vscode
-- tokyodark
-- material_deepocean
-- moonfly
-- onedark_dark
-- github_dark_defualt
-- kanagawa_wave
-- kanagawa_dragon

-- for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do vim.api.nvim_set_hl(0, group, {}) end

---[[ Here for reference:
--]]
