set tabstop=2
set shiftwidth=2
set expandtab
set autoindent
set smartindent

set number
set cursorline
set laststatus=2
set cmdheight=2
set showmatch

"set wildmenu
"set lazyredraw "Incompatible with airline-vim

set hlsearch
set smartcase
set incsearch
set wrapscan
set gdefault

set backspace=indent,eol,start
set whichwrap=b,s,h,l,<,>,[,]

set clipboard=unnamed,unnamedplus
set mouse=a

set wildmenu wildmode=list:longest,full
set history=10000

set visualbell t_vb=

syntax on
set encoding=utf8
set fileencoding=utf-8
set scrolloff=5
set nostartofline
set matchpairs& matchpairs+=<:>
set wrap
set shiftround
set infercase
set virtualedit=all
set showcmd

set foldenable
set foldlevelstart=10
set foldnestmax=15
set foldmethod=indent

cmap w!! w !sudo tee > /dev/null %
inoremap jj <Esc>
nmap <silent> <Esc><Esc> :nohlsearch<CR>
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz
nnoremap j gj
nnoremap k gk
" Move to begining/end of line
nnoremap B ^
nnoremap E $
" highlight last inserted text
nnoremap gV `[v`]
vnoremap v $h
nnoremap &lt;Tab&gt; %
vnoremap &lt;Tab&gt; %

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap [toggle] <Nop>
nmap T [toggle]
nnoremap <silent> [toggle]s :setl spell!<CR>:setl spell?<CR>
nnoremap <silent> [toggle]l :setl list!<CR>:setl list?<CR>
nnoremap <silent> [toggle]t :setl expandtab!<CR>:setl expandtab?<CR>
nnoremap <silent> [toggle]w :setl wrap!<CR>:setl wrap?<CR>

" save session
nnoremap <leader>s :mksession<CR>
" Open previous session with vim -S

" Operate command on entire file
onoremap af :<C-u>normal! ggVG<CR>

set runtimepath^=~/.vim/bundle/jellybeans.vim
set runtimepath^=~/.vim/bundle/vim-vividchalk
set runtimepath^=~/.vim/bundle/vim-colors-solarized
set runtimepath^=~/.vim/bundle/base16-vim
set runtimepath^=~/.vim/bundle/tomorrow-theme
set runtimepath^=~/.vim/bundle/vim-hybrid
set runtimepath^=~/.vim/bundle/gruvbox

colorscheme jellybeans
" Enable background image with custom colorscheme
hi Normal ctermbg=none

set runtimepath^=~/.vim/bundle/YouCompleteMe
set runtimepath^=~/.vim/bundle/tern_for_vim
set runtimepath^=~/.vim/bundle/vimproc.vim
set runtimepath^=~/.vim/bundle/vim-rails
set runtimepath^=~/.vim/bundle/the_silver_searcher
set runtimepath^=~/.vim/bundle/ag.vim
set runtimepath^=~/.vim/bundle/typescript-vim
set runtimepath^=~/.vim/bundle/tsuquyomi
set runtimepath^=~/.vim/bundle/syntastic
set runtimepath^=~/.vim/bundle/ctrlp.vim
set runtimepath^=~/.vim/bundle/nerdtree
set runtimepath^=~/.vim/bundle/vim-airline
set runtimepath^=~/.vim/bundle/vim-airline-themes
set runtimepath^=~/.vim/bundle/vim-jdaddy
set runtimepath^=~/.vim/bundle/vim-fugitive
set runtimepath^=~/.vim/bundle/vim-gitgutter
set runtimepath^=~/.vim/bundle/asyncrun.vim
set runtimepath^=~/.vim/bundle/vim-clang-format

" OPTIONALS
set runtimepath^=~/.vim/bundle/unite.vim
set runtimepath^=~/.vim/bundle/neocomplete.vim
set runtimepath^=~/.vim/bundle/neosnippet
set runtimepath^=~/.vim/bundle/neosnippet-snippets

" Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 0
let g:tsuquyomi_disable_quickfix = 1
let g:syntastic_typescript_checkers = ['tsuquyomi']
" https://github.com/scrooloose/syntastic/blob/master/doc/syntastic-checkers.txt for full list
" needs https://github.com/feross/standard.git
let g:syntastic_javascript_checkers = ['standard']
autocmd bufwritepost *.js silent !standard-format -w %
set autoread

" YCM settings
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'

" open ag.vim
nnoremap <leader>a :Ag

" CtrlP settings
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
" let g:ctrlp_custom_ignore = { 'dir':  '\v[\/]\.(git|hg|svn)$', 'file': '\v\.(exe|so|dll)$' }


