return {
	{
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local kind_icons = require("config.icons.kinds")

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
					["<C-j>"] = cmp.mapping.scroll_docs(-4),
					["<C-k>"] = cmp.mapping.scroll_docs(4),
					["<Enter>"] = cmp.mapping.confirm({
						select = true,
						behavior = cmp.ConfirmBehavior.Replace,
					}),
					["<Esc>"] = cmp.mapping.close(),
					["<C-l>"] = cmp.mapping.complete(),
				}),
				sources = cmp.config.sources({
					-- { name = "nvim_lsp" },
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
					-- { name = "luasnip" },
					-- { name = "cmp_luasnip" },
				}, {
					{ name = "buffer" },
					{ name = "path" },
				}),
				formatting = {
					fields = { "abbr", "menu", "kind" },
					format = function(entity, item)
						local format_text = require("plugins.cmp.format")

						item.menu = format_text[entity.source.name]

						if kind_icons[item.kind] then
							item.kind = kind_icons[item.kind] .. "  " .. item.kind
						end

						return item
					end,
				},
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
		end,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			-- "saadparwaiz1/cmp_luasnip",
			"roobert/tailwindcss-colorizer-cmp.nvim",
		},
	},
	{
		"aznhe21/actions-preview.nvim",
	},
}
