return {
	keymap = {
		preset = "enter",
		["<C-l>"] = {
			function(cmp)
				cmp.show()
			end,
		},
	},
	cmdline = {
		enabled = false,
	},
	appearance = {
		use_nvim_cmp_as_default = false,
		nerd_font_variant = "mono",
		kind_icons = require("config.icons").kinds,
	},
	completion = {
		accept = {
			auto_brackets = {
				enabled = true,
			},
		},
		menu = {
			draw = {
				-- We don't need label_description now because label and label_description are already
				-- combined together in label by colorful-menu.nvim.
				columns = { { "kind_icon" }, { "label", gap = 1 } },
				components = {
					label = {
						width = { fill = true, max = 60 },
						text = function(ctx)
							local highlights_info = require("colorful-menu").blink_highlights(ctx)
							if highlights_info ~= nil then
								-- Or you want to add more item to label
								return highlights_info.label
							else
								return ctx.label
							end
						end,
						highlight = function(ctx)
							local highlights = {}
							local highlights_info = require("colorful-menu").blink_highlights(ctx)
							if highlights_info ~= nil then
								highlights = highlights_info.highlights
							end
							for _, idx in ipairs(ctx.label_matched_indices) do
								table.insert(highlights, { idx, idx + 1, group = "BlinkCmpLabelMatch" })
							end
							-- Do something else
							return highlights
						end,
					},
				},
			},
		},
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 200,
		},
	},
	-- signature = {
	-- 	window = {
	-- 	},
	-- },
	-- winblend = 0,

	-- Default list of enabled providers defined so that you can extend it
	-- elsewhere in your config, without redefining it, due to `opts_extend`
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
}
