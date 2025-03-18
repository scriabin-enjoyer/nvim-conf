-- CONTENTS
-- 0. WHICHKEY
-- 1. COLORSCHEME
-- 2. GITSIGNS
-- 3. INDENTBLANKLINES IBL
-- 4. TOGGLETERM
-- 5. TELESCOPE
-- 6. LSP

return {
        -- 0. COLORSCHEME ; see https://github.com/Mofiqul/vscode.nvim
        {
                -- REMEMBER TO SET colorscheme IN TOP LEVEL init.lua
                "Mofiqul/vscode.nvim",
                priority = 1000,
                lazy = false,
                config = function()
                        local opts = {
                                transparent = true,
                                italic_comments = true,
                                underline_links = true,
                                terminal_colors = false,
                                color_overrides = {
                                        vscBack = "#0a0a0a",
                                },
                        }
                        require('vscode').setup(opts)
                        vim.cmd [[colorscheme vscode]]
                end,
        },

        -- 1. WHICHKEY ; see https://github.com/folke/which-key.nvim
        {
                "folke/which-key.nvim",
                enabled = true,
                event = "VeryLazy",
                opts = {
                        preset = 'helix',
                        delay = 0,
                        icons = {
                                mappings = vim.g.have_nerd_font,
                                keys = vim.g.have_nerd_font and {} or {
                                        Up = '<Up> ',
                                        Down = '<Down> ',
                                        Left = '<Left> ',
                                        Right = '<Right> ',
                                        C = '<C-…> ',
                                        M = '<M-…> ',
                                        D = '<D-…> ',
                                        S = '<S-…> ',
                                        CR = '<CR> ',
                                        Esc = '<Esc> ',
                                        ScrollWheelDown = '<ScrollWheelDown> ',
                                        ScrollWheelUp = '<ScrollWheelUp> ',
                                        NL = '<NL> ',
                                        BS = '<BS> ',
                                        Space = '<Space> ',
                                        Tab = '<Tab> ',
                                        F1 = '<F1>',
                                        F2 = '<F2>',
                                        F3 = '<F3>',
                                        F4 = '<F4>',
                                        F5 = '<F5>',
                                        F6 = '<F6>',
                                        F7 = '<F7>',
                                        F8 = '<F8>',
                                        F9 = '<F9>',
                                        F10 = '<F10>',
                                        F11 = '<F11>',
                                        F12 = '<F12>',
                                },
                        },
                },
                keys = {
                        {
                                "<leader>?",
                                function()
                                        require("which-key").show({ global = false })
                                end,
                                desc = "Buffer Local Keymaps (which-key)",
                        },
                },
                -- Document existing key chains
                spec = {
                        { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
                        { '<leader>d', group = '[D]ocument' },
                        { '<leader>r', group = '[R]ename' },
                        { '<leader>s', group = '[S]earch' },
                        { '<leader>w', group = '[W]orkspace' },
                        { '<leader>t', group = '[T]oggle' },
                        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
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
                                -- local map fn for ease of use
                                local function map(mode, l, r, opts)
                                        opts = opts or {}
                                        opts.buffer = bufnr
                                        vim.keymap.set(mode, l, r, opts)
                                end
                                -- to pass to map
                                local opts_next = { desc = 'Goto next hunk' }
                                local opts_prev = { desc = 'Goto prev hunk' }
                                local opts_preview = { desc = 'Preview hunk' }
                                -- Navigation ; find next hunk
                                map('n', ']g', function()
                                        if vim.wo.diff then
                                                vim.cmd.normal({']c', bang = true})
                                        else
                                                gitsigns.nav_hunk('next')
                                        end
                                end, opts_next)
                                -- Navigation ; find prev hunk
                                map('n', '[g', function()
                                        if vim.wo.diff then
                                                vim.cmd.normal({'[c', bang = true})
                                        else
                                                gitsigns.nav_hunk('prev')
                                        end
                                end, opts_prev)
                                -- Preview Hunk in little window
                                map('n', '<leader>gp', gitsigns.preview_hunk, opts_preview)
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
                'akinsho/toggleterm.nvim',
                version = "*",
                opts = {
                        size = 20,
                        open_mapping = [[<c-\>]],
                        hide_numbers = true,
                        --shade_filetypes = {},
                        --shade_terminals = true,
                        --shading_factor = 2,
                        start_in_insert = true,
                        insert_mappings = true,
                        persist_size = true,
                        direction = "float",
                        close_on_exit = true,
                        shell = vim.o.shell,
                        float_opts = {
                                border = "curved",
                                winblend = 0,
                                highlights = {
                                        border = "Normal",
                                        background = "Normal",
                                },
                        },
                },
        },

        -- 5. TELESCOPE
        {
                'nvim-telescope/telescope.nvim',
                event = 'VimEnter',
                branch = '0.1.x',
                dependencies = {
                        'nvim-lua/plenary.nvim',
                        {
                                'nvim-telescope/telescope-fzf-native.nvim',
                                build = 'make',
                                cond = function()
                                        return vim.fn.executable 'make' == 1
                                end,
                        },
                        {
                                'nvim-telescope/telescope-ui-select.nvim'
                        },
                },
                config = function()
                        require('telescope').setup({
                                defaults = {
                                        layout_strategy = 'vertical',
                                        layout_config = {
                                                horizontal = {
                                                        preview_width = 0.6
                                                }
                                        }
                                },
                                pickers = {},
                                extensions = {
                                         ['ui-select'] = {
                                                 require('telescope.themes').get_dropdown(),
                                         },
                                         fzf = {},
                                },
                        })
                        -- Enable Telescope extensions if they are installed
                        require('telescope').load_extension('fzf')
                        require('telescope').load_extension('ui-select')
                        -- p := phind
                        local builtin = require 'telescope.builtin'
                        vim.keymap.set('n', '<leader>ph', builtin.help_tags, { desc = '[S]earch [H]elp' })
                        vim.keymap.set('n', '<leader>pk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
                        vim.keymap.set('n', '<leader>pt', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
                        vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = '[S]earch [F]iles' })
                        vim.keymap.set('n', '<leader>pw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
                        vim.keymap.set('n', '<leader>pg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
                        vim.keymap.set('n', '<leader>pd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
                        vim.keymap.set('n', '<leader>po', builtin.oldfiles, { desc = '[S]earch Old [F]iles' })
                        vim.keymap.set('n', '<leader>pb', builtin.buffers, { desc = '[S]earch Buffers' })
                        -- g := git
                        vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = '[S]earch Git [F]iles' })
                        vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = '[S]earch Git Branches' })
                        vim.keymap.set('n', '<leader>gca', builtin.git_commits, { desc = '[S]earch Git Commits (All)' })
                        vim.keymap.set('n', '<leader>gcb', builtin.git_bcommits, { desc = '[S]earch Git Commits (Buffer)' })
                        vim.keymap.set('n', '<leader>gst', builtin.git_status, { desc = '[S]earch Git Status' })
                        vim.keymap.set('n', '<leader>gsh', builtin.git_stash, { desc = '[S]earch Git Stash' })
                        -- some custom configurations
                        vim.keymap.set('n', '<leader>pp', function()
                                builtin.live_grep {
                                        grep_open_files = true,
                                        prompt_title = 'Live Grep in Open Files',
                                }
                        end, { desc = '[S]earch [/] in Open Files' })
                        -- Shortcut for searching your Neovim configuration files
                        vim.keymap.set('n', '<leader>nvim', function()
                                builtin.find_files {
                                        cwd = vim.fn.stdpath 'config',
                                        prompt_title = 'Live Grep Nvim Config',
                                }
                        end, { desc = '[S]earch [N]eovim files' })
                end,
        },

        -- 6. LSP
        {

        },
}
