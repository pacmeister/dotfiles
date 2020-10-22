set runtimepath=~/.config/vim
set packpath=~/.config/vim
set viminfo=
execute pathogen#infect()
syntax on
filetype plugin indent on
autocmd BufWritePre * %s/\s\+$//e
set t_Co=256
set background=dark
colors zenburn
highlight Visual cterm=reverse ctermbg=NONE
let r_indent_align_args = 0
set autoindent
set cindent
set cinoptions=t0
set clipboard=unnamedplus
set expandtab
set mouse=a
"set noshowmode
set nu
set shiftwidth=4
