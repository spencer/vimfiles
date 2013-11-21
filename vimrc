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
let g:ackprg = 'ag --nogroup --nocolor --column'
set grepformat=%f:%l:%m

set undodir=~/.vim/undodir
set undofile
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload

" Intuitive backspacing in insert mode
set backspace=indent,eol,start

" Set OSX Clipboad
set clipboard+=unnamed

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

nmap <leader>fc %s/;/;\n/g
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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RUNNING TESTS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>t :call RunTestFile()<cr>
map <leader>T :call RunNearestTest()<cr>
map <leader><space> :call ReRunTestCommand()<cr>

map <leader>c :w\|:!script/features<cr>
map <leader>p :w\|:!cucumber --profile wip %<cr>

function! RunTestFile(...)
    if a:0
        let command_suffix = a:1
    else
        let command_suffix = ""
    endif

    " Run the tests for the previously-marked file.
    let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\|_test.rb\)$') != -1
    if in_test_file
        call SetTestFile()
    elseif !exists("t:grb_test_file")
        return
    end
    call RunTests(t:grb_test_file . command_suffix)
endfunction

function! RunNearestTest()
    let spec_line_number = line('.')
    call RunTestFile(":" . spec_line_number . " -b")
endfunction

function! SetTestFile()
    " Set the spec file that tests will be run for.
    let t:grb_test_file=@%
endfunction

function! RunTests(filename)
    " Write the file and run tests for the given filename
    :w
    if match(a:filename, '\.feature') != -1
        if filereadable("script/features")
            let run_test = "script/features " . a:filename
        elseif filereadable("Gemfile")
            let run_test = "bundle exec cucumber --color " . a:filename
        else
            let run_test = "cucumber --color " . a:filename
        end
    else
        if filereadable("script/test")
            let run_test = "script/test " . a:filename
        elseif filereadable("Gemfile")
            let run_test = "bundle exec rspec --color " . a:filename
        else
            let run_test = "rspec --color " . a:filename
        end
    end
    call RunTestCommand(run_test)
endfunction

function! RunTestCommand(cmd)
    if match(a:cmd, '.') != -1
      let t:sst_test_command = a:cmd
    end
    "if $TMUX != ""
      "call VimuxRunCommand("clear; " . t:sst_test_command)
    "else
      exec ":!clear;" . t:sst_test_command
    "endif
endfunction

function! ReRunTestCommand()
  call RunTestCommand("")
endfunction

inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

function FormatRubyHash()
  Tabularize /^[^:]*\zs:/r1c0l0
  Tabularize /^[^=>]*\zs=>/l1
endfunction

function FormatEquals()
  Tabularize /[=:]/
endfunction

function FormatCommas()
  Tabularize /,\zs/l1l0
endfunction

function FormatCss()
  Tabularize /: \zs/l1l0
endfunction

function FormatRubySymbols()
  Tabularize /:\zs/l1l10
endfunction

map <leader>ah :call FormatRubyHash()<cr>
map <leader>a= :call FormatEquals()<cr>
map <leader>a, :call FormatCommas()<cr>
map <leader>ac :call FormatCss()<cr>
map <leader>a: :call FormatRubySymbols()<cr>

map <F1> :noh<Cr>

function! OpenTestAlternate()
  let new_file = AlternateForCurrentFile()
  exec ':e ' . new_file
endfunction

function! AlternateForCurrentFile()
  let current_file = expand("%")
  let new_file = current_file
  let in_spec = match(current_file, '^spec/') != -1
  let going_to_spec = !in_spec
  let in_app = match(current_file, '\<controllers\>') != -1 || match(current_file, '\<models\>') != -1 || match(current_file, '\<views\>') != -1
  "let in_app = match(current_file, '^app/') != -1
  if going_to_spec
    if in_app
      let new_file = substitute(new_file, '^app/', '', '')
    else
      let new_file = substitute(new_file, '^lib/', '', '')
    end
    let new_file = substitute(new_file, '\.rb$', '_spec.rb', '')
    let new_file = 'spec/' . new_file
  else
    let new_file = substitute(new_file, '_spec\.rb$', '.rb', '')
    let new_file = substitute(new_file, '^spec/', '', '')
    if in_app
      let new_file = 'app/' . new_file
    else
      let new_file = 'lib/' . new_file
    end
  endif
  return new_file
endfunction
nnoremap <leader>. :call OpenTestAlternate()<cr>
nnoremap <leader><leader> <c-^>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PROMOTE VARIABLE TO RSPEC LET
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! PromoteToLet()
  :normal! dd
  " :exec '?^\s*it\>'
  :normal! P
  :.s/\(\w\+\) = \(.*\)$/let(:\1) { \2 }/
  :normal ==
endfunction
:command! PromoteToLet :call PromoteToLet()
:map <leader>p :PromoteToLet<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EXTRACT VARIABLE (SKETCHY)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! ExtractVariable()
    let name = input("Variable name: ")
    if name == ''
        return
    endif
    " Enter visual mode (not sure why this is needed since we're already in
    " visual mode anyway)
    normal! gv

    " Replace selected text with the variable name
    exec "normal c" . name
    " Define the variable on the line above
    exec "normal! O" . name . " = "
    " Paste the original selected text to be the variable value
    normal! $p
endfunction
vnoremap <leader>xv :call ExtractVariable()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" INLINE VARIABLE (SKETCHY)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InlineVariable()
    " Copy the variable under the cursor into the 'a' register
    :let l:tmp_a = @a
    :normal "ayiw
    " Delete variable and equals sign
    :normal 2daW
    " Delete the expression into the 'b' register
    :let l:tmp_b = @b
    :normal "bd$
    " Delete the remnants of the line
    :normal dd
    " Go to the end of the previous line so we can start our search for the
    " usage of the variable to replace. Doing '0' instead of 'k$' doesn't
    " work; I'm not sure why.
    normal k$
    " Find the next occurence of the variable
    exec '/\<' . @a . '\>'
    " Replace that occurence with the text we yanked
    exec ':.s/\<' . @a . '\>/' . @b
    :let @a = l:tmp_a
    :let @b = l:tmp_b
endfunction
nnoremap <leader>iv :call InlineVariable()<cr>


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

set guifont=Menlo-Powerline:h15

colorscheme lucius
LuciusLightLowContrast
