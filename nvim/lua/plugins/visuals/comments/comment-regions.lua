--[[ `gcc` - Toggles the current line using linewise comment
`gbc` - Toggles the current line using blockwise comment
`[count]gcc` - Toggles the number of line given as a prefix-count using linewise
`[count]gbc` - Toggles the number of line given as a prefix-count using blockwise
`gc[count]{motion}` - (Op-pending) Toggles the region using linewise comment
`gb[count]{motion}` - (Op-pending) Toggles the region using blockwise comment ]]
return { "numToStr/Comment.nvim", opts = {} }

-- Use `opts = {}` to force a plugin to be loaded.
--
--  This is equivalent to:
--    require('Comment').setup({})
