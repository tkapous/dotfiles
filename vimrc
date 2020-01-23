" *************************************************************************** "
"                                                                             "
" vimrc                                                                       "
"                                                 _____  _ __ _    _          "
" By: tris <tristan.kapous@protonmail.com>       |_   _|| '__|\ \/ /          "
"                                                  | |  | |    '  '           "
" Created: 2019/06/23 05:39:33 by tris             |_|  |_|   /_/\_\          "
" Updated: 2019/08/06 19:27:58 by tris                                        "
"                                                                             "
" *************************************************************************** "

""    Signature
" """""""""""""""""""""""""""""""""""""""""""""""""""
"  ____ _____ _____  _______     ______ _____		"
" |  _ \_   _/ ____|/ ____\ \   / /  _ \_   _|		"
" | |_) || || |  __| |  __ \ \_/ /| |_) || |		"
" |  _ < | || | |_ | | |_ | \   / |  _ < | |		"
" | |_) || || |__| | |__| |  | |  | |_) || |_		"
" |____/_____\_____|\_____|  |_|  |____/_____|vimrc "
"													"
" """""""""""""""""""""""""""""""""""""""""""""""""""

""    Vimrc settings

set nocompatible " not compatible with vi
filetype plugin on
" set shellcmdflag=-ic
let $BASH_ENV = "$HOME/dotfiles/bash_aliases" " use aliases in vim
let $PAGER=''	" clear pager env var in vim (for vim as pager)

" pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()
" execute pathogen#helptags()
" command! PHelpTags :call pathogen#helptags()
" function! PHelpTags ()
" 	call pathogen#helptags()
" endfunction

" automatically reload vimrc when modified
" au! BufWritePost $MYVIMRC silent source $MYVIMRC

""    Environement

let DOT="$HOME/dotfiles"
let HOM_VID="$HOME/Videos"
let HOM_PIC="$HOME/Pictures"
let HOM_GAM="$HOME/Games"
let HOM_DOC="$HOME/Documents"
let HOM_MUS="$HOME/Music"
let HOM_42="$HOME/42"
let GOPATH="$HOME/go"

""    General

" for 'gf' : add suffix to word under cursor
set suffixesadd=.tex,.latex,.java,.c,.h,.js

set history=10000 " default 20

" backspace behave in a sane manner
set backspace=indent,eol,start

" faster redrawing
set ttyfast

" coma is end of word
set iskeyword+=,

" restore undo history
if exists('+undofile')
  set undofile
endif

