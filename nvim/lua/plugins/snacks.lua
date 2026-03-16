return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },
        dim = { enabled = true },
        explorer = { enabled = true },
        gh = { enabled = false },
        image = { enabled = true },
        input = { enabled = true },
        notifier = { enabled = true, timeout = 6000 },
        picker = {
            enabled = false,
            sources = {
                gh_issue = {},
                gh_pr = {},
            },
        },
    },
    keys = {
        {
            "<leader>e",
            function()
                Snacks.explorer()
            end,
            desc = "Toggle Explorer",
        },
        {
            "<leader>gi",
            function()
                Snacks.picker.gh_issue()
            end,
            desc = "GitHub Issues (open)",
        },
        {
            "<leader>gI",
            function()
                Snacks.picker.gh_issue({ state = "all" })
            end,
            desc = "GitHub Issues (all)",
        },
        {
            "<leader>gp",
            function()
                Snacks.picker.gh_pr()
            end,
            desc = "GitHub Pull Requests (open)",
        },
        {
            "<leader>gP",
            function()
                Snacks.picker.gh_pr({ state = "all" })
            end,
            desc = "GitHub Pull Requests (all)",
        },
        {
            "<leader>de",
            function()
                Snacks.dim.enable()
            end,
            desc = "[D]im enable",
        },
        {
            "<leader>di",
            function()
                Snacks.dim.disable()
            end,
            desc = "[D]im disable",
        },
        {
            "<leader>z",
            function()
                Snacks.zen()
            end,
            desc = "[Z]en mode",
        },
    },
}
