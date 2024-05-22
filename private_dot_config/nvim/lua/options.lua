-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true

-- Use spaces instead of tabs
vim.opt.expandtab = true
vim.opt.shiftround = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

-- insert indents automatically
vim.opt.smartindent = true

-- scroll offset
vim.opt.scrolloff = 8

-- Enable break indent, wraps lines with indent
vim.opt.breakindent = true

-- Enable incremental search
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- confirm to save changes before exiting modified buffer
vim.opt.confirm = true

-- Don't show the mode, since it's already in status line
vim.opt.showmode = false

-- enable 24-bit color
vim.opt.termguicolors = true

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = 'unnamedplus'

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 200
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = false
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Turn of swapfile
vim.opt.swapfile = false

-- UTF-8 encoding
vim.opt.fileencoding = 'utf-8'

-- hide tilde on end of buffer
vim.opt.fillchars = { eob = ' ' }

-- use ripgrep
vim.opt.grepprg = 'rg --vimgrep --no-heading --smart-case'