" Backup files dir
set hidden
set backupskip=/tmp/*,/private/tmp/*		" vim can edit crontab
set backupdir=$HOME/.vim/backup//
set directory=$HOME/.vim/swap//
set undodir=$HOME/.vim/undo//

" Shortmess : 'hit enter' prompt custzomization
set shortmess+=A				" No error message when swap exists, just edit
set shortmess+=f				" Abbreviation for file count
set shortmess+=i				" Abbreviation for line without end
set shortmess+=l				" Abbreviation for line and word count
set shortmess+=m				" Abbreviation for modified
set shortmess+=n				" Abbreviation for new file
set shortmess+=r				" Abbreviation for read only
set shortmess+=w				" Abbreviation for writter
set shortmess+=x				" Abbreviation for dos and mac format
set shortmess+=W				" No message when writing
" set cmdheight=2


" set noswapfile

" gnome adaptive cursor shape
" if has("au")
"   atocmdu VimEnter,InsertLeave * silent execute '!echo -ne "\e[2 q"' | redraw!
"   au InsertEnter,InsertChange *
"     \ if v:insertmode == 'i' |
"     \   silent execute '!echo -ne "\e[6 q"' | redraw! |
"     \ elseif v:insertmode == 'r' |
"     \   silent execute '!echo -ne "\e[4 q"' | redraw! |
"     \ endif
"   au VimLeave * silent execute '!echo -ne "\e[ q"' | redraw!
" endif


""    User Interface

set ruler
set mouse=a
set visualbell
set noerrorbells
set t_vb=
set wildmenu
set showmode
set showcmd
set completeopt=longest,menuone

" tabulation control
set noexpandtab				" tabs ftw
set smarttab				" tab respects 'tabstop' 'shiftwidth' 'softtabstop'
set tabstop=4				" the visible width of tabs
set softtabstop=4			" tabs 4 characters wide
set shiftwidth=4			" indents 4 characters wide
set autoindent				" automatically set indent of new line
set smartindent				" ... in a sane way
set shiftround				" round indent to a multiple of 'shiftwidth'
filetype indent on

set splitbelow				" default split below
set splitright				" default split right
" set equalalways			" always equalize windows
" set list					" show invisible characters
" set listchars=tab:>\ ,trail:·	" but only show tabs and trailing whitespace

set number					" show number column
set relativenumber			" relative to current line

" set number relativenumber
" augroup NumToggle
" 	au!
" 	au VimEnter,WinEnter,BufWinEnter * set number relativenumber
" 	au WinLeave * set nonumber norelativenumber
" augroup END

set virtualedit=block		" visual selection broken free

set whichwrap+=<,>,h,l,[,]	" free cursor betweem lines
set wrap					" no horizontal scroll
" set linebreak				" break lines
set breakindent				" with indent
set showbreak=\ \ ¬			" ... showing a character

set sidescrolloff=5			" min horizontal cursor offset
let &scrolloff=winheight(win_getid())/10 + 1 " min vertical cursor offset

" status line
set laststatus=2			" show the satus line all the time
" show buffer number
" set statusline=%02n:%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

""    Look / Theme

syntax on

if (has("termguicolors"))
  set termguicolors
endif

" code
set encoding=utf8
let base16colorspace=256	" access colors present in 256 colorspace"
set t_Co=256	" explicitly tell vim that the terminal supports 256 colors"



""    Window behaviour

augroup myterm | au!
	au TerminalOpen * if &buftype ==# 'terminal' | wincmd L | vert resize 55 | endif
augroup end

let g:term_buf = 0
let g:term_win = 0
function! Term_toggle(height)
	if win_gotoid(g:term_win)
		let g:term_win = 0
		hide
	else
		try
			exec "buffer " . g:term_buf
		catch
			vertical terminal
			"             let g:term_buf = bufnr("")
		endtry
		startinsert!
		let g:term_win = win_getid()
	endif
endfunction

nnoremap <leader>T :call Term_toggle(10)<cr>
tnoremap <c-t> <c-\><c-n>:call Term_toggle(10)<cr>
" tnoremap <a-h> <c-\><c-n><c-w>h
" tnoremap <a-j> <c-\><c-n><c-w>j
" tnoremap <a-k> <c-\><c-n><c-w>k
" tnoremap <a-l> <c-\><c-n><c-w>l

" Note: does not work anymore?
" resize windows quicker
nnoremap <leader>= :exe "resize +10"<cr>
nnoremap <leader>- :exe "resize -10"<cr>
nnoremap <leader>> :exe "vertical resize +10"<CR>:echo "width -"<cr>
nnoremap <leader>< :exe "vertical resize -10"<CR>:echo "width +"<cr>

" new file in vertical split instead of horizontal
nnoremap <c-w><c-n> :vertical new<cr>
nnoremap <c-w>n :vertical new<cr>
nnoremap <c-w><c-f> :vertical wincmd f<cr>


""    Highlights / Match
"""        Global
" highlight overlength ctermbg=203 ctermfg=white guibg=#592928
" match overlength /\%81v.\+/

" show traling whitespaces

" match TrailWhite /\s\+$/
augroup TrailWhite
	au!
	au BufWinEnter * match TrailWhite /\s\+$/
	au InsertEnter * match TrailWhite /\s\+\%#\@<!$/
	au InsertLeave * match TrailWhite /\s\+$/
	au BufWinLeave * call clearmatches()
augroup end

" focus current window : cursorline and relative numbers
augroup WinFocus
	au!
	au VimEnter,WinEnter,BufNew,WinNew * setlocal nocursorline "relativenumber number
	au WinLeave * setlocal nocursorline "norelativenumber number
augroup end

" color column 81 for code
if exists('+colorcolumn')
 	au FileType c,cpp,css,java,python,ruby,bash,sh set colorcolumn=81
endif

set mat=2 " how many tenths of a second to blink

" " Highlight 'f' searchers
" function! HighlightFSearches(cmd)
"   " Get extra character for the command.
"   let char = nr2char(getchar())
"   if char ==# ''
"     " Skip special keys: arrows, backspace...
"     return ''
"   endif
"   " Highlight 'char' on the current line.
"   let match_str = 'match IncSearch "\%' . line('.') . 'l' . char . '"'
"   execute match_str
"   " Finally, execute the original command with char appended to it
"   return a:cmd.char
" endfunction

" " highlight searches using 'f'
" nnoremap <expr> f HighlightFSearches('f')
" nnoremap f<bs> <nop>
" vnoremap <expr> f HighlightFSearches('f')
" vnoremap f<bs> <nop>

" " highlight searches using 'F'
" nnoremap <expr> F HighlightFSearches('F')
" nnoremap F<bs> <nop>
" vnoremap <expr> F HighlightFSearches('F')
" vnoremap F<bs> <nop>

"""        DarkLightSwitch
" switch between light and dark theme (UI + ligtline)
function! DarkLightSwitch()
	if g:DarkLightSwitch == 'dark'
		set background=dark
		source $HOME/.vim/colors/base16-onedark.vim
		let g:lightline = { 'colorscheme': 'wombat' }
		let g:DarkLightSwitch = 'light'
	else
		set background=light
		source $HOME/.vim/colors/base16-one-light.vim
		let g:lightline = { 'colorscheme': 'wombat_light' }
		let g:DarkLightSwitch = 'dark'
	endif
	if exists("g:DarkLightOn")
		call lightline#enable()
	endif
	let g:DarkLightOn = '0'
endfunction

" open vim with different color based on time of day

let g:DarkLightMod = '0'
" 0 : auto
" 1 : force dark
" 2 : force light
if ! exists("g:DarkLightMod")
	let g:DarkLightMod = '0'
endif
if g:DarkLightMod == '0'
	if ! exists("g:DarkLightOn")
		let hour = strftime("%H")
		if 9 <= hour && hour < 15
			let g:DarkLightSwitch = 'light'
		else
			let g:DarkLightSwitch = 'dark'
		endif
		call DarkLightSwitch()
	endif
elseif g:DarkLightMod == '1'
	let g:DarkLightSwitch = 'dark'
	call DarkLightSwitch()
elseif g:DarkLightMod == '2'
	let g:DarkLightSwitch = 'light'
	call DarkLightSwitch()
endif


nnoremap <silent> <leader>sc :call DarkLightSwitch()<cr>:call lightline#enable()<cr>
" nnoremap <leader>sv :source $MYVIMRC<cr>:call lightline#enable()<cr>:echo "vimrc sourced"<cr>

""    Folding

set foldmethod=syntax " fold based on indent
set foldnestmax=10 " deepest fold is 10 levels
set nofoldenable " don't fold by default
set foldlevel=1

" automatily save and restore files views (folding state and more)
augroup ReViews
	au!
	au BufWinLeave * if expand("%") != "" && &filetype != 'help' && &filetype != 'man' | mkview | endif
	au BufWinEnter * if expand("%") != "" && &filetype != 'help' && &filetype != 'man' | loadview | endif
augroup end

" inoremap <leader><space> <c-o>za
nnoremap <leader><space> za
onoremap <leader><space> <c-c>za
vnoremap <leader><space> zf

" recursively open even partial folds
nnoremap zo zczO

""    File automation

set autoread "not working until cmd like :e
" detect when a file is changed
if ! exists("g:CheckUpdateStarted")
    let g:CheckUpdateStarted=1
    call timer_start(1,'CheckUpdate')
endif
function! CheckUpdate(timer)
    silent! checktime
    call timer_start(1000,'CheckUpdate')
endfunction

" autosave file upon modification
" au TextChanged,TextChangedI <buffer> silent write

" open file where it was closed
augroup ReOpenFileWhereLeft
	au!
	au BufReadPost *
		\ if line("'\"") > 0 && line("'\"") <= line("$") |
		\   exe "normal! g`\"" |
		\ endif
augroup end

" auto change dir to git repo OR file directory
augroup CdGitRootOrFileDir
	au!
	au BufEnter * silent! cd %:p:h | silent! Gcd
augroup end

" filetype recognition
augroup FileTypeAutoSelect
	au!
	au FileType c setlocal ofu=ccomplete#CompleteCpp
	au FileType css setlocal ofu=csscomplete#CompleteCSS
	au FileType html,xhtml setlocal ofu=htmlcomplete#CompleteTags
	au FileType php setlocal ofu=phpcomplete#CompletePHP
	au FileType ruby,eruby setlocal ofu=rubycomplete#Complete
	au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
	au BufNewFile,BufFilePre,BufRead *.sh,bash,zsh set filetype=sh
	au BufNewFile,BufFilePre,BufRead *.c,h,cpp set filetype=c
	au BufNewFile,BufFilePre,BufRead *.php set filetype=php
	au BufNewFile,BufFilePre,BufRead *.css set filetype=css
	au BufNewFile,BufFilePre,BufRead *.html,htm set filetype=html
	au BufNewFile,BufFilePre,BufRead *.js set filetype=javascript
	au BufNewFile,BufFilePre,BufRead *.json set filetype=json
	" au BufNewFile,BufNew,BufFilePre,BufRead,BufEnter *.php set filetype=html syntax=phtml
augroup end

" refresh filetype upon writing
" au BufWritePost * filetype detect

" auto chose tag from .git folder
" set path for code
augroup CodePathTags
	au!
	au BufEnter * silent! set tags+=.git/tags
	au FileType make,c,cpp,css,java,python,ruby,js,json,javascript,sh au! BufRead,BufEnter <buffer> silent!
	\ | set path+=inc,incs,includes,include,headers,src,srcs,sources,js,html,ruby,python,javascript,tscript,typescript
augroup end
" set path+=**			" recursive path from current path

" autoreload tags file on save
" au BufWritePost *.c,*.cpp,*.h silent! !ctags -R --langmap=c:.c.h &
" au BufWritePost *.cpp silent! !ctags -R &
" set tags=tags;./git/
" set tags=./tags;

augroup HelpManSplit
	au!
	au FileType man au! BufEnter <buffer>
		\ | silent! wincmd H | silent! 79 wincmd|
		\ | setlocal noswapfile nobackup nobuflisted
		\ | setlocal nolinebreak wrap showbreak=
		\ | setlocal norelativenumber nonumber colorcolumn=0 signcolumn=no
	au FileType man
		\ | silent! wincmd H | silent! 79 wincmd|
		\ | setlocal noswapfile nobackup nobuflisted
		\ | setlocal nolinebreak wrap showbreak=
		\ | setlocal norelativenumber nonumber colorcolumn=0 signcolumn=no

	au FileType help au! BufEnter <buffer>
		\ | silent! wincmd H | silent! 79 wincmd|
		\ | setlocal noswapfile nobackup nobuflisted
		\ | setlocal nolinebreak nowrap showbreak=
		\ | setlocal norelativenumber nonumber colorcolumn=0 signcolumn=no

	au FileType help,man au! BufLeave <buffer> silent!
		\ | if (&columns < 88) | 0 wincmd| | endif
augroup end

"css width
" au BufEnter *.css silent! if (&filetype == 'css') | 40 wincmd| | endif

augroup HelpManMaps
	au! HelpManMaps
	au FileType help,man nnoremap <buffer> <silent> q :bw<cr>
augroup end

" Open man page in vim split, defaults to K
runtime! ftplugin/man.vim
set keywordprg=:Man
let $PAGER=''


""    Searching
nmap g/ :vimgrep /<C-R>//j %<CR>\|:cw<CR>

" set path+=**			" recursive path from current path
" set incsearch
set wildchar=<tab>
set wildmenu wildmode=longest:full,full
" set wildmode=full
" set wildmode=longest:full:list,full


set ignorecase			" case insensitive searching
set smartcase			" case-sensitive if expresson contains a capital letter
set hlsearch			" highlight all searches
set incsearch			" set incremental search, like modern browsers
set nolazyredraw		" don't redraw while executing macros

set switchbuf=useopen	" open buffers in their window if exist (:sb 'file')

" ignore some files from wildcard expansion
" set wildignore+=**/.git/**,**/__pycache__/**,**/venv/**,**/node_modules/**,**/dist/**,**/build/**,*.o,*.pyc,*.swp
set wildignore+=**/__pycache__/**,**/venv/**,**/node_modules/**,**/dist/**,**/build/**,*.o,*.pyc,*.swp

set magic " Set magic on, for regex

" use unix regex in searches
nnoremap / /\v
vnoremap / /\v

" keep cursor in middle of screen when searching / folding
" nnoremap n nzz
" nnoremap N Nzz
" nnoremap * *zz
" nnoremap # #zz
" nnoremap g* g*zz
" nnoremap g# g#zz
nnoremap zM zMzz
" " nnoremap za zazz
" nnoremap zA zAzz
" nnoremap <leader>za zMzvzz

"do not move cursor with match
nnoremap <silent> * :let @/= '\<' . expand('<cword>') . '\>' <bar> set hls <cr>
" vnoremap <silent> * :let @/= '\<' . expand('<cword>') . '\>' <bar> set hls <cr>
nnoremap <silent> g* :let @/=expand('<cword>') <bar> set hls <cr>

"Clear search highlight
nnoremap <silent> - :nohlsearch<cr>

" For local sed replace
nnoremap gr :s/<c-r>///g<left><left>
vnoremap gr :s/<c-r>///g<left><left>
nnoremap gR :%s/<c-r>///g<left><left>

" search visual selection
" function! s:VSetSearch()
" 	let temp = @@
" 	norm! gvy
" 	let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
" 	let @@ = temp
" endfunction

" vnoremap * :<c-u>cal <SID>VSetSearch()<cr>//<cr><c-o>
" vnoremap # :<c-u>cal <SID>VSetSearch()<cr>??<cr><c-o>
vnoremap * y/\V<C-R>=escape(@",'/\')<CR><CR>

""    Autocompletion

" inoremap <c-x>f <c-x><c-f>
" inoremap <c-x>] <c-x><c-]>
" inoremap <c-x>l <c-x><c-l>


""    Plugins settings
"""        Netrw

" Toggle Vexplore with <leader>t
function! ToggleNetrw()
	if exists("t:expl_buf_num")
		let expl_win_num = bufwinnr(t:expl_buf_num)
		let cur_win_num = winnr()
		if expl_win_num != -1
			while expl_win_num != cur_win_num
				exec "wincmd w"
				let cur_win_num = winnr()
			endwhile
			exec "bwipeout"
		endif
		unlet t:expl_buf_num
	else
		silent Lexplore
		let t:expl_buf_num = bufnr("%")
	endif
endfunction
" let g:NetrwIsOpen=0

" function! ToggleNetrw()
" 	if g:NetrwIsOpen
" 		let i = bufnr("$")
" 		while (i >= 1)
" 			if (getbufvar(i, "&filetype") == "netrw")
" 				silent exe "bwipeout " . i
" 			endif
" 			let i-=1
" 		endwhile
" 		let g:NetrwIsOpen=0
" 	else
" 		let g:NetrwIsOpen=1
" 		silent Lexplore
" 	endif
" endfunction

" function! ToggleNetrw()
" let i = bufnr("$")
" let wasOpen = 0
" while (i >= 1)
" 	if (getbufvar(i, "&filetype") == "netrw")
" 		silent exe "bwipeout " . i
" 		let wasOpen = 1
" 	endif
" 	let i-=1
" endwhile
" if !wasOpen
" silent Lexplore
" endif
" endfunction

" Add your own mapping. For example:
nnoremap <silent> <leader>t :call ToggleNetrw()<cr>
" nnoremap <silent> <leader>t :call ToggleVExplorer()<cr>

" Netrw customization
let g:netrw_keepdir= 0
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 2
let g:netrw_altv = 1
let g:netrw_winsize = -25
let g:netrw_sort_sequence = '[\/]$,*'					" sort folders on top

" open netrw if vim starts without file
let g:netrw_startup = 0
let g:netrw_startup_no_file = 1
augroup NetrwStartup
	au!
	au VimEnter * if g:netrw_startup_no_file == '1' && expand("%") == "" | e . | endif
  au VimEnter * if g:netrw_startup == '1' | e . | endif
augroup end


"""        Fugitive

nnoremap <silent> <leader>gg :vertical Gstatus<cr>
set diffopt+=vertical " vertical split for diff
augroup FugitiveSet
	au!
	" au FileType gitcommit start
	au FileType fugitive setlocal cursorline norelativenumber nonumber colorcolumn=0
augroup end

"""        Syntastic
" let g:syntastic_c_config_file = ['$HOME/dotfiles/.vim/c_errors_file']
" let g:syntastic_c_include_dirs = ["inc", "incs", "includes", "headers"]
" let g:syntastic_c_compiler_options = "-Wall -Wextra"
" let g:ycm_global_ycm_extra_conf = '~/dotfiles/ycm_extra_conf.py'

" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" set statusline+=%H*

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 1

" let g:syntastic_c_remove_include_errors = 1
" let g:syntastic_enable_c_checker = 1
" let g:syntastic_c_check_header = 1
" let g:syntastic_c_checkers = ['make', 'gcc', 'clangcheck']
" let g:syntastic_tex_checkers = ['lacheck']
" let g:ycm_use_clangd = 1

" let g:syntastic_python_checkers=['flake8']
" let g:syntastic_python_flake8_args = '--ignore="E501"' " ignore long lines

" let g:syntastic_json_checkers=['jsonlint']

" let g:syntastic_html_checkers=['tidy']

"""        Lightline
set noshowmode " do not show mode in status line
" Show full path of filename

" let g:lightline.colorscheme = 'wombat'

let g:lightline.mode_map = {
			\	'n': ' N ',
			\	'i': ' I ',
			\	'R': ' R ',
			\	'v': ' V ',
			\	'V': 'V-L',
			\	"\<c-v>": 'V-B',
			\	'c': ' C ',
			\	's': ' S ',
			\	'S': 'S-L',
			\	"\<c-s>": 'S-B',
			\	't': ' T ' }

let g:lightline.active = {
			\	'left': [ [ 'mode', 'paste' ],
			\			[ 'readonly', 'gitbranch' ],
			\			[ 'relativepath', 'modified' ] ],
		    \	'right': [ [ 'lineinfo' ],
			\			[ 'percent' ],
		    \			[ 'filetype' ] ] }

let g:lightline.inactive = {
			\	'left': [ [ 'readonly', 'gitbranch' ],
			\			[ 'relativepath', 'modified' ] ],
		    \	'right': [ [ 'lineinfo' ],
			\			[ 'percent' ],
		    \			[ 'filetype' ] ] }

" git branch from fugitive
let g:lightline.component_function = {
			\	'format': 'LightlineFileformat',
			\	'modified': 'LightlineModified',
			\	'fugitive': 'LightlineFugitive',
			\	'readonly': 'LightlineReadonly',
			\	'gitbranch': 'fugitive#head',
			\   'cocstatus': 'coc#status',
			\   'currentfunction': 'CocCurrentFunction',
			\	'filename': 'FilenameForLightline' }

" let g:lightline.separator = { 'left': '', 'right': '' }
" let g:lightline.subseparator = { 'left': '', 'right': '' }
let g:lightline.separator = { 'left': '', 'right': '' }
let g:lightline.subseparator = { 'left': '', 'right': '|' }

function! LightlineModified()
	return &ft =~ 'help\|vimfiler' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
	return &ft !~? 'help\|vimfiler' && &readonly ? 'RO' : ''
endfunction

function! LightlineFilename()
	return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
				\ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
				\  &ft == 'unite' ? unite#get_status_string() :
				\  &ft == 'vimshell' ? vimshell#get_status_string() :
				\ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
				\ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFileformat()
	return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFugitive()
	if exists('*fugitive#head')
		let branch = fugitive#head()
		return branch !=# '' ? ''.branch : ''
	endif
	return ''
endfunction

"""        Gitgutter
if exists('&signcolumn')  " Vim 7.4.2201
	set signcolumn=yes
else
	let g:gitgutter_sign_column_always = 1
endif
set updatetime=100						" need for Coc + gitgutter
nmap ]h <Plug>GitGutterNextHunk
nmap [h <Plug>GitGutterPrevHunk
let g:gitgutter_sign_added = '▎'
let g:gitgutter_sign_modified = '▎'
let g:gitgutter_sign_removed = '▎'
" let g:gitgutter_sign_removed = '▏'
let g:gitgutter_sign_removed_first_line = '▔'
let g:gitgutter_sign_modified_removed = '▎'
" let g:gitgutter_sign_modified_removed = '▋'

"""        FZF

let g:fzf_command_prefix = 'Fzf'
let g:fzf_buffers_jump = 1						" [Buffers] to existing window
let g:fzf_layout = { 'down' : '10 reverse' }
let g:fzf_colors =
	\ { 'fg':      ['fg', 'Normal'],
	\ 'bg':      ['bg', 'Normal'],
	\ 'hl':      ['fg', 'Comment'],
	\ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
	\ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
	\ 'hl+':     ['fg', 'Statement'],
	\ 'info':    ['fg', 'PreProc'],
	\ 'border':  ['fg', 'Ignore'],
	\ 'prompt':  ['fg', 'Conditional'],
	\ 'pointer': ['fg', 'Exception'],
	\ 'marker':  ['fg', 'Keyword'],
	\ 'spinner': ['fg', 'Label'],
	\ 'header':  ['fg', 'Comment'] }
let g:fzf_history_dir = '~/.local/share/fzf-history'

" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

nnoremap <leader>ff :FZF $HOME<cr>
nnoremap <leader><c-f> :FZF .<cr>
nnoremap <leader>F :FZF /<cr>
nnoremap <leader>fb :FzfBuffers<cr>
nnoremap <leader>b :FzfBuffers<cr>
nnoremap <leader>fw :FzfWindows<cr>
nnoremap <leader>ft :FzfTags<cr>
nnoremap <leader>f<c-t> :FzfBTags<cr>
nnoremap <leader>fc :FzfCommit<cr>
nnoremap <leader>fg :FzfGFiles?<cr>
nnoremap <leader>f<c-g> :FzfGFiles<cr>
nnoremap <leader>fl :FzfLines<cr>
nnoremap <leader>f<c-l> :FzfBLines<cr>
nnoremap <leader>f; :FzfHistory:<cr>
nnoremap <leader>f/ :FzfHistory/<cr>
nnoremap <leader>fh :FzfHistory<cr>
nnoremap <leader>fm :FzfHelptags<cr>
nnoremap <leader>fs <esc>:FzfSnippets<cr>
inoremap <c-f> <c-o>:Snippets<cr>
" nnoremap <leader>f :FZF<c-r>=fnamemodify(getcwd(), ':p')<cr><cr>

command! -bang -complete=dir -nargs=* LS
\ call fzf#run(fzf#wrap({'source': 'ls', 'dir': <q-args>}, <bang>0))

command! -bang -nargs=? -complete=dir Files
	\ call fzf#vim#files(<q-args>, {'options': ['--preview', 'bat {}']}, <bang>0)

"""        UltiSnips
inoremap <c-p> <nop>
inoremap <c-n> <nop>
" let g:UltiSnips#ExpandSnippetOrJump = "<c-n>"
let g:UltiSnipsExpandTrigger = "<c-x>"
" let g:UltiSnipsListSnippets = "<c-p>"
let g:UltiSnipsJumpForwardTrigger = "<c-n>"
let g:UltiSnipsJumpBackwardTrigger = "<c-p>"

"""        Searchhi
" let g:searchhi_clear_all_aus = 'InsertEnter'
" let g:searchhi_update_all_aus = 'InsertLeave'
" let g:searchhi_open_folds = 0

"""        Latex Live Preview

" au FileType tex,plaintex let g:tex_fold_enabled=1
augroup TexSet
	au!
	au FileType tex setlocal updatetime=1000
	" let g:livepreview_previewer = 'zathura'
	" let g:livepreview_cursorhold_recompile = 0
	" let g:livepreview_engine = 'your_engine' . ' [options]'
augroup end

"""        Vim-run
let g:vim_run_command_map = {
  \'javascript': 'node',
  \'php': 'php',
  \'python': 'python',
  \'markdown': 'markdown',
  \}

""    Quickfix

augroup ft_quickfix
	au!
	au FileType qf setlocal colorcolumn=0 nolist nocursorline tw=0

	" vimscript is a joke
	au FileType qf nnoremap <buffer> <cr> :execute "normal! \<lt>cr>"<cr>
	au FileType qf call AdjustWindowHeight(1, 5)
augroup end

function! AdjustWindowHeight(minheight, maxheight)
	let l = 1
	let n_lines = 0
	let w_width = winwidth(0)
	while l <= line('$')
		" number to float for division
		let l_len = strlen(getline(l)) + 0.0
		let line_width = l_len/w_width
		let n_lines += float2nr(ceil(line_width))
		let l += 1
	endw
	exe max([min([n_lines, a:maxheight]), a:minheight]) . "wincmd _"
endfunction


" Automatically open, but do not go to (if there are errors) the quickfix /
" location list window, or close it when is has become empty.
"
" Note: Must allow nesting of aus to enable any customizations for quickfix
" buffers.
" Note: Normally, :cwindow jumps to the quickfix window if the command opens it
" (but not if it's already open). However, as part of the au, this doesn't
" seem to happen.

" au QuickFixCmdPost [^l]* nested botright copen
" au QuickFixCmdPost    l* nested botright lwindo

augroup AutoLocationWindow
	au!
	au QuickFixCmdPost [^l]* nested botright lopen
	au QuickFixCmdPost    l* nested botright lwindow
augroup end

nnoremap <leader>cm :make<cr><cr>
nnoremap <leader>cr :make re<cr><cr>
nnoremap <leader>ce :make ex<cr><cr>
nnoremap <leader>ct :make ex TESTFF=test/test*<cr><cr>
nnoremap <leader>cT :make ex TESTFF=
nnoremap <leader>cv :make ex TEST=<cr><cr>
nnoremap <leader>c<c-t> :make ex TEST=test/%<cr><cr>

nnoremap <leader>csm :Shell make<cr>
nnoremap <leader>csr :Shell make re<cr>
nnoremap <leader>cse :Shell make ex<cr><cr>
nnoremap <leader>cst :Shell make ex TESTFF=test/test*<cr><cr>
nnoremap <leader>cs<c-t> :Shell make ex TEST=test/%<cr><cr>
nnoremap <leader>csT :Shell make ex TESTFF=
nnoremap <leader>csv :Shell make ex TEST=<cr><cr>
nnoremap <leader>csm :Shell make<cr><cr>

" nnoremap <leader>cc :ll<cr>
" nnoremap <leader>cn :lnext<cr>
" nnoremap <leader>cp :lprevious<cr>

" nnoremap ]<c-q> :cc<cr>
" nnoremap [q :cprev<cr>
" nnoremap ]q :cnext<cr>
" nnoremap [Q :cfirst<cr>
" nnoremap ]Q :clast<cr>

" nnoremap [<c-w> :ll<cr>
" nnoremap [w :lprev<cr>
" nnoremap ]w :lnext<cr>
" nnoremap [W :lfirst<cr>
" nnoremap ]W :llast<cr>

""    Mini plugins
"""        Shell output split

command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
	echo a:cmdline
	let expanded_cmdline = a:cmdline
	for part in split(a:cmdline, ' ')
		if part[0] =~ '\v[%#<]'
			let expanded_part = fnameescape(expand(part))
			let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
		endif
	endfor
	vert new
	setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
	call setline(1, a:cmdline . '  |  ' . expanded_cmdline)
	call setline(2,substitute(getline(1),'.','-','g'))
	execute '$read !'. expanded_cmdline
" 	setlocal nomodifiable
endfunction

"""        Scrollbar
" shows a horizontal scroll line, incompatible with lightline
" func! STL()
"   let stl = '%f [%{(&fenc==""?&enc:&fenc).((exists("+bomb") && &bomb)?",B":"")}%M%R%H%W] %y [%l/%L,%v] [%p%%]'
"   let barWidth = &columns - 65 " <-- wild guess
"   let barWidth = barWidth < 3 ? 3 : barWidth

"   if line('$') > 1
" 	let progress = (line('.')-1) * (barWidth-1) / (line('$')-1)
"   else
" 	let progress = barWidth/2
"   endif
"   " line + vcol + %
"   let pad = strlen(line('$'))-strlen(line('.')) + 3 - strlen(virtcol('.')) + 3 - strlen(line('.')*100/line('$'))
"   let bar = repeat(' ',pad).' [%1*%'.barWidth.'.'.barWidth.'('
" 		\.repeat('-',progress )
" 		\.'%2*0%1*'
" 		\.repeat('-',barWidth - progress - 1).'%0*%)%<]'

"   return stl.bar
" endfun

" hi def link User1 DiffAdd
" hi def link User2 DiffDelete
" set stl=%!STL()

"""        Smooth scroll
" function SmoothScroll(up)
"     if a:up
"         let scrollaction=""
"     else
"         let scrollaction=""
"     endif
"     exec "normal " . scrollaction
"     redraw
"     let counter=1
"     while counter<&scroll
"         let counter+=1
"         sleep 10m
"         redraw
"         exec "normal " . scrollaction
"     endwhile
" endfunction

" nnoremap <C-U> :call SmoothScroll(1)<Enter>
" nnoremap <C-D> :call SmoothScroll(0)<Enter>
" inoremap <C-U> <Esc>:call SmoothScroll(1)<Enter>i
" inoremap <C-D> <Esc>:call SmoothScroll(0)<Enter>i

" map <ScrollWheelUp> <C-Y>
" map <ScrollWheelDown> <C-E>

""    Headers
"""        42Header

let s:asciiart = [
			\"               /          ",
			\"     .::    .:/ .      .::",
			\"  +:+:+   +:    +:  +:+:+ ",
			\"   +:+   +:    +:    +:+  ",
			\"  #+#   #+    #+    #+#   ",
			\" #+#   ##    ##    #+#    ",
			\"###    #+. /#+    ###.fr  ",
			\"          /               ",
			\"         /                ",
			\"           LE - /         "
			\]

" let s:asciiart = [
" 			\":.:      .: .:  .:      .:",
" 			\" :+:   :+: +:+ +:+:   :+:+",
" 			\"  +:+ +:+  +:+ +:+:+ +:+:+",
" 			\"    #+#    #+# #+# #+# #+#",
" 			\"     +     #+# #+#  +  #+#",
" 			\""
" 			\]

" :.:     :.: :.: :.:     :.:
"  :+:   :+:  +:+ +:+:   :+:+
"   +:+ +:+   +:+ +:+:+ +:+:+
"    +#+#+    #+# #+# #+# #+#
"     #+#     #+# #+# #+# #+#
"      +      #+# #+#  +  #+#

" let s:asciiart = [
" 			\"        :::      ::::::::",
" 			\"      :+:      :+:    :+:",
" 			\"    +:+ +:+         +:+  ",
" 			\"  +#+  +:+       +#+     ",
" 			\"+#+#+#+#+#+   +#+        ",
" 			\"     #+#    #+#          ",
" 			\"    ###   ########.fr    "
" 			\]

let s:start		= '/*'
let s:end		= '*/'
let s:fill		= '*'
let s:length	= 80
let s:margin	= 5

