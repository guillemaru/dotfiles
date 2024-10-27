return {
	"sourcegraph/sg.nvim",
	--commit = "8bdd4d19da2268072708d5fe18fda9c23e16509d",
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

	vim.keymap.set("n", "<leader>cm", function()
		local cody = require("sg.cody.commands")
		local request = {}
		request.row, request.col = unpack(vim.api.nvim_win_get_cursor(0))
		request.filename = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
		cody.autocomplete(request, function(err, data)
			if err then
				print("Autocomplete error: ")
				print(vim.inspect(err))
			else
				print("Autocomplete result: ")
				for i, item in ipairs(data.items) do
					-- Print the insertText field
					print(string.format("Item %d:", i))
					print("  Insert Text: " .. (item.insertText or "N/A"))

					-- Assuming range has fields like start and end
					if item.range then
						print("  Range:")
						print("    Start: " .. vim.inspect(item.range.start))
						print("    End: " .. vim.inspect(item.range["end"]))
					else
						print("  Range: N/A")
					end
				end
			end
		end)
	end, { desc = "Trigger Cody manual completion" }),
	vim.keymap.set("n", "<leader>cc", function()
		require("sg.cody.commands").chat(true, {
			keymaps = {
				i = {
					["hello"] = {
						"Says Hello",
						function(chat)
							print("hello")
						end,
					},
				},
			},
		})
	end, { desc = "Start cody chat" }),
}
