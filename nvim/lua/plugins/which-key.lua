-- NOTE: Plugins can also be configured to run Lua code when they are loaded.
--
-- This is often very useful to both group configuration, as well as handle
-- lazy loading plugins that don't need to be loaded immediately at startup.
--
-- For example, in the following configuration, we use:
--  event = 'VimEnter'
--
-- which loads which-key before all the UI elements are loaded. Events can be
-- normal autocommands events (`:help autocmd-events`).
--
-- Then, because we use the `config` key, the configuration only runs
-- after the plugin has been loaded:
--  config = function() ... end
return {
    "folke/which-key.nvim",
    event = "VimEnter", -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
        require("which-key").setup()
        require("which-key").add({
            { "<leader>c", group = "[C]ode", mode = { "n", "x" } },
            { "<leader>d", group = "[D]ocument" },
            { "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
            { "<leader>l", group = "[L]ine" },
            { "<leader>p", group = "[P]erforce" },
            { "<leader>r", group = "[R]ename" },
            { "<leader>s", group = "[S]earch" },
            { "<leader>t", group = "[T]oggle" },
            { "<leader>w", group = "[W]orkspace" },
            { "<leader>-", group = "[O]il" },
        })
    end,
}