let s:types		= {
			\'\.c$\|\.h$\|\.cc$\|\.hh$\|\.cpp$\|\.hpp$\|\.php':
			\['/*', '*/', '*'],
			\'\.htm$\|\.html$\|\.xml$':
			\['<!--', '-->', '*'],
			\'\.js$':
			\['//', '//', '*'],
			\'\.tex$':
			\['%', '%', '*'],
			\'\.ml$\|\.mli$\|\.mll$\|\.mly$':
			\['(*', '*)', '*'],
			\'\.vim$\|\vimrc$':
			\['"', '"', '*'],
			\'\.el$\|\emacs$':
			\[';', ';', '*'],
			\'\.f90$\|\.f95$\|\.f03$\|\.f$\|\.for$':
			\['!', '!', '/']
			\}

function! s:filetype()
	let l:f = s:filename()
	let s:start	= '#'
	let s:end	= '#'
	let s:fill	= '*'
	for type in keys(s:types)
		if l:f =~ type
			let s:start	= s:types[type][0]
			let s:end	= s:types[type][1]
			let s:fill	= s:types[type][2]
		endif
	endfor
endfunction

function! s:ascii(n)
	return s:asciiart[a:n - 3]
endfunction

function! s:textline(left, right)
	let l:left = strpart(a:left, 0, s:length - s:margin * 3 - strlen(a:right) + 1)
	return s:start . repeat(' ', s:margin - strlen(s:start)) . l:left . repeat(' ', s:length - s:margin * 2 - strlen(l:left) - strlen(a:right)) . a:right . repeat(' ', s:margin - strlen(s:end)) . s:end
