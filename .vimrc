set nocompatible
filetype off

set shell=/bin/bash
set hidden          " opening new file hides current instead of closing
set nowrap          " switch off line wrapping
set tabstop=4       " Set tabs to 4 characaters wide
set shiftwidth=4    " Set indentation width to match tab
set expandtab       " Use spaces instead of actual hard tabs
set softtabstop=4   " Set the soft tab to match the hard tab width
set backspace=indent,eol,start  " Make bs work across line breaks etc
set autoindent      " Enable basic auto indentation
set copyindent      " Preserve manual indentation
set number
set shiftround
set showmatch
set ignorecase
set smartcase
set smarttab
set hlsearch
set incsearch
set history=1000
set undolevels=1000
set title
set ruler
set novisualbell
set noerrorbells
set laststatus=2
set cursorline
set encoding=utf-8


" netrw file browser settings
let g:netrw_banner=0		" Hide the directory banner
let g:netrw_liststyle=3		" 0=thin; 1=long; 2=wide; 3=tree

filetype plugin indent on
syntax on
colorscheme default
highlight CursorLine cterm=NONE ctermbg=8 ctermfg=white

" Map Ctrl+[hjkl] to navigate windows vim style
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-j> <C-w>j
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-l> <C-w>l
" Map Ctrl+[arrow] to navigate windows`
nnoremap <silent> <C-Left> <C-w>h
nnoremap <silent> <C-Down> <C-w>j
nnoremap <silent> <C-Up> <C-w>k
nnoremap <silent> <C-Right> <C-w>l
" Increase/descrease window split size
if bufwinnr(1)
	map + <C-W>+
	map - <C-W>-
endif

" Pageup/down will scroll half-page and center the current line on the screen
" nnoremap <silent> <PageUp> <C-U>zz
" vnoremap <silent> <PageUp> <C-U>zz
" inoremap <silent> <PageUp> <C-O><C-U><C-O>zz
" nnoremap <silent> <PageDown> <C-D>zz
" vnoremap <silent> <PageDown> <C-D>zz
" inoremap <silent> <PageDown> <C-O><C-D><C-O>zz
" F1 netrw file browser
" nnoremap <silent> <F1> :Explore<CR>

" F2 to toggle paste mode
nnoremap <silent> <F2> :set paste!<CR>
" F3 to remove all trailing whitespace
nnoremap <silent> <F3> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

let mapleader=" "
inoremap jk <Esc>
nnoremap <CR> :noh<CR><CR>
" Open netrw filebrowser in current window, with current file selected
nmap <leader>e :e .<CR>
" Rotate windows
nmap <leader>r <C-w>r
" Quick save the current file
nmap <leader>w :w<CR>
" Insert empty line below
nmap <silent> <leader><CR> o<ESC>
" Clear search highlights
nmap <silent> <leader><space> :noh<CR>
" Close buffer without affecting splits
nmap <leader>d :bprevious<CR>:bdelete #<CR>
" Easy buffer navigation
nmap <leader>n :bn<CR>
nmap <leader>p :bp<CR>
nmap <leader>b :buffer <Tab>
" Load vimrc
nmap <leader>v :e ~/.vimrc<CR>
" Toggle/cycle line number modes
nmap <leader>l :call CycleLineNumbers()<CR>
function! CycleLineNumbers()
  if (&number == 1 && &relativenumber == 0)
    set relativenumber
  else
    if (&relativenumber == 1 && &number == 1)
        set norelativenumber
        set nonumber
    else
        set number
        set norelativenumber
    endif
  endif
endfunc

















