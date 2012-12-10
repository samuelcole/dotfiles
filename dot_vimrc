call pathogen#infect()

syntax on
set background=dark
let g:solarized_termcolors=16
colorscheme solarized
filetype plugin indent on
set grepprg=ack
set grepformat=%f:%l:%m

set nocompatible
set modelines=0

set number

set tabstop=2
set smarttab
set shiftwidth=2
set autoindent
set expandtab
set nocindent
set backspace=indent,eol,start

set guifont=Anonymous\ Pro:h14

set hlsearch

set scrolloff=3
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set ttyfast
set laststatus=2
set undofile
set ruler
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}\ %{SyntasticStatuslineFlag()}.%=%-14.(%l,%c%V%)\ %P

let g:syntastic_enable_signs=1
let g:syntastic_auto_jump=1
let g:syntastic_auto_loc_list=1
let g:NodelintConfig = $HOME.'/Code/kickstarter/test/javascripts/lint-options.js'

" search
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch

" wrapping
set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=85

" let's get real
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" tabs
set showtabline=2
map <leader>t :tabnew<CR>
map <leader>] :tabn<CR>
map <leader>[ :tabp<CR>

map <leader>q :q<CR>

" alternate
map <leader>a :A<CR>
"fuzzy find
map <leader>f :FuzzyFinderFile<CR>
map <leader>b :FuzzyFinderBuffer<CR>
"nerd_tree
map <leader>d :execute 'NERDTreeToggle %'<CR>
"gundo
map <leader>u :GundoToggle<CR>

let g:fuzzy_ignore = "*.log,public/assets/*"
let g:fuzzy_matching_limit = 150
let g:fuzzy_ceiling = 500000

if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  "setglobal bomb
  set fileencodings=ucs-bom,utf-8,latin1
endif

" remove trailing whitespace
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" clipboard!
set clipboard=unnamed

" open nerd_tree by default
autocmd vimenter * if !argc() | NERDTree | endif

