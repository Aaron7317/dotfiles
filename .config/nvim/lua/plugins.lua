-- Management and Installation of plugins for NeoVim

vim.cmd('packadd termdebug')

function get_setup(name)
  return string.format('require("setup/%s")', name)
end

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd [[packadd packer.nvim]]
end

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use({'wbthomason/packer.nvim'})

  -- File Management
  use({'nvim-tree/nvim-tree.lua', config = get_setup("nvim-tree")})

  -- Useful Misc
  use({'vimwiki/vimwiki', config = get_setup("vimwiki")})
  use {"akinsho/toggleterm.nvim", tag = 'v2.*', config = get_setup("toggleterm")}
  use({'folke/which-key.nvim', config = get_setup("which-key")})
 
  -- Telescope
  use("nvim-lua/plenary.nvim")
  use({
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
  -- or                            , branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  })

  -- Themes
  use({'arcticicestudio/nord-vim'})
    
  -- LaTeX
  use({'lervag/vimtex'})

  -- Style 
  use({'junegunn/goyo.vim'})
  use({'norcalli/nvim-colorizer.lua', config = get_setup("nvim-colorizer")})
  use({'kyazdani42/nvim-web-devicons'})
  use({'nvim-lualine/lualine.nvim', config = get_setup("lualine")})
  use({"lukas-reineke/indent-blankline.nvim", config = get_setup("indent-blankline")})
  use({'romgrk/barbar.nvim'})
  use({
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    config = get_setup("nvim-treesitter")
  })

  -- LSP and Completion Support
  use({'hrsh7th/cmp-nvim-lsp'})
  use({'hrsh7th/cmp-buffer'})
  use({'hrsh7th/cmp-path'})
  use({'hrsh7th/cmp-cmdline'})
  use({'hrsh7th/nvim-cmp', config = get_setup("nvim-cmp")})
  use({'L3MON4D3/LuaSnip', config = get_setup("luasnip")})
  use({'saadparwaiz1/cmp_luasnip'})
  -- Order of these is important!
  --use({"williamboman/mason.nvim", config = get_setup("mason")})
  --use({"williamboman/mason-lspconfig.nvim", config = get_setup("mason-lspconfig")})
  use({"neovim/nvim-lspconfig", config = get_setup("nvim-lspconfig")})
end)
