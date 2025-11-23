local function isFileOpenedForEdit(filePath)
    -- Run the p4 opened command and capture the output
    local command = "p4 opened " .. filePath .. " 2>&1"
    local handle = io.popen(command)
    if not handle then
        return false
    end
    local result = handle:read("*a")
    handle:close()

    -- Check if the output indicates the file is opened for edit
    if result:find("currently opened for edit") or result:find("edit change") then
        return true
    elseif result:find("not") then
        return false
    else
        return false
    end
end

local function isMarkDown(bufnr)
    local ft = vim.bo[bufnr].filetype
    return ft == "markdown"
end

return {
    "stevearc/conform.nvim",
    lazy = false,
    keys = {
        {
            "<leader>f",
            function()
                require("conform").format({ async = true, dry_run = false, lsp_format = "fallback" })
            end,
            mode = "",
            desc = "[F]ormat buffer",
        },
    },
    opts = {
        notify_on_error = true,
        format_on_save = function(bufnr)
            -- Disable "format_on_save lsp_fallback" for certain circumstances.
            local formatOpts = {}
            formatOpts["dry_run"] = isFileOpenedForEdit(vim.fn.expand("%:p")) or isMarkDown(bufnr) -- if true, formatting won't happen
            formatOpts["timeout_ms"] = 500
            return formatOpts
        end,
        formatters_by_ft = {
            cpp = { "clang-format", lsp_format = "fallback" },
            go = { "gofmt", lsp_format = "fallback" },
            javascript = { "prettierd", "prettier", stop_after_first = true },
            json = { "jq" },
            lua = { "stylua", lsp_format = "fallback" },
            markdown = { "noop" },
            -- cmake = { "cmake_format", quiet = true, lsp_format = "fallback" },
            ["*"] = { "trim_whitespace" },
        },
        notify_no_formatters = true,
    },
}
