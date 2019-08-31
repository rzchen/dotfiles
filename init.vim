call plug#begin()

Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-bundler'
Plug 'elixir-editors/vim-elixir'

"================================================
" Clojure
"================================================
Plug 'tpope/vim-salve'
Plug 'tpope/vim-fireplace'

"================================================
" Dev Tools
"================================================
Plug 'rking/ag.vim'
Plug 'w0rp/ale'
Plug 'tpope/vim-dispatch'
Plug 'bootleq/vim-qrpsqlpq'
Plug 'thinca/vim-quickrun'
Plug 'janko-m/vim-test'
Plug 'tpope/vim-cucumber'
Plug 'christoomey/vim-tmux-navigator'
Plug 'christoomey/vim-tmux-runner'
Plug 'majutsushi/tagbar' " list all methods in a file
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}

"================================================
" Javascript/HTML
"================================================
Plug 'kchmck/vim-coffee-script'
Plug 'mattn/emmet-vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'slim-template/vim-slim'
Plug 'tpope/vim-ragtag'

"================================================
" Git
"================================================
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

"================================================
" Enhance Vim
"================================================
Plug 'austintaylor/vim-indentobject'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'junegunn/vim-easy-align'
Plug 'pedrohdz/vim-yaml-folds'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'

"================================================
" Theme
"================================================
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'flazz/vim-colorschemes'
Plug 'ryanoasis/vim-devicons'
Plug 'joshdick/onedark.vim' " for correct colorscheme
Plug 'cocopon/iceberg.vim' " for correct airline theme
Plug 'rakr/vim-one' " for correct airline theme

call plug#end()

"================================================
" General
"================================================
set nocompatible
syntax enable

set autoindent
set autoread                                                 " reload files when changed on disk, i.e. via `git checkout`
set backspace=2                                              " Fix broken backspace in some setups
set backupcopy=yes                                           " see :help crontab
set clipboard=unnamed                                        " yank and paste with the system clipboard
set directory-=.                                             " don't store swapfiles in the current directory
set encoding=utf-8
set expandtab                                                " expand tabs to spaces
set ignorecase                                               " case-insensitive search
set incsearch                                                " search as you type
set laststatus=2                                             " always show statusline
set list                                                     " show trailing whitespace
set listchars=tab:▸\ ,trail:▫
set number                                                   " show line numbers
set ruler                                                    " show where you are
set scrolloff=3                                              " show context above/below cursorline
set shiftwidth=2                                             " normal mode indentation commands use 2 spaces
set showcmd
set smartcase                                                " case-sensitive search if any caps
set softtabstop=2                                            " insert mode tab and backspace use 2 spaces
set tabstop=8                                                " actual tabs occupy 8 characters
set wildignore=log/**,node_modules/**,target/**,tmp/**,*.rbc
set wildmenu                                                 " show a navigable menu for tab completion
set wildmode=longest,list,full
set nowrap
set nocursorline
set nohlsearch
set relativenumber
set noswapfile                                               " disable .swp files creation in vim
set hidden                                                   " allow you to switch between buffers without saving
" set colorcolumn=80

" Enable basic mouse behavior such as resizing buffers.
set mouse=a
if exists('$TMUX')  " Support resizing in tmux
  if !has('nvim')
    set ttymouse=xterm2
  endif
endif

" https://github.com/neovim/neovim/issues/7994#issuecomment-388296360
au InsertLeave * set nopaste

" fix the problem on lagging issue on using relativenumber (syntax highlight)
" ref: vim/vim#282, vim-ruby/vim-ruby#243
" set regexpengine=1
" set lazyredraw

" fdoc is yaml
autocmd BufRead,BufNewFile *.fdoc set filetype=yaml
autocmd BufRead,BufNewFile *.yml setlocal spell
" slim is slim
autocmd BufNewFile,BufRead *.slim setlocal filetype=slim
" git commit textwidth limit
autocmd Filetype gitcommit setlocal spell textwidth=72

" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

"================================================
" Remap
"================================================
let mapleader = ','

" sometimes need , to repeat latest f, t, F or T in opposite direction
noremap \ ,
" Helps when I want to delete something without clobbering my unnamed register.
nnoremap s "_d
nnoremap ss "_dd

" navigating
noremap H ^
noremap L $
nmap j gj
nmap k gk

noremap <C-n> <C-i>

" Don't copy the contents of an overwritten selection.
vnoremap p "_dP
vnoremap <leader>ag y:AgBuffer <c-r>"<cr>

"================================================
" Plugin
"================================================

" Disable documentation window
set completeopt-=preview
let g:deoplete#enable_at_startup=1
let g:deoplete#enable_refresh_always=0
let g:deoplete#enable_smart_case=1
let g:deoplete#file#enable_buffer_path=1

let g:deoplete#sources={}
let g:deoplete#sources._    = ['around', 'buffer', 'file', 'ultisnips']
let g:deoplete#sources.ruby = ['around', 'buffer', 'member', 'file', 'ultisnips']
let g:deoplete#sources.vim  = ['around', 'buffer', 'member', 'file', 'ultisnips']
let g:deoplete#sources['javascript.jsx'] = ['around', 'buffer', 'file', 'ultisnips', 'ternjs']
let g:deoplete#sources.css  = ['around', 'buffer', 'member', 'file', 'omni', 'ultisnips']
let g:deoplete#sources.scss = ['around', 'buffer', 'member', 'file', 'omni', 'ultisnips']
let g:deoplete#sources.html = ['around', 'buffer', 'member', 'file', 'omni', 'ultisnips']
let g:ctrlp_match_window = 'order:ttb,max:20'

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --ignore db/ --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif

" " Reduce the time that signs appear when enable gitgutter
set updatetime=200

" extra rails.vim help
autocmd User Rails silent! Rnavcommand job app/jobs -glob=**/* -suffix=_job.rb

