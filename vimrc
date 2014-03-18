set expandtab
set tabstop=8
set softtabstop=4
set shiftwidth=4
set autoindent
:syntax on
filetype plugin on
set backspace=2
set hlsearch

" Execute file being edited with <Shift> + e:
map <buffer> <S-e> :w<CR>:!/usr/bin/env python % <CR>

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Bundle 'scrooloose/nerdtree'
Bundle 'Valloric/YouCompleteMe'
" Powerline setup
" set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
set laststatus=2

" Nerd Tree
map <F2> :NERDTreeToggle<CR>

" Pathogen load
filetype off
call pathogen#infect()
call pathogen#helptags()
filetype plugin indent on
syntax on

autocmd filetype python set colorcolumn=80
autocmd filetype python hi ColorColumn ctermbg=lightgrey guibg=lightgrey


"python mode
" Disable pylint checking every save
"let g:pymode_lint_write = 0
" Set key 'R' for run python code
"let g:pymode_run_key = 'R'
" Load the whole plugin
"let g:pymode = 1
" Load show documentation plugin
"let g:pymode_doc = 1
" Key for show python documentation
"let g:pymode_doc_key = 'K'

:augroup gzip
    :  autocmd!
    :  autocmd BufReadPre,FileReadPre   *.gz set bin
    :  autocmd BufReadPost,FileReadPost   *.gz '[,']!gunzip
    :  autocmd BufReadPost,FileReadPost *.gz set nobin
    :  autocmd BufReadPost,FileReadPost   *.gz execute ":doautocmd BufReadPost " . expand("%:r")
    :  autocmd BufWritePost,FileWritePost   *.gz !mv <afile> <afile>:r
    :  autocmd BufWritePost,FileWritePost *.gz !gzip <afile>:r

    :  autocmd FileAppendPre        *.gz !gunzip <afile>
    :  autocmd FileAppendPre      *.gz !mv <afile>:r <afile>
    :  autocmd FileAppendPost       *.gz !mv <afile> <afile>:r
    :  autocmd FileAppendPost     *.gz !gzip <afile>:r
:augroup END

