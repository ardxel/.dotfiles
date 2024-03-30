return {
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			-- local kind_icons = require("config.icons.kinds")

			cmp.setup({
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				performance = {
					-- debounce = 25,
					max_view_entries = 25,
				},
				window = {
					documentation = {
						winhighlight = "Normal:None,FloatBorder:None,CursorLine:PmenuSel,Search:None",
						border = "rounded",
					},
					completion = {
						winhighlight = "Normal:None,FloatBorder:None,CursorLine:PmenuSel,Search:None",
						border = "rounded",
					},
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
					["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<Enter>"] = cmp.mapping.confirm({
						select = true,
						behavior = cmp.ConfirmBehavior.Replace,
					}),
					["<Esc>"] = cmp.mapping.close(),
					["<C-l>"] = cmp.mapping.complete(),
				}),
				sources = cmp.config.sources({
					{
						name = "nvim_lsp",
						entry_filter = function(entry)
							-- ignore emmet
							if
								entry:get_kind() == require("cmp.types").lsp.CompletionItemKind.Snippet
								and entry.source:get_debug_name() == "nvim_lsp:emmet_ls"
							then
								return false
							end
							return true
						end,
					},
					{ name = "luasnip", keyword_length = 2 },
				}, {
					{ name = "buffer" },
					{ name = "path" },
				}),
				---@diagnostic disable-next-line: missing-fields
				formatting = {
					fields = { "abbr", "menu", "kind" },
					-- format = function(entity, item)
					-- 	local format_text = require("plugins.cmp.format")
					--
					-- 	item.menu = format_text[entity.source.name]
					--
					-- 	if kind_icons[item.kind] then
					-- 		item.kind = kind_icons[item.kind] .. "  " .. item.kind
					-- 	end
					--
					-- 	return item
					-- end,
					format = require("lspkind").cmp_format({
						mode = "symbol_text",
						menu = require("plugins.cmp.format"),
						before = require("tailwind-tools.cmp").lspkind_format,
					}),
				},
				---@diagnostic disable-next-line: missing-fields
				sorting = {
					comparators = {
						cmp.config.compare.offset,
						cmp.config.compare.exact,
						cmp.config.compare.score,
						cmp.config.compare.recently_used,
						cmp.config.compare.kind,
					},
				},
			})

			-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
			-- cmp.setup.cmdline(":", {
			-- 	mapping = cmp.mapping.preset.cmdline(),
			-- 	sources = cmp.config.sources({
			-- 		{ name = "path" },
			-- 	}, {
			-- 		{ name = "cmdline" },
			-- 	}),
			-- })
		end,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			-- "roobert/tailwindcss-colorizer-cmp.nvim",
			"onsails/lspkind.nvim",
		},
	},
	{
		"aznhe21/actions-preview.nvim",
	},
}