endfunction

function! s:line(n)
	if a:n == 1 || a:n == 12 " top and bottom line
		return s:start . ' ' . repeat(s:fill, s:length - strlen(s:start) - strlen(s:end) - 2) . ' ' . s:end
		" 	elseif a:n == 2 || a:n == 10 " blank line
		" 		return s:textline('', '')
	elseif a:n == 2 || a:n == 3 || a:n == 5 || a:n == 7 || a:n == 10 || a:n == 11 " empty with ascii
		return s:textline('', s:ascii(a:n))
	elseif a:n == 4 " filename
		return s:textline(s:filename(), s:ascii(a:n))
	elseif a:n == 6 " author
		return s:textline("By: " . s:user() . " <" . s:mail() . ">", s:ascii(a:n))
	elseif a:n == 8 " created
		return s:textline("Created: " . s:date() . " by " . s:user(), s:ascii(a:n))
	elseif a:n == 9 " updated
		return s:textline("Updated: " . s:date() . " by " . s:user(), s:ascii(a:n))
	endif
endfunction

function! s:user()
	let l:user = $USER
	if strlen(l:user) == 0
		let l:user = "marvin"
	endif
	return l:user
endfunction

function! s:mail()
	let l:mail = $MAIL
	if strlen(l:mail) == 0
		let l:mail = "marvin@student.le-101.fr"
	endif
	return l:mail
