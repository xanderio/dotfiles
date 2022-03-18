require'lspconfig'.rnix.setup({
  capabilities = require('lsp').capabilities(),
  on_attach = require('lsp').on_attach,
})
