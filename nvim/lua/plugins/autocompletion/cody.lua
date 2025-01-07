return {
	"sourcegraph/sg.nvim",
    enabled = false,
	dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
	config = function()
		require("sg").setup({
			-- Pass your own custom attach function
			--    If you do not pass your own attach function, then the following maps are provide:
			--        - gd -> goto definition
			--        - gr -> goto references
			-- on_attach = your_custom_lsp_attach_function
		})
		--
	end,
	vim.keymap.set("n", "<leader>cp", function()
		require("sg.cody.commands").focus_prompt()
	end, { desc = "Focus currently active Cody prompt" }),
	vim.keymap.set("n", "<leader>ch", function()
		require("sg.cody.commands").focus_history()
	end, { desc = "Focus currently active Cody history window" }),
	vim.keymap.set("n", "<leader>ct", function()
		require("sg.cody.commands").toggle()
	end, { desc = "CodyToggle" }),
}
