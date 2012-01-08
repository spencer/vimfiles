filetype off

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

syntax on
filetype plugin indent on
set tabstop=2
set smarttab
set title
set scrolloff=3
set shiftwidth=2
set autoindent
set expandtab
set number
set ruler
set hidden
set history=1000
set wildmode=list:longest
set ignorecase 
set smartcase
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set shortmess=atI
set visualbell

set nrformats=octal,hex,alpha

set grepprg=ack
set grepformat=%f:%l:%m

set undodir=~/.vim/undodir
set undofile
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload

" Intuitive backspacing in insert mode
set backspace=indent,eol,start

" Set OSX Clipboad
set clipboard=unnamed

"
" Highlight search terms...
set hlsearch
set incsearch " ...dynamically as they are typed.

nnoremap ' `
nnoremap ` '
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

let mapleader = ","

nmap <silent> <leader>n :silent :nohlsearch<CR>

set listchars=tab:>-,trail:·,eol:$
nmap <silent> <leader>s :set nolist!<CR>

nmap <silent> <leader>d :NERDTreeToggle<CR>

let g:rsenseHome = "/usr/lib/rsense-0.2"

if has("autocmd")
  filetype plugin indent on
endif

" Understand :W as :w
command! W :w

" Show unwanted whitespace
set listchars=tab:>-,trail:.,extends:>
set list!

" Status line
set laststatus=2
set statusline=%t\ %y\ format:\ %{&ff};\ [%c,%l]
"colorscheme jellybeans
set background=dark
colorscheme jellybeans
