local cmd = vim.cmd
local M = {}

function M.on_attach(client, bufnr)
    M.lsp_keybinding(bufnr)

    require('cmp').setup.buffer({
      sources = {
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'luasnip' },
        { name = 'crates' },
        { name = 'emoji' },
        { name = 'buffer', keyword_length = 5, max_item_count = 2}
      }
    })

    cmd [[augroup Lsp]]
    if vim.bo.filetype == "rust" then
      cmd [[au BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()]]
    end
    if client.resolved_capabilities.document_formatting then
      cmd [[au BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000) ]]
    end
    -- Lightbulb
    cmd [[au CursorHold,CursorHoldI <buffer> lua require'nvim-lightbulb'.update_lightbulb()]]
    cmd [[augroup END]]

    -- lsp status
    require('lsp-status').on_attach(client)

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
  capabilities = vim.tbl_extend('keep', capabilities, require('lsp-status').capabilities)
  return require('cmp_nvim_lsp').update_capabilities(capabilities)
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
  buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
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
