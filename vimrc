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
call vundle#begin()
Bundle 'scrooloose/nerdtree'
Bundle 'davidhalter/jedi-vim'
Bundle 'bling/vim-airline'
Bundle 'altercation/vim-colors-solarized'
Bundle 'klen/python-mode'
Bundle 'kien/ctrlp.vim'
Bundle 'ervandew/supertab'
Bundle 'derekwyatt/vim-scala'
Bundle 'tfnico/vim-gradle'
Bundle 'scrooloose/syntastic'
Bundle 'Raimondi/delimitMate'
call vundle#end() 

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
colorscheme solarized
"let g:solarized_termcolors=256
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


syntax on
filetype plugin indent on
set nobackup
set noswapfile
set hlsearch

" Nerd Tree
 map <F2> :NERDTreeToggle<CR>

"When more than one match, list all matches and
"complete till longest common string.
set wildmode=longest,list


set splitbelow
set splitright

let g:jedi#use_tabs_not_buffers = 0 " new buffer when jumping around

let g:pymode_folding = 0    "disable folding by default
let g:pymode_lint = 1       "Turn on code checking
let g:pymode_lint_write = 1
let g:pymode_rope = 0 
let g:pymode_doc = 0
let g:pymode_run = 0
let g:pymode_breakpoint = 1

let g:SuperTabDefaultCompletionType = 'context'
:set guioptions-=L "left hand side scrollbar is disabled

"let g:syntastic_java_javac_classpath = "./lib/*.jar\n./src"
let g:syntastic_check_on_wq = 0     " Don't check syntax when quitting.

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
