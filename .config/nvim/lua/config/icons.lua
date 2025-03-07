return {
	folder = {
		Diagnostic = "󰒡",
		FolderClosed = "",
		FolderEmpty = "",
		FolderOpen = "",
		DefaultFile = "󰈙",
	},
	git = {
		Git = "󰊢",
		GitAdd = "",
		GitBranch = "",
		GitChange = "",
		GitConflict = "",
		GitDelete = "",
		GitIgnored = "◌",
		GitSign = "▎",
		GitStaged = "✓",
	},
	kinds = {
		Text = "󰉿",
		Method = "󰊕",
		Function = "󰊕",
		Constructor = "",

		Field = "󰜢",
		Variable = "󰆦",
		Property = "󰖷",

		Class = "󰠱",
		Interface = "",
		Struct = "󰙅",
		Module = "",

		Unit = "󰑭",
		Value = "󰎠",
		Enum = "",
		EnumMember = "",

		Keyword = "󰌋",
		Constant = "󰏿",

		Snippet = "󱄽",
		Color = "󰏘",
		File = "󰈔",
		Reference = "󰬲",
		Folder = "󰉋",
		Event = "󱐋",
		Operator = "󰪚",
		TypeParameter = "󰬛",
		Codeium = "",
	},
	diagnostics = {
		Error = "",
		Warning = "",
		Info = "",
		Hint = "",
	},
	signs = {
		ERROR = "",
		WARN = "",
		HINT = "",
		INFO = "",
	},
	platforms = {
		unix = vim.fn.has("macunix") and "" or "",
		dos = "",
		mac = "",
	},
}
