" General settings
syntax enable
set nocompatible
set modelines=0
set relativenumber
set number
set mouse=nicr
set autoindent
set smartindent
set undofile
set backspace=indent,eol,start
set cursorline
set ttyfast
set visualbell
set encoding=utf-8
set scrolloff=3
set wildmenu
set lazyredraw
set showmatch
set colorcolumn=87
"set clipboard=unnamed
inoremap jk <ESC>

" Modify search options
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <silent> <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %
vnoremap // y/\V<C-R>"<CR> " search for visually selected text

" Split settings
" More natural split positions
set splitbelow
set splitright
" Quicker navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Wrapping
"set wrap
"set textwidth=79
"set formatoptions=qrn1

" Save time by remapping ; to :
nnoremap ; :

" Autosave files when tabbing away from vim
au FocusLost * :wa

" tab settings
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
set softtabstop=4
" when indenting with '>' use 4 spaces width
set shiftwidth=4
" on pressing tab, insert four spaces
set expandtab

" Disable autocommenting
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Strip all trailing whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" Scrolling
noremap <ScrollWheelUp> <C-Y>
noremap <ScrollWheelDown> <C-E>

" Put in equals signs before/after line of text
nnoremap <silent> <leader>1 yypVr=
nnoremap <silent> <leader>2 yykpVr=
nnoremap <silent> <leader>3 yypVr=kyykpVr=

" pbcopy/pbpaste
" Set F1 to paste
noremap <F1> :set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
inoremap <F1> <Esc>:set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
" Set F2 to copy
nnoremap <F2> :.w !pbcopy<CR><CR>
vnoremap <F2> :w !pbcopy<CR><CR>

" Copy to system clipboard
vnoremap <silent> <leader>y "+y
vnoremap <silent> <leader>p "+p

" Toggle paste on and off
set pastetoggle=<F3>

" Disable arrow keys to force use of hjkl
"imap  <Up>     <NOP>
"imap  <Down>   <NOP>
"imap  <Left>   <NOP>
"imap  <Right>  <NOP>
"nmap   <Up>     <NOP>
"nmap   <Down>   <NOP>
"" Remap left and right to browse buffers
nnoremap   <silent> <Left>   :bprevious<CR>
nnoremap   <silent> <Right>  :bnext<CR>

" Move vertically by visual line
nnoremap j gj
nnoremap k gk

" Function to remap arrow keys
" This doesn't work right now!
"function! RemapArrows()
    "iunmap  <Up>
    "iunmap  <Down>
    "iunmap  <Left>
    "iunmap  <Right>
    "nunmap   <Up>
    "nunmap   <Down>
    "nunmap   <Left>
    "nunmap   <Right>
"endfunc
"" Quickly call with Ctrl-a
"nnoremap <C-a> :call RemapArrows()<CR>

" Folding
set foldenable
set foldlevelstart=10 " Should be able to see everything intially
set foldnestmax=10 " Limit no. of nested folds
nnoremap <space> za
set foldmethod=syntax

"Colourscheme
set background=dark
colorscheme solarized
"colorscheme molokai
"colorscheme Tomorrow-night

" Plugins
" Add restore_view plugin
set runtimepath^=~/.vim/bundle/restore_view.vim

" VimPlug
call plug#begin()
" Commenting shortcut: \cc to comment
Plug 'scrooloose/nerdcommenter'
" NerdTree filesystem explorer
Plug 'scrooloose/nerdtree'
" Surroundings/parentheses: e.g. cs(' to change ( to '
Plug 'tpope/vim-surround'
" Solarize colorscheme
Plug 'altercation/vim-colors-solarized'
" Airline
Plug 'vim-airline/vim-airline'
" Airline themes
Plug 'vim-airline/vim-airline-themes'
" YCM generator
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
" Syntastic
Plug 'vim-syntastic/syntastic'
" Fugitive
Plug 'tpope/vim-fugitive'
" Fix FocusGained and FocusLost in tmux
Plug 'tmux-plugins/vim-tmux-focus-events'
call plug#end()

"Vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
" YouCompleteMe autocompleter
Plugin 'Valloric/YouCompleteMe'
" Plugin for .tmux.conf
Plugin 'tmux-plugins/vim-tmux'
call vundle#end()
filetype plugin indent on

" Airline settings
set laststatus=2
let g:airline_powerline_fonts=1
let g:airline_theme = 'solarized'
set t_Co=256
let g:airline#extensions#tabline#enabled =1

" YouCompleteMe
let g:ycm_global_ycm_extra_conf = "~/.vim/bundle/.ycm_extra_conf.py"
let g:ycm_confirm_extra_conf = 0
nnoremap <silent> <leader>f<CR> :YcmCompleter FixIt <C-J> <C-W><C-J> :q <CR>
nnoremap  <leader>g<CR> :YcmGenerateConfig

"" Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_cpp_check_header = 1
let g:syntastic_c_include_dirs = ['../../include','../include','../inc']
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_loc_list_height=5
nnoremap <silent> <leader>r :SyntasticReset<CR>
"let g:syntastic_python_flake8_args = '--ignore="E501,E302,E261,E701,E241,E126,E127,E128,W801"'
"nnoremap <leader>c :SyntasticCheck

"" Powerline
"set rtp+=/Users/hannahpullen/Library/Python/2.7/lib/python/site-packages/powerline/bindings/vim
"let g:airline_powerline_fonts = 1
"let g:Powerline_symbols='unicode'
"set laststatus=2
"set t_Co=256

"Number toggle function
"function! NumberToggle()
    "if(&relativenumber == 1)
        "set number
    "else
        "set relativenumber
    "endif
"endfunc
"nnoremap <C-t> :call NumberToggle()<cr>


" Add to Vundle list if you want these
"""Plugin 'vim-syntastic/syntastic'
"""Plugin 'bling/vim-airline'
"""Bundle 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
