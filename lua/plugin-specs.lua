-- CONTENTS
-- 0. COLORSCHEMES
-- 1. WHICHKEY
-- 2. RAINBOW DELIMITERS
-- 3. GITSIGNS
-- 4. INDENTBLANKLINES IBL
-- 5. TOGGLETERM
-- 6. TELESCOPE
-- 7. TREESITTER
-- 8. LSP & CMP
-- OTHER

-- NOTE: Setting either 'opts' or 'config' in any spec will cause Lazy to automatically load the plugin when we call require('lazy').setup(...)
-- Otherwise, the plugin is loaded only when we explicitly require() it.
return {
    -- 0. COLORSCHEMES 
    -- TokyoDark
    {
        'https://github.com/tiagovla/tokyodark.nvim',
        priority = 999,
        -- lazy = true,
        config = function()
            require("tokyodark").setup({
                transparent_background = false, -- set background to transparent
                gamma = 1.00, -- adjust the brightness of the theme
                styles = {
                    comments = { italic = true }, -- style for comments
                    keywords = { italic = false }, -- style for keywords
                    identifiers = { italic = false }, -- style for identifiers
                    functions = { italic = false }, -- style for functions
                    variables = { italic = false }, -- style for variables
                },
                custom_highlights = {} or function(highlights, palette) return {} end, -- extend highlights
                custom_palette = {} or function(palette) return {} end, -- extend palette
                terminal_colors = true, -- enable terminal colors
            })
            -- vim.cmd [[colorscheme tokyodark]]
        end,
    },
    -- vscode
    {
        "https://github.com/Mofiqul/vscode.nvim",
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
    -- Material Theme
    {
        'https://github.com/marko-cerovac/material.nvim',
        priority = 1000,
        -- lazy = true,
    },
    -- Kanagawa
    {
        'https://github.com/rebelot/kanagawa.nvim',
        priority = 1000,
        -- lazy = true,
    },
    -- Onedark
    {
        'https://github.com/olimorris/onedarkpro.nvim',
        priority = 1000,
        -- lazy = true,
    },
    -- Github
    {
        'https://github.com/projekt0n/github-nvim-theme',
        priority = 1000,
        -- lazy = false,
    },
    -- Moonfly
    {
        'https://github.com/bluz71/vim-moonfly-colors',
        priority = 1000,
        -- lazy = true,
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

    -- 2. RAINBOW DELIMITERS
    {
        'HiPhish/rainbow-delimiters.nvim',
    },

    -- 3. GITSIGNS ; see https://github.com/lewis6991/gitsigns.nvim
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
            current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
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

    -- 4. INDENTBLANKLINES IBL ; see https://github.com/lukas-reineke/indent-blankline.nvim
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        ---@module "ibl"
        ---@type ibl.config
        config = function()
            require('ibl').setup({
                indent = { char = '▏' },
            })
            vim.keymap.set('n', '<leader>ibl', ':IBLToggle<CR>', { desc = 'Toggle IBL plugin' })
        end,
    },

    -- 5. TOGGLETERM
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

    -- 6. TELESCOPE
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
                            preview_cutoff = 1,
                            preview_width = 0.6
                        },
                        vertical = {
                            preview_cutoff = 1,
                        },
                    },
                    mappings = {
                        i = {
                            -- ['<C-v>'] = require('telescope.actions.layout').toggle_preview,
                        },
                    },
                    preview = {
                        treesitter = false,
                    }
                },
                pickers = {
                    find_files = {
                        hidden = true,
                        no_ignore = true,
                        no_ignore_parent = true,
                        file_ignore_patterns = { '.git', },
                    },
                },
                extensions = {
                    ['ui-select'] = {
                        require('telescope.themes').get_dropdown(),
                    },
                    fzf = {},
                },
            }) -- END setup({...})
            -- Enable Telescope extensions if they are installed
            require('telescope').load_extension('fzf')
            require('telescope').load_extension('ui-select')
            -- Telescope Keymaps
            local builtin = require 'telescope.builtin'
            -- file pickers
            vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = '[S]earch [F]iles' })
            vim.keymap.set('n', '<leader>pw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
            vim.keymap.set('n', '<leader>pg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
            vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = '[S]earch Git [F]iles' })
            -- vim pickers
            vim.keymap.set('n', '<leader>ph', builtin.help_tags, { desc = '[S]earch [H]elp' })
            vim.keymap.set('n', '<leader>pk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
            vim.keymap.set('n', '<leader>pt', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
            vim.keymap.set('n', '<leader>pd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
            vim.keymap.set('n', '<leader>po', builtin.oldfiles, { desc = '[S]earch Old [F]iles' })
            vim.keymap.set('n', '<leader>pb', builtin.buffers, { desc = '[S]earch Buffers' })
            vim.keymap.set('n', '<leader>pq', builtin.quickfix, { desc = '[S]earch Quickfix List' })
            vim.keymap.set('n', '<leader>pm', builtin.marks, { desc = '[S]earch Marks' })
            vim.keymap.set('n', '<leader>pc', builtin.colorscheme, { desc = '[S]earch Colorschemes' })
            -- git pickers
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
                    no_ignore = false,
                    cwd = vim.fn.stdpath 'config',
                    prompt_title = 'Live Grep Nvim Config',
                }
            end, { desc = '[S]earch [N]eovim files' })
        end, -- END CONFIG CALLBACK
    },

    -- 7. TREESITTER
    {
        "nvim-treesitter/nvim-treesitter",
        -- enabled = false,
        build = ":TSUpdate",
        config = function() 
            local configs = require("nvim-treesitter.configs")
            configs.setup({
                ensure_installed = {
                    'c', 'lua', 'html', 'css', 'ruby', 'python', 'javascript',
                    'sql', 'yaml', 'json', 'bash', 'regex', 'markdown',
                    'markdown_inline',
                },
                -- Install parsers synchronously (only applied to `ensure_installed`)
                sync_install = false,
                -- Automatically install missing parsers when entering buffer
                auto_install = true,
                -- List of parsers to ignore installing (or "all")
                -- ignore_install = {},
                highlight = {
                    enable = true,
                    disable = {'vimdoc'},
                    -- if ruby indenting doesn't work, add 'ruby' below and disable indent for it in indent.disable field below
                    additional_vim_regex_highlighting = {'ruby', 'vimdoc'},
                },
                indent = {
                    enable = true,
                    disable = {'ruby', 'vimdoc', 'html'},
                },
            })
        end,
    },

    -- 7. LSP & CMP
    {'neovim/nvim-lspconfig'},
    {'williamboman/mason.nvim'},
    {'williamboman/mason-lspconfig.nvim'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'hrsh7th/cmp-buffer'},
    {'hrsh7th/cmp-path'},
    {'hrsh7th/cmp-nvim-lsp-signature-help'},
    {
        'hrsh7th/nvim-cmp',
                      event = 'InsertEnter',

    },
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
}

-- OTHER
-- https://github.com/stevearc/oil.nvim
