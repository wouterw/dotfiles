local actions = require("telescope.actions")

require("telescope").setup {
  defaults = {
    prompt_prefix = " ",
    selection_caret = " ",
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist
      }
    }
  },
}

local lsp_code_actions = function()
  require('telescope.builtin').lsp_code_actions(require('telescope.themes').get_cursor())
end

local map = vim.keymap.set
local opt = { noremap = true, silent = true }

map("n", "<Leader>ff", "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>", opt)
map("n", "<Leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", opt)

map("n", "<Leader>fb", "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown({ previewer = false }))<cr>", opt)
map("n", "<Leader>fr", "<cmd>lua require('telescope.builtin').registers(require('telescope.themes').get_dropdown({ previewer = false }))<cr>", opt)

map("n", "<Leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", opt)
map("n", "<Leader>fm", "<cmd>lua require('telescope.builtin').man_pages()<cr>", opt)

map("n", "<Leader>fs", "<cmd>lua require('telescope.builtin').lsp_references()<cr>", opt)
map("n", "<Leader>ca", function() lsp_code_actions() end, opt)
