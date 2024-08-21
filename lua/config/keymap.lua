vim.keymap.set('t', '<c-w>h', '<C-\\><C-n><C-w>h', {noremap=true})
vim.keymap.set('t', '<c-w>l', '<C-\\><C-n><C-w>l', {noremap=true})
vim.keymap.set('t', '<c-w>j', '<C-\\><C-n><C-w>j', {noremap=true})
vim.keymap.set('t', '<c-w>k', '<C-\\><C-n><C-w>k', {noremap=true})

vim.keymap.set('n', '<c-w>f', '<C-w><BAR><C-w><S-_>', {noremap=true})
vim.keymap.set('n', '<c-w>z', '<cmd>Maximize<cr>', {noremap=true})

vim.keymap.set('i', '<Esc>', '<NOP>', {noremap=true})
vim.keymap.set('i', '<c-c>', '<Esc>', {noremap=true})
vim.keymap.set('n', '<c-c>', '<Esc>', {noremap=true})
vim.keymap.set('v', '<c-c>', '<Esc>', {noremap=true})
vim.keymap.set('o', '<c-c>', '<Esc>', {noremap=true})

