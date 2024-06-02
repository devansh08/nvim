return {
	settings = {
		json = {
			schemas = {
				{
					fileMatch = {
						"package.json",
					},
					url = "https://json.schemastore.org/package.json",
				},
				{
					fileMatch = {
						"prettierrc.json",
						".prettierrc.json",
					},
					url = "https://json.schemastore.org/prettierrc.json",
				},
				{
					fileMatch = {
						"manifest.json",
					},
					url = "https://json.schemastore.org/webextension.json",
				},
				{
					fileMatch = {
						".ncurc",
						".ncurc.json",
					},
					url = "https://raw.githubusercontent.com/raineorshine/npm-check-updates/main/src/types/RunOptions.json",
				},
			},
		},
	},
}
