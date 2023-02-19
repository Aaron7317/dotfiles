
  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['ccls'].setup {}
  require('lspconfig')['lua_ls'].setup {}
  require('lspconfig')['cmake'].setup {}
  require('lspconfig')['rnix'].setup {}
  require('lspconfig')['pylsp'].setup {}
