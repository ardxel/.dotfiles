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

function M.is_dark_mode()
	return vim.g.colors_name == "vague"
end

return M
