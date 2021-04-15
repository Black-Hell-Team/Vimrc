" Black Hell Team
" https://github.com/Black-Hell-Team
" Coded by: Lucaz dev and Near Shelby
" https://github.com/luc4sd3v
" https://github.com/nearshelby-yt

" Encoding
set encoding=UTF-8

" General
set nocompatible
filetype off


"Plugin
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'preservim/nerdtree'
Plugin 'morhetz/gruvbox'
Plugin 'luochen1990/rainbow'
Plugin 'jiangmiao/auto-pairs'
Plugin 'ryanoasis/vim-devicons'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'
Plugin 'mhinz/vim-startify'
Plugin 'neoclide/coc.nvim'
Plugin 'sheerun/vim-polyglot'
Plugin 'gabrielelana/vim-markdown'
Plugin 'airblade/vim-gitgutter'
Plugin 'Yggdroot/indentLine.git'
Plugin 'AndrewRadev/tagalong.vim'
Plugin 'mattesgroeger/vim-bookmarks'
Plugin 'tpope/vim-commentary'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/syntastic'
Plugin 'vim-scripts/AutoComplPop'
Plugin 'jreybert/vimagit'
Plugin 'ap/vim-css-color'
Plugin 'tpope/vim-surround'
Plugin 'mboughaba/i3config.vim'
Plugin 'mattn/emmet-vim'

call vundle#end()
filetype plugin on
filetype plugin indent on

" Text Rendering
set display+=lastline
set linebreak
set scrolloff=1
set sidescrolloff=5
syntax enable
set wrap

" Interface
set laststatus=2
set ruler
set wildmenu
set tabpagemax=50
set termguicolors
let g:gruvbox_italic = 1
let g:gruvbox_contrast_dark = 'medium'
colorscheme gruvbox
set cursorline
set number
set noerrorbells
set visualbell
set mouse=a
set title
set background=dark
set confirm
set noshowmode

" Rainbow Brackets
let g:rainbow_active = 1

" Vim Airline
let g:airline_theme='gruvbox'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_powerline_fonts = 1

" Indent
set smartindent
set autoindent
filetype on
filetype indent on
set expandtab
set shiftround
set shiftwidth=4
set smarttab
set tabstop=4

" Search
set hlsearch
set ignorecase
set incsearch
set smartcase

" Split Options
set splitbelow
set splitright

" Perfomance
set ttyfast
set complete-=i
set lazyredraw

" Vim Startify
let g:startify_custom_header = [
  \ ' ',
  \ '          ██▒   █▓ ██▓ ███▄ ▄███▓',
  \ '         ▓██░   █▒▓██▒▓██▒▀█▀ ██▒',
  \ '          ▓██  █▒░▒██▒▓██    ▓██░',
  \ '           ▒██ █░░░██░▒██    ▒██ ',
  \ '            ▒▀█░  ░██░▒██▒   ░██▒',
  \ '            ░ ▐░  ░▓  ░ ▒░   ░  ░',
  \ '            ░ ░░   ▒ ░░  ░      ░',
  \ '              ░░   ▒ ░░      ░   ',
  \ '               ░   ░         ░   ',
  \ '              ░                  ',
  \ ' ',
  \ ]

