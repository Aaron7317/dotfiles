-- Key mappings for neovim
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Key Bindings
-- Map <leader> to space
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Split navigation
map('n', '<C-J>', '<C-W><C-J>', opts)
map('n', '<C-K', '<C-W><C-K', opts)
map('n', '<C-L>', '<C-W><C-L>', opts)
map('n', '<C-H>', '<C-W><C-H>', opts)

-- Telescope mappings
map('n', '<leader>ff', ':Telescope find_files<cr>', opts)
map('n', '<leader>fg', ':Telescope live_grep<cr>', opts)
map('n', '<leader>fb', ':Telescope buffers<cr>', opts)
map('n', '<leader>fh', ':Telescope help_tags<cr>', opts)

-- Colorizer Toggling
map('n', '<leader>c', ':ColorizerToggle<cr>', opts)

-- Goyo plugin makes text more readable:
map('n', '<leader>g', ':Goyo | set linebreak | highlight SignColumn guibg=none ctermbg=none<CR>', opts)

-- Spell-check set to <leader>w, 'w' for 'writing':
map('n', '<leader>w', ':setlocal spell! spelllang=en_us<CR>', opts)

-- Nvim tree
map('n', '<leader>n', ':NvimTreeToggle<CR>', opts)

-- toggleterm
map('n', '<leader>t', ":ToggleTerm size=10 direction=horizontal<CR>", opts)
map('t', '<esc>', [[<C-\><C-n>]], opts)
map('t', 'jk', [[<C-\><C-n>]], opts)
map('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
map('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
map('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
map('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)


-- Barbar
-- Move to previous/next
map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)
-- Re-order to previous/next
map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)
-- Goto buffer in position...
map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)
-- Pin/unpin buffer
map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)
-- Close buffer
map('n', '<A-c>', '<Cmd>BufferClose<CR>', opts)

-- LuaSnip
-- Yes, we're just executing a bunch of Vimscript using vim.cmd
vim.cmd[[
" Use Tab to expand and jump through snippets
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
smap <silent><expr> <Tab> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<Tab>'

" Use Shift-Tab to jump backwards through snippets
imap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
smap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
]]
