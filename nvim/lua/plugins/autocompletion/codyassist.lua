return {
    "guillemaru/codyassist",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        require("codyassist").setup()
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
