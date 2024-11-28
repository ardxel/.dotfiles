local wezterm = require("wezterm")
local io = require("io")
local nvim_colorsheme_filename = "nvim_colorscheme"
local nvim_wezterm_colors = {
	["Default"] = "Default",
	["GruvboxLight"] = "GruvboxLight",
}

local M = {}
M._index_current_img = 1
M._brightness = 0.03
M._colorscheme = nvim_wezterm_colors.Default
M.images = {}

---@param ... string
---@return string
local join_paths = function(...)
	local sep = package.config:sub(1, 1) -- Separator: "/" for Unix, "\" for Windows
	return table.concat({ ... }, sep)
end

local assets_path = join_paths(wezterm.home_dir, ".dotfiles", "assets")
for filename in io.popen('ls "' .. assets_path .. '"'):lines() do ---@cast filename string
	if filename:match("%.png$") or filename:match("%.jpg$") then
		table.insert(M.images, join_paths(assets_path, filename))
	end
end
table.insert(M.images, "Default")

---	Wezterm event callback.
--- Change background image loop. Images must be existing in assets directory of dotfiles
--- $XDG_CONFIG_HOME/assets
--- @param window any
M._set_next_bg_image = function(window)
	if #M.images == 0 then
		wezterm.log_info("No images found in " .. assets_path)
	end

	local overrides = window:get_config_overrides() or {
		window_background_image_hsb = { brightness = 0.03 },
	}
	local image = M.images[M._index_current_img]

	if image == "Default" then
		overrides.window_background_image = nil
	else
		overrides.window_background_image = image
	end

	window:set_config_overrides(overrides)
	M._index_current_img = M._index_current_img % #M.images + 1
end

--- Wezterm event callback.
--- @param window any
--- @param value integer
M._change_brightness = function(window, value)
	if M.images[M._index_current_img] == "Default" then
		return
	end

	local overrides = window:get_config_overrides() or {}
	local max_brightness = 0.30
	local hsb = overrides.window_background_image_hsb or { brightness = M._brightness }

	hsb.brightness = hsb.brightness + value
	hsb.brightness = math.max(0, hsb.brightness)
	hsb.brightness = math.min(max_brightness, hsb.brightness)
	overrides.window_background_image_hsb = hsb
	window:set_config_overrides(overrides)
	M._brightness = hsb.brightness
end

--- [trick source](https://www.reddit.com/r/neovim/comments/19bb3e1/consistent_neovimwezterm_colorscheme/)
--- Update wezterm colorscheme after updating neovim colorscheme.
--- In Neovim run :colorscheme <name> and save file with specific name inside wezterm config direcory.
--- After that wezterm will update status and read neovim colorscheme name from saved file previously.
---	This function will be executed only once, not for events, because it will be more complicated:
---	will need to be done manually, may cause infinite loops.
---	Using this function in "update-right-status" event make no sense, because function will be executed anyway, atleast once per status updating
---
---	Works only if background image is set by default "Default"
---@param config any
M._nvim_colorscheme = function(config)
	local nvim_cs_path = join_paths(wezterm.config_dir, nvim_colorsheme_filename)
	local nvim_cs_file = io.open(nvim_cs_path, "r")

	if nvim_cs_file == nil then
		nvim_cs_file = io.open(nvim_cs_path, "w")
		assert(nvim_cs_file)
		nvim_cs_file:write("Default")
	else
		local data = nvim_cs_file:read("*a") ---@type string
		data = data:gsub("%+s", "")
		local colorscheme = nvim_wezterm_colors[data]
		assert(colorscheme ~= nil, "Unknown colorscheme: " .. data)

		if colorscheme ~= "Default" then
			M._colorscheme = colorscheme
			config.color_scheme = colorscheme
		end
	end
	nvim_cs_file:close()
end

M.setup = function(config)
	wezterm.on("toggle-image", function(window)
		M._set_next_bg_image(window)
	end)
	wezterm.on("increase-brightness", function(window)
		M._change_brightness(window, 0.01)
	end)
	wezterm.on("decrease-brightness", function(window)
		M._change_brightness(window, -0.01)
	end)
	M._nvim_colorscheme(config)
end

return M
