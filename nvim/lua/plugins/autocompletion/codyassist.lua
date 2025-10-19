return {
    "guillemaru/codyassist",
    name = "codyassist",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        require("codyassist").setup({
            window = { width = 0.4, height = 0.9 },
            context = { include_buffers = "opened" },
        })

        vim.keymap.set("n", "<leader>ce", function()
            require("codyassist").EnableRepo()
        end, { noremap = true, silent = true, desc = "Enable using Cody context repo" })
        vim.keymap.set("n", "<leader>cd", function()
            require("codyassist").DisableRepo()
        end, { noremap = true, silent = true, desc = "Disable using Cody context repo" })
        vim.keymap.set("n", "<leader>ct", function()
            require("codyassist").ToggleChatWindow()
        end, { noremap = true, silent = true, desc = "Toggle window with Cody's answer" })
    end,
}
