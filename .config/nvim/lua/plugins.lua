local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  
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

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
