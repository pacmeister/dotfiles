autocmd BufWritePre * %s/\s\+$//e
execute pathogen#infect()
filetype plugin indent on
colorscheme zenburn
let g:lightline = { 'colorscheme' : 'seoul256' }
let r_indent_align_args = 0
set autoindent
set background=dark
set cindent
set cinoptions=t0
set clipboard=unnamedplus
set expandtab
set mouse=a
set noshowmode
set nu
set shiftwidth=4
syntax enable
