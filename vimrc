call pathogen#infect()

syntax on
set background=light
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

let g:quickfixsigns_classes = ['vcsdiff']
let g:quickfixsigns_class_vcsdiff = {'sign': '*quickfixsigns#vcsdiff#Signs', 'get': 'quickfixsigns#vcsdiff#GetList(%s)', 'event': ['BufEnter,BufWritePost'], 'level': 6}

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
highlight ColorColumn ctermbg=9

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
set showtabline=1
map <leader>t :tabnew<CR>
map <leader>] :tabn<CR>
map <leader>[ :tabp<CR>

map <leader>q :q<CR>

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

"
" Jump to the next or previous line that has the same level or a lower
" level of indentation than the current line.
"
" exclusive (bool): true: Motion is exclusive
" false: Motion is inclusive
" fwd (bool): true: Go to next line
" false: Go to previous line
" lowerlevel (bool): true: Go to line with lower indentation level
" false: Go to line with the same indentation level
" skipblanks (bool): true: Skip blank lines
" false: Don't skip blank lines
function! NextIndent(exclusive, fwd, lowerlevel, skipblanks)
  let line = line('.')
  let column = col('.')
  let lastline = line('$')
  let indent = indent(line)
  let stepvalue = a:fwd ? 1 : -1
  while (line > 0 && line <= lastline)
    let line = line + stepvalue
    if ( ! a:lowerlevel && indent(line) == indent ||
          \ a:lowerlevel && indent(line) < indent)
      if (! a:skipblanks || strlen(getline(line)) > 0)
        if (a:exclusive)
          let line = line - stepvalue
        endif
        exe line
        exe "normal " column . "|"
        return
      endif
    endif
  endwhile
endfunction

" Moving back and forth between lines of same or lower indentation.
nnoremap <silent> [l :call NextIndent(0, 0, 0, 1)<CR>
nnoremap <silent> ]l :call NextIndent(0, 1, 0, 1)<CR>
nnoremap <silent> [L :call NextIndent(0, 0, 1, 1)<CR>
nnoremap <silent> ]L :call NextIndent(0, 1, 1, 1)<CR>
vnoremap <silent> [l <Esc>:call NextIndent(0, 0, 0, 1)<CR>m'gv''
vnoremap <silent> ]l <Esc>:call NextIndent(0, 1, 0, 1)<CR>m'gv''
vnoremap <silent> [L <Esc>:call NextIndent(0, 0, 1, 1)<CR>m'gv''
vnoremap <silent> ]L <Esc>:call NextIndent(0, 1, 1, 1)<CR>m'gv''
onoremap <silent> [l :call NextIndent(0, 0, 0, 1)<CR>
onoremap <silent> ]l :call NextIndent(0, 1, 0, 1)<CR>
onoremap <silent> [L :call NextIndent(1, 0, 1, 1)<CR>
onoremap <silent> ]L :call NextIndent(1, 1, 1, 1)<CR>
