" ==============================================================================
" Plugins
" Using https://github.com/junegunn/vim-plug
" ==============================================================================
call plug#begin('~/.vim/plugged')
" Sets a bunch of defaults
Plug 'tpope/vim-sensible'

Plug 'tpope/vim-abolish'
Plug 'tpope/vim-surround'

Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'bronson/vim-trailing-whitespace'
Plug 'fatih/vim-go', {'for': 'go'}
Plug 'majutsushi/tagbar'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mileszs/ack.vim'
Plug 'gilsondev/searchtasks.vim', {'on': 'SearchTasks'}
Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'
Plug 'AndrewRadev/bufferize.vim'

" Dash app integration
Plug 'rizzatti/dash.vim'

" Colorschemes
Plug 'chriskempson/base16-vim'

" Syntax
" TODO: Figure out if there is a good 'for' line for this.
Plug 'aklt/plantuml-syntax', {'for': ['pu', 'plantuml', 'md', 'mdown', 'uml']}
Plug 'keith/swift.vim', {'for': ['swift']}

" Snippets
Plug 'tomtom/tlib_vim'
Plug 'marcweber/vim-addon-mw-utils'

"Plug 'SirVer/ultisnips'

" The fork that Janus VIM used.
" Plug 'garbas/vim-snipmate'
"Plug '~/Code/vim-kubernetes-snippets'

Plug 'isRuslan/vim-es6', {'for': ['javascript', 'js']}

" TypeScript
Plug 'leafgarland/typescript-vim'
" Turned off to try mhartington one
"Plug 'Quramy/tsuquyomi'
" Not yet working on VIM8
Plug 'mhartington/nvim-typescript'
"
"Plug 'jason0x43/vim-js-indent'

" RUST
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
set hidden  " Do I need to do this here?
let g:racer_cmd = '/Users/technosophos/.cargo/bin/racer' " FIXME
let g:racer_experimental_complete = 1
let g:racer_insert_paren = 1
au FileType rust nmap <leader>gd <Plug>(rust-doc)
au FileType *.rs nmap <leader>gd <Plug>(rust-doc)

" Personal Plugins
Plug 'technosophos/vim-myhelp'

" Kubernetes
" Plug 'andrewstuart/vim-kubernetes'
"
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'zchee/deoplete-go'

" Docker
Plug 'ekalinin/Dockerfile.vim'

if has('nvim')
	" nvim
  "Plug 'neomake/neomake', {'on': ['Neomake']}
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
	" macvim
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
  Plug 'Shougo/vimproc.vim', {'do': 'make'}
  Plug 'Shougo/deoplete.nvim'
endif

" Fonts/Icons
Plug 'ryanoasis/vim-devicons'

call plug#end()

" ==============================================================================
" Basics
" ==============================================================================
set encoding=utf8
let g:mapleader = "\\"
" lots of this is from https://github.com/adamreese/dotfiles/blob/master/nvim/init.vim
set number          " Show line numbers

set splitright      " Open new horizontal splits right
set splitbelow      " Open new vertical splits below

set autowrite       " Autosave before :next/:write, etc
set autoread        " Re-read a file when it is changed on disk

set smartindent

set lazyredraw
set scrolloff=10
set sidescrolloff=8
set sidescroll=1
set title      " show file name in window title.
" ==============================================================================


set noswapfile
"set nobackup

set laststatus=2


set cc=81    " Highlight column 81
" Don't start overlength highlighting until we hit column 90, which is the
" Golang recommendation.
highlight OverLength cterm=underline gui=underline term=underline
match OverLength '\%91v.*'

" Selectively show some hidden things
set list listchars=tab:░\ ,trail:▨,precedes:⤥,extends:☛
" ================================================================================================================


" ==============================================================================
" Searching
" ==============================================================================
" If search is lowercase, match against uppercase.
"set ignorespace
"set smartcase
set hlsearch
set incsearch
" TODO: wildignore settings

" ==============================================================================
" Navigation, tabs, windows, buffers
" ==============================================================================
if has('nvim')
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1
endif

" Quick navigation of panes
map <D-S-Right> <C-w>l
map <D-S-Left> <C-w>h
map <D-S-DOWN> <C-w><C-w>
map <D-S-UP> <C-w>W

