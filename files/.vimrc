if has("gui_running") && system('ps xw | grep "Vim -psn" | grep -vc grep') > 0
  if $SHELL =~ '/\(sh\|csh\|bash\|tcsh\|zsh\|fish\)$'
    let s:path = system("echo echo VIMPATH'${PATH}' | $SHELL -l")
    let $PATH = matchstr(s:path, 'VIMPATH\zs.\{-}\ze\n')
  endif
endif

" I think this is standard stuff...
set shell=/bin/sh
set nocompatible
filetype off
scriptencoding utf-8

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'Shougo/vimproc'

"Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/neosnippet'
Bundle 'scrooloose/syntastic'
"
Bundle 'schell/vim-snippets'
Bundle 'scrooloose/nerdtree'
Bundle 'altercation/vim-colors-solarized'
Bundle 'pbrisbin/html-template-syntax'
Bundle 'ujihisa/neco-ghc'
Bundle 'tpope/vim-fugitive.git'
Bundle 'kien/ctrlp.vim'
Bundle 'Lokaltog/vim-powerline'
Bundle 'majutsushi/tagbar'
Bundle 'kana/vim-fakeclip'
Bundle 'juvenn/mustache.vim'
Bundle 'vim-scripts/rails.vim'
Bundle 'flazz/vim-colorschemes'
Bundle 'eagletmt/ghcmod-vim'
Bundle 'bitc/vim-hdevtools'
Bundle 'vim-scripts/Superior-Haskell-Interaction-Mode-SHIM'
Bundle 'travitch/hasksyn'
Bundle 'pangloss/vim-javascript'
Bundle 'editorconfig/editorconfig-vim'
Bundle 'lunaru/vim-less'
Bundle 'beyondmarc/glsl.vim'
Bundle 'jamestomasino/actionscript-vim-bundle'
Bundle 'dag/vim2hs'
Bundle 'vim-scripts/hlint'
Bundle 'dart-lang/dart-vim-plugin'
Bundle 'lambdatoast/elm.vim'
Bundle 'raichoo/purescript-vim'
Bundle 'facebook/vim-flow'

filetype plugin indent on     " required!
" Always show the statusline
set laststatus=2
" Necessary to show Unicode glyphs
set encoding=utf-8
" Looks...
set term=screen-256color
syntax enable
set guifont=Ubuntu\ Mono:h16

set background=dark
colorscheme solarized

set showmode
set cursorline
set cursorcolumn
set colorcolumn=80
highlight ColorColumn

call Pl#Theme#InsertSegment('fullcurrenttag', 'before', 'filetype')

set nu
set showmatch                   " show matching brackets/parenthesis
set incsearch                   " find as you type search
set hlsearch                    " highlight search terms

" Formatting...
set autoindent                  " indent at the same level of the previous line
set smartindent                 " indent after {
set shiftwidth=4                " use indents of 4 spaces
set expandtab                   " tabs are spaces, not tabs
set tabstop=4                   " an indentation every four columns
set softtabstop=4               " let backspace delete indent

" Don't expand tabs when working on a Makefile
autocmd FileType make setlocal noexpandtab

" Key mappings...
nnoremap <Leader>ee :Errors<CR>
nnoremap <left>  <nop>
nnoremap <right> <nop>
nnoremap <up>    <nop>
nnoremap <down>  <nop>
nnoremap <leader>sv :source $MYVIMRC<CR>
inoremap <up>    <nop>
inoremap <down>  <nop>
inoremap <left>  <nop>
inoremap <right> <nop>
nmap     ;       :

" C headers
autocmd BufRead,BufNewFile *.h set filetype=c

" as3
autocmd BufRead,BufNewFile *.as set filetype=actionscript

" Markdown
autocmd BufRead,BufNewFile *.md set filetype=markdown

" GLSL
autocmd BufNewFile,BufRead *.vp,*.fp,*.gp,*.vs,*.fs,*.gs,*.tcs,*.tes,*.cs,*.vert,*.frag,*.geom,*.tess,*.shd,*.gls,*.glsl set ft=glsl430

