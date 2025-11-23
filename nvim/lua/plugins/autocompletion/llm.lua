return {
    -- For questions
    require("plugins.autocompletion.codyassist"),
    -- For autocompletions
    vim.fn.has("mac") == 1
            and {
                "milanglacier/minuet-ai.nvim",
                dependencies = { "nvim-lua/plenary.nvim" },
                enabled = true,
                opts = {
                    provider = "openai_fim_compatible",
                    request_timeout = 2.5,
                    n_completions = 1, -- recommend for local model for resource saving
                    -- I recommend beginning with a small context window size and incrementally
                    -- expanding it, depending on your local computing power. A context window
                    -- of 512, serves as an good starting point to estimate your computing
                    -- power. Once you have a reliable estimate of your local computing power,
                    -- you should adjust the context window to a larger value.
                    context_window = 512,
                    throttle = 1000, -- only send the request every x milliseconds
                    debounce = 500, -- wait x milliseconds after not typing before sending a request
                    notify = "error", -- false: Disable all notifications (use boolean false, not string "false")
                    virtualtext = {
                        auto_trigger_ft = { --[[ "*" ]]
                        },
                        keymap = {
                            accept = "<A-]>", -- accept whole completion
                            accept_line = "<A-[>",
                            dismiss = "<A-d>",
                        },
                        show_on_completion_menu = false,
                    },
                    provider_options = {
                        openai_fim_compatible = {
                            -- For Windows users, TERM may not be present in environment variables.
                            -- Consider using APPDATA instead.
                            api_key = "TERM",
                            name = "Llama.cpp",
                            end_point = "http://localhost:8012/v1/completions",
                            -- The model is set by the llama-cpp server and cannot be altered
                            -- post-launch.
                            model = "PLACEHOLDER",
                            optional = {
                                max_tokens = 128,
                                top_p = 0.9,
                                stop = { "\n\n" },
                            },
                            stream = true,
                            -- Llama.cpp does not support the `suffix` option in FIM completion.
                            -- Therefore, we must disable it and manually populate the special
                            -- tokens required for FIM completion.
                            template = {
                                prompt = function(context_before_cursor, context_after_cursor, _)
                                    return "<|fim_prefix|>"
                                        .. context_before_cursor
                                        .. "<|fim_suffix|>"
                                        .. context_after_cursor
                                        .. "<|fim_middle|>"
                                end,
                                suffix = false,
                            },
                        },
                    },
                },
                vim.keymap.set(
                    "n",
                    "<leader>mt",
                    ":Minuet virtualtext toggle<CR>",
                    { noremap = true, silent = true, desc = "Minuet virtualtext toggle" }
                ),
            }
        or nil,
    vim.fn.has("unix") == 1 and {
        "ggml-org/llama.vim",
        init = function()
            vim.g.llama_config = {
                show_info = false,
            }
        end,
    } or nil,
}
