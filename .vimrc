
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Vim plugins inclusion
call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'zah/nim.vim'
Plug 'preservim/nerdtree'
call plug#end()

set number
set autoindent
set smartindent
set tabstop=4
set expandtab
set shiftwidth=4
syntax on
colorscheme desert
set showcmd
let g:airline#extensions#ale#enabled = 1

autocmd BufWritePre,BufRead *.pro set filetype=prolog
autocmd BufWritePre,BufRead *.service set filetype=systemd
autocmd BufWritePre,BufRead *sudoers* set filetype=sudoers
autocmd Filetype tex set tabstop=3 shiftwidth=3
" Start NERDTree and put cursor in main window
" autocmd VimEnter * NERDTree | wincmd p

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

packloadall
silent! helptags ALL