" With hyperkey mod
map <M-C-D-S-DOWN> <C-w><C-w>
map <M-C-D-S-UP> <C-w>W
map <leader>] <C-w><C-w>
map <leader>[ <C-w>W

" Fixing for neovim, whose DS gets intercepted by iTerm2
"map <leader>aa <C-w>h
"map <leader>dd <C-w>l
"map <leader>ss <C-w><C-w>
"map <leader>ww <C-w>W

" Some helpers to edit mode http://vimcasts.org/e/14
" Expand %% into the CWD
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
" On command line, begin with current path.
nmap <leader>ew :e %%
nmap <leader>es :sp %%
nmap <leader>ev :vsp %%
nmap <leader>et :tabe %%

" Copy \y to the system clipboard
nnoremap <silent> <leader>y "*y
vnoremap <silent> <leader>y "*y

" ==============================================================================
" Avoid typos
" ==============================================================================
command! W w
command! Q q
command! Wq wq

" ==============================================================================
" Formatting
" ==============================================================================
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab
set textwidth=0 " NO INSERTING LINE BREAKS AT 80 CHARS
set nowrap
"set linebreak

set backspace=indent,eol,start

nmap <leader>u mQviwU`Q    " lowercase word
nmap <leader>l mQviwu`Q    " uppercase word

map <leader>ss :setlocal spell!<cr>

" ==============================================================================
" Colors
" ==============================================================================
if exists('+termguicolors')
  set termguicolors
endif
let base16colorspace=256
color base16-harmonic-dark
set bg=dark

" ==============================================================================
" Colors
" ==============================================================================
"set guifont=Menlo\ Regular:h12
"set guifont=Anonymous\ Pro:h12
" This comes from 'brew cask install font-hack-nerd-font'
set guifont=Knack\ Nerd\ Font:h12

" this is sort of a hack
highlight Cursor guifg=orange guibg=orange
highlight iCursor guifg=yellow guibg=yellow
set guicursor=n-v-c:block-Cursor


" ==============================================================================
" Plugin Settings
" ==============================================================================
" NerdTree
map <silent> <leader>n :NERDTreeToggle<CR> :NERDTreeMirror<CR>
let g:NERDTreeDirArrowExpandable = "\uf07b"
let g:NERDTreeDirArrowCollapsible = "\uf07c"

" NERDCommenter
" Map CTRL-D to toggling comments on and off.
map <D-/> :NERDComToggleComment<CR>
map <M-/> :NERDComToggleComment<CR>
" let g:NERDDefaultAlign = 'left' " Align comments on left side instead of indenting.
let g:NERDCompactSexyComs = 1   " How could I not?

" SnipMate settings
let g:snips_author="Matt Butcher (technosophos)"

" Vim-Wiki settings
let g:vimwiki_list = [{'path': '~/Documents/VimWiki'}]
" \ 'syntax': 'markdown', 'ext': '.md'}]

" Use ag instead of ack if we can.
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

map <leader>ag :Ack<space>

" Tagbar
nmap <leader>rt :TagbarToggle<CR>

" CtrlP
let g:ctrlp_working_path_mode = 'ra'
" Super cool hack from adamreese to use ag for CtrlP
let g:ctrlp_user_command = 'ag -Q %s -l --nocolor -g "" --ignore _output'
let g:ctrlp_use_caching = 0 " Because ag is fast
let g:ctrlp_buftag_types = {'go' : '--language-force=go --golang-types=ft'}
let g:ctrlp_extensions = ['buffertag']

" testing tsu with vimproc
let g:tsuquyomi_use_vimproc = 1
let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.typescript = ['tsuquyomi#complete']
"let g:deoplete#omni_patterns.typescript = '[^. *\t]\.\w*'
let g:tsuquyomi_completion_detail = 1

" Debugging deoplete/omni/ts
"let g:deoplete#enable_profile = 1
"call deoplete#enable_logging('DEBUG', 'deoplete.log')
"call deoplete#custom#source('jedi', 'is_debug_enabled', 1)

" neocomplete
let g:acp_enableAtStartup = 0
let g:deoplete#enable_at_startup = 1

" airline
" See https://github.com/ryanoasis/powerline-extra-symbols
" See https://nerdfonts.com
" See https://github.com/ryanoasis/vim-devicons
let g:airline_powerline_fonts = 1
let g:airline_left_sep = "\uE0C6"
let g:airline_right_sep = "\uE0C7"

" ==============================================================================
" Language-specific Settings
" ==============================================================================
filetype plugin indent on
if has("autocmd")
  " Makefile
  au FileType make setlocal noexpandtab

  " Ruby
  au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,Procfile,Guardfile,config.ru,*.rake} set ft=ruby

  " Markdown
  au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} setf markdown

  " Python (PEP-8)"
  au FileType python setlocal tabstop=4 shiftwidth=4

  " Thrift
  au BufRead,BufNewFile *.thrift set filetype=thrift
  "au! Syntax thrift source ~/.vim/thrift.vim

  " Support for Go tab indents.
  autocmd FileType go setlocal shiftwidth=4 tabstop=4 noexpandtab
  " Protobuf should use tabs for indent.
  autocmd FileType proto setlocal shiftwidth=4 tabstop=4 noexpandtab
endif
