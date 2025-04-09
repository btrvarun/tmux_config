"       _       _
"      (_)   __(_)___ ___
"     / / | / / / __ `__ \
"    / /| |/ / / / / / / /
"   /_/ |___/_/_/ /_/ /_/
"
"   Main Contributor: Xiao-Ou Zhang (kepbod) <kepbod@gmail.com>
"   Version: 3.0
"   Created: 2012-01-20
"   Last Modified: 2016-12-29
"
"   Sections:
"     -> ivim Setting
"     -> General
"     -> Platform Specific Setting
"     -> Vim-plug
"     -> User Interface
"     -> Colors and Fonts
"     -> Indent Related
"     -> Search Related
"     -> Fold Related
"     -> Key Mapping
"     -> Plugin Setting
"     -> Local Setting
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"------------------------------------------------
" => ivim Setting
"------------------------------------------------

" ivim user setting
let g:ivim_user='Varun' " User name
let g:ivim_email='btr.varun93@gmail.com' " User email
" ivim ui setting
let g:ivim_show_number=1 " Enable showing number
" ivim plugin setting
let g:ivim_bundle_groups=['ui', 'enhance', 'move', 'navigate',
            \ 'compile', 'language']

" Customise ivim settings for personal usage
if filereadable(expand($HOME . '/.vimrc.ivim.local'))
    source $HOME/.vimrc.ivim.local
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"------------------------------------------------
" => General
"------------------------------------------------

set nocompatible " Get out of vi compatible mode
filetype plugin indent on " Enable filetype
let mapleader=',' " Change the mapleader
let maplocalleader='\' " Change the maplocalleader
set timeoutlen=500 " Time to wait for a command

" Source the vimrc file after saving it
autocmd BufWritePost $MYVIMRC source $MYVIMRC
" Fast edit the .vimrc file using ,x
nnoremap <Leader>x :tabedit $MYVIMRC<CR>

set autoread " Set autoread when a file is changed outside
set hidden " Turn on hidden"

set history=1000 " Increase the lines of history
set modeline " Turn on modeline
set encoding=utf-8 " Set utf-8 encoding
set completeopt+=longest " Optimize auto complete
set completeopt-=preview " Optimize auto complete

set undofile " Set undo

" Set directories
function! InitializeDirectories()
    let parent=$HOME
    let prefix='.vim'
    let dir_list={
                \ 'backup': 'backupdir',
                \ 'view': 'viewdir',
                \ 'swap': 'directory',
                \ 'undo': 'undodir',
                \ 'cache': '',
                \ 'session': ''}
    for [dirname, settingname] in items(dir_list)
        let directory=parent.'/'.prefix.'/'.dirname.'/'
        if !isdirectory(directory)
            if exists('*mkdir')
                let dir = substitute(directory, "/$", "", "")
                call mkdir(dir, 'p')
            else
                echo 'Warning: Unable to create directory: '.directory
            endif
        endif
        if settingname!=''
            exe 'set '.settingname.'='.directory
        endif
    endfor
endfunction
call InitializeDirectories()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-------------------------------------------------
" => Platform Specific Setting
"-------------------------------------------------

" On Windows, also use .vim instead of vimfiles
if has('win32') || has('win64')
    set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif

set viewoptions+=slash,unix " Better Unix/Windows compatibility
set viewoptions-=options " in case of mapping change

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"--------------------------------------------------
" => Vim-plug
"--------------------------------------------------

if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')

if count(g:ivim_bundle_groups, 'ui') " UI setting
    Plug 'Yggdroot/indentLine' " Indentation level
    Plug 'bling/vim-bufferline' " Buffer line
    Plug 'mhinz/vim-startify' " Start page
    Plug 'junegunn/goyo.vim', { 'for': 'markdown' } " Distraction-free
    Plug 'junegunn/limelight.vim', { 'for': 'markdown' } " Hyperfocus-writing
endif

if count(g:ivim_bundle_groups, 'enhance') " Vim enhancement
    Plug 'Raimondi/delimitMate' " Closing of quotes
    Plug 'tomtom/tcomment_vim' " Commenter
    Plug 'tpope/vim-abolish' " Abolish
    Plug 'tpope/vim-speeddating' " Speed dating
    Plug 'tpope/vim-repeat' " Repeat
    Plug 'terryma/vim-multiple-cursors' " Multiple cursors
    Plug 'junegunn/vim-slash' " In-buffer search
    Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' } " Undo tree
    Plug 'tpope/vim-surround' " Surround
    Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] } " Easy align
    Plug 'AndrewRadev/splitjoin.vim' " Splitjoin
    Plug 'sickill/vim-pasta' " Vim pasta
    Plug 'Keithbsmiley/investigate.vim' " Helper
    Plug 'wikitopian/hardmode' " Hard mode
    Plug 'wellle/targets.vim' " Text objects
    Plug 'roman/golden-ratio' " Resize windows
    Plug 'chrisbra/vim-diff-enhanced' " Create better diffs
endif

if count(g:ivim_bundle_groups, 'move') " Moving
    Plug 'tpope/vim-unimpaired' " Pairs of mappings
    Plug 'Lokaltog/vim-easymotion' " Easy motion
    Plug 'kepbod/quick-scope' " Quick scope
    Plug 'yuttie/comfortable-motion.vim' " Comfortable motion
    Plug 'bkad/CamelCaseMotion' " Camel case motion
    Plug 'majutsushi/tagbar' " Tag bar
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  } " Fuzzy finder
    Plug 'junegunn/fzf.vim' " Fuzzy finder plugin
endif

if count(g:ivim_bundle_groups, 'navigate') " Navigation
    Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' } " NERD tree
    Plug 'mhinz/vim-tmuxify' " Tmux panes
    Plug 'gmarik/Vundle.vim' " Vundle
    Plug 'christoomey/vim-tmux-navigator' " Make navigation between tmux and vim easier
endif

if count(g:ivim_bundle_groups, 'compile') " Compiling
    Plug 'scrooloose/syntastic' " Syntax checking
    Plug 'xuhdev/SingleCompile' " Single compile
endif

if count(g:ivim_bundle_groups, 'language') " Language Specificity
    Plug 'davidhalter/jedi-vim', { 'for': 'python' } " Python jedi plugin
    Plug 'fatih/vim-go', { 'for': 'go' } " Golang
    Plug 'tpope/vim-rails', { 'for': [] } " Rails
    Plug 'mattn/emmet-vim', { 'for': ['html', 'css'] } " Emmet
    Plug 'LaTeX-Box-Team/LaTeX-Box' " LaTex
    Plug 'sheerun/vim-polyglot' " Language Support
endif

if filereadable(expand($HOME . '/.vimrc.bundles.local')) " Load local bundles
    source $HOME/.vimrc.bundles.local
endif

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