" NerdTree Setting
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1
let g:NERDSpaceDelims=1

" Vim-test
" https://github.com/janko-m/vim-test#custom-strategies
" let test#strategy = "vtr"
" need to setup this to make binding.pry works...
" let g:test#ruby#minitest#executable = 'disboot bundle exec ruby -Itest'
" let test#ruby#minitest#options = '--verbose'

" vim-easy-align
" override default ignore comment and string in vim-easy-align
let g:easy_align_ignore_groups = []

"================= Helper =================
source ~/dotfiles/.vim/minitest_helper.vim
source ~/dotfiles/.vim/whitespace.vim

" run sql file to give your the result table!
" usage: <leader_key>p + j, l, r
function! s:init_qrpsqlpq()
  nmap <buffer> <Leader>p [qrpsqlpq]
  nnoremap <silent> <buffer> [qrpsqlpq]j :call qrpsqlpq#run('split')<CR>
  nnoremap <silent> <buffer> [qrpsqlpq]l :call qrpsqlpq#run('vsplit')<CR>
  nnoremap <silent> <buffer> [qrpsqlpq]r :call qrpsqlpq#run()<CR>

  if !exists('b:rails_root')
    call RailsDetect()
  endif
  if !exists('b:rails_root')
    let b:qrpsqlpq_db_name = 'postgres'
  endif
endfunction

if executable('psql')
  let g:qrpsqlpq_expanded_format_max_lines = -1
  autocmd FileType sql call s:init_qrpsqlpq()
endif

"================================================
" Shortcut
"================================================
nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>d :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>
nnoremap <leader>T :CtrlPClearCache<CR>:CtrlP<CR>
nnoremap <leader>] :TagbarToggle<CR>
nnoremap <leader><space> :call whitespace#strip_trailing()<CR>

" in case you forgot to sudo
cnoremap w!! %!sudo tee > /dev/null %

" indenting
noremap <leader>in mmgg=G'm

nmap <leader>p obinding.pry<ESC>^
nmap <leader>c "ay
nmap <leader>vv "ap

" window
nmap <leader>w <C-w>

" buffer switch
nnoremap <silent> <tab> :bn<CR>
nnoremap <silent> <S-tab> :bp<CR>

" Note that remapping C-s requires flow control to be disabled (in .zshrc)
nmap <C-s> <esc>:w<CR>
imap <C-s> <esc>:w<CR>

