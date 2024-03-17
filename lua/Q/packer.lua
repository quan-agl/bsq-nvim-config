-- This file can be loaded by calling `lua require('plugins')` from your init.vim
-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]
print("load packer Q")
return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.2',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use({
        'rose-pine/neovim',
        as = 'rose-pine',
        config = function()
            require('rose-pine').setup({
                highlight_groups = {
                    ColorColumn = { bg = 'highlight_med' }, }
            })
            vim.cmd('colorscheme rose-pine')
        end
    })
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('mbbill/undotree')
    use('tpope/vim-fugitive')
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },             -- Required
            { 'williamboman/mason.nvim' },           -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' },     -- Required
        }
    }
    use {
        'xbase-lab/xbase',
        run = 'make install', -- or "make install && make free_space" (not recommended, longer build time)
        requires = {
            "neovim/nvim-lspconfig",
            "nvim-telescope/telescope.nvim", -- optional
            -- "nvim-lua/plenary.nvim", -- optional/requirement of telescope.nvim
            -- "stevearc/dressing.nvim", -- optional (in case you don't use telescope but something else)
        },
        config = function()
            require 'xbase'.setup({
                log_level = vim.log.levels.DEBUG,
                --- Options to be passed to lspconfig.nvim's sourcekit setup function.
                --- Setting this to {} is sufficient, However, it is strongly recommended to use on_attach key to setup custom mappings
                --- {
                --- cmd = { "sourcekit-lsp", "--log-level", "error" },
                --- filetypes = { "swift" },
                --- root_dir = pattern("Package.swift", ".git", "project.yml", "Project.swift"),
                --- }
                sourcekit = nil, -- Disabled by default (xbase will not call it for you)
                --- Statusline provider configurations
                statusline = {
                    watching = { icon = "", color = "#1abc9c" },
                    device_running = { icon = "", color = "#4a6edb" },
                    success = { icon = "", color = "#1abc9c" },
                    failure = { icon = "", color = "#db4b4b" },
                },
                mappings = {
                    --- Whether xbase mapping should be disabled.
                    enable = true,
                    --- Open build picker. showing targets and configuration.
                    build_picker = 0,          --- set to 0 to disable
                    --- Open run picker. showing targets, devices and configuration
                    run_picker = 0,            --- set to 0 to disable
                    --- Open watch picker. showing run or build, targets, devices and configuration
                    watch_picker = 0,          --- set to 0 to disable
                    --- A list of all the previous pickers
                    all_picker = "<leader>ef", --- set to 0 to disable
                    --- horizontal toggle log buffer
                    toggle_split_log_buffer = "<leader>ls",
                    --- vertical toggle log buffer
                    toggle_vsplit_log_buffer = "<leader>lv",
                },
            }) -- see default configuration bellow
        end
    }
    use {
        "williamboman/mason.nvim",
        "mfussenegger/nvim-dap",
        "jay-babu/mason-nvim-dap.nvim",
    }
    use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" },
        lazy = true,
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")
            dapui.setup()
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
        end
    }
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional
        },
    }
end)
