require ('config.settings')
require ('config.lazy')
require ('config.keymap')

vim.cmd("colorscheme tokyonight")
vim.cmd("autocmd BufWinEnter,WinEnter term://* startinsert")
