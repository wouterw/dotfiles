require("nvim-tree").setup({
	diagnostics = { enable = true },
	renderer = {
		icons = {
			glyphs = {
				folder = {
					default = "●",
					empty = "◌",
					empty_open = "○",
					open = "○",
				},
			},
		},
	},
})

-- Mappings
vim.keymap.set("n", "<C-n>", function()
	require("nvim-tree").toggle()
end, { noremap = true, silent = true })
