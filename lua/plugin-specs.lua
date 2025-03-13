-- CONTENTS
-- 1. COLORSCHEME
-- 2. GITSIGNS
-- 3. INDENTBLANKLINES IBL
-- 4. TOGGLETERM

return {
        -- 1. COLORSCHEME ; see https://github.com/Mofiqul/vscode.nvim
        {
                -- REMEMBER TO SET colorscheme IN TOP LEVEL init.lua
                "Mofiqul/vscode.nvim",
                priority = 1000,
                opts = {
                        transparent = true,
                        italic_comments = true,
                        underline_links = true,
                        terminal_colors = false,
                        color_overrides = {
                                vscBack = "#0a0a0a",
                        },
                },
        },

        -- 2. GITSIGNS ; see https://github.com/lewis6991/gitsigns.nvim
        {
                'lewis6991/gitsigns.nvim',
                opts = {
                        signs = {
                                add          = { text = '┃' },
                                change       = { text = '┃' },
                                delete       = { text = '_' },
                                topdelete    = { text = '‾' },
                                changedelete = { text = '~' },
                                untracked    = { text = '┆' },
                        },
                        signs_staged = {
                                add          = { text = '┃' },
                                change       = { text = '┃' },
                                delete       = { text = '_' },
                                topdelete    = { text = '‾' },
                                changedelete = { text = '~' },
                                untracked    = { text = '┆' },
                        },
                        signs_staged_enable = true,
                        signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
                        numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
                        linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
                        word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
                        watch_gitdir = {
                                follow_files = true
                        },
                        auto_attach = true,
                        attach_to_untracked = false,
                        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
                        current_line_blame_opts = {
                                virt_text = true,
                                virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
                                delay = 1000,
                                ignore_whitespace = false,
                                virt_text_priority = 100,
                                use_focus = true,
                        },
                        current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
                        sign_priority = 6,
                        update_debounce = 100,
                        status_formatter = nil, -- Use default
                        max_file_length = 40000, -- Disable if file is longer than this (in lines)
                        preview_config = {
                                -- Options passed to nvim_open_win
                                border = 'single',
                                style = 'minimal',
                                relative = 'cursor',
                                row = 0,
                                col = 1
                        },
                        on_attach = function(bufnr)
                                local gitsigns = require('gitsigns')

                                local function map(mode, l, r, opts)
                                        opts = opts or {}
                                        opts.buffer = bufnr
                                        vim.keymap.set(mode, l, r, opts)
                                end

                                -- Navigation
                                map('n', ']g', function()
                                        if vim.wo.diff then
                                                vim.cmd.normal({']c', bang = true})
                                        else
                                                gitsigns.nav_hunk('next')
                                        end
                                end)

                                map('n', '[g', function()
                                        if vim.wo.diff then
                                                vim.cmd.normal({'[c', bang = true})
                                        else
                                                gitsigns.nav_hunk('prev')
                                        end
                                end)
                        end,
                },
        },

        -- 3. INDENTBLANKLINES IBL ; see https://github.com/lukas-reineke/indent-blankline.nvim
        {
                "lukas-reineke/indent-blankline.nvim",
                main = "ibl",
                ---@module "ibl"
                ---@type ibl.config
                opts = {
                        indent = { char = '▏' },
                },
        },
        -- 4. TOGGLETERM
        {

        },
}