" Syntastic
let g:syntastic_javascript_checkers=['jshint', 'jslint']

" Javascript
let g:flow#enable = 1
let g:flow#autoclose = 1
let g:flow#errjmp = 1

" Dart
let $DART_SDK_DIR='/Users/schell/Code/dart/dart-sdk'
let g:syntastic_dart_checkers=['dartanalyzer']

" ctrlp
set wildignore+=*.o,*.hi,*/tmp/*,*.so,*.swp,*.zip,*.dyn_*,*.p_*,*/mock/*,*/test/spec/*

" Neocomplcache stuff...
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_enable_auto_delimiter = 1
let g:neocomplcache_max_list = 15
let g:neocomplcache_auto_completion_start_length = 3
let g:neocomplcache_force_overwrite_completefunc = 1
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

inoremap <expr><C-g>   neocomplcache#undo_completion()
inoremap <expr><C-l>   neocomplcache#complete_common_string()

" AutoComplPop like behavior.
let g:neocomplcache_enable_auto_select = 0

" neosnippet
let g:neosnippet#snippets_directory = "~/.vim/bundle/vim-snippets/snippets"

" Haskell stuff
let g:hdevtools_options = '-g-isrc -g-Wall'
let g:syntastic_haskell_checkers=['hdevtools']
let g:syntastic_haskell_hdevtools_args = '-g-isrc -g-Wall'
"autocmd BufWritePost *.hs SyntasticCheck
autocmd BufNewFile,BufRead *.hamlet set syntax=hamlet

au FileType haskell nnoremap <buffer> <Leader>tt :HdevtoolsType<CR>
au FileType haskell nnoremap <buffer> <Leader>tc :HdevtoolsClear<CR>

" node/js stuff
autocmd BufWritePost *.js SyntasticCheck

" TagBar
nmap <Leader>tb :TagbarOpenAutoClose<CR>
let g:tagbar_type_actionscript = {
    \ 'ctagstype' : 'Actionscript',
    \ 'kinds' : [
        \ 'c:consts',
        \ 'v:vars',
        \ 'o:overrides',
        \ 'f:functions',
    \ ]
\ }

let g:tagbar_type_javascript = {
    \ 'ctagstype' : 'Javascript',
    \ 'kinds' : [
        \ 'v:vars',
        \ 'p:properties',
        \ 's:object_functions',
        \ 'g:getters_setters',
        \ 'f:functions',
    \ ]
\ }

if executable('lushtags')
    let g:tagbar_type_haskell = {
        \ 'ctagsbin' : 'lushtags',
        \ 'ctagsargs' : '--ignore-parse-error --',
        \ 'kinds' : [
            \ 'm:module:0',
            \ 'e:exports:1',
            \ 'i:imports:1',
            \ 't:declarations:0',
            \ 'd:declarations:1',
            \ 'n:declarations:1',
            \ 'f:functions:0',
            \ 'c:constructors:0'
        \ ],
        \ 'sro' : '.',
        \ 'kind2scope' : {
            \ 'd' : 'data',
            \ 'n' : 'newtype',
            \ 'c' : 'constructor',
            \ 't' : 'type'
        \ },
        \ 'scope2kind' : {
            \ 'data' : 'd',
            \ 'newtype' : 'n',
            \ 'constructor' : 'c',
            \ 'type' : 't'
        \ }
    \ }
endif

" Clipboard
set clipboard=unnamed

" NerdTree
nmap <Leader>nt :NERDTreeFind<CR>

let NERDTreeShowBookmarks=1
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=1
let NERDTreeMouseMode=2
let NERDTreeShowHidden=1
let NERDTreeKeepTreeInNewTab=1
let NERDTreeIgnore=['\.hi$', '\.o$', '\.DS_Store$', '.*dyn_.*$']
let g:nerdtree_tabs_open_on_gui_startup=0

" Special chars
" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

"Invisible character colors
highlight NonText guibg=#000000
highlight SpecialKey guibg=#000000

echom "(>^.^<)"

