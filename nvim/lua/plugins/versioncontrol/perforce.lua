return {
    "guillemaru/perfnvim",
    config = function()
        require("perfnvim").setup()
        vim.keymap.set("n", "<leader>pa", function()
            require("perfnvim").P4add()
        end, { noremap = true, silent = true, desc = "'p4 add' current buffer" })
        vim.keymap.set("n", "<leader>pe", function()
            require("perfnvim").P4edit()
        end, { noremap = true, silent = true, desc = "'p4 edit' current buffer" })
        vim.keymap.set(
            "n",
            "<leader>pR",
            ":!p4 revert -a %<CR>",
            { noremap = true, silent = true, desc = "Revert if unchanged" }
        )
        vim.keymap.set("n", "<leader>pn", function()
            require("perfnvim").P4next()
        end, { noremap = true, silent = true, desc = "Jump to next changed line" })
        vim.keymap.set("n", "<leader>pp", function()
            require("perfnvim").P4prev()
        end, { noremap = true, silent = true, desc = "Jump to previous changed line" })
        vim.keymap.set("n", "<leader>po", function()
            require("perfnvim").P4opened()
        end, { noremap = true, silent = true, desc = "'p4 opened' (telescope)" })
        vim.keymap.set("n", "<leader>pg", function()
            require("perfnvim").P4grep()
        end, { noremap = true, silent = true, desc = "grep p4 files" })
    end,
}
