return {
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
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
					debounce = 25,
					max_view_entries = 25,
				},
				-- experimental = {
				-- 	ghost_text = false,
				-- },
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
							-- if
							-- 	entry:get_kind() == require("cmp.types").lsp.CompletionItemKind.Snippet
							-- 	and entry.source:get_debug_name() == "nvim_lsp:emmet_ls"
							-- then
							-- 	return false
							-- end
							return true
						end,
					},
					{ name = "luasnip" },
					{ name = "codeium" },
				}, {
					{ name = "buffer" },
					{ name = "path" },
				}),
				---@diagnostic disable-next-line: missing-fields
				formatting = {
					fields = { "abbr", "menu", "kind" },
					format = require("lspkind").cmp_format({
						mode = "symbol_text",
						menu = {
							nvim_lsp = "[LSP] ",
							luasnip = "[Snip] ",
							buffer = "[Buff] ",
							path = "[Path] ",
						},
						symbol_map = { Codeium = "" },
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
		end,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"onsails/lspkind.nvim",
			"saadparwaiz1/cmp_luasnip",
		},
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			{
				"rafamadriz/friendly-snippets",
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load()
				end,
			},
		},
		opts = {
			history = true,
			delete_check_events = "TextChanged",
		},
	},
}
