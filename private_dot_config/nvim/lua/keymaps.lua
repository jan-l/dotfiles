-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Tmux pane navigation
vim.cmd [[
  noremap <silent> <c-h> :<C-U>TmuxNavigateLeft<cr>
  noremap <silent> <c-j> :<C-U>TmuxNavigateDown<cr>
  noremap <silent> <c-k> :<C-U>TmuxNavigateUp<cr>
  noremap <silent> <c-l> :<C-U>TmuxNavigateRight<cr>
  noremap <silent> <c-\> :<C-U>TmuxNavigatePrevious<cr>
]]

--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- better up/down with wrapped lines
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>dl', vim.diagnostic.open_float, { desc = 'Show diagnostic Error messages' })
vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = 'Open [D]iagnostic [Q]uickfix list' })

-- Buffer keymaps
vim.keymap.set('n', '[b', '<cmd>bp<cr>', { desc = 'Go to previous [B]uffer' })
vim.keymap.set('n', ']b', '<cmd>bp<cr>', { desc = 'Go to next [B]uffer' })
vim.keymap.set('n', '<leader>bp', '<cmd>bp<cr>', { desc = 'Go to [P]revious [B]uffer' })
vim.keymap.set('n', '<leader>bn', '<cmd>bp<cr>', { desc = 'Go to [N]ext [B]uffer' })
vim.keymap.set('n', '<leader>bd', '<cmd>bd<cr>', { desc = '[D]elete [B]uffer' })

-- Move lines in visual mode
vim.keymap.set('v', 'J', ":m '>+1<cr>gv=gv", { desc = 'Move down' })
vim.keymap.set('v', 'K', ":m '<-2<cr>gv=gv", { desc = 'Move up' })

-- paste over currently selected text without yanking it
vim.keymap.set('v', 'p', '"_dp', { desc = 'which_key_ignore' })
vim.keymap.set('v', 'P', '"_dP', { desc = 'which_key_ignore' })

-- better scrolling with centered cursor
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'which_key_ignore' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'which_key_ignore' })

-- replace current selection (word) in buffer
vim.keymap.set('n', '<leader>r', [[>:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = '[R]eplace selection in buffer' })

vim.keymap.set('n', '<leader>lr', ':LspRestart<CR>')

-- better indenting
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- new file
vim.keymap.set('n', '<leader>nf', '<cmd>enew<cr>', { desc = 'New File' })
-- quick exit insert
vim.keymap.set('i', 'jk', '<esc>', { desc = 'Exit insert mode' })

-- do not yank normal mode x remove
vim.keymap.set('n', 'x', '"_x', { desc = 'which_key_ignore' })
-- quit
vim.keymap.set('n', '<leader>qq', '<cmd>qa<cr>', { desc = 'Quit all' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- lazygit
vim.keymap.set('n', '<leader>gg', ':!tmux new-window -c ' .. vim.fn.getcwd() .. ' -- lazygit <CR><CR>', { silent = true, desc = 'Open Lazy[G]it' })
