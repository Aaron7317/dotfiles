-- Options for neovim
-- Basic NeoVim Settings
vim.cmd('syntax on')
--vim.cmd('highlight SignColumn guibg=none ctermbg=none')

vim.cmd('set termguicolors')

vim.cmd('colorscheme nord')

-- Decrease update time
vim.o.timeout = true
vim.o.timeoutlen = 500
vim.o.updatetime = 200

-- Number of screen lines to keep above and below the cursor
vim.o.scrolloff = 8

-- Better editor UI
vim.o.number = true
vim.o.numberwidth = 2
vim.o.relativenumber = true
vim.o.signcolumn = 'yes'
vim.o.cursorline = true

-- Better editing experience
vim.o.expandtab = true
vim.o.smarttab = true
vim.o.cindent = true
vim.o.autoindent = true
vim.o.wrap = true
vim.o.textwidth = 300
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = -1 -- If negative, shiftwidth value is used
vim.o.list = true
vim.o.listchars = 'trail:·,nbsp:◇,tab:→ ,extends:▸,precedes:◂'
-- o.listchars = 'eol:¬,space:·,lead: ,trail:·,nbsp:◇,tab:→-,extends:▸,precedes:◂,multispace:···⬝,leadmultispace:│   ,'
-- o.formatoptions = 'qrn1'

-- Makes neovim and host OS clipboard play nicely with each other
vim.o.clipboard = 'unnamedplus'

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Undo and backup options
vim.o.backup = false
vim.o.writebackup = false
vim.o.undofile = true
vim.o.swapfile = false
-- o.backupdir = '/tmp/'
-- o.directory = '/tmp/'
-- o.undodir = '/tmp/'

-- Remember 50 items in commandline history
vim.o.history = 50

-- completion
vim.o.completeopt = 'menu,menuone,noselect'

-- Better buffer splitting
vim.o.splitright = true
vim.o.splitbelow = true

vim.opt.mouse = "a"

-- debugging windows
-- vim.g.termdebug_popup = 0
-- vim.g.termdebug_wide = 163

