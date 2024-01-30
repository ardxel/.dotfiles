return {
	{
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

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
					debounce = 150,
					max_view_entries = 15,
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
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					-- { name = "cmp_luasnip" },
				}, {
					{ name = "buffer" },
					{ name = "path" },
				}),
				formatting = {
					fields = { "abbr", "menu", "kind" },
					format = function(entity, item)
						local format_text = require("plugins.cmp.format")
						local kind_icons = require("config.icons.kinds")

						item.menu = format_text[entity.source.name]

						if kind_icons[item.kind] then
							item.kind = kind_icons[item.kind] .. "  " .. item.kind
						end

						return item
					end,
				},
			})

			-- Set configuration for specific filetype.
			cmp.setup.filetype("gitcommit", {
				sources = cmp.config.sources({
					{ name = "git" }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
				}, {
					{ name = "buffer" },
				}),
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
