" Identify platform {
        silent function! OSX()
            return has('macunix')
        endfunction
        silent function! LINUX()
            return has('unix') && !has('macunix') && !has('win32unix')
        endfunction
        silent function! WINDOWS()
            return (has('win16') || has('win32') || has('win64'))
        endfunction
" }

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/ctrlp.vim
set rtp+=~/.vim/bundle/Vundle.vim
"call vundle#begin()
call plug#begin('~/.vim/plugged')
Plug 'chdupre/nerdtree'
Plug 'kien/ctrlp.vim'
Plug 'vim-airline/vim-airline'
"Plug 'altercation/vim-colors-solarized'
"Plug 'tpope/vim-fugitive'
Plug 'derekwyatt/vim-scala'
Plug 'derekwyatt/vim-fswitch'
Plug 'ensime/ensime-vim'
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
"Plug 'ryanolsonx/vim-lsp-python'
"Plug 'davidhalter/jedi-vim'
"Plug 'python-mode/python-mode'
Plug 'ervandew/supertab'
"Plug 'tfnico/vim-gradle'
Plug 'scrooloose/syntastic'
Plug 'Raimondi/delimitMate'
Plug 'xolox/vim-notes'
Plug 'xolox/vim-misc'
Plug 'vimwiki/vimwiki'
Plug 'mattn/calendar-vim'
Plug 'elzr/vim-json'
Plug 'tpope/vim-surround'
Plug 'mileszs/ack.vim'
"call vundle#end()
call plug#end()

" if executable('pyls')
"     au User lsp_setup call lsp#register_server({
"         \ 'name': 'pyls',
"         \ 'cmd': {server_info->['pyls']},
"         \ 'whitelist': ['python'],
"         \ })
" endif


if WINDOWS()
    set diffexpr=WindowdDiff()
endif

if has("gui_running")
    if WINDOWS()
        set guifont=Source_Code_Pro:h12:cANSI
    else
        set guifont=Source\ Code\ Pro\ 12
    endif
endif
"colorscheme solarized
set t_Co=256
set background=dark

" Execute file being edited with <Shift> + e:
if WINDOWS()
map <buffer> <S-e> :w<CR>:!c:\Python27\python.exe % <CR>
else
    map <buffer> <S-e> :w<CR>:!/usr/bin/env python % <CR>
endif

"set textwidth=79  " lines longer than 79 columns will be broken
set shiftwidth=4  " operation >> indents 4 columns; << unindents 4 columns
set tabstop=4     " an hard TAB displays as 4 columns
set expandtab     " insert spaces when hitting TABs
set softtabstop=4 " insert/delete 4 spaces when hitting a TAB/BACKSPACE
set shiftround    " round indent to multiple of 'shiftwidth'
set autoindent    " align the new line indent with the previous line

set backspace=2   " make backspace work like most other apps

nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

syntax on
filetype plugin indent on
set nobackup
set noswapfile
set hlsearch

" Automatically read a file that has changed on disk
set autoread

" Nerd Tree
 map <F2> :NERDTreeToggle<CR>
 map <F3> :NERDTreeFocus<CR>
 nnoremap <silent><expr> <F4> (winnr()==g:NERDTree.GetWinNum() ? ":NERDTreeClose\<CR>" : ":NERDTreeFocus\<CR>")

"When more than one match, list all matches and
"complete till longest common string.
set wildmode=longest,list


set splitbelow
set splitright

let delimitMate_expand_cr = 1

let g:scala_use_default_keymappings = 0

" System default for mappings is now the "," character
let mapleader=","
au FileType scala let b:fswitchdst = 'scala'
au FileType scala nnoremap <localleader>df :EnDeclaration<CR><Paste>
au FileType scala nnoremap <buffer> <silent> K  :EnDocBrowse<CR>
au FileType scala nnoremap <buffer> <silent> gd :EnDeclaration<CR>