function! s:gitModified()
    let files = systemlist('git ls-files -m 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

function! s:gitUntracked()
    let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

let g:startify_lists = [
        \ { 'type': 'files',     'header': ['   MRU']            },
        \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
        \ { 'type': 'sessions',  'header': ['   Sessions']       },
        \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
        \ { 'type': function('s:gitModified'),  'header': ['   git modified']},
        \ { 'type': function('s:gitUntracked'), 'header': ['   git untracked']},
        \ { 'type': 'commands',  'header': ['   Commands']       },
        \ ]

"  Coc
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_global_extensions = ['coc-sh', 'coc-highlight', 'coc-clangd']

" Indent Line
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_setColors = 0

" tagalong
let g:tagalong_verbose = 1

" Commentary
nnoremap <C-c> :Commentary<CR>

" Bookmarks
let g:bookmark_sign = ''
let g:bookmark_annotation_sign = ''
let g:bookmark_highlight_lines = 1
nnoremap <C-m> :BookmarkToggle<CR>
nnoremap <C-n> :BookmarkAnnotate<CR>
nnoremap <C-a> :BookmarkClearAll<CR>

" i3-config

aug i3config_ft_detection
    au!
    au BufNewFile,BufRead ~/.config/i3/config set filetype=i3config_ft_detectionfig
aug end

" Runner CTRL + g
function! Executar(arq)
  :w
  if &filetype == 'go'
    :exec '!go run' a:arq
  elseif &filetype == 'python'
    :exec '!pypy' a:arq '|| python3' a:arq
  elseif &filetype == 'javascript'
    :exec '!node' a:arq
  elseif &filetype == 'c'
    :exec '!clang' a:arq '|| gcc' a:arq
  elseif &filetype == 'rust'
    :exec "!cargo-fmt"
    :exec '!cargo-clippy && cargo run || cargo run || rustc' a:arq
  elseif &filetype == 'typescript'
    :exec '!tsc -w' a:arq
  elseif &filetype == 'cpp'
    :exec '!clang++' a:arq '|| g++' a:arq
  elseif &filetype == 'ruby'
    :exec '!ruby' a:arq
  elseif &filetype == 'php'
    :exec '!php' a:arq
  elseif &filetype == 'java'
    :exec '!javac' a:arq
  elseif &filetype == 'cs'
    :exec '!dotnet run'
  elseif &filetype == 'matlab'
    :exec '!gcc `gnustep-config --objc-flags` -lgnustep-base' a:arq
  elseif &filetype == 'swift'
    :exec '!swift' a:arq
  elseif &filetype == 'perl'
    :exec '!perl' a:arq
  elseif &filetype == 'sh'
    :exec '!bash' a:arq
  elseif &filetype == "lisp"
    :exec "!sbcl --script" a:arq
  elseif &filetype == "prolog"
    :exec "!swipl" a:arq
  elseif &filetype == "haskell"
    :exec "!stack run || cabal run || ghc" a:arq
  elseif &filetype == "elixir"
    :exec "!elixir" a:arq
  endif
endfunction
noremap <C-g> :call Executar(shellescape(@%, 1))<CR>

" scripts bash
fun! InsertHeadBash()
   normal(1G)
   :set ft=bash
   :set ts=4
   call append(0, "#!bin/bash")
   call append(1, "# Criado em:" . strftime("%a %d/%b/%Y hs %H:%M"))
   call append(2, "# ultima modificação:" . strftime("%a %d/%b/%Y hs %H:%M"))
   call append(3, "# Nome da empresa")
   call append(3, "# Propósito do script")
   normal($)
endfun
map ,sh :call InsertHeadBash()<cr>A

" REPL
function! Repl()
    :w
    if &filetype == "javascript"
        :exec "terminal node"
    elseif &filetype == "lisp"
        :exec "terminal sbcl"
    elseif &filetype == "haskell"
        :exec "terminal ghci"
    elseif &filetype == "elixir"
        :exec "terminal iex"
    elseif &filetype == "python"
        :exec "terminal python3"
    elseif &filetype == "v"
        :exec "terminal v repl"
    elseif &filetype == "prolog"
        :exec "terminal swipl"
    elseif &filetype == "php"
        :exec "terminal php -a"
    elseif &filetype == "sh"
        :exec "terminal"
    elseif &filetype == "ruby"
        :exec "terminal irb"
    elseif &filetype == "scala"
        :exec "terminal scala"
    elseif &filetype == "erlang"
        :exec "terminal erl"
    endif
endfunction
noremap <C-a> :call Repl() <CR>
