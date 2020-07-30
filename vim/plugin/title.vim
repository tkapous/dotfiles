if exists('g:plugin_title')
  finish
endif
let g:plugin_title = 1

augroup WinTitle
  au!
  au BufRead,BufEnter * let &titlestring = MyWindowTitle()
augroup end

function! GetGitRepoName(file) abort
  let l:path=fnamemodify(a:file, ':p')
  while l:path != '' && l:path != '/'
    let l:path=fnamemodify(l:path, ':h')
    let l:candidate=l:path . '/.git'
    let l:folder=substitute(l:path, '/.*/', '', '')
    if isdirectory(l:path . '/.git')
      return l:folder
    endif
  endwhile
  return ''
endfunction

function! MyWindowTitle() abort
  let l:hostname = hostname() . "   ▏ "
  let l:file = substitute(expand('%'), '/.*/', '', '')
  let gitrepo = GetGitRepoName('%') . "   〉  "
  return(hostname . gitrepo . file)
endfunction