endfunction

function! s:filename()
	let l:filename = expand("%:t")
	if strlen(l:filename) == 0
		let l:filename = "< new >"
	endif
	return l:filename
endfunction

function! s:date()
	return strftime("%Y/%m/%d %H:%M:%S")
endfunction

function! s:insert()
	let l:line = 12
	" empty line after header
	call append(0, "")
	" loop over lines
	while l:line > 0
		call append(0, s:line(l:line))
		let l:line = l:line - 1
	endwhile
endfunction

function! s:update()
	call s:filetype()
	if getline(9) =~ s:start . repeat(' ', s:margin - strlen(s:start)) . "Updated: "
		if &mod
			call setline(9, s:line(9))
		endif
		call setline(4, s:line(4))
		return 0
	endif
	return 1
endfunction

function! Stdheader()
	if s:update()
		call s:insert()
	endif
endfunction

" Bind command and shortcut
command! Header101 call Stdheader()
" nnoremap <leader>h1 :Header101<cr>
nnoremap <silent> <leader>h1 :call Stdheader()<cr>
" au BufWritePre * call s:update ()

""    Operators
"""        Start / End of line
onoremap ah :<c-u>normal! ^<cr>
onoremap ih :<c-u>normal! h^<cr>

onoremap al :<c-u>normal! v$<cr>
onoremap il :<c-u>normal! lv$<cr>

"""        Surroundings
onoremap i. :<c-u>normal! T.vt.<cr>
onoremap a. :<c-u>normal! F.vf.<cr>

onoremap i, :<c-u>normal, T,vt,<cr>
onoremap a, :<c-u>normal, F,vf,<cr>

onoremap i: :<c-u>normal! T:vt:<cr>
onoremap a: :<c-u>normal! F:vf:<cr>

onoremap i; :<c-u>normal! T;vt;<cr>
onoremap a; :<c-u>normal! F;vf;<cr>

onoremap i? :<c-u>normal! T?vt?<cr>
onoremap a? :<c-u>normal! F?vf?<cr>

onoremap i! :<c-u>normal! T!vt!<cr>
onoremap a! :<c-u>normal! F!vf!<cr>

onoremap i- :<c-u>normal! T-vt-<cr>
onoremap a- :<c-u>normal! F-vf-<cr>

onoremap i_ :<c-u>normal! T_vt_<cr>
onoremap a_ :<c-u>normal! F_vf_<cr>

onoremap i/ :<c-u>normal! T/vt/<cr>
onoremap a/ :<c-u>normal! F/vf/<cr>

onoremap i\ :<c-u>normal! T\vt\<cr>
onoremap a\ :<c-u>normal! F\vf\<cr>

onoremap i@ :<c-u>normal! T@vt@<cr>
onoremap a@ :<c-u>normal! F@vf@<cr>

onoremap i* :<c-u>normal! T*vt*<cr>
onoremap a* :<c-u>normal! F*vf*<cr>

" onoremap i| :<c-u>normal! T|vt|<cr>
" onoremap a| :<c-u>normal! F|vf|<cr>

"""        Next Surroundings
onoremap in( :<c-u>normal! f(vi(<cr>
onoremap in) :<c-u>normal! f(vi(<cr>
onoremap an( :<c-u>normal! f(va(<cr>
onoremap an) :<c-u>normal! f(va(<cr>
onoremap iN( :<c-u>normal! F(vi(<cr>
onoremap iN) :<c-u>normal! F(vi(<cr>
onoremap aN( :<c-u>normal! F(va(<cr>
onoremap aN) :<c-u>normal! F(va(<cr>

onoremap in{ :<c-u>normal! f{vi{<cr>
onoremap in} :<c-u>normal! f{vi{<cr>
onoremap an{ :<c-u>normal! f{va{<cr>
onoremap an} :<c-u>normal! f{va{<cr>
onoremap iN{ :<c-u>normal! F{vi{<cr>
onoremap iN} :<c-u>normal! F{vi{<cr>
onoremap aN{ :<c-u>normal! F{va{<cr>
onoremap aN} :<c-u>normal! F{va{<cr>

onoremap in[ :<c-u>normal! f[vi[<cr>
onoremap in] :<c-u>normal! f[vi[<cr>
onoremap an[ :<c-u>normal! f[va[<cr>
onoremap an] :<c-u>normal! f[va[<cr>
onoremap iN[ :<c-u>normal! F[vi[<cr>
onoremap iN] :<c-u>normal! F[vi[<cr>
onoremap aN[ :<c-u>normal! F[va[<cr>
onoremap aN] :<c-u>normal! F[va[<cr>

onoremap in< :<c-u>normal! f<vi<<cr>
onoremap in> :<c-u>normal! f<vi<<cr>
onoremap an< :<c-u>normal! f<va<<cr>
onoremap an> :<c-u>normal! f<va<<cr>
onoremap iN< :<c-u>normal! F<vi<<cr>
onoremap iN> :<c-u>normal! F<vi<<cr>
onoremap aN< :<c-u>normal! F<va<<cr>
onoremap aN> :<c-u>normal! F<va<<cr>

onoremap in" :<c-u>normal! f"vi"<cr>
onoremap an" :<c-u>normal! f"va"<cr>
onoremap iN" :<c-u>normal! F"vi"<cr>
onoremap aN" :<c-u>normal! F"va"<cr>

onoremap in' :<c-u>normal! f'vi'<cr>
onoremap an' :<c-u>normal! f'va'<cr>
onoremap iN' :<c-u>normal! F'vi'<cr>
onoremap aN' :<c-u>normal! F'va'<cr>

onoremap in. :<c-u>normal! f.lvt.<cr>
onoremap an. :<c-u>normal! f.vf.<cr>
onoremap iN. :<c-u>normal! F.hvT.<cr>
onoremap aN. :<c-u>normal! F.vF.<cr>

onoremap in- :<c-u>normal! f-lvt-<cr>
onoremap an- :<c-u>normal! f-vf-<cr>
onoremap iN- :<c-u>normal! F-hvT-<cr>
onoremap aN- :<c-u>normal! F-vF-<cr>

onoremap in, :<c-u>normal, f,lvt,<cr>
onoremap an, :<c-u>normal, f,vf,<cr>
onoremap iN, :<c-u>normal, F,hvT,<cr>
onoremap aN, :<c-u>normal, F,vF,<cr>

onoremap in* :<c-u>normal! f*lvt*<cr>
onoremap an* :<c-u>normal! f*vf*<cr>
onoremap iN* :<c-u>normal! F*hvT*<cr>
onoremap aN* :<c-u>normal! F*vF*<cr>

""    Mappings
"""        Modes
" space as leader, prompt '\' in command line window :)
map <space> <leader>

" enter command mode with ;
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;
nnoremap <leader>; :!

