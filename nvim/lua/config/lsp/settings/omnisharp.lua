local M = {
		init_options = {
			RoslynExtensionsOptions = {
				enableAnalyzersSupport = true
			},
			FormattingOptions = {
				enableEditorConfigSupport = true,
				NewLine = "\n",
				UseTabs = false,
				OrganizeImports = true,
				IndentationSize = 4,
				TabSize = 4
			},
			cake = {
				enabled = false
			},
			script = {
				enabled = false
			},
			excludeSearchPatterns = {
				"Library/**/*",
				"Temp/**/*",
				"obj/**/*"
			},
		}
	}

	return M;
