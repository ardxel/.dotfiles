local wezterm = require("wezterm")
local io = require("io")
local empty_image_trigger = "🤡"

local M = {}
M._index_current_img = 1
M._brightness = 0.03
M.images = {}

local join_paths = function(...)
	local sep = package.config:sub(1, 1) -- Separator: "/" for Unix, "\" for Windows
	return table.concat({ ... }, sep)
end

local assets_path = join_paths(wezterm.home_dir, ".dotfiles", "assets")
for filename in io.popen('ls "' .. assets_path .. '"'):lines() do
	if filename:match("%.png$") or filename:match("%.jpg$") then
		table.insert(M.images, join_paths(assets_path, filename))
	end
end
table.insert(M.images, empty_image_trigger)

M._set_next_background = function(window)
	if #M.images == 0 then
		wezterm.log_info("No images found in " .. assets_path)
	end

	local overrides = window:get_config_overrides() or {
		window_background_image_hsb = { brightness = 0.03 },
	}
	local image = M.images[M._index_current_img]

	if image == empty_image_trigger then
		overrides.window_background_image = nil
	else
		overrides.window_background_image = image
	end

	window:set_config_overrides(overrides)
	M._index_current_img = M._index_current_img % #M.images + 1
end

M._change_brightness = function(window, value)
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

M.setup = function()
	wezterm.on("toggle-background", function(window)
		M._set_next_background(window)
	end)
	wezterm.on("increase-brightness", function(window)
		M._change_brightness(window, 0.01)
	end)
	wezterm.on("decrease-brightness", function(window)
		M._change_brightness(window, -0.01)
	end)
end

return M
