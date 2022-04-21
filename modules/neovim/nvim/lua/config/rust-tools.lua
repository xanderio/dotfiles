require('rust-tools').setup({
  autoSetHints = false,
  inlayHints = {
    only_current_line = false
  },
  server = {
    capabilities = require('lsp').capabilities(),
    on_attach = require('lsp').on_attach,
    flags = {
      debounce_text_changes = 150,
    },
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          command = "clippy"
        },
        files = {
          watcher = "server"
        },
        cargo = {
          allFeatures = true,
          loadOutDirsFromCheck = true
        },
        procMacro = {
          enable = true
        },
        diagnostics = {
          disabled = { "unresolved-import" }
        },
        completion = {
          snippets = snippets
        }
      }
    }
  },
  dap = {
    adapter = {
      command = "lldb-vscode13"
    }
  }
})

local snippets = {
  ["Arc::new"] = {
    postfix = { "arc" },
    body = { "Arc::new(${receiver})" },
    requires = "std::sync::Arc",
    description = "Put the expression in an `Arc`",
    scope = "expr"
  },
  ["Rc::new"] = {
    postfix = { "rc" },
    body = { "Rc::new(${receiver})" },
    requires = "std::rc::Rc",
    description = "Put the expression in an `Rc`",
    scope = "expr"
  },
  ["Box::pin"] = {
    postfix = { "pinbox" },
    body = { "Box::pin(${receiver})" },
    requires = "std::boxed::Box",
    description = "Put the expression into a pinned `Box`",
    scope = "expr"
  },
  ["Ok"] = {
    postfix = { "ok" },
    body = { "Ok(${receiver})" },
    description = "Wrap the expression in an `Result::Ok`",
    scope = "expr"
  },
  ["Err"] = {
    postfix = { "err" },
    body = { "Err(${receiver})" },
    description = "Wrap the expression in an `Result::Err`",
    scope = "expr"
  },
  ["Some"] = {
    postfix = { "some" },
    body = { "Some(${receiver})" },
    description = "Wrap the expression in an `Option::Some`",
    scope = "expr"
  },
}
