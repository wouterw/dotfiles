vim.g.nvim_tree_group_empty = 1
vim.g.nvim_tree_highlight_opened_files = 1

vim.g.nvim_tree_special_files = {}
vim.g.nvim_tree_root_folder_modifier = ":p:~"

vim.g.nvim_tree_symlink_arrow = " ⤑  "

vim.g.nvim_tree_icons = {
	folder = {
		default = "●",
		empty = "◌",
		empty_open = "○",
		open = "○",
	},
}

-- vim.g.nvim_tree_show_icons = {
-- 	folders = 1,
-- 	files = 1,
-- }

require("nvim-tree").setup({
	diagnostics = { enable = true },
})

-- Mappings
vim.keymap.set("n", "<C-n>", function()
	require("nvim-tree").toggle()
end, { noremap = true, silent = true })
