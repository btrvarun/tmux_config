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

"-------------------------------------------------
" => User Interface
"-------------------------------------------------

" Only have cursorline in current window and in normal window
set wildmenu " Show list instead of just completing
set wildmode=list:longest,full " Use powerful wildmenu
set shortmess=at " Avoids hit enter
set showcmd " Show cmd

set backspace=indent,eol,start " Make backspaces delete sensibly
set whichwrap+=h,l,<,>,[,] " Backspace and cursor keys wrap to
set virtualedit=block,onemore " Allow for cursor beyond last character
set scrolljump=5 " Lines to scroll when cursor leaves screen
set scrolloff=3 " Minimum lines to keep above and below cursor
set sidescroll=1 " Minimal number of columns to scroll horizontally
set sidescrolloff=10 " Minimal number of screen columns to keep away from cursor

set showmatch " Show matching brackets/parenthesis
set matchtime=2 " Decrease the time to blink

if g:ivim_show_number
    set number relativenumber" Show line numbers
    " Toggle relativenumber
    nnoremap <Leader>n :set relativenumber!<CR>
endif

set formatoptions+=rnlmM " Optimize format options
set wrap " Set wrap
set textwidth=80 " Change text width

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-------------------------------------------------
" => Colors and Fonts
"-------------------------------------------------

colorscheme desert
set background=dark

syntax on " Enable syntax

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-------------------------------------------------
" => Indent Related
"-------------------------------------------------

set autoindent " Preserve current indent on new lines
set cindent " set C style indent
set expandtab " Convert all tabs typed to spaces
set softtabstop=4 " Indentation levels every four columns
set shiftwidth=4 " Indent/outdent by four columns
set shiftround " Indent/outdent to nearest tabstop

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-------------------------------------------------
" => Search Related
"-------------------------------------------------

set ignorecase " Case insensitive search
set smartcase " Case sensitive when uc present
set hlsearch " Highlight search terms
set incsearch " Find as you type search
set gdefault " turn on g flag

" Use sane regexes
nnoremap / /\v
vnoremap / /\v
cnoremap s/ s/\v
nnoremap ? ?\v
vnoremap ? ?\v
cnoremap s? s?\v

" Use ,Space to toggle the highlight search
nnoremap <Leader><Space> :set hlsearch!<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-------------------------------------------------
" => Fold Related
"-------------------------------------------------

set foldlevelstart=0 " Start with all folds closed
set foldcolumn=1 " Set fold column

" Space to toggle and create folds.
nnoremap <silent> <Space> @=(foldlevel('.') ? 'za' : '\<Space>')<CR>
vnoremap <Space> zf

" Set foldtext
function! MyFoldText()
    let line=getline(v:foldstart)
    let nucolwidth=&foldcolumn+&number*&numberwidth
    let windowwidth=winwidth(0)-nucolwidth-3
    let foldedlinecount=v:foldend-v:foldstart+1
    let onetab=strpart('          ', 0, &tabstop)
    let line=substitute(line, '\t', onetab, 'g')
    let line=strpart(line, 0, windowwidth-2-len(foldedlinecount))
    let fillcharcount=windowwidth-len(line)-len(foldedlinecount)
    return line.'…'.repeat(' ',fillcharcount).foldedlinecount.'L'.' '
endfunction
set foldtext=MyFoldText()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-------------------------------------------------
" => Key Mapping
"-------------------------------------------------

" Make j and k work the way you expect
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Navigation between windows
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>

" Same when jumping around
nnoremap g; g;zz
nnoremap g, g,zz

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" Repeat last substitution, including flags, with &.
nnoremap & :&&<CR>
xnoremap & :&&<CR>

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" Select entire buffer
nnoremap vaa ggvGg_

" Strip all trailing whitespace in the current file
nnoremap <Leader>q :%s/\s\+$//<CR>:let @/=''<CR>

" Modify all the indents
nnoremap \= gg=G

" See the differences between the current buffer and the file it was loaded from
command! DiffOrig vert new | set bt=nofile | r ++edit # | 0d_
            \ | diffthis | wincmd p | diffthis

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"--------------------------------------------------
" => Plugin Setting
"--------------------------------------------------

