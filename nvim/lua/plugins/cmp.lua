local config = function()
	local cmp = require("cmp")
	local lspkind = require("lspkind")
	local cmp_autopairs = require("nvim-autopairs.completion.cmp")
	cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
	cmp.setup({
		completion = {
			completeopt = "menu,menuone",
		},
		window = {
			keyword_length = 2,
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
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
			{ name = "nvim_lsp" },
			{ name = "path", keyword_length = 3 },
			{ name = "lazydev" },
			{ name = "buffer" },
			{ name = "codeium" },
		}),
		---@diagnostic disable-next-line: missing-fields
		formatting = {
			fields = { "abbr", "menu", "kind" },
			format = lspkind.cmp_format({
				mode = "symbol_text",
				menu = {
					nvim_lsp = "[LSP]",
					nvim_lua = "[LUA]",
					buffer = "[BUF]",
					path = "[PATH]",
				},
				symbol_map = { Codeium = "" },
				before = require("tailwind-tools.cmp").lspkind_format,
			}),
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

return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	config = config,
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"onsails/lspkind.nvim",
	},
}
