local actions = require("telescope.actions")

require("telescope").setup {
  defaults = {
    prompt_prefix = " ",
    selection_caret = " ",
    mappings = {i = {["<esc>"] = actions.close, ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist}}
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    }
  }
}

require('telescope').load_extension('fzf')

local M = {}

M.lsp_code_actions = function()
  require("telescope.builtin").lsp_code_actions(require("telescope.themes").get_cursor())
end

local map = require("util").map
local opts = {noremap = true, silent = true}

map("n", "<Leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", opts)
map("n", "<Leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", opts)

map("n", "<Leader>fts", "<cmd>lua require('telescope.builtin').treesitter()<cr>", opts)

map("n", "<Leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>", opts)
map("n", "<Leader>fr", "<cmd>lua require('telescope.builtin').registers()<cr>", opts)

map("n", "<Leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", opts)
map("n", "<Leader>fm", "<cmd>lua require('telescope.builtin').man_pages()<cr>", opts)

map("n", "<Leader>fs", "<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<cr>", opts)
map("n", "<Leader>ca", "<cmd>lua require('config.telescope').lsp_code_actions()<cr>", opts)

return M
