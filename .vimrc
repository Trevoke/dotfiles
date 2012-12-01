"Confused? Remember that you can use :help <something>

call pathogen#infect() " Remember to call :Helptags to generate the vimhelpfiles
syntax on
filetype plugin indent on

set t_Co=256
colorscheme jellybeans

" Define "," as the "Leader" character (:help leader)
let mapleader = ","
let g:mapleader = ","

" Ruby <3 : tab = 2 spaces
set expandtab
set tabstop=2 shiftwidth=2 softtabstop=2
set autoindent

"I like line numbers, relative to the cursor.
:set rnu
" Insert mode: absolute line numbers
au InsertEnter * :set nu
" Other modes: relative line numbers
au InsertLeave * :set rnu

set ruler " Where the cursor is, in the linebuffer
set scrolloff=3  " Always show 3 lines around cursor

set hls " Highlight searches
set incsearch " Highlight search as you type
set ignorecase " Searches ignore case
set smartcase " Searching for 'a/Bc'  matches 'aBc' not 'abc'

" Fast saving with Leader "w"
map <leader>w :w!<CR>

" use Leader "space" to clear out the search results highlighting
nnoremap <leader><space> :noh<CR>

" Please don't try to help me. The Esc key just gets smaller and smaller...
" And sometimes I am not using Ctrl-[ to go back to Normal mode.
noremap <F1> <Esc>

" vim-statline (:help statline)
let g:statline_fugitive = 1

" taglist
let Tlist_Ctags_Cmd = "/usr/local/bin/ctags" "ctags command
let Tlist_WinWidth = 50 "width of ctags window
"toggle ctags window with "F4"
map <F4> :TlistToggle<CR> 
"build ctags with "F8"
map <F8> :!/usr/local/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" "zz" now puts the line 10% above the middle of the screen instead of dead
" center
if has('float')
  nnoremap <silent> zz :exec "normal! zz" . float2nr(winheight(0)*0.1) . "\<Lt>C-E>"<CR>
endif

" show git diff in window split when committing
autocmd FileType gitcommit DiffGitCached | wincmd
