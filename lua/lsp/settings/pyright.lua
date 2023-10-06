return {
	settings = {
		pyright = {
			disableLanguageServices = false,
			disableOrganizeImports = false,
			analysis = {
				autoImportCompletions = true,
				autoSearchPaths = true,
				diagnosticMode = "openFilesOnly",
				extraPaths = {},
				logLevel = "Information",
				stubPath = "typings",
				typeCheckingMode = "basic",
				typeshedPaths = {},
				useLibraryCodeForTypes = true,
			},
			pythonPath = "python",
			venvPath = "",
		},
	},
}
