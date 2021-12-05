local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

 if fn.empty(fn.glob(install_path)) > 0 then
   packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://gitee.com/nvim-plug-gitee-fork/packer.nvim', install_path})
 end

return require('packer').startup(function(use)
  -- My plugins here
  -- use 'foo1/bar1.nvim'
  -- use 'foo2/bar2.nvim'
  --
  -- A File Explorer For Neovim Written In Lua
  use {
    'nvim-plug-gitee-fork/nvim-tree.lua',
    requires = {
    	'nvim-plug-gitee-fork/nvim-web-devicons',	
    }
  }
  -- LSP
  use 'nvim-plug-gitee-fork/nvim-lspconfig'
  use 'nvim-plug-gitee-fork/cmp-nvim-lsp'
  use 'nvim-plug-gitee-fork/cmp-buffer'
  use 'nvim-plug-gitee-fork/cmp-path'
  use 'nvim-plug-gitee-fork/cmp-cmdline'
  use 'nvim-plug-gitee-fork/nvim-cmp'
  use 'nvim-plug-gitee-fork/cmp-vsnip'
  use 'nvim-plug-gitee-fork/vim-vsnip'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

