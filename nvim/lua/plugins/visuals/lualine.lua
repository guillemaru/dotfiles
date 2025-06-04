return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "milanglacier/minuet-ai.nvim",
        },
        config = function()
            local custom_catppuccin = require("lualine.themes.catppuccin-mocha")

            require("lualine").setup({
                options = { theme = custom_catppuccin },
                sections = {
                    lualine_x = {
                        {
                            "harpoon2",
                            icon = "",
                            indicators = { "v", "b", "n", "m" },
                            active_indicators = { "V", "B", "N", "M" },
                            color_active = { fg = "#a6e3a1" },
                            _separator = ",",
                            no_harpoon = "Harpoon not loaded",
                        },
                    },
                    lualine_y = {
                        {
                            require("minuet.lualine"),
                            -- the follwing is the default configuration
                            -- the name displayed in the lualine. Set to "provider", "model" or "both"
                            display_name = "provider",
                            -- separator between provider and model name for option "both"
                            -- provider_model_separator = ':',
                            -- whether show display_name when no completion requests are active
                            display_on_idle = true,
                            icon = "󰳆",
                        },
                        {
                            "lsp_status",
                            icon = "", -- f013
                            symbols = {
                                -- Standard unicode symbols to cycle through for LSP progress:
                                spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
                                -- Standard unicode symbol for when LSP is done:
                                done = "✓",
                                -- Delimiter inserted between LSP names:
                                separator = " ",
                            },
                            -- List of LSP names to ignore (e.g., `null-ls`):
                            ignore_lsp = {},
                        },
                        "filetype",
                    },
                },
                extensions = { "lazy", "mason", "oil", "quickfix" },
            })
            local harpoon = require("harpoon")
            vim.keymap.set("n", "<C-v>", function()
                harpoon:list():select(1)
            end)
            vim.keymap.set("n", "<C-b>", function()
                harpoon:list():select(2)
            end)
            vim.keymap.set("n", "<C-n>", function()
                harpoon:list():select(3)
            end)
            vim.keymap.set("n", "<C-m>", function()
                harpoon:list():select(4)
            end)
        end,
    },
    {
        "letieu/harpoon-lualine",
        dependencies = {
            {
                "ThePrimeagen/harpoon",
                branch = "harpoon2",
            },
        },
    },
}
