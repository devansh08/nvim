return {
	{
		"nvim-tree/nvim-tree.lua",
		branch = "master",
		dependencies = {
			{
				"nvim-tree/nvim-web-devicons",
				branch = "master",
				lazy = true,
			},
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

				keymap("<C-]>", api.tree.change_root_to_node, opts("CD"))
				keymap("<C-k>", api.node.show_info_popup, opts("Info"))
				keymap("<C-r>", api.fs.rename_sub, opts("Rename: Omit Filename"))
				keymap("<CR>", function()
					if vim.fn.tabpagewinnr(vim.fn.tabpagenr(), "$") == 1 then
						api.node.open.edit()
					else
						api.node.open.tab_drop()
					end
				end, opts("Open: New Tab"))
				keymap("<C-t>", api.node.open.edit, opts("Open"))
				keymap("<C-v>", api.node.open.vertical, opts("Open: Vertical Split"))
				keymap("<C-x>", api.node.open.horizontal, opts("Open: Horizontal Split"))
				keymap("<BS>", api.node.navigate.parent_close, opts("Close Directory"))
				keymap("<Tab>", api.node.open.preview, opts("Open Preview"))
				keymap(">", api.node.navigate.sibling.next, opts("Next Sibling"))
				keymap("<", api.node.navigate.sibling.prev, opts("Previous Sibling"))
				keymap(".", api.node.run.cmd, opts("Run Command"))
				keymap("-", api.tree.change_root_to_parent, opts("Up"))
				keymap("a", api.fs.create, opts("Create"))
				keymap("bd", api.marks.bulk.delete, opts("Delete Bookmarked"))
				keymap("bmv", api.marks.bulk.move, opts("Move Bookmarked"))
				keymap("B", api.tree.toggle_no_buffer_filter, opts("Toggle No Buffer"))
				keymap("c", api.fs.copy.node, opts("Copy"))
				keymap("C", api.tree.toggle_git_clean_filter, opts("Toggle Git Clean"))
				keymap("[c", api.node.navigate.git.prev, opts("Prev Git"))
				keymap("]c", api.node.navigate.git.next, opts("Next Git"))
				keymap("d", api.fs.remove, opts("Delete"))
				keymap("D", api.fs.trash, opts("Trash"))
				keymap("E", api.tree.expand_all, opts("Expand All"))
				keymap("e", api.fs.rename_basename, opts("Rename: Basename"))
				keymap("]e", api.node.navigate.diagnostics.next, opts("Next Diagnostic"))
				keymap("[e", api.node.navigate.diagnostics.prev, opts("Prev Diagnostic"))
				keymap("F", api.live_filter.clear, opts("Clean Filter"))
				keymap("f", api.live_filter.start, opts("Filter"))
				keymap("g?", api.tree.toggle_help, opts("Help"))
				keymap("gy", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
				keymap("H", api.tree.toggle_hidden_filter, opts("Toggle Dotfiles"))
				keymap("I", api.tree.toggle_gitignore_filter, opts("Toggle Git Ignore"))
				keymap("J", api.node.navigate.sibling.last, opts("Last Sibling"))
				keymap("K", api.node.navigate.sibling.first, opts("First Sibling"))
				keymap("m", api.marks.toggle, opts("Toggle Bookmark"))
				keymap("o", api.node.open.edit, opts("Open"))
				keymap("O", api.node.open.no_window_picker, opts("Open: No Window Picker"))
				keymap("p", api.fs.paste, opts("Paste"))
				keymap("P", api.node.navigate.parent, opts("Parent Directory"))
				keymap("q", api.tree.close, opts("Close"))
				keymap("r", api.fs.rename, opts("Rename"))
				keymap("R", api.tree.reload, opts("Refresh"))
				keymap("s", api.node.run.system, opts("Run System"))
				keymap("S", api.tree.search_node, opts("Search"))
				keymap("U", api.tree.toggle_custom_filter, opts("Toggle Hidden"))
				keymap("W", api.tree.collapse_all, opts("Collapse"))
				keymap("x", api.fs.cut, opts("Cut"))
				keymap("y", api.fs.copy.filename, opts("Copy Name"))
				keymap("Y", api.fs.copy.relative_path, opts("Copy Relative Path"))
				keymap("<2-LeftMouse>", api.node.open.edit, opts("Open"))
				keymap("<2-RightMouse>", api.tree.change_root_to_node, opts("CD"))
			end,
			select_prompts = true,
			view = {
				cursorline = true,
				width = {
					min = 30,
					max = -1,
				},
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
				enable = true,
				truncate = true,
				types = {
					all = true,
				},
			},
		},
	},
}
