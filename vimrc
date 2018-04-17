set nocompatible              " be iMproved, required
filetype off                  " required


" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle/
"set rtp+=/usr/local/opt/fzf

call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"let path = '~/some/path/here'
"call vundle#rc(path)

" let Vundle manage Vundle, required
Plugin 'gmarik/vundle'

" The following are examples of different formats supported.
" Keep Plugin commands between here and filetype plugin indent on.
" scripts on GitHub repos
Plugin 'tpope/vim-fugitive'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'tpope/vim-rails.git'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" scripts from http://vim-scripts.org/vim/scripts.html
"Plugin 'vim-scripts/L9'
"Plugin 'vim-scripts/FuzzyFinder'
Plugin 'scrooloose/nerdtree'
Plugin 'L9'
Plugin 'FuzzyFinder'
" scripts not on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'

Plugin 'tmhedberg/SimpylFold'
let g:SimpylFold_docstring_preview=1


Plugin 'vim-scripts/indentpython.vim'

set encoding=utf-8

"Plugin 'Valloric/YouCompleteMe'

let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

Plugin 'vim-syntastic/syntastic'

Plugin 'nvie/vim-flake8'

let python_highlight_all=1
syntax on

Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'

Plugin 'jistr/vim-nerdtree-tabs'

let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

call vundle#end()


filetype plugin indent on     " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Plugin commands are not allowed.
" Put your stuff after this line



" options settings ---------------------- {{{

set splitbelow
set splitright

"split navigations
nnoremap , <C-W><C-W>

" Enable folding
set foldmethod=indent
set foldlevel=99

set nu
set numberwidth=6
set relativenumber
set ruler
set showcmd
set autoindent
set list
set listchars=tab:>-,trail:~
syntax enable

" }}}


" keys mapping ---------------------- {{{

nnoremap ;; <c-f>
nnoremap ;j <c-d>
nnoremap ;k <c-u>
nnoremap ;h ^
nnoremap ;l $

nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel

nnoremap <leader>gr :silent exe "grep -R " . shellescape(expand("<cWORD>")) . " ."<cr>:copen<cr><c-l>

nnoremap <leader>go :set operatorfunc=<SID>GrepOperator<cr>g@
vnoremap <leader>go :<c-u>call <SID>GrepOperator(visualmode())<cr><c-l>

function! s:GrepOperator(type)
    let saved_unnamed_register = @@

    if a:type ==# 'v'
        normal! `<v`>y
    elseif a:type ==# 'char'
        normal! `[v`]y
    else
        return
    endif

    silent execute "grep! -R " . shellescape(@@) . " ."
    copen

    let @@ = saved_unnamed_register
endfunction

nnoremap <leader>gq :call QuickfixToggle()<cr>
let g:quickfix_is_open = 0
function! QuickfixToggle()
    if g:quickfix_is_open
        cclose
        let g:quickfix_is_open = 0
        execute g:quickfix_return_to_window . "wincmd w"
    else
        let g:quickfix_return_to_window = winnr()
        copen
        let g:quickfix_is_open = 1
    endif
endfunction

nnoremap <leader>gf :call FoldColumnToggle()<cr>
function! FoldColumnToggle()
    if &foldcolumn
            setlocal foldcolumn=0
    else
            setlocal foldcolumn=4
    endif
endfunction

nnoremap <leader>q :call QuickfixToggle()<cr>

" }}}


" Autocmd ---------------------- {{{
autocmd FileType javascript nnoremap <buffer> <localleader>c I//<esc>
autocmd FileType python nnoremap <buffer> <localleader>c I#<esc>

augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

set clipboard=unnamed

