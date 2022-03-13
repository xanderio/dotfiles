require('lspconfig').clangd.setup({
  capabilities = require('lsp').capabilities(),
  on_attach = require('lsp').on_attach,
  cmd = { "clangd13", "--background-index", "--inlay-hints" },
})
