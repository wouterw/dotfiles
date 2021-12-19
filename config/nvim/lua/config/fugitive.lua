local map = require("util").map
-- Git
-- NOTE: 'dv' to get conflicts
-- NOTE: Ctrl+w & Ctrl+o to save
map("n", "<Leader>gh", ":diffget //2<CR>", {noremap = true})
map("n", "<Leader>gl", ":diffget //3<CR>", {noremap = true})

-- Fugitive
map("n", "<Leader>gs", ":Git<CR>", {noremap = true})
map("n", "<Leader>gp", ":G push<CR>", {noremap = true})
map("n", "<Leader>gl", ":G pull<CR>", {noremap = true})

map("n", "<Leader>grs", ":G reset --soft HEAD~1<CR>", {noremap = true})
map("n", "<Leader>grh", ":G reset --hard HEAD~1<CR>", {noremap = true})
