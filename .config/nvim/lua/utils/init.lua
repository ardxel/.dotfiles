local M = {}

--- @return string
function M.get_embed_arg_path()
	local arg = vim.fn.argv(0)

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

return M
