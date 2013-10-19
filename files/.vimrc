" Get path info (mac stuff)
" TODO:  Is there a better way to tell that Vim.app was started from Finder.app?
" Note:  Do not move this to the gvimrc file, else this value of $PATH will
" not be available to plugin scripts.
if has("gui_running") && system('ps xw | grep "Vim -psn" | grep -vc grep') > 0
  " Get the value of $PATH from a login shell.
  " If your shell is not on this list, it may be just because we have not
  " tested it.  Try adding it to the list and see if it works.  If so,
  " please post a note to the vim-mac list!
  if $SHELL =~ '/\(sh\|csh\|bash\|tcsh\|zsh\)$'
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

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles here:
Bundle 'Shougo/vimproc'
Bundle 'scrooloose/syntastic'
Bundle 'altercation/vim-colors-solarized'
Bundle 'eagletmt/ghcmod-vim'
Bundle 'pbrisbin/html-template-syntax'
Bundle 'ujihisa/neco-ghc'
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/neosnippet'
Bundle 'tpope/vim-fugitive.git'
Bundle 'kien/ctrlp.vim'
Bundle 'Lokaltog/vim-powerline'
Bundle 'majutsushi/tagbar'
Bundle 'kana/vim-fakeclip'
Bundle 'scrooloose/nerdtree'
Bundle 'juvenn/mustache.vim'
Bundle 'vim-scripts/rails.vim'
Bundle 'flazz/vim-colorschemes'
Bundle 'travitch/hasksyn'
Bundle 'pangloss/vim-javascript'
Bundle 'editorconfig/editorconfig-vim'
Bundle 'lunaru/vim-less'
Bundle 'beyondmarc/glsl.vim'

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
let os = substitute(system('uname'), "\n", "", "") 
if os == "Darwin"
    set guifont=Ubuntu\ Mono:h16
endif
" set background=dark
colorscheme zenburn
set showmode
set cursorline
set cursorcolumn
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

" GLSL
autocmd BufNewFile,BufRead *.vp,*.fp,*.gp,*.vs,*.fs,*.gs,*.tcs,*.tes,*.cs,*.vert,*.frag,*.geom,*.tess,*.shd,*.gls,*.glsl set ft=glsl430

" Syntastic
let g:syntastic_javascript_checkers=['jshint', 'jslint']

" CtrlP
set wildignore+=*.o,*.hi

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

" neosnippet 
let g:neosnippet#snippets_directory = "~/.vim/snippets"

" haskell/yesod stuff
autocmd BufWritePost *.hs GhcModCheckAndLintAsync 
autocmd BufNewFile,BufRead *.hamlet set syntax=hamlet

nmap _t  :w<CR>:GhcModType<CR>
nmap _ti :w<CR>:GhcModTypeInsert<CR>

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
let g:tagbar_type_haskell = {
    \ 'ctagstype' : 'Haskell',
    \ 'kinds' : [
        \ 'm:module',
        \ 'i:import',
        \ 'd:data',
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

" Special chars
" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>
 
" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬
        
"Invisible character colors
highlight NonText guibg=#000000
highlight SpecialKey guibg=#000000
