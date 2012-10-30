" I think this is standard stuff...
set shell=/bin/sh
set nocompatible
filetype off
scriptencoding utf-8

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles here:
Bundle 'Shougo/vimproc'
Bundle 'scrooloose/syntastic'
Bundle 'altercation/vim-colors-solarized'
Bundle 'eagletmt/ghcmod-vim'
Bundle 'ujihisa/neco-ghc'
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/neocomplcache-snippets-complete'
Bundle 'dag/vim2hs'
Bundle 'tpope/vim-fugitive.git'
Bundle 'kien/ctrlp.vim'
Bundle 'Lokaltog/vim-powerline'
Bundle 'majutsushi/tagbar'
Bundle 'kana/vim-fakeclip'
Bundle 'scrooloose/nerdtree'
Bundle 'pangloss/vim-javascript'
Bundle 'juvenn/mustache.vim'

" original repos on github
" Bundle 'tpope/vim-fugitive'

" vim-scripts repos
" Bundle 'L9'

" non github repos
" Bundle 'git://git.wincent.com/command-t.git'
" ...

filetype plugin indent on     " required!
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..

set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show Unicode glyphs

" Looks... 
set term=screen-256color
syntax enable
set background=dark
colorscheme solarized
set showmode
set cursorline
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

" Key mappings...
nnoremap <left>  <nop>
nnoremap <right> <nop>
nnoremap <up>    <nop>
nnoremap <down>  <nop>
inoremap <up>    <nop>
inoremap <down>  <nop>
inoremap <left>  <nop>
inoremap <right> <nop>
nmap     ;       :

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
imap <C-k>     <Plug>(neocomplcache_snippets_expand)
smap <C-k>     <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g>   neocomplcache#undo_completion()
inoremap <expr><C-l>   neocomplcache#complete_common_string()
" AutoComplPop like behavior.
let g:neocomplcache_enable_auto_select = 0
" Neocomplcache-snippets-complete
let g:neocomplcache_snippets_dir = '~/.vim/snippets'

" ghcmod stuff
autocmd BufWritePost *.hs call s:check_and_lint()

function! s:check_and_lint()
    let l:qflist = ghcmod#make('check')
    call extend(l:qflist, ghcmod#make('lint'))
    call setqflist(l:qflist)
    cwindow
    if empty(l:qflist)
        echo "No errors found :)"
    endif
endfunction

nmap _t  :w<CR>:GhcModType<CR>
nmap _ti :w<CR>:GhcModTypeInsert<CR>

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
let g:tagbar_type_haskell = {
    \ 'ctagstype' : 'Haskell',
    \ 'kinds' : [
        \ 'm:module',
        \ 'i:import',
        \ 'd:data',
        \ 'f:functions',
    \ ]
\ }

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
let g:nerdtree_tabs_open_on_gui_startup=0
