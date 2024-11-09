return {
	{
		"nvim-tree/nvim-tree.lua",
		branch = "master",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			disable_netrw = true,
			auto_reload_on_write = true,
			respect_buf_cwd = true,
			update_focused_file = {
				enable = true,
				update_root = true,
			},
			diagnostics = {
				enable = true,
				show_on_dirs = true,
				show_on_open_dirs = true,
				icons = {
					hint = "",
					info = "",
					warning = "",
					error = "",
				},
				severity = {
					min = vim.diagnostic.severity.HINT,
					max = vim.diagnostic.severity.ERROR,
				},
			},
			git = {
				enable = true,
				ignore = true,
				show_on_dirs = true,
				show_on_open_dirs = true,
			},
			modified = {
				enable = true,
				show_on_dirs = true,
				show_on_open_dirs = true,
			},
			filesystem_watchers = {
				enable = true,
			},
			on_attach = function(bufnr)
				local api = require("nvim-tree.api")

				local function opts(desc)
					return {
						desc = "nvim-tree: " .. desc,
						buffer = bufnr,
						noremap = true,
						silent = true,
						nowait = true,
					}
				end

				local keymap = function(k, v, opt)
					vim.keymap.set("n", k, v, opt)
				end

				keymap("-", api.tree.change_root_to_parent, opts("Tree: Change Root Directory to Parent"))
				keymap("<C-]>", api.tree.change_root_to_node, opts("Tree: Change Root Directory to Current Node"))
				keymap("<2-LeftMouse>", api.node.open.edit, opts("Tree: Open"))
				keymap(
					"<2-RightMouse>",
					api.tree.change_root_to_node,
					opts("Tree: Change Root Directory to Current Node")
				)
				keymap("<BS>", api.node.navigate.parent_close, opts("Tree: Close Directory"))

				keymap("<C-t>", api.node.open.edit, opts("Tree: Open in New Tab"))
				keymap("<CR>", api.node.open.edit, opts("Tree: Open in Current Buffer"))
				keymap("<C-v>", api.node.open.vertical, opts("Tree: Open in Vertical Split"))
				keymap("<C-x>", api.node.open.horizontal, opts("Tree: Open in Horizontal Split"))
				keymap("O", api.node.open.no_window_picker, opts("Tree: Open without Window Picker"))

				keymap("<C-k>", api.node.show_info_popup, opts("Tree: Show Info"))
				keymap("<Tab>", api.node.open.preview, opts("Tree: Open Preview"))
				keymap(".", api.node.run.cmd, opts("Tree: Run Ex Command"))

				keymap("<C-r>", api.fs.rename_sub, opts("Tree: Rename without Filename"))
				keymap("e", api.fs.rename_basename, opts("Tree: Rename with only Filename"))
				keymap("r", api.fs.rename, opts("Tree: Rename"))

				keymap(">", api.node.navigate.sibling.next, opts("Tree: Jump to Next Sibling"))
				keymap("<", api.node.navigate.sibling.prev, opts("Tree: Jump to Previous Sibling"))
				keymap("J", api.node.navigate.sibling.last, opts("Tree: Jump to Last Sibling"))
				keymap("K", api.node.navigate.sibling.first, opts("Tree: Jump to First Sibling"))
				keymap("[c", api.node.navigate.git.prev, opts("Tree: Jump to Previous Dirty Git File"))
				keymap("]c", api.node.navigate.git.next, opts("Tree: Jump to Next Dirty Git File"))
				keymap("]e", api.node.navigate.diagnostics.next, opts("Tree: Jump to Next File with Diagnostics"))
				keymap("[e", api.node.navigate.diagnostics.prev, opts("Tree: Jump to Previous File with Diagnostic"))
				keymap("P", api.node.navigate.parent, opts("Tree: Jump to Parent Directory"))

				keymap("a", api.fs.create, opts("Tree: Create New File/Dir"))

				keymap("m", api.marks.toggle, opts("Tree: Toggle Bookmark"))
				keymap("bd", api.marks.bulk.delete, opts("Tree: Delete Bookmarked"))
				keymap("bmv", api.marks.bulk.move, opts("Tree: Move Bookmarked"))

				keymap("B", api.tree.toggle_no_buffer_filter, opts("Tree: Toggle Show Only Open Files in Buffers"))
				keymap("C", api.tree.toggle_git_clean_filter, opts("Tree: Toggle Show Only Git Clean Files"))
				keymap("H", api.tree.toggle_hidden_filter, opts("Tree: Toggle Dotfiles"))
				keymap("I", api.tree.toggle_gitignore_filter, opts("Tree: Toggle Git Ignore"))
				keymap("U", api.tree.toggle_custom_filter, opts("Tree: Toggle Hidden"))

				keymap("x", api.fs.cut, opts("Tree: Cut"))
				keymap("c", api.fs.copy.node, opts("Tree: Copy"))
				keymap("d", api.fs.remove, opts("Tree: Delete"))
				keymap("D", api.fs.trash, opts("Tree: Send to Trash"))
				keymap("p", api.fs.paste, opts("Tree: Paste"))

				keymap("E", api.tree.expand_all, opts("Tree: Expand All"))
				keymap("W", api.tree.collapse_all, opts("Tree: Collapse All"))

				keymap("F", api.live_filter.clear, opts("Tree: Clear Filter"))
				keymap("f", api.live_filter.start, opts("Tree: Filter"))

				keymap("g?", api.tree.toggle_help, opts("Tree: Help"))

				keymap("gy", api.fs.copy.absolute_path, opts("Tree: Copy Absolute Path"))
				keymap("Y", api.fs.copy.relative_path, opts("Tree: Copy Relative Path"))
				keymap("y", api.fs.copy.filename, opts("Tree: Copy Name"))

				keymap("q", api.tree.close, opts("Tree: Close"))

				keymap("R", api.tree.reload, opts("Tree: Refresh"))

				keymap("s", api.node.run.system, opts("Tree: Open with System App"))

				keymap("S", api.tree.search_node, opts("Tree: Search"))
			end,
			select_prompts = true,
			view = {
				cursorline = true,
				width = 30,
				side = "left",
				number = false,
				signcolumn = "yes",
				float = {
					enable = false,
				},
			},
			renderer = {
				add_trailing = false,
				group_empty = true,
				highlight_git = true,
				indent_width = 2,
				indent_markers = {
					enable = true,
					inline_arrows = true,
					icons = {
						corner = "└",
						edge = "│",
						item = "│",
						bottom = "─",
						none = " ",
					},
				},
				icons = {
					webdev_colors = true,
					git_placement = "before",
					modified_placement = "after",
					padding = " ",
					symlink_arrow = " ➛ ",
					show = {
						file = true,
						folder = true,
						folder_arrow = true,
						git = true,
						modified = true,
					},
				},
			},
			filters = {
				dotfiles = false,
				git_clean = false,
				no_buffer = false,
				custom = {
					"^.git$",
					".null-ls*",
					"*.class",
					"*.out",
					"*.jar",
					".out-*",
					"__pycache__",
				},
			},
			actions = {
				change_dir = {
					enable = false,
				},
				expand_all = {
					exclude = {
						".git",
						"dist",
						"target",
						"build",
						".vscode",
					},
				},
				open_file = {
					quit_on_open = false,
					resize_window = true,
				},
			},
			live_filter = {
				always_show_folders = true,
			},
			tab = {
				sync = {
					open = true,
					close = true,
				},
			},
			notify = {
				threshold = vim.log.levels.INFO,
				absolute_path = true,
			},
			ui = {
				confirm = {
					remove = true,
					trash = true,
				},
			},
			log = {
				enable = false,
				truncate = false,
				types = {
					all = false,
				},
			},
		},
	},
}
