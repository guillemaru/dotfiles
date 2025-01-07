-- Deal with which code completion to use
--[[ local completionPlugin
local llmPlugin
local src_endpoint = os.getenv("SRC_ENDPOINT")
if src_endpoint then
    if src_endpoint == "https://sourcegraph.com" then
        llmPlugin = "plugins.autocompletion.cody"
        completionPlugin = "plugins.autocompletion.nvim-cmp"
    else
        local filepath = vim.fn.expand("%:p")
        local dir_name = os.getenv("WORK_ROOT_DIR")
        if dir_name ~= nil and filepath:sub(1, #dir_name) == dir_name then
            -- For an enterprise account, use the codyassist plugin
            llmPlugin = "plugins.autocompletion.codyassist"
            completionPlugin = "plugins.autocompletion.blinkcmp"
        else
            -- Outside the work directory, prefer Codeium
            llmPlugin = "plugins.autocompletion.codeium"
            completionPlugin = "plugins.autocompletion.nvim-cmp"
        end
    end
else
    llmPlugin = "plugins.autocompletion.codeium"
    completionPlugin = "plugins.autocompletion.nvim-cmp"
end ]]

local llmPlugin = "plugins.autocompletion.codyassist"
local completionPlugin = "plugins.autocompletion.blinkcmp"

return {
    require(llmPlugin),
    require(completionPlugin),
}
