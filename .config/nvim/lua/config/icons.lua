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
		Method = "󰆧",
		Function = "󰊕",
		Constructor = "",
		Field = "󰜢",
		Variable = "󰀫",
		Class = "󰠱",
		Interface = "",
		Module = "",
		Property = "󰜢",
		Unit = "󰑭",
		Value = "󰎠",
		Enum = "",
		Keyword = "󰌋",
		Snippet = "",
		Color = "󰏘",
		File = "󰈙",
		Reference = "󰈇",
		Folder = "󰉋",
		EnumMember = "",
		Constant = "󰏿",
		Struct = "󰙅",
		Event = "",
		Operator = "󰆕",
		TypeParameter = "",
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