au FileType scala nnoremap <buffer> <silent> <C-]>  :EnDeclaration<CR>
au FileType scala nnoremap <buffer> <silent> <C-w>] :EnDeclarationSplit<CR>
au FileType scala nnoremap <buffer> <silent> <C-w><C-]> :EnDeclarationSplit<CR>
au FileType scala nnoremap <buffer> <silent> <C-v>] :EnDeclarationSplit v<CR>

au FileType scala nnoremap <buffer> <silent> <LocalLeader>i :EnInspectType<CR>
au FileType scala nnoremap <buffer> <silent> <LocalLeader>I :EnSuggestImport<CR>
au FileType scala nnoremap <buffer> <silent> <LocalLeader>r :EnRename<CR>

nnoremap <Leader>f :NERDTreeFind<CR>

" Matches scala files that do not end with Test.scala
au BufEnter *\(Test\)\@!.scala let b:fswitchlocs = 'reg:+/app/+/test/+' | let b:fswitchfnames='/$/Test/'
" Use the one below if you're dealing with a Scala app with src/main/scala and
" src/test/scala intead of app and test directories (like Play)
" au BufEnter *\(Test\)\@!.scala let b:fswitchlocs = 'reg:+/src/main/scala+/src/test/scala/+' | let b:fswitchfnames='/$/Test/'

" Matches scala files that do end with Test.scala
au BufEnter *Test.scala let b:fswitchlocs = 'reg:+/test/+/app/+' | let b:fswitchfnames='/Test$//'
" au BufEnter *Test.scala let b:fswitchlocs = 'reg:+/src/test/scala+/src/main/scala/+' | let b:fswitchfnames='/Test$//'

let b:fswitchlocs = 'reg:/app/test/'

let g:jedi#use_tabs_not_buffers = 0 " new buffer when jumping around

"let g:pymode_folding = 0    "disable folding by default
"let g:pymode_lint = 1       "Turn on code checking
"let g:pymode_lint_write = 1
"let g:pymode_rope = 0
"let g:pymode_doc = 0
"let g:pymode_run = 0
"let g:pymode_run = 1    "allow to run script
"let g:pymode_breakpoint = 1
"let g:mymode_python = 'python3'
"let g:pymode_rope_rename_bind = '<C-c>rr'
let g:deoplete#enable_at_startup = 1

let g:SuperTabDefaultCompletionType = 'context'
:set guioptions-=L "left hand side scrollbar is disabled

"let g:syntastic_java_javac_classpath = "./lib/*.jar\n./src"
let g:syntastic_check_on_wq = 0     " Don't check syntax when quitting.
"let g:syntastic_mode_map = { 'passive_filetypes': ['scala', 'scss'] }

set laststatus=2 "Airline's status line appears at startup, even is there is no split
let g:airline#extensions#hunks#enabled = 1

let g:notes_directories = ['~/Dropbox/Notes']"

let g:vimwiki_list = [{'path': '~/Dropbox/Wiki/'}]

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

let ensime_server_v2=1

augroup vimrc_autocmds
    autocmd!
    if WINDOWS()
        autocmd FileType python set colorcolumn=80
        autocmd FileType python highlight ColorColumn ctermbg=lightgrey guibg=darkgrey
    else
        autocmd FileType python set colorcolumn=80
        autocmd FileType python highlight ColorColumn ctermbg=lightgrey guibg=lightgrey
    endif
augroup END

if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

function! WindowdDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

function! s:VSetSearch()
  let temp = @@
  norm! gvy
  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  let @@ = temp
endfunction

vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR>

nmap <silent> ,of :FSHere<CR>
command! Difft windo diffthis
command! Diffo windo diffoff
    
" "ino " ""<left>
" "ino ' ''<left>
" "ino ( ()<left>
" "ino [ []<left>
" "ino { {}<left>
" "ino {<CR> {<CR>}<ESC>O    
    