" Setting for enhancement plugins
if count(g:ivim_bundle_groups, 'enhance')

    " -> delimitMate
    let delimitMate_expand_cr=1
    let delimitMate_expand_space=1
    let delimitMate_balance_matchpairs=1

    " -> Tcomment
    " Map \<Space> to commenting
    function! IsWhiteLine()
        if (getline('.')=~'^$')
            exe 'TCommentBlock'
            normal! j
        else
            normal! A   
            exe 'TCommentRight'
            normal! l
            normal! x
        endif
        startinsert!
    endfunction
    nnoremap <silent> <LocalLeader><Space> :call IsWhiteLine()<CR>

    " -> Undo tree
    nnoremap <Leader>u :UndotreeToggle<CR>
    let g:undotree_SetFocusWhenToggle=1

    " -> Easy Align
    xmap ga <Plug>(EasyAlign)
    nmap ga <Plug>(EasyAlign)

    " -> Splitjoin
    let g:splitjoin_split_mapping = ',s'
    let g:splitjoin_join_mapping  = ',j'
    let g:splitjoin_normalize_whitespace=1
    let g:splitjoin_align=1

    " -> Investigate.vim
    nnoremap K :call investigate#Investigate()<CR>
    let g:investigate_use_dash=1

endif

" setting for moving plugins
if count(g:ivim_bundle_groups, 'move')

    " -> Tag bar
    nnoremap <Leader>t :TagbarToggle<CR>
    let g:tagbar_autofocus=1
    let g:tagbar_expand=1
    let g:tagbar_foldlevel=2
    let g:tagbar_autoshowtag=1

    " Matchit
    " Start mathit
    packadd! matchit
    " Use Tab instead of % to switch
    nmap <Tab> %
    vmap <Tab> %

endif

" Setting for navigation plugins
if count(g:ivim_bundle_groups, 'navigate')

    " -> NERD Tree
    nnoremap <Leader>f :NERDTreeToggle<CR>
    let NERDTreeChDirMode=2
    let NERDTreeShowBookmarks=1
    let NERDTreeShowHidden=1
    let NERDTreeShowLineNumbers=1
    augroup nerd_loader
        autocmd!
        autocmd VimEnter * silent! autocmd! FileExplorer
        autocmd BufEnter,BufNew *
                    \  if isdirectory(expand('<amatch>'))
                    \|   call plug#load('nerdtree')
                    \|   execute 'autocmd! nerd_loader'
                    \| endif
    augroup END

endif


" Setting for compiling plugins
if count(g:ivim_bundle_groups, 'compile')

    " -> Syntastic
    let g:syntastic_check_on_open=1
    let g:syntastic_aggregate_errors=1
    let g:syntastic_auto_jump=1
    let g:syntastic_auto_loc_list=1

    " -> Singlecompile
    nnoremap <Leader>r :SingleCompileRun<CR>
    let g:SingleCompile_showquickfixiferror=1

endif

" Setting for language specificity
if count(g:ivim_bundle_groups, 'language')

    " -> Emmet
    let g:user_emmet_leader_key='<C-Z>'
    let g:user_emmet_settings={'indentation':'    '}
    let g:use_emmet_complete_tag=1

    " -> Polyglot
    let g:vim_markdown_conceal=0

endif

" Setting for django
let g:last_relative_dir = ''
nnoremap \1 :call RelatedFile ("models.py")<cr>
nnoremap \2 :call RelatedFile ("views.py")<cr>
nnoremap \3 :call RelatedFile ("urls.py")<cr>
nnoremap \4 :call RelatedFile ("admin.py")<cr>
nnoremap \5 :call RelatedFile ("tests.py")<cr>
nnoremap \6 :call RelatedFile ( "templates/" )<cr>
nnoremap \7 :call RelatedFile ( "templatetags/" )<cr>
nnoremap \8 :call RelatedFile ( "management/" )<cr>
nnoremap \0 :e settings.py<cr>
nnoremap \9 :e urls.py<cr>

fun! RelatedFile(file)
    #This is to check that the directory looks djangoish
    if filereadable(expand("%:h"). '/models.py') || isdirectory(expand("%:h") . "/templatetags/")
        exec "edit %:h/" . a:file
        let g:last_relative_dir = expand("%:h") . '/'
        return ''
    endif
    if g:last_relative_dir != ''
        exec "edit " . g:last_relative_dir . a:file
        return ''
    endif
    echo "Cant determine where relative file is : " . a:file
    return ''
endfun

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"--------------------------------------------------
" => Local Setting
"--------------------------------------------------

" Use local vimrc if available
if filereadable(expand($HOME . '/.vimrc.local'))
    source $HOME/.vimrc.local
endif

" Use local gvimrc if available and gui is running
if has('gui_running')
    if filereadable(expand($HOME . '/.gvimrc.local'))
        source $HOME/.gvimrc.local
    endif
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Custom Setting
"---------------------------------------------------------------

set mouse=a " Set mouse mode on
set clipboard=unnamedplus " Syncing clipboard
set pastetoggle=<leader>p " Toggle paste mode

