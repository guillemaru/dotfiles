-- Deal with which code completion to use
local completionPlugin
local src_endpoint = os.getenv("SRC_ENDPOINT")
if src_endpoint then
    if src_endpoint == "https://sourcegraph.com" then
        completionPlugin = "plugins.autocompletion.cody"
    else
        local filepath = vim.fn.expand("%:p")
        local dir_name = os.getenv("WORK_ROOT_DIR")
        if dir_name ~= nil and filepath:sub(1, #dir_name) == dir_name then
            -- For an enterprise account, use the codyassist plugin
            completionPlugin = "plugins.autocompletion.codyassist"
        else
            -- Outside the work directory, prefer Codeium
            completionPlugin = "plugins.autocompletion.codeium"
        end
    end
else
    completionPlugin = "plugins.autocompletion.codeium"
end

return {
    require(completionPlugin),
}
