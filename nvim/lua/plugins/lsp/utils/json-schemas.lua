--- @type table<{tableMatch: table<number,string>, url: string}>
local M = {}

-- package.json
table.insert(M, {
	fileMatch = { "package.json" },
	url = "https://json.schemastore.org/package.json",
})

-- tsconfig.json
table.insert(M, {
	fileMatch = { "tsconfig*.json" },
	url = "https://json.schemastore.org/tsconfig.json",
})

-- prettier
table.insert(M, {
	fileMatch = {
		".prettierrc",
		".prettierrc.json",
		"prettier.config.json",
	},
	url = "https://json.schemastore.org/prettierrc.json",
})

-- eslint
table.insert(M, {
	fileMatch = { ".eslintrc", ".eslintrc.json", ".eslintrc.js" },
	url = "https://json.schemastore.org/eslintrc.json",
})

-- babel
table.insert(M, {
	fileMatch = {
		".babelrc",
		".babelrc.json",
		"babel.config.json",
		"babel.config.js",
	},
	url = "https://json.schemastore.org/babelrc.json",
})

-- versel
table.insert(M, {
	fileMatch = { "now.json", "vercel.json" },
	url = "https://json.schemastore.org/now.json",
})

-- stylelint
table.insert(M, {
	fileMatch = {
		".stylelintrc",
		".stylelintrc.json",
		"stylelint.config.json",
	},
	url = "http://json.schemastore.org/stylelintrc.json",
})

-- expo
table.insert(M, {
	fileMatch = {
		"app.json",
	},
	url = "https://json.schemastore.org/expo-46.0.0.json",
})

return M
