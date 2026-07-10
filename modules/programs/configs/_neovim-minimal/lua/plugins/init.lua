---- Custom Plugin Manager written by James Craven
---- repo: https://github.com/4jamesccraven/dotfiles.git

local M = {}

--- Validates a plugin.
-- @param plug A plugin configuration.
local function validate_plugin(plug)
	vim.validate("plug", plug, "table")

	vim.validate("owner", plug.owner, "string")
	vim.validate("repo", plug.repo, "string")
	vim.validate("immediate", plug.immediate, "boolean", true)
	vim.validate("site", plug.site, "string", true)
	vim.validate("config", plug.config, "function", true)
	vim.validate("deps", plug.deps, "table", true)
end

--- Collects plugin configurations from a provided directory.
-- @param dir The directory with the config files.
-- @return A list of plugin configurations.
local function collect_plugs(dir)
	local scan = vim.uv.fs_scandir(dir)
	if not scan then
		return {}
	end

	local plugs = {}

	while true do
		local name, fs_type = vim.uv.fs_scandir_next(scan)
		if not name then
			break
		end

		if fs_type == "file" and name:match("%.lua$") and name ~= "init.lua" then
			local module = "plugins." .. name:gsub("%.lua$", "")
			local ok, conf = pcall(require, module)
			if not ok then
				vim.notify("failed to load plugin config: " .. module .. "\n" .. conf, vim.log.levels.ERROR)
			end
			if ok then
				table.insert(plugs, conf)
			end
		end
	end

	return plugs
end

--- Accumulates unique plugin specs into a list. Also ensures that plugins are valid.
-- @param plug A plugin configuration
-- @param acc An accumulator that contains the final list of specs.
-- @param seen A set of already seen specs.
local function collect_specs(plug, acc, seen)
	validate_plugin(plug)

	local id = plug.owner .. "/" .. plug.repo
	if seen[id] then
		return
	end
	seen[id] = true

	table.insert(acc, (plug.site or "https://github.com/") .. id)

	if plug.deps then
		for _, dep in ipairs(plug.deps) do
			collect_specs(dep, acc, seen)
		end
	end
end

--- Runs configurations if something about them is true.
-- @param plugs A list of configurations to filter and potentially run.
-- @param predicate A function that takes a configuration and executes it if true.
local function run_configs_if(plugs, predicate)
	for _, plug in ipairs(plugs) do
		if plug.config ~= nil and predicate(plug) then
			local ok, conf = pcall(plug.config)
			if not ok then
				vim.notify(
					"failed to load plugin: " .. plug.owner .. "/" .. plug.repo .. "\n" .. conf,
					vim.log.levels.ERROR
				)
			end
		end
	end
end

-- Collect user configuration.
local plugs = collect_plugs(vim.fn.stdpath("config") .. "/lua/plugins")
local specs = {}
local seen = {}

if plugs ~= nil then
	-- Sort the list of plugins so that loading is deterministic
	table.sort(plugs, function(a, b)
		return (a.owner .. "/" .. a.repo) < (b.owner .. "/" .. b.repo)
	end)

	-- Ensure that all plugins are installed
	for _, plug in ipairs(plugs) do
		collect_specs(plug, specs, seen)
	end
	vim.pack.add(specs)

	-- Run plugins marked for immediate execution.
	run_configs_if(plugs, function(p)
		return p.immediate
	end)

	-- Wait until neovim has started to load the rest.
	vim.api.nvim_create_autocmd("VimEnter", {
		callback = function()
			run_configs_if(plugs, function(p)
				return not p.immediate
			end)
		end,
	})
end

-- Remove unused plugins (i.e., ones that have had their configuration deleted
-- since the previous startup).
local unused = vim.iter(vim.pack.get())
	:filter(function(x)
		return not x.active
	end)
	:map(function(x)
		return x.spec.name
	end)
	:totable()

if not vim.tbl_isempty(unused) then
	vim.pack.del(unused)
end

return M
