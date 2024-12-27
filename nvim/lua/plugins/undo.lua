return {
    "mbbill/undotree",
    keys = {
        { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Toggle [U]ndo Tree" },
    },
    config = function()
        vim.g.undotree_WindowLayout = 2
        vim.g.undotree_SetFocusWhenToggle = 1
    end,
}
