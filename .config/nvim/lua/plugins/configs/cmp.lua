local M = {}

M.setup = function()
	local cmp = require("cmp")
	-- local cmp_autopairs = require("nvim-autopairs.completion.cmp")
	-- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

	cmp.setup({
		completion = {
			completeopt = "menu,menuone,noinsert",
		},
		window = {
			keyword_length = 2,
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},
		mapping = cmp.mapping.preset.insert({
			["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
			["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
			["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
			["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
			["<C-CR>"] = cmp.mapping.confirm({ select = true }),
			["<CR>"] = cmp.mapping.confirm({
				select = true,
				behavior = cmp.ConfirmBehavior.Replace,
			}),
			["<Esc>"] = function(fallback)
				cmp.abort()
				fallback()
			end,
			["<C-l>"] = cmp.mapping.complete(),
		}),
		sources = cmp.config.sources({
			{ name = "lazydev" },
			{ name = "nvim_lsp" },
			{ name = "path", keyword_length = 2 },
			{ name = "buffer" },
			{ name = "git" },
			{ name = "snippets" },
			{ name = "codeium" },
		}),
		---@diagnostic disable-next-line: missing-fields
		formatting = {
			fields = { "abbr", "menu", "kind" },
			format = function(entry, item)
				local icons = require("config.icons").kinds
				item.kind = string.format("%s %s", icons[item.kind] or "", item.kind)

				item.menu = ({
					nvim_lsp = "[LSP]",
					nvim_lua = "[LUA]",
					buffer = "[BUF]",
					path = "[PATH]",
				})[entry.source.name]

				local widths = {
					abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
					menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
				}

				for key, width in pairs(widths) do
					if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
						item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. "…"
					end
				end

				return item
				-- return lspkind.cmp_format()(entry, item)
			end,
			symbol_map = { Codeium = "" },
			before = require("tailwind-tools.cmp").lspkind_format,
		},
	})

	-- `/` cmdline setup
	cmp.setup.cmdline("/", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = "buffer" },
		},
	})
end

return M
