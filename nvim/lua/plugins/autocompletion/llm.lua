-- Deal with which code completion to use
local src_endpoint = os.getenv("SRC_ENDPOINT")
if src_endpoint then
    return {
        require("plugins.autocompletion.codyassist"),
    }
else
    return {}
end
