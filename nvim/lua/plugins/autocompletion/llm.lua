-- Deal with which code completion to use
local completionPlugin
local llmPlugin
local src_endpoint = os.getenv("SRC_ENDPOINT")
if src_endpoint then
    if src_endpoint == "https://sourcegraph.com" then
        llmPlugin = "plugins.autocompletion.cody"
        completionPlugin = "plugins.autocompletion.nvim-cmp"
    else
        -- For an enterprise account, use the codyassist plugin
        llmPlugin = "plugins.autocompletion.codyassist"
        completionPlugin = "plugins.autocompletion.blinkcmp"
    end
else
    llmPlugin = ""
    completionPlugin = "plugins.autocompletion.blinkcmp"
end

return {
    require(llmPlugin),
    require(completionPlugin),
}
