local actions = require('telescope.actions')

require('telescope').setup({
  defaults = {
    prompt_prefix = ' ',
    selection_caret = ' ',
    mappings = {
      i = {
        ['<esc>'] = actions.close,
        ['<C-q>'] = actions.smart_send_to_qflist + actions.open_qflist,
      },
    },
  },
})

local lsp_code_actions = function()
  require('telescope.builtin').lsp_code_actions(require('telescope.themes').get_cursor())
end

local map = vim.keymap.set
local opt = { noremap = true, silent = true }

local dropdown = require('telescope.themes').get_dropdown({ previewer = false })

-- stylua: ignore start
map('n', '<Leader>ff', function() return require('telescope.builtin').find_files(dropdown) end, opt)
map('n', '<Leader>fb', function() return require('telescope.builtin').buffers(dropdown) end, opt)
map('n', '<Leader>fr', function() return require('telescope.builtin').registers(dropdown) end, opt)
map('n', '<Leader>fh', function() return require('telescope.builtin').help_tags() end, opt)
map('n', '<Leader>fm', function() return require('telescope.builtin').man_pages() end, opt)
map('n', '<space>=', function() return require('telescope.builtin').spell_suggest() end, opts)
map('n', '<Leader>fs', function() return require('telescope.builtin').lsp_references() end, opt)
map('n', '<Leader>fg', function() return require('telescope.builtin').live_grep() end, opt)
map('n', '<Leader>ca', function() lsp_code_actions() end, opt)
-- stylua: ignore end
