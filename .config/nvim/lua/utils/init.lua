local M = {}

--- @return string
function M.get_embed_arg_path()
	local arg = vim.fn.argv(0) --- @cast arg string

	if vim.fn.isdirectory(arg) == 1 then
		return arg
	end

	while arg and #arg > 0 do
		arg = vim.fn.fnamemodify(arg, ":h")
		if vim.fn.isdirectory(arg) then
			return arg
		end
	end

	return vim.fn.getcwd()
end

---@param ms number
---@param fn function
---@return function
M.debounce = function(ms, fn)
	local timer = vim.loop.new_timer()
	return function(...)
		local argv = { ... }
		timer:start(ms, 0, function()
			timer:stop()
			vim.schedule_wrap(fn)(unpack(argv))
		end)
	end
end

---@return string
M.pywal_mode = function()
	local mode_file = io.open(os.getenv("HOME") .. "/.cache/wal/mode", "r")
	assert(mode_file)
	local mode = mode_file:read("*a")
	mode_file:close()
	mode = mode:gsub("%s+", "")
	mode = string.gsub(mode, "%s+", "")
	return mode
end

M.read_pywal_colors = function()
	local json_file = io.open(os.getenv("HOME") .. "/.cache/wal/colors.json", "r")
	assert(json_file)
	local json = json_file:read("*a")
	local colors = vim.json.decode(json)
	json_file:close()
	return colors
end

return M
