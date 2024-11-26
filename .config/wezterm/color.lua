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

M._get_background_layer = function()
	return {
		source = { File = "" },
		hsb = { brightness = M._brightness },
		horizontal_align = "Center",
	}
end

M._set_next_background = function(window)
	if #M.images == 0 then
		wezterm.log_info("No images found in " .. assets_path)
	end

	local overrides = window:get_config_overrides() or {}
	local layer = M._get_background_layer()
	local image = M.images[M._index_current_img]

	if image == empty_image_trigger then
		overrides.background = nil
	else
		layer.source.File = image
		overrides.background = { layer }
	end

	window:set_config_overrides(overrides)
	M._index_current_img = M._index_current_img % #M.images + 1
end

M._change_brightness = function(window, value)
	local overrides = window:get_config_overrides() or {}

	if overrides == nil or overrides.background == nil then
		return
	end

	local max_brightness = 0.30
	local layer = overrides.background[1]
	local brightness = layer.hsb.brightness ---@type number
	brightness = brightness + value
	brightness = math.max(0, brightness)
	brightness = math.min(max_brightness, brightness)
	layer.hsb.brightness = brightness
	overrides.background = { layer }
	window:set_config_overrides(overrides)
	M._brightness = brightness
end

M.setup = function(c)
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
