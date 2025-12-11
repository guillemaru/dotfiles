return {
    "saghen/blink.cmp",
    optional = true,
    dependencies = {
        "rafamadriz/friendly-snippets",
        "mgalliou/blink-cmp-tmux",
        "Kaiser-Yang/blink-cmp-git",
        "milanglacier/minuet-ai.nvim",
    },

    version = "*",

    config = function()
        local kind_icons = {
            -- LLM Provider icons
            ["Llama.cpp"] = "󰳆",
        }
        local source_icons = {
            minuet = "󱗻",
            nvim_lsp = "",
            lsp = "",
            buffer = "",
            luasnip = "",
            snippets = "",
            path = "",
            git = "",
            tags = "",
            cmdline = "󰘳",
            -- tmux = "",
            -- FALLBACK
            fallback = "󰜚",
        }
        local default_sources = {
            "buffer",
            "git",
            "lazydev",
            "lsp",
            "path",
            "snippets",
        }
        local default_providers = {
            lazydev = {
                name = "LazyDev",
                module = "lazydev.integrations.blink",
                -- make lazydev completions higher priority (see `:h blink.cmp`)
                score_offset = 50,
            },
            git = {
                module = "blink-cmp-git",
                name = "Git",
                opts = {},
            },
        }
        table.insert(default_sources, "minuet")
        default_providers.minuet = {
            name = "minuet",
            module = "minuet.blink",
            async = true,
            -- Should match minuet.config.request_timeout * 1000,
            -- since minuet.config.request_timeout is in seconds
            timeout_ms = 2500,
            score_offset = 100, -- Gives minuet higher priority among suggestions
        }
        require("blink-cmp").setup({
            keymap = {
                -- 'default' for mappings similar to built-in completion
                -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
                -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
                preset = "default",
                ["<C-f>"] = {
                    function(cmp)
                        cmp.show({ providers = { "minuet" } })
                    end,
                },
            },

            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = "mono",
                kind_icons = kind_icons,
            },

            sources = {
                default = default_sources,
                providers = default_providers,
            },
            signature = {
                enabled = true,
                window = { border = "single" },
            },
            completion = {
                menu = {
                    draw = {
                        padding = { 0, 1 }, -- padding only on right side
                        columns = {
                            { "label", "label_description", gap = 1 },
                            { "kind_icon", "kind" },
                            { "source_icon" },
                        },
                        components = {
                            kind_icon = {
                                --  use highlights from mini.icons
                                highlight = function(ctx)
                                    local hl = ctx.kind_hl
                                    if vim.tbl_contains({ "Path" }, ctx.source_name) then
                                        local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                                        if dev_icon then
                                            hl = dev_hl
                                        end
                                    end
                                    return hl
                                end,
                            },
                            kind = {
                                -- use highlights from mini.icons
                                highlight = function(ctx)
                                    local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                                    return hl
                                end,
                            },
                            source_icon = {
                                -- don't truncate source_icon
                                ellipsis = false,
                                text = function(ctx)
                                    return source_icons[ctx.source_name:lower()] or source_icons.fallback
                                end,
                                highlight = "BlinkCmpSource",
                            },
                        },
                    },
                    border = "single",
                },
                trigger = {
                    show_on_keyword = true,
                    show_on_trigger_character = true,
                    show_on_insert_on_trigger_character = true,
                    show_on_accept_on_trigger_character = true,
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 500,
                    window = { border = "single" },
                },
            },
        })
    end,
}