" jk to enter normal mode
inoremap jk <esc>
cnoremap jk <esc>
nnoremap gI `.gi<esc>

" no more default ex mode
nnoremap Q <nul>

" <c-z> in insert mode
inoremap <c-z> <c-[><c-z>

" <c-s> save and enter normal mode
nnoremap <c-s> :w<cr>
inoremap <c-s> <c-o>:stopinsert<cr>:w<cr><esc>

" :W! save files as root
cnoremap <c-r><c-s> %!sudo tee > /dev/null %

"""        Files

" cd shell to vim current working directory
nnoremap <leader>cd :!cd &pwd<cr> :echo "shell cd : pwd"<cr>

" toggle cursor always in middle with <leader>zz
nnoremap <silent> <leader>zz :let &scrolloff=999-&scrolloff<cr>

" open file under cursor in vertical split
nnoremap g<c-f> :vertical wincmd f<cr>

" trim current line
nnoremap <silent> <leader>xx :s/\s\+$//<cr>:redraw<cr>
"trim file
nnoremap <leader>xX :%s/\s\+$//<cr>:redraw<cr>

" % as <c-g>
nnoremap <c-g> %

" Word count
function! WC()
    echo system("detex " . expand("%") . " | wc -w | tr -d [[:space:]]") "words"
endfunction
nnoremap <leader>wc :call WC()<cr>
" nnoremap <leader>w :w !detex \| wc -w<cr>


"""        Popup Menu Completion
inoremap <expr> <c-j> pumvisible() ? "\<C-n>" : ""
inoremap <expr> <c-k> pumvisible() ? "\<C-p>" : ""
inoremap <silent><expr> <c-@> pumvisible() ? "\<c-y>" : coc#refresh()
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" nnoremap <silent><expr> <c-@> coc#refresh()
" inoremap <silent><expr> <c-@> pumvisible() ? coc#_select_confirm() : coc#refresh()
" inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() :
			" \"\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

"""        Coc
" function text object mappings
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" pmenu mappings
set cmdheight=2
nmap <silent> <leader>gf <Plug>(coc-definition)
nmap <silent> <leader>gd <Plug>(coc-declaration)
nmap <silent> <leader>gt <Plug>(coc-type-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)
nmap <silent> [w <Plug>(coc-diagnostic-prev)
nmap <silent> ]w <Plug>(coc-diagnostic-next)
nmap <leader>cf  <Plug>(coc-fix-current)

" rename word
nmap <leader>rn <Plug>(coc-rename)

" show doc on K
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	else
		call CocAction('doHover')
	endif
endfunction

" Highlight symbol under cursor on CursorHold
au CursorHold * silent call CocActionAsync('highlight')

augroup mygroup
	au!
	" Setup formatexpr specified filetype(s).
	au FileType typescript,json setl formatexpr=CocAction('formatSelected')
	" Update signature help on jump placeholder
	au User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" set nobackup
" set nowritebackup
set shortmess+=c

au User CocStatusChange,CocDiagnosticChange call lightline#update()
function! StatusDiagnostic() abort
	let info = get(b:, 'coc_diagnostic_info', {})
	if empty(info) | return '' | endif
	let msgs = []
	if get(info, 'error', 0)
		call add(msgs, 'E' . info['error'])
	endif
	if get(info, 'warning', 0)
		call add(msgs, 'W' . info['warning'])
	endif
	return join(msgs, ' ') . ' ' . get(g:, 'coc_status', '')
endfunction

let g:markdown_fenced_languages = ['css', 'js=javascript']

" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

"""        Movement
" up down on visual lines
nnoremap <silent> j gj
nnoremap <silent> k gk
xnoremap <silent> j gj
xnoremap <silent> k gk

nnoremap H ^
nnoremap L g_
nnoremap <c-h> B
nnoremap <c-l> E
nnoremap <c-k> {
nnoremap <c-j> }
nnoremap <c-q> <silent>:redraw<cr>

"go to next / previous buffer
nnoremap <leader>] :bn<cr>
nnoremap <leader>[ :bp<cr>

vnoremap H ^
vnoremap L g_
vnoremap <c-h> B
vnoremap <c-l> E
vnoremap <c-k> {
vnoremap <c-j> }

" move between windows with ctrl
" nnoremap <c-h> :wincmd h<cr>
" nnoremap <c-j> :wincmd j<cr>
" nnoremap <c-k> :wincmd k<cr>
" nnoremap <c-l> :wincmd l<cr>
" imap <c-w> <c-o><c-w>

" open buffer with partial search
" nnoremap <leader>b :buffer<space>
" nnoremap <leader><c-b> :vertical sbuffer<space>
" nnoremap <leader>B :sbuffer<space>
" nnoremap <leader>T :vertical sbuffer !/bin/bash<cr>

"navigate through git commits
" nnoremap ]g :!git checkout HEAD~1<cr>
" nnoremap [g :!git checkout HEAD^1<cr>

"""        Command
cnoremap <c-a> <Home>
cnoremap <c-e> <End>
cnoremap <c-k> <Up>
cnoremap <c-j> <Down>
cnoremap <c-b> <Left>
cnoremap <c-f> <Right>
cnoremap <c-l> <S-Right>
cnoremap <c-h> <S-Left>
cnoremap <c-x> <Del>
cnoremap <c-o> <s-tab>
cnoremap <c-r><c-l> <c-r>=substitute(getline('.'), '^\s*', '', '')<cr>

"""        Clipboard

" delete without saving to register
nnoremap <leader>d "_d
xnoremap <leader>d "_d
" xnoremap <leader>p "_dP

" paste with indentation
" nnoremap P mp]P==`p
" nnoremap p mp]p==`p

nnoremap cl c$
nnoremap dl d$
nnoremap yl y$
nnoremap ch c^
nnoremap dh d^
nnoremap yh y^

" System clipboard interraction
" paste from clipboard ...
nnoremap <leader>p mp"+]p==`p
nnoremap <leader>P mp"+]P==`p
" ... on new line ...
nnoremap <leader>op o<esc>"+]p==
" ... above
nnoremap <leader>oP O<esc>"+]p==
nnoremap <leader>Op O<esc>"+]p==
nnoremap <leader>OP O<esc>"+]p==
" copy to clipboard
nnoremap <leader>y "+y
nnoremap <leader>yl "+y$
nnoremap <leader>yh "+y^
vnoremap <leader>y "+y

" helpers for dealing with other people's code
" nmap \t :set ts=4 sts=4 sw=4 noet<cr>
" nmap \s :set ts=4 sts=4 sw=4 et<cr>


"""        Dotfiles

" source vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>:call lightline#enable()<cr>:echo "vimrc sourced"<cr>
nnoremap <leader>ss :source $MYVIMRC<cr>:nohlsearch<cr>:w<cr>:redraw<cr>:echo "all fresh"<cr>

" source colors
nnoremap <silent> <leader>s1 :source $HOME/.vim/colors/base16-onedark.vim<cr>
nnoremap <silent> <leader>s2 :source $HOME/.vim/colors/base16-one-light.vim<cr>


" edit dotfiles
nnoremap <leader>ev :e $DOT/vimrc<cr>
nnoremap <leader>e<c-v> :vertical split $DOT/vimrc<cr>
nnoremap <leader>eb :e $DOT/bashrc<cr>
nnoremap <leader>e<c-b> :vertical split $DOT/bashrc<cr>
nnoremap <leader>ea :e $DOT/bash_aliases<cr>
nnoremap <leader>e<c-a> :vertical split $DOT/bash_aliases<cr>
nnoremap <leader>ei :e $DOT/inputrc<cr>
nnoremap <leader>e<c-i> :vertical split $DOT/inputrc<cr>
nnoremap <leader>ep $DOT/bash_profile<cr>
nnoremap <leader>e<c-p> :vertical split $DOT/bash_profile<cr>
nnoremap <leader>ec1 :e $DOT/vim/colors/base16-onedark.vim<cr>
nnoremap <leader>ec2 :e $DOT/vim/colors/base16-one-light.vim<cr>
nnoremap <leader>eco :CocConfig<cr>
set notimeout
set ttimeout
set ttimeoutlen=10


" " rename file
" nnoremap <leader>mv :!mv % %:h:p/

""    Code Mappings
"""        General
nnoremap g<c-g> gg=G<c-o><c-o>
nnoremap <expr> <leader>cl get(getloclist(0, {'winid':0}), 'winid', 0) ?
			\ ":lclose<cr>" : ":lopen<cr><c-w>p"

