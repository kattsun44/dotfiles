set shell=/bin/zsh
set shiftwidth=2
set tabstop=2
set expandtab "タブキーでスペース入力
set textwidth=0
set autoindent ":set paste で解除可能な自動インデント
set hlsearch
set clipboard=unnamed
set number
syntax on

"vim-plug https://github.com/junegunn/vim-plug
call plug#begin()
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'sheerun/vim-polyglot'
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
call plug#end()

" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

"ノーマルモードのまま空行を挿入
nnoremap O O<Esc>

