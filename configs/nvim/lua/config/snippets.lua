local snippets = require'snippets'
local U = require'snippets.utils'

snippets.set_ux(require'snippets.inserters.vim_input')

snippets.use_suggested_mappings()

snippets.snippets.global = {
	todo = U.force_comment "TODO(xanderio): ";
}