"""        bash
augroup Shmaps
	au! Shmaps
	au FileType sh inoremap <buffer> ,#! #!/bin/bash
augroup end

"""        C
augroup Cmaps
	au! Cmaps
	au FileType c inoremap <buffer> ,ma <esc>:Header101<cr>iint<tab><tab>main(int ac, char **av)<cr>{<cr>}<esc>Oreturn(0);<esc>O
	au FileType c inoremap <buffer> ,if if ()<cr>{<cr>}<esc>2k3==f)i
	au FileType c inoremap <buffer> ,wh while ()<cr>{<cr>}<esc>2k3==f)i
	au FileType c inoremap <buffer> ,ret return (0);<esc>^
	au FileType c inoremap <buffer> ,imin -2147483648
	au FileType c inoremap <buffer> ,imax 2147483647
	au FileType c inoremap <buffer> ,endl ft_putendl("");<left><left><left>
	au FileType c inoremap <buffer> ,str ft_putstr("");<left><left><left>
	au FileType c inoremap <buffer> ,nbr ft_putnbr();<cr>ft_putendl("");<up><left><left>
	au FileType c inoremap <buffer> ,lib #include <stdlib.h><cr>#include <unistd.h><cr>#include <stdio.h><cr>#include <sys/types.h><cr>#include <sys/wait.h><cr>#include <sys/types.h><cr>#include <sys/stat.h><cr>#include <fcntl.h><cr>

	au FileType c nnoremap <buffer> <leader><c-]> <c-w>v<c-]>z<cr>
	au FileType c nnoremap <buffer> <leader>xt $Ji<space>?<esc>$i : 0<esc>^dw

	" le and execute current
	au FileType c nnoremap <buffer> <leader>cc :Shell gcc -Wall -Wextra % && ./a.out
	au FileType c nnoremap <buffer> <leader>cm :Shell gcc -Wall -Wextra % main.c && ./a.out

	" close brackets
	au FileType c inoremap <buffer> {<cr>  {<cr>}<esc>O

	" brackets around paragraph
	au FileType c nnoremap <buffer> <leader>{} {S{<esc>}S}<c-c>=%<c-o><c-o>=iB
	au FileType c nnoremap <buffer> <leader>{{ o}<esc>kO{<esc>3==j

	"  name of current c function (needs '()')
	au FileType c nnoremap <silent> g<c-d> j[[h^t(b

	" semicolon/coma EOL
	au FileType c nnoremap <leader>; i<c-o>m`<c-o>A;<esc>``<esc>
	au FileType c nnoremap <leader>, i<c-o>m`<c-o>A,<esc>``<esc>

	" t all text in function
	au FileType c nnoremap <leader>vf j[[V%o
augroup end

" nnoremap viB [[%v%jok$
" nnoremap vaB [[%v%
" " nnoremap vib [{%v%jok$
" nnoremap vab [{%v%

" " Commenting blocks of code.
" au FileType c,cpp,java,scala let b:com_size = '3' | let b:com = '// '
" au FileType sh,ruby,python   let b:com_size = '2' | let b:com = '# '
" au FileType conf,fstab       let b:com_size = '2' | let b:com = '# '
" au FileType tex              let b:com_size = '2' | let b:com = '% '
" au FileType mail             let b:com_size = '2' | let b:com = '> '
" au FileType vim              let b:com_size = '2' | let b:com = '" '
" au FileType readline         let b:com_size = '2' | let b:com = '# '

" nnoremap <silent> <leader>'' m'V:norm i<c-r>=expand(b:com)<cr><cr>`'<right><right>
" vnoremap <silent> <leader>'' m':norm i<c-r>=expand(b:com)<cr><cr>`'

" nnoremap <silent> <leader>"" m'V:norm <c-r>=expand(b:com_size)<cr>x<cr>`'<left><left>
" vnoremap <silent> <leader>"" m':norm <c-r>=expand(b:com_size)<cr>x<cr>`'

" noremap <silent> <leader>'p yypk:<c-b> <c-e>s/^\V<c-r>=escape(b:comment_leader,'\/')<cr>//e<cr>:nohlsearch<cr>

"""        JavaScript
augroup JSmaps
	au! JSmaps
	au FileType javascript nnoremap <buffer> <leader>cr :Run<cr>
	au FileType javascript nnoremap <buffer> <leader>ca :AutoRun<cr>
	au FileType javascript nnoremap <buffer> <leader>; i<c-o>m`<c-o>A;<esc>``<esc>
	au FileType javascript nnoremap <buffer> <leader>, i<c-o>m`<c-o>A,<esc>``<esc>
	au FileType javascript inoremap <buffer> {<cr>  {<cr>}<esc>O
	au FileType javascript nnoremap <buffer> <leader>cc :Shell node %<cr>
	au FileType javascript nnoremap <buffer> <leader>ls :!live-server %<cr>
	au FileType javascript inoremap <buffer> ,if if ()<cr>{<cr>}<esc>2k3==f)i
	au FileType javascript inoremap <buffer> ,fo for ()<cr>{<cr>}<esc>2k3==f)i
	au FileType javascript inoremap <buffer> ,wh while ()<cr>{<cr>}<esc>2k3==f)i
	au FileType javascript inoremap <buffer> ,cl console.log();<esc>F)i
	au FileType javascript nnoremap <buffer> <leader>xl yiwoconsole.log();<esc>F(p
	au FileType javascript vnoremap <buffer> <leader>xl yoconsole.log();<esc>F(p
augroup end

"""        Json
augroup Jsonmaps
	au! Jsonmaps
	au FileType json nnoremap <buffer> <leader>; i<c-o>m`<c-o>A;<esc>``<esc>
	au FileType json nnoremap <buffer> <leader>, i<c-o>m`<c-o>A,<esc>``<esc>
	au FileType json inoremap <buffer> {<cr>  {<cr>}<esc>O
augroup end

"""        PHP/HTML/CSS
augroup Webmaps
	au! Webmaps
	au FileType css nnoremap <buffer> <c-w>u :40 wincmd\|<cr>
	au FileType css inoremap <buffer> {<cr>  {<cr>}<esc>O
	au FileType php,html inoremap <buffer> ,php <?php<cr>?><esc>O
	au FileType php,html inoremap <buffer> ,bo <body></body><esc>F<i
	au FileType php,html inoremap <buffer> ,h1 <h1></h1><esc>F<i
	au FileType php,html inoremap <buffer> ,h2 <h2></h2><esc>F<i
	au FileType php,html inoremap <buffer> ,h3 <h3></h3><esc>F<i
	au FileType php,html inoremap <buffer> ,h4 <h4></h4><esc>F<i
	au FileType php,html inoremap <buffer> ,h5 <h5></h5><esc>F<i
	au FileType php,html inoremap <buffer> ,h6 <h6></h6><esc>F<i
	au FileType php,html inoremap <buffer> ,pp <p></p><esc>F<i
	au FileType php,html inoremap <buffer> ,br <br/>
	au FileType php,html inoremap <buffer> ,aa <a href="" alt=""></a><esc>F<i
	au FileType php,html inoremap <buffer> ,img <img src="" alt=""></img><esc>F<i
	au FileType php,html inoremap <buffer> ,uu <u></u><esc>F<i
	au FileType php,html inoremap <buffer> ,ii <i></i><esc>F<i
	au FileType php,html inoremap <buffer> ,bb <b></b><esc>F<i
	au FileType php,html inoremap <buffer> ,sk <strike></strike><esc>F<i
	au FileType php,html inoremap <buffer> ,sup <sup></sup><esc>F<i
	au FileType php,html inoremap <buffer> ,sub <sub></sub><esc>F<i
	au FileType php,html inoremap <buffer> ,sm <small></small><esc>F<i
	au FileType php,html inoremap <buffer> ,tt <tt></tt><esc>F<i
	au FileType php,html inoremap <buffer> ,pre <pre></pre><esc>F<i
	au FileType php,html inoremap <buffer> ,bq <blockquote></blockquote><esc>F<i
	au FileType php,html inoremap <buffer> ,st <strong></strong><esc>F<i
	au FileType php,html inoremap <buffer> ,em <em></em><esc>F<i
	au FileType php,html inoremap <buffer> ,ol <ol></ol><esc>F<i
	au FileType php,html inoremap <buffer> ,dd <dd></dd><esc>F<i
	au FileType php,html inoremap <buffer> ,dt <dt></dt><esc>F<i
	au FileType php,html inoremap <buffer> ,dl <dl></dl><esc>F<i
	au FileType php,html inoremap <buffer> ,ul <ul></ul><esc>F<i
	au FileType php,html inoremap <buffer> ,li <li></li><esc>F<i
	au FileType php,html inoremap <buffer> ,hr <hr></hr><esc>F<i
	au FileType php,html inoremap <buffer> ,di <div></div><esc>F<i
	au FileType php,html inoremap <buffer> ,sp <span></span><esc>F<i
	au FileType php,html inoremap <buffer> ,se <select></select><esc>F<i
	au FileType php,html inoremap <buffer> ,op <optionlect></optionlect><esc>F<i
	au FileType php,html inoremap <buffer> ,tx <textarealect></textarealect><esc>F<i

	au FileType php,html inoremap <buffer> ,fo <form action="" method=""><return><input type="text" name=""><return></form>
	au FileType php,html inoremap <buffer> ,fg <form action="" method="get"><return><input type="text" name=""><return></form>
	au FileType php,html inoremap <buffer> ,fp <form action="" method="post"><return><input type="text" name=""><return></form>
	au FileType php,html inoremap <buffer> ,in <input type="" name="" value=""></input><esc>F<i

	au FileType php,html inoremap <buffer> ,ec echo "";<esc>hi
	au FileType php,html inoremap <buffer> ,ge $_GET[""]<esc>hi
	au FileType php,html inoremap <buffer> ,po $_POST[""]<esc>hi
	au FileType php,html inoremap <buffer> ,lorem Lorem ipsum dolor sit amet,
				\ consectetuer adipiscing elit, sed diam nonummy nibh
				\ euismod tincidunt ut laoreet dolore magna aliquam erat
				\ volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci
				\ tation ullamcorper suscipit lobortis nisl ut aliquip ex ea
				\ commodo consequat. Duis autem vel eum iriure dolor in
				\ hendrerit in vulputate velit esse molestie consequat, vel
				\ illum dolore eu feugiat nulla facilisis at vero eros et
				\ accumsan et iusto odio dignissim qui blandit praesent
				\ luptatum zzril delenit augue duis dolore te feugait nulla
				\ facilisi.

	au FileType php,html nnoremap <leader>; i<c-o>m`<c-o>A;<esc>``<esc>
	au FileType php,html nnoremap <leader>, i<c-o>m`<c-o>A,<esc>``<esc>
augroup end

"""        LATEX
augroup LatexSmith
	au! LatexSmith
	" Navigating with guides
	au FileType plaintex,tex silent inoremap <buffer> ,, <esc>/<++><cr>"_4s
	au FileType plaintex,tex silent vnoremap <buffer> ,, <esc>/<++><cr>"_4s
	au FileType plaintex,tex silent map <buffer> ,, <esc>/<++><cr>"_4s

	au FileType plaintex,tex silent nnoremap <buffer> <leader>ll :LLPStartPreview

	" Latex snippets
	au FileType plaintex,tex inoremap <buffer> ,fr \begin{frame}<Enter>\frametitle{}<Enter><Enter><++><Enter><Enter>\end{frame}<Enter><Enter><++><esc>6kf}i
	au FileType plaintex,tex inoremap <buffer> ,fi \begin{fitch}<Enter><Enter>\end{fitch}<Enter><Enter><++><esc>3kA
	au FileType plaintex,tex inoremap <buffer> ,exe \begin{exe}<Enter>\ex<space><Enter>\end{exe}<Enter><Enter><++><esc>3kA
	au FileType plaintex,tex inoremap <buffer> ,em \emph{}<++><esc>T{i
	au FileType plaintex,tex inoremap <buffer> ,bf \textbf{}<++><esc>T{i
	au FileType plaintex,tex vnoremap <buffer> , <ESC>`<i\{<ESC>`>2la}<ESC>?\\{<Enter>a
	au FileType plaintex,tex inoremap <buffer> ,it \textit{}<++><esc>T{i
	au FileType plaintex,tex inoremap <buffer> ,ct \textcite{}<++><esc>T{i
	au FileType plaintex,tex inoremap <buffer> ,cp \parencite{}<++><esc>T{i
	au FileType plaintex,tex inoremap <buffer> ,glos {\gll<space><++><space>\\<Enter><++><space>\\<Enter>\trans{``<++>''}}<esc>2k2bcw
	au FileType plaintex,tex inoremap <buffer> ,x \begin{xlist}<Enter>\ex<space><Enter>\end{xlist}<esc>kA<space>
	au FileType plaintex,tex inoremap <buffer> ,ol \begin{enumerate}<Enter><Enter>\end{enumerate}<Enter><Enter><++><esc>3kA\item<space>
	au FileType plaintex,tex inoremap <buffer> ,ul \begin{itemize}<Enter><Enter>\end{itemize}<Enter><Enter><++><esc>3kA\item<space>
	au FileType plaintex,tex inoremap <buffer> ,li <Enter>\item<space>
	au FileType plaintex,tex inoremap <buffer> ,dc <Enter>\documentclass<space>
	au FileType plaintex,tex inoremap <buffer> ,doc <Enter>\documentation<space>
	au FileType plaintex,tex inoremap <buffer> ,ref \ref{}<space><++><esc>T{i
	au FileType plaintex,tex inoremap <buffer> ,tab \begin{tabular}<Enter><++><Enter>\end{tabular}<Enter><Enter><++><esc>4kA{}<esc>i
	au FileType plaintex,tex inoremap <buffer> ,ot \begin{tableau}<Enter>\inp{<++>}<tab>\const{<++>}<tab><++><Enter><++><Enter>\end{tableau}<Enter><Enter><++><esc>5kA{}<esc>i
	au FileType plaintex,tex inoremap <buffer> ,can \cand{}<tab><++><esc>T{i
	au FileType plaintex,tex inoremap <buffer> ,con \const{}<tab><++><esc>T{i
	au FileType plaintex,tex inoremap <buffer> ,v \vio{}<tab><++><esc>T{i
	au FileType plaintex,tex inoremap <buffer> ,a \href{}{<++>}<space><++><esc>2T{i
	au FileType plaintex,tex inoremap <buffer> ,sc \textsc{}<space><++><esc>T{i
	au FileType plaintex,tex inoremap <buffer> ,chap \chapter{}<Enter><Enter><++><esc>2kf}i
	au FileType plaintex,tex inoremap <buffer> ,sec \section{}<Enter><Enter><++><esc>2kf}i
	au FileType plaintex,tex inoremap <buffer> ,ssec \subsection{}<Enter><Enter><++><esc>2kf}i
	au FileType plaintex,tex inoremap <buffer> ,sssec \subsubsection{}<Enter><Enter><++><esc>2kf}i
	au FileType plaintex,tex inoremap <buffer> ,st <esc>F{i*<esc>f}i
	au FileType plaintex,tex inoremap <buffer> ,beg \begin{}<Enter><++><Enter>\end{}<Enter><Enter><++><esc>4k0f{a
	au FileType plaintex,tex inoremap <buffer> ,up <esc>/usepackage<Enter>o\usepackage{}<esc>i
	au FileType plaintex,tex nnoremap <buffer> ,up /usepackage<Enter>o\usepackage{}<esc>i
	au FileType plaintex,tex inoremap <buffer> ,tt \texttt{}<space><++><esc>T{i
	au FileType plaintex,tex inoremap <buffer> ,bt {\blindtext}
	au FileType plaintex,tex inoremap <buffer> ,nu $\varnothing$
	au FileType plaintex,tex inoremap <buffer> ,col \begin{columns}[T]<Enter>\begin{column}{.5\textwidth}<Enter><Enter>\end{column}<Enter>\begin{column}{.5\textwidth}<Enter><++><Enter>\end{column}<Enter>\end{columns}<esc>5kA
	au FileType plaintex,tex inoremap <buffer> ,rn (\ref{})<++><esc>F}i
augroup end

"""        Markdown
augroup MarkdownMaps
	au!
	au FileType markdown nnoremap <buffer> <leader>cr :Run<cr>
	au FileType markdown nnoremap <buffer> <leader>ca :AutoRun<cr>
	" au FileType markdown nnoremap <buffer> <leader>br A<br><esc>
augroup end

""    Auto Header
"""        Basic headers
augroup headers
	au!
	au BufNewFile *.sh 0r $HOME/.vim/skel/bash_header
	au BufNewFile *.html 0r $HOME/.vim/skel/html_header
augroup end

"""        Auto protect c header
if !exists("autocommands_loaded")
	let autocommands_loaded = 1
	au BufNewFile *.h call InsertCHHeader()
endif

function! InsertCHHeader()
	let path_to_skeletons = "$HOME/dotfiles/vim/skel/ch_header"
	" Save cpoptions
	let cpoptions = &cpoptions
	" Remove the 'a' option - prevents the name of the
	" alternate file being overwritten with a :read command
	exe "set cpoptions=" . substitute(cpoptions, "a", "", "g")
	exe "read " . path_to_skeletons
	" Restore cpoptions
	exe "set cpoptions=" . cpoptions
	1, 1 delete _

	let fname = expand("%:t")
	let fname = toupper(fname)
	let fname = substitute(fname, "\\.", "_", "g")
	%s/HEADERNAME/\=fname/g
endfunction

""    Dotfiles settings
"""        Filetype
augroup dotfiles_sh
	au!
	au BufEnter bash_aliases,bashrc,inputrc,.bash_aliases,.bashrc,.inputrc setfiletype sh
augroup end

augroup suffixes
    au!
    let associations = [
                \["javascript", ".js,.javascript,.es,.esx,.json"],
                \["python", ".py,.pyw"],
                \["c", ".c,.h"],
                \["cpp", ".c,.h"]
                \]
    for ft in associations
        execute "au FileType " . ft[0] . " setlocal suffixesadd=" . ft[1]
    endfor
augroup end

"""        Vimrc mappings
augroup VimrcMaps
	au! VimrcMaps
	au FileType vim silent nnoremap <buffer> zm mpzM100<c-y>`pzC
	" au FileType vim nnoremap <silent> <buffer> zm mpzM100<c-y>k`pzC
	au FileType vim inoremap <buffer> ,""<space> ""<space><space><space><space>
	au FileType vim inoremap <buffer> ,"""<space> """<space><space><space><space><space><space><space><space>
	au FileType vim inoremap <buffer> ,''<space> ""<space><space><space><space>
	au FileType vim inoremap <buffer> ,'''<space> """<space><space><space><space><space><space><space><space>
augroup end
"""        Vimrc folding
function! VimFold()
	let line = getline(v:foldstart)

	let nucolwidth = &fdc + &number * &numberwidth
	let windowwidth = winwidth(0) - nucolwidth - 4
	if windowwidth > 79
		let windowwidth = 79
	endif
	let foldedlinecount = v:foldend - v:foldstart
	" expand tabs into spaces
	let onetab = strpart('          ', 0, &tabstop)
	let line = substitute(line, '\t', onetab, 'g')
	let longbreak=" "
	let line = strpart(line, 0, windowwidth - 2 - len(foldedlinecount))
	if len(line) > windowwidth - 15
		let line=line[0:windowwidth - 15]
		let longbreak="¬"
	endif
	let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
	return line . longbreak . repeat(" ", fillcharcount%2 + len(foldedlinecount) - 1) . '' . repeat(" .",fillcharcount/2 - 3) . repeat(" ", 5 - len(foldedlinecount)) . foldedlinecount . '    '
endfunction
set modelineexpr

"""        Vimrc modeline
" vim:tw=0
" vim:foldmethod=expr:foldtext=VimFold()
" vim:fde=getline(v\:lnum)=~'^""'?'>'.(matchend(getline(v\:lnum),'""*')-1)\:'='
