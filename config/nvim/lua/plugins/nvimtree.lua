require("nvim-tree").setup({
	view = {
		hide_root_folder = true,
		signcolumn = "no",
	},
	renderer = {
		highlight_git = true,
		indent_markers = { enable = true },
		icons = {
			webdev_colors = false,
			show = {
				file = false,
				folder = false,
				folder_arrow = true,
				git = false,
			},
			glyphs = {
				folder = {
					arrow_closed = "●",
					arrow_open = "○",
					default = "●",
					empty = "◌",
					empty_open = "○",
					open = "○",
				},
			},
		},
		special_files = {},
	},
	update_focused_file = { enable = true },
	diagnostics = { enable = true },
})

-- Mappings
vim.keymap.set("n", "<C-n>", function()
	require("nvim-tree").toggle()
end, { noremap = true, silent = true })
