setlocal suffixesadd=.python,.py,.pyw
setlocal colorcolumn=81

let b:undo_ftplugin = get(b:, 'undo_ftplugin' .. ' | ', '')
let b:undo_ftplugin .= "setlocal suffixesadd< colorcolumn<"