" Close current buffer
nmap <leader>q <esc>:bw<cr>
imap <leader>q <esc>:bw<cr>

" in all modes hit ,, can return to normal mode
noremap  ,, <C-\><C-N>
noremap!  ,, <C-\><C-N>

" vim-gitgutter
nnoremap <leader>gg :GitGutterToggle<CR>

" Fugitive
set diffopt+=vertical

nmap <silent><leader>gb :Gblame<cr>

nmap <leader>ge :Gedit<Space>
nmap <leader>gdd :Gdiff<Space>
" compare with working area
nmap <leader>gdw :Gdiff<cr>
" compare with index
nmap <leader>gdi :Gdiff HEAD<cr>
" reset the diff with working area in Gdiff mode
nmap <leader>gdr :diffget<cr>
nmap <leader>gs :Gstatus<cr>

" Rails
nmap <leader>aa :A<CR>
nmap <leader>av :AV<CR>
nmap <leader>gr :R<CR>
nmap <leader>vl :sp<cr><C-^><cr>
nmap <leader>hl :vsp<cr><C-^><cr>

" Ag
nmap <leader>ab :AgBuffer<space>
nmap <leader>ag :Ag<space>

" Vim-test
nmap <silent> <leader><C-t> :TestNearest<CR>
nmap <silent> <leader><C-f> :TestFile<CR>
nmap <silent> <leader><C-l> :TestLast<CR>

" start interactive EasyAlign in visual mode
vmap <Enter> <Plug>(EasyAlign)
" start interactive EasyAlign for a motion/text object (e.g. <leader>eaip)
nmap <leader>l <Plug>(EasyAlign)

" Vim Tmux Runner
nnoremap <leader>ar :VtrAttachToPane<cr>
nnoremap <leader>kr :VtrKillRunner<cr>
nnoremap <leader>sl :VtrSendLinesToRunner<cr>
nnoremap <leader>rc :VtrOpenRunner {'orientation': 'h', 'percentage': 45, 'cmd': 'rc'}<cr>
nnoremap <leader>ry :VtrOpenRunner {'orientation': 'h', 'percentage': 45, 'cmd': 'rpy'}<cr>

" barrow from unimpaired
nmap ]<Space> o<ESC>
nmap [<Space> O<ESC>

" run commands in vim
nmap <leader>ss :!rpu<enter>
nmap <leader>ks :!krpu<enter>
nmap <leader>cop :!cop<enter>

"================================================
" Javascript
"================================================
let g:user_emmet_settings = {
\  'javascript.jsx' : {
\      'extends': 'jsx'
\  },
\}

let g:user_emmet_leader_key='<C-E>'

"================================================
" Theme
"================================================
if (has("termguicolors"))
  set termguicolors
endif

let g:WebDevIconsUnicodeDecorateFolderNodes = 1

" vim-airline
" smart tab line, automatically displays all buffers when there's only one tab open.
let g:airline#extensions#tabline#enabled = 1

" https://github.com/vim-airline/vim-airline#integrating-with-powerline-fonts
let g:airline_powerline_fonts = 1
let g:airline_left_sep         = '⮀'
let g:airline_left_alt_sep     = '⮁'
let g:airline_right_sep        = '⮂'
let g:airline_right_alt_sep    = '⮃'

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_symbols.branch   = '⭠'
let g:airline_symbols.readonly = '⭤'
let g:airline_symbols.linenr   = '⭡'

" let g:airline_theme='onedark'
let g:airline_theme='iceberg'
" let g:airline_theme='one'

color dracula
" colorscheme onedark
" colorscheme one
" set background=light
" colorscheme iceberg
" colorscheme xemacs
" colorscheme spacegray
" colorscheme spring

" change SpellBad style, have to do this after colorscheme setup, otherwise
" will be overwritten
hi SpellBad ctermbg=20

" keep set secure on the last line
set secure " safer working with script files in the current directory

" set runtimepath^=~/.vim runtimepath+=~/.vim/after
" let &packpath = &runtimepath
" source ~/.vimrc