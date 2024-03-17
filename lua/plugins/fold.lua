return {
	{
		"kevinhwang91/promise-async",
		branch = "main",
		lazy = true,
	},
	{
		"kevinhwang91/nvim-ufo",
		branch = "main",
		lazy = true,
		cmd = "UfoEnable",
		dependencies = {
			"kevinhwang91/promise-async",
		},
		config = function()
			local ufo = require("ufo")

			ufo.setup({
				open_fold_hl_timeout = 400,
				provider_selector = function(_)
					return { "lsp", "indent" }
				end,
				close_fold_kinds = {},
				enable_get_fold_virt_text = false,
				fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
					local newVirtText = {}
					local suffix = (" %d lines "):format(endLnum - lnum)
					local sufWidth = vim.fn.strdisplaywidth(suffix)
					local targetWidth = width - sufWidth
					local curWidth = 0

					for _, chunk in ipairs(virtText) do
						local chunkText = chunk[1]
						local chunkWidth = vim.fn.strdisplaywidth(chunkText)

						if targetWidth > curWidth + chunkWidth then
							table.insert(newVirtText, chunk)
						else
							chunkText = truncate(chunkText, targetWidth - curWidth)

							local hlGroup = chunk[2]
							table.insert(newVirtText, { chunkText, hlGroup })
							chunkWidth = vim.fn.strdisplaywidth(chunkText)

							if curWidth + chunkWidth < targetWidth then
								suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
							end

							break
						end

						curWidth = curWidth + chunkWidth
					end

					table.insert(newVirtText, { suffix, "MoreMsg" })

					return newVirtText
				end,
				preview = {
					win_config = {
						border = "rounded",
						winblend = 0,
						maxheight = 20,
					},
					-- mappings = {},
				},
			})
		end,
	},
}
