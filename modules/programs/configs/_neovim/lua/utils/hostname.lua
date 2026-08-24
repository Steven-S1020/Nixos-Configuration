--- Credit to github.com/4jamesccraven/dotfiles
---Returns the current machine's hostname.
---@return string
local function get_hostname()
    local handle = io.popen('hostname')
    local result = handle:read("*a") or ''
    handle:close()
    return result:gsub('%s+$', '')
end

return get_hostname()
