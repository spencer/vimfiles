filetype off

runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()

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

" Set cursor line and column
set cursorline
set cursorcolumn

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
" Understand :Q as :q
command! Q :q

" Show unwanted whitespace
set listchars=tab:>-,trail:.,extends:>
set list!

"folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1         "this is just what i use" Status line

" window
nmap <leader>sw<left>  :topleft  vnew<CR>
nmap <leader>sw<right> :botright vnew<CR>
nmap <leader>sw<up>    :topleft  new<CR>
nmap <leader>sw<down>  :botright new<CR>
" buffer
nmap <leader>s<left>   :leftabove  vnew<CR>
nmap <leader>s<right>  :rightbelow vnew<CR>
nmap <leader>s<up>     :leftabove  new<CR>
nmap <leader>s<down>   :rightbelow new<CR>

nnoremap <leader><leader> <c-^>let g:Powerline_symbols = 'fancy'
set laststatus=2
" set statusline=%t\ %y\ format:\ %{&ff};\ [%c,%l]

if exists('$TMUX')
  autocmd FileType ruby map <buffer> <Leader>f :RunRubyFocusedTest<CR>
  autocmd FileType ruby map <buffer> <Leader>t :RunAllRubyTests<CR>
  autocmd FileType cucumber map <Leader>f :RunFocusedCuke<CR>
  autocmd FileType cucumber map <Leader>t :RunAllCukes<CR>
endif

" Set Vimux to split horizontal
let g:VimuxOrientation = "h"

"Set cmd-t triggers to not conflict with vimux
nnoremap <silent> <Leader>tt :CommandT<CR>
nnoremap <silent> <Leader>bb :CommandTBuffer<CR>

set background=dark
colorscheme solarized
