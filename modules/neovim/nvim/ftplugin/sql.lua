require'lspconfig'.sqlls.setup({
  capabilities = require('lsp').capabilities(),
  on_attach = require('lsp').on_attach,
})

