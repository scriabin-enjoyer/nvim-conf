-- This here in case I want to use one of these. Ultimately, the vscode color
-- scheme is KING seriously it's too good and if you think otherwise you are
-- wrong.

local colors = {

    -- TokyoDark
    {
        'https://github.com/tiagovla/tokyodark.nvim',
        priority = 1000,
        lazy = false,
        config = function()
            require("tokyodark").setup({
                transparent_background = true, -- set background to transparent
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

    -- Material Theme
    {
        'https://github.com/marko-cerovac/material.nvim',
        priority = 1000,
        lazy = false,
        config = function()
            local opts = {
                disable = { background = true },
                high_visibility = { darker = true },
            }
            require('material').setup(opts)
            -- vim.cmd [[colorscheme material-darker]]
        end
    },

    -- Kanagawa
    {
        'https://github.com/rebelot/kanagawa.nvim',
        priority = 1000,
        lazy = false,
    },

    -- Onedark
    {
        'https://github.com/olimorris/onedarkpro.nvim',
        priority = 1000,
        lazy = false,
        config = function()
            local opts = {
                options = {
                    transparency = true,
                }
            }
            require('onedarkpro').setup(opts)
            -- vim.cmd [[colorscheme onedark_dark]]
        end
    },

    -- Moonfly
    {
        'https://github.com/bluz71/vim-moonfly-colors',
        priority = 1000,
        -- lazy = false,
        config = function()
            -- don't need to require() it
            vim.g.moonflyTransparent = true
            -- vim.cmd [[colorscheme moonfly]]
        end
    },
}
