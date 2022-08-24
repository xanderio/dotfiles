require('notify').setup({
  stages = "slide"
})

-- match LSP 
-- match group 1: everthing inside [ ]
-- match group 2: reset of input
--
-- LSP[rust_analyzer] overly long loop turn: 203.106162ms
local lsp_pattern = '^LSP%[(.*)%](.*)$'

function notify_filter(msg, log_level, opts)
  local notify = require('notify')

  if msg:find("does not support documentSymbols") then
    return
  end
  
  -- rust_analyzer: -32801: waiting for cargo metadata or cargo check
  if msg:find("waiting for cargo metadata or cargo check") then
    -- this error is emited on every startup, just ignore it -.-
    return
  end

  local lsp, message = string.match(msg, lsp_pattern)
  if lsp and message then

    if message:find("overly long loop turn") then
      -- i don't care
      return
    end

    opts = vim.tbl_deep_extend("force", opts or {}, { title = lsp })
    notify(message, log_level, opts)
    return
  end

  notify(msg, log_level, opts)
end

vim.notify = notify_filter
