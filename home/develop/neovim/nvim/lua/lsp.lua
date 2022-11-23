local cmd = vim.cmd
local M = {}

function lsp_formatting(bufnr) 
  vim.lsp.buf.format({
    filter = function(client)
      -- filter out clients that you don't want to use
      return client.name ~= "tsserver" 
    end,
    bufnr = bufnr,
})
end

function M.on_attach(client, bufnr)
  M.lsp_keybinding(bufnr)

  require('cmp').setup.buffer({
    sources = {
      { name = 'nvim_lsp' },
      { name = 'nvim_lsp_signature_help' },
      { name = 'luasnip' },
      { name = 'crates' },
      { name = 'emoji' },
      { name = 'buffer', keyword_length = 3, max_item_count = 4}
    }
  })

  local augroup = vim.api.nvim_create_augroup("Lsp", { clear = false })
  --vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })

  if vim.bo.filetype == "rust" then
    vim.api.nvim_create_autocmd({"BufEnter", "CursorHold", "InsertLeave"},
    {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.codelens.refresh()
      end,
    })

    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_create_autocmd("BufWritePre",
        {
          group = augroup,
          buffer = bufnr,
          callback = function()
            lsp_formatting(bufnr)
          end,
        })
    end
  end

  -- Lightbulb
    vim.api.nvim_create_autocmd({"CursorHold", "CursorHoldI"},
    {
      group = augroup,
      buffer = bufnr,
      callback = function()
        require('nvim-lightbulb').update_lightbulb()
      end,
    })

  -- lsp status
  --require('lsp-status').on_attach(client)
  require("fidget").setup({
    sources = {
      ['null-ls'] = {
        ignore = true,
      },
    },
  })

  require('nvim-navic').attach(client, bufnr)

  -- lsp trouble
  require("trouble").setup({})

  -- lsputils
  -- vim.lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
  vim.lsp.handlers['textDocument/references'] = require'lsputil.locations'.references_handler
  vim.lsp.handlers['textDocument/definition'] = require'lsputil.locations'.definition_handler
  vim.lsp.handlers['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
  vim.lsp.handlers['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
  vim.lsp.handlers['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
  vim.lsp.handlers['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
  vim.lsp.handlers['workspace/symbol'] = require'lsputil.symbols'.workspace_handler

  -- lsp extensions
  -- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  -- require('lsp_extensions.workspace.diagnostic').handler, {  }
  -- )
end

function M.capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = { "documentation", "detail", "additionalTextEdits" },
  }
  capabilities = vim.tbl_extend('keep', capabilities, require('lsp-status').capabilities)
  capabilities = vim.tbl_extend('keep', capabilities, require('cmp_nvim_lsp').default_capabilities())
  return capabilities
end

function M.status()
  if next(vim.lsp.buf_get_clients()) then
    return vim.trim(require('lsp-status').status())
  else 
    return nil
  end
end


function M.lsp_keybinding(bufnr) 
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  local opts = { noremap=true, silent=true }
  

  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.format()<CR>', opts)
  buf_set_keymap('n', 'd,', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', 'd;', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

  buf_set_keymap('n', '<C-t>', '<cmd>lua require("telescope.builtin").lsp_dynamic_workspace_symbols()<CR>', opts)
  buf_set_keymap('n', '<leader>m', '<cmd>lua require("telescope.builtin").lsp_document_symbols()<CR>', opts)

  if vim.bo.filetype == "rust" then
    -- buf_set_keymap('n', 'ga', '<cmd>RustCodeAction<CR>', opts)
    buf_set_keymap('n', 'J', '<cmd>RustJoinLines<CR>', opts)
  end
  buf_set_keymap('n', 'ga', '<cmd>CodeActionMenu<CR>', opts)

end

return M
