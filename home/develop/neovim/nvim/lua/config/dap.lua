local cmd = vim.cmd

cmd [[nnoremap <silent> <leader>dt :lua require'dapui'.toggle()<CR>]]
cmd [[nnoremap <silent> <F5> :lua require'dap'.continue()<CR>]]
cmd [[nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>]]
cmd [[nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>]]
cmd [[nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>]]
cmd [[nnoremap <silent> <leader>b :lua require'dap'.toggle_breakpoint()<CR>]]
cmd [[nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>]]
cmd [[nnoremap <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>]]
cmd [[nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>]]
cmd [[nnoremap <silent> <leader>dl :lua require'dap'.run_last()<CR>]]