" NerdTree settings
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif  " auto-close on last window
let g:NERDTreeQuitOnOpen = 1

" NeoComplete settings
let g:neocomplete#enable_at_startup = 1

" Airline settings
" displays all buffers when one window is open
let g:airline_theme='jellybeans'
let g:airline#extensions#tabline#enabled = 1
let g:airline_enable_branch     = 0
"let g:airline_enable_syntastic  = 1
let g:airline_powerline_fonts   = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

" Git Gutter settings
nmap ]h <Plug>GitGutterNextHunk
nmap [h <Plug>GitGutterPrevHunk

" Clang-format settings
let g:clang_format#style_options = { 'AllowShortIfStatementsOnASingleLine' : 'true' }
let g:clang_format#filetype_style_options = { 'cpp' : {'Standard' : 'C++11'} }
map <C-I> :ClangFormat <CR>
imap <C-I> <ESC> :ClangFormat <CR>i
vnoremap <buffer><C-I> :ClangFormat <CR>
autocmd bufwritepost *.cpp,*.h silent :ClangFormat

" auto create when file does not exist (:e)
function! s:mkdir(dir, force)
  if !isdirectory(a:dir) && (a:force || input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
    call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
  endif
endfunction

" set default current directoty
function! s:ChangeCurrentDir(directory, bang)
  if a:directory == ''
    lcd %:p:h
  else
    execute 'lcd' . a:directory
  endif
  if a:bang == ''
    pwd
  endif
endfunction

" read setting from ~/.vimrc.local if exists
let s:local_vimrc = expand('~/.vimrc.local')
if filereadable(s:local_vimrc)
  execute 'source ' . s:local_vimrc
endif

cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'
if has('unnamedplus')
  set clipboard& clipboard+=unnamedplus
else
  set clipboard& clipboard+=unnamed,autoselect
endif

nnoremap <silent> j gj
nnoremap <silent> k gk

inoremap <c-d> <delete>
inoremap <c-j> <down>
inoremap <c-k> <up>
inoremap <c-h> <left>
inoremap <c-l> <right>

augroup configgroup
  autocmd!
  autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript
  autocmd BufNewFile,BufRead *.tsx setlocal filetype=typescript
  autocmd BufNewFile,BufRead *.jj setlocal filetype=jcc
  autocmd VimEnter * highlight clear SignColumn
  autocmd BufWritePre *.php,*.py,*.js,*.ts,*.tsx,*.txt,*.hs,*.java,*.md,*.c,*.cpp,*.h,*.rb :%s/\s\+$//e
  autocmd BufWritePre *.jj :%s/\s\+$//e
  autocmd FileType java let g:syntastic_always_populate_loc_list = 0
  autocmd FileType java let g:syntastic_check_on_open = 0
  autocmd FileType java let g:syntastic_auto_loc_list = 2
  autocmd FileType php setlocal expandtab
  autocmd FileType php setlocal list
  autocmd FileType php setlocal listchars=tab:+\ ,eol:-
  autocmd FileType php setlocal formatprg=par\ -w80\ -T4
  autocmd FileType jcc setlocal tabstop=4
  autocmd FileType jcc setlocal shiftwidth=4
  autocmd FileType jcc setlocal softtabstop=4
  autocmd FileType jcc setlocal expandtab
  autocmd FileType java setlocal tabstop=4
  autocmd FileType java setlocal shiftwidth=4
  autocmd FileType java setlocal softtabstop=4
  autocmd FileType java setlocal expandtab
  autocmd FileType ruby setlocal tabstop=2
  autocmd FileType ruby setlocal shiftwidth=2
  autocmd FileType ruby setlocal softtabstop=2
  autocmd FileType ruby setlocal commentstring=#\ %s
  autocmd FileType ruby setlocal makeprg=ruby\ -c\ %
  autocmd FileType ruby setlocal errorformat=%m\ in\ %f\ on\ line\ %l
  autocmd FileType python setlocal commentstring=#\ %s
  autocmd BufEnter *.cls setlocal filetype=java
  autocmd BufEnter *.zsh-theme setlocal filetype=zsh
  autocmd BufEnter Makefile setlocal noexpandtab
  autocmd FileType cs setlocal expandtab
  autocmd FileType cs setlocal tabstop=4
  autocmd FileType cs setlocal shiftwidth=4
  autocmd FileType cs setlocal softtabstop=4
  autocmd BufEnter *.sh setlocal tabstop=2
  autocmd BufEnter *.sh setlocal shiftwidth=2
  autocmd BufEnter *.sh setlocal softtabstop=2
  autocmd FileType typescript setlocal shiftwidth=2
augroup END

set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

filetype plugin indent on
