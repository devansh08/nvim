return {
	settings = {
		javascript = {
			autoClosingTags = true,
			format = {
				enable = false,
			},
			implicitProjectConfig = {
				checkJs = false,
				experimentalDecorators = false,
			},
			inlayHints = {
				enumMemberValues = {
					enabled = false,
				},
				functionLikeReturnTypes = {
					enabled = false,
				},
				parameterNames = {
					enabled = "none",
					suppressWhenArgumentMatchesName = true,
				},
				parameterTypes = {
					enabled = false,
				},
				propertyDeclarationTypes = {
					enabled = false,
				},
				variableTypes = {
					enabled = false,
					suppressWhenTypeMatchesName = true,
				},
			},
			preferGoToSourceDefinition = false,
			preferences = {
				autoImportFileExcludePatterns = {},
				importModuleSpecifier = "shortest",
				importModuleSpecifierEnding = "auto",
				jsxAttributeCompletionStyle = "auto",
				quoteStyle = "auto",
				renameMatchingJsxTags = true,
				renameShorthandProperties = true,
				useAliasesForRenames = true,
			},
			referencesCodeLens = {
				enabled = false,
				showOnAllFunctions = false,
			},
			suggest = {
				autoImports = true,
				classMemberSnippets = {
					enabled = true,
				},
				completeFunctionCalls = false,
				completeJSDocs = true,
				enabled = true,
				includeAutomaticOptionalChainCompletions = true,
				includeCompletionsForImportStatements = true,
				jsdoc = {
					generateReturns = true,
				},
				names = true,
				paths = true,
			},
			suggestionActions = {
				enabled = true,
			},
			updateImportsOnFileMove = {
				enabled = "prompt",
			},
			validate = {
				enable = true,
			},
		},
		["js/ts"] = {
			implicitProjectConfig = {
				checkJs = false,
				experimentalDecorators = false,
				module = "ESNext",
				strictFunctionTypes = true,
				strictNullChecks = true,
				target = "ES2020",
			},
		},
		typescript = {
			autoClosingTags = true,
			check = {
				npmIsInstalled = true,
			},
			disableAutomaticTypeAcquisition = false,
			enablePromptUseWorkspaceTsdk = false,
			experimental = {
				tsserver = {
					web = {
						typeAcquisition = {
							enabled = false,
						},
					},
				},
			},
			format = {
				enable = false,
			},
			implementationsCodeLens = {
				enabled = false,
				showOnInterfaceMethods = false,
			},
			inlayHints = {
				enumMemberValues = {
					enabled = false,
				},
				functionLikeReturnTypes = {
					enabled = false,
				},
				parameterNames = {
					enabled = "none",
					suppressWhenArgumentMatchesName = true,
				},
				parameterTypes = {
					enabled = false,
				},
				propertyDeclarationTypes = {
					enabled = false,
				},
				variableTypes = {
					enabled = false,
					suppressWhenTypeMatchesName = true,
				},
			},
			locale = "auto",
			preferGoToSourceDefinition = false,
			preferences = {
				autoImportFileExcludePatterns = {},
				importModuleSpecifier = "shortest",
				importModuleSpecifierEnding = "auto",
				includePackageJsonAutoImports = "auto",
				jsxAttributeCompletionStyle = "auto",
				preferTypeOnlyAutoImports = false,
				quoteStyle = "auto",
				renameMatchingJsxTags = true,
				renameShorthandProperties = true,
				useAliasesForRenames = true,
			},
			referencesCodeLens = {
				enabled = false,
				showOnAllFunctions = false,
			},
			reportStyleChecksAsWarnings = true,
			suggest = {
				autoImports = true,
				classMemberSnippets = {
					enabled = true,
				},
				completeFunctionCalls = false,
				completeJSDocs = true,
				enabled = true,
				includeAutomaticOptionalChainCompletions = true,
				includeCompletionsForImportStatements = true,
				jsdoc = {
					generateReturns = true,
				},
				objectLiteralMethodSnippets = {
					enabled = true,
				},
				paths = true,
			},
			suggestionActions = {
				enabled = true,
			},
			surveys = {
				enabled = false,
			},
			tsc = {
				autoDetect = "on",
			},
			tsserver = {
				enableTracing = false,
				experimental = {
					enableProjectDiagnostics = false,
				},
				log = "off",
				maxTsServerMemory = 3072,
				nodePath = "",
				pluginPaths = {},
				useSeparateSyntaxServer = true,
				useSyntaxServer = "auto",
				watchOptions = "",
			},
			web = {
				projectWideIntellisense = {
					enabled = true,
				},
				suppressSemanticErrors = true,
			},
			updateImportsOnFileMove = {
				enabled = "prompt",
			},
			validate = {
				enable = true,
			},
			workspaceSymbols = {
				excludeLibrarySymbols = true,
				scope = "allOpenProjects",
			},
		},
	},
}
