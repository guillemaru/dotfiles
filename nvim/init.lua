-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Use Nerd Font
vim.g.have_nerd_font = true

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  See `:help 'clipboard'`
vim.opt.clipboard = "unnamedplus"

-- Enable break indent (for lines that are longer than the width of the window)
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time to write swap file to disk
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time (default is 1000)
-- Displays which-key popup sooner
vim.opt.timeoutlen = 500

-- Configure how new splits should be opened
-- Horizontal Split: Press Ctrl-w s
-- Vertical Split:   Press Ctrl-w v
-- Close split:      Press Ctrl-w c
vim.opt.splitright = true
vim.opt.splitbelow = true
-- Key binds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Helper to execute Lua code and source config files
vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>", { desc = "Source file" })
vim.keymap.set("n", "<space>x", ":.lua<CR>", { desc = "E[x]ecute current Lua line" })
vim.keymap.set("v", "<space>x", ":lua<CR>", { desc = "E[x]ecute lua snippet" })

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 12

vim.opt.spelllang = "en_us"
vim.opt.spell = true

-- [[ Basic Keymaps ]]

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<M-j>", "<cmd>cnext<CR>", { desc = "[Q]uickfix next" })
vim.keymap.set("n", "<M-k>", "<cmd>cprev<CR>", { desc = "[Q]uickfix prev" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
-- NOTE: This won't work in all terminal emulators/tmux/etc. use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

vim.keymap.set("n", "<leader>lc", function()
    vim.api.nvim_set_hl(0, "LineNr", { fg = "#C4C3D0" })
end, { desc = "Change [L]ine colors (brighter)" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Automatically save the current buffer when switching to another buffer
vim.api.nvim_create_autocmd("BufLeave", {
    desc = "Save current buffer when switching to another buffer",
    pattern = "*",
    callback = function()
        if vim.bo.modified then
            vim.cmd("silent! write")
        end
    end,
})

-- Do not show line numbers in terminal mode
vim.api.nvim_create_autocmd("TermOpen", {
    group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
    callback = function()
        vim.opt.number = false
        vim.opt.relativenumber = false
    end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field

-- Put Lazy into the runtime path for Neovim
-- We need this because we are about to require lazy
vim.opt.runtimepath:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
require("lazy").setup({
    { import = "plugins.cmake" },
    { import = "plugins.mini" },
    { import = "plugins.oil" },
    { import = "plugins.tmux-navigator" },
    { import = "plugins.undo" },
    { import = "plugins.which-key" },

    { import = "plugins.navigation.telescope" },
    { import = "plugins.navigation.harpoon" },

    { import = "plugins.autocompletion.llm" },
    { import = "plugins.autocompletion.blinkcmp" },
    { import = "plugins.lsp.lsp" },

    { import = "plugins.versioncontrol.gitsigns" },
    { import = "plugins.versioncontrol.perforce" },

    { import = "plugins.visuals.colorschemes.catppuccin" },
    { import = "plugins.visuals.colorschemes.tokyo" },
    { import = "plugins.visuals.comments.todo-comments" },
    { import = "plugins.visuals.comments.comment-regions" },
    { import = "plugins.visuals.formatting.autoformat" },
    { import = "plugins.visuals.formatting.vimsleuth" },
    { import = "plugins.visuals.highlighting.treesitter" },
    { import = "plugins.visuals.lualine" },
}, {
    ui = {
        -- If you are using a Nerd Font: set icons to an empty table which will use the
        -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
        icons = vim.g.have_nerd_font and {} or {
            cmd = "⌘",
            config = "🛠",
            event = "📅",
            ft = "📂",
            init = "⚙",
            keys = "🗝",
            plugin = "🔌",
            runtime = "💻",
            require = "🌙",
            source = "📄",
            start = "🚀",
            task = "📌",
            lazy = "💤 ",
        },
    },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
