" General "{{{
set nocompatible               " be iMproved

scriptencoding utf-8           " utf-8 all the way
set encoding=utf-8

set history=256                " Number of things to remember in history.
set timeoutlen=250             " Time to wait after ESC (default causes an annoying delay)
set clipboard+=unnamed         " Yanks go on clipboard instead.
set pastetoggle=<F10>          " toggle between paste and normal: for 'safer' pasting from keyboard
set shiftround                 " round indent to multiple of 'shiftwidth'
set tags=.git/tags;$HOME       " consider the repo tags first, then
                               " walk directory tree upto $HOME looking for tags
                               " note `;` sets the stop folder. :h file-search

set modeline
set modelines=5                " default numbers of lines to read for modeline instructions

set autowrite                  " Writes on make/shell commands
set autoread

set nobackup
set nowritebackup
set directory=/tmp//           " prepend(^=) $HOME/.tmp/ to default path; use full path as backup filename(//)
set noswapfile                 "

set hidden                     " The current buffer can be put to the background without writing to disk

set hlsearch                   " highlight search
set ignorecase                 " be case insensitive when searching
set smartcase                  " be case sensitive when input has a capital letter
set incsearch                  " show matches while typing

let g:is_posix = 1             " vim's default is archaic bourne shell, bring it up to the 90s
let mapleader = ','
let maplocalleader = '	'      " Tab as a local leader
let g:netrw_banner = 0         " do not show Netrw help banner
" "}}}

" Formatting "{{{
set fo+=o                      " Automatically insert the current comment leader after hitting 'o' or 'O' in Normal mode.
set fo-=r                      " Do not automatically insert a comment leader after an enter
set fo-=t                      " Do no auto-wrap text using textwidth (does not apply to comments)

set nowrap
set textwidth=0                " Don't wrap lines by default

set tabstop=2                  " tab size eql 2 spaces
set softtabstop=2
set shiftwidth=2               " default shift width for indents
set expandtab                  " replace tabs with ${tabstop} spaces
set smarttab                   "

set backspace=indent
set backspace+=eol
set backspace+=start

set autoindent
set cindent
set indentkeys-=0#            " do not break indent on #
set cinkeys-=0#
set cinoptions=:s,ps,ts,cs
set cinwords=if,else,while,do
set cinwords+=for,switch,case
" "}}}

" Visual "{{{
syntax on                      " enable syntax

" set synmaxcol=250            " limit syntax highlighting to 128 columns

set mouse=a                   "enable mouse in GUI mode
set mousehide                 " Hide mouse after chars typed

set nonumber                  " line numbers Off
set showmatch                 " Show matching brackets.
set matchtime=2               " Bracket blinking.

set wildmode=longest,list     " At command line, complete longest common string, then list alternatives.

set completeopt-=preview      " disable auto opening preview window

set novisualbell              " No blinking
set noerrorbells              " No noise.
set vb t_vb=                  " disable any beeps or flashes on error

set laststatus=2              " always show status line.
set shortmess=atI             " shortens messages
set showcmd                   " display an incomplete command in statusline

set statusline=%<%f\          " custom statusline
set stl+=[%{&ff}]             " show fileformat
set stl+=%y%m%r%=
set stl+=%-14.(%l,%c%V%)\ %P


set foldenable                " Turn on folding
set foldmethod=marker         " Fold on the marker
set foldlevel=100             " Don't autofold anything (but I can still fold manually)

set foldopen=block,hor,tag    " what movements open folds
set foldopen+=percent,mark
set foldopen+=quickfix

set virtualedit=block

set splitbelow
set splitright

set list                      " display unprintable characters f12 - switches
set listchars=tab:\ ·,eol:¬
set listchars+=trail:·
set listchars+=extends:»,precedes:«
map <silent> <F12> :set invlist<CR>

" let g:molokai_original = 1

if has('gui_running')
  set guioptions=cMg " console dialogs, do not show menu and toolbar

  " Fonts
  " :set guifont=* " to launch a GUI dialog
  if has('mac')
  set guifont=Andale\ Mono:h14
  else
  set guifont=Terminus:h16
  end

  if has('mac')
  set noantialias
  " set fullscreen
  set fuoptions=maxvert,maxhorz ",background:#00AAaaaa
  endif
endif
" "}}}

" Key mappings " {{{
" Duplication
nnoremap <leader>c mz"dyy"dp`z
vnoremap <leader>c "dymz"dP`z

nnoremap <leader>rs :source ~/.vimrc<CR>
nnoremap <leader>rt :tabnew ~/.vim/vimrc<CR>
nnoremap <leader>re :e ~/.vim/vimrc<CR>
nnoremap <leader>rd :e ~/.vim/ <CR>
nnoremap <leader>rc :silent ! cd ~/.vim/ && git commit ~/.vim/vimrc -v <CR>

" Tabs
nnoremap <M-h> :tabprev<CR>
nnoremap <M-l> :tabnext<CR>

" Buffers
nnoremap <localleader>- :bd<CR>
nnoremap <localleader>-- :bd!<CR>
" Split line(opposite to S-J joining line)
nnoremap <C-J> gEa<CR><ESC>ew

" map <silent> <C-W>v :vnew<CR>
" map <silent> <C-W>s :snew<CR>

" copy filename
map <silent> <leader>. :let @+=expand('%:p').':'.line('.')<CR>
map <silent> <leader>/ :let @+=expand('%:p:h')<CR>
" copy path


map <S-CR> A<CR><ESC>

map <leader>E :Explore<CR>
map <leader>EE :Vexplore!<CR><C-W>=

" toggle search highlighting
nnoremap <silent> <space> :let &hls=1-&hls<cr>

" Make Control-direction switch between windows (like C-W h, etc)
nmap <silent> <C-k> <C-W><C-k>
nmap <silent> <C-j> <C-W><C-j>
nmap <silent> <C-h> <C-W><C-h>
nmap <silent> <C-l> <C-W><C-l>

  " vertical paragraph-movement
nmap <C-K> {
nmap <C-J> }

" vertical split with fuzzy-searcher
nnoremap <leader>v :exec ':vnew \| CtrlP'<CR>
" and without
nnoremap <leader>V :vnew<CR>

" when pasting copy pasted text back to 
" buffer instead replacing with owerride
xnoremap p pgvy

if has('mac')

  if has('gui_running')
    set macmeta
  end

" map(range(1,9), 'exec "imap <D-".v:val."> <C-o>".v:val."gt"')
" map(range(1,9), 'exec " map <D-".v:val."> ".v:val."gt"')

" Copy whole line
nnoremap <silent> <D-c> yy

" close/delete buffer when closing window
map <silent> <D-w> :bdelete<CR>
endif

" Control+S and Control+Q are flow-control characters: disable them in your terminal settings.
" $ stty -ixon -ixoff
noremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR>
"
" generate HTML version current buffer using current color scheme
map <leader>2h :runtime! syntax/2html.vim<CR>

" " }}}

" AutoCommands " {{{
au BufRead,BufNewFile {*.go}                                          setl ft=go tabstop=2 softtabstop=2 noexpandtab smarttab
au BufRead,BufNewFile {*.coffee}                                      setl ft=coffee tabstop=2 softtabstop=2 expandtab smarttab
au BufRead,BufNewFile {Gemfile,Rakefile,*.rake,config.ru,*.rabl}      setl ft=ruby tabstop=2 softtabstop=2 shiftwidth=2 expandtab smarttab
au BufRead,BufNewFile {*.local}                                       setl ft=sh
au BufRead,BufNewFile {*.md,*.mkd,*.markdown}                         setl ft=markdown
au BufRead,BufNewFile {*.scala}                                       setl ft=scala
au! BufReadPost       {COMMIT_EDITMSG,*/COMMIT_EDITMSG}               exec 'setl ft=gitcommit noml list spell' | norm 1G
au! BufWritePost      {*.snippet,*.snippets}                          call ReloadAllSnippets()

" open help in vertical split
" au BufWinEnter {*.txt} if 'help' == &ft | wincmd H | nmap q :q<CR> | endif
" " }}}

" Scripts and Plugins " {{{
" auto install Vunde if not found, for fresh install.
" @see http://erikzaadi.com/2012/03/19/auto-installing-vundle-from-your-vimrc/
let iCanHazVundle=0
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle...\n"
    silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
    let iCanHazVundle=1
endif

filetype off
" runtime macros/matchit.vim
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" supertab
" @see https://github.com/ervandew/supertab
" @see http://vim.wikia.com/wiki/Omni_completion_popup_menu
Plugin 'ervandew/supertab'
let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
let g:SuperTabDefaultCompletionType = "context"

" Vim GO
" Plugin 'fatih/vim-go'
Plugin 'fatih/vim-go'
" Commands
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
au FileType go nmap <Leader>gb <Plug>(go-doc-browser)
au FileType go nmap <Leader>s <Plug>(go-implements)
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>e <Plug>(go-rename)
" syntax-highlighting for Functions, Methods and Structs
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
" goimports to automatically insert import paths instead of gofmt
" let g:go_fmt_command = "goimports"
" vim-go shows errors for the fmt command, to disable it
" let g:go_fmt_fail_silently = 1
" Disable auto fmt on save
" let g:go_fmt_autosave = 0
" Disable opening browser after posting your snippet to play.golang.org
" let g:go_play_open_browser = 0

" NeoComplete
Plugin 'Shougo/neocomplete.vim'
let g:neocomplete#enable_at_startup = 1

" UtilSnips
Plugin 'SirVer/ultisnips'

" Go-Explorer
Plugin 'garyburd/go-explorer'

" Vim-Markdown
Plugin 'tpope/vim-markdown'
Plugin 'timcharper/textile.vim'

" vundle
" @see https://github.com/gmarik/Vundle.vim
" let Vundle manage Vundle, required
"
" install bundle
" - launch vim and run :BundleInstall
" - from command line: vim +BundleInstall +qall
"
Plugin 'VundleVim/Vundle.vim'
" Bundle 'gmarik/vundle'

" vim-jason
Plugin 'elzr/vim-json'

" vim-flake8
" @see https://github.com/nvie/vim-flake8
" sudo pip install flake8
"
Plugin 'nvie/vim-flake8'
autocmd BufWritePost *.py call Flake8()

" nerdtree
" @see https://github.com/scrooloose/nerdtree
"
Plugin 'scrooloose/nerdtree.git'
" nmap <leader>nn :NERDTreeToggle<CR>
nmap <F2> :NERDTreeToggle<CR>

" vim-airline
" @see https://github.com/bling/vim-airline
" @see https://powerline.readthedocs.org/en/latest/installation/linux.html#font-installation
"
Plugin 'bling/vim-airline'
let g:airline_powerline_fonts = 1
"set guifont=Ubuntu\ Mono\ 12
set ruler
set nocompatible   " Disable vi-compatibility
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show unicode glyphs
set t_Co=256       " Tell terminal your console support 256 colors

" conque-shell
" @see https://github.com/oplatek/Conque-Shell
" Short to lauch several conque term tabs
"
Plugin 'oplatek/Conque-Shell'
nnoremap <leader>bb :ConqueTermTab bash<CR>
nnoremap <leader>pp :ConqueTermTab psql -U kianmeng<CR>
nnoremap <leader>mm :ConqueTermTab mysql -u root -p<CR>

" tagbar
" @see https://github.com/majutsushi/tagbar
"
" works for python
"
Plugin 'majutsushi/tagbar'
nmap <F8> :TagbarToggle<CR>

" add support for markdown files in tagbar.
" @see http://github.com/jszakmeister/markdown2ctags
let g:tagbar_type_markdown = {
    \ 'ctagstype': 'markdown',
    \ 'ctagsbin' : '~/bin/markdown2ctags.py',
    \ 'ctagsargs' : '-f - --sort=yes',
    \ 'kinds' : [
        \ 's:sections',
        \ 'i:images'
    \ ],
    \ 'sro' : '|',
    \ 'kind2scope' : {
        \ 's' : 'section',
    \ },
    \ 'sort': 0,
\ }

" groovy
let g:tagbar_type_groovy = {
    \ 'ctagstype' : 'groovy',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'c:class',
        \ 'i:interface',
        \ 'f:function',
        \ 'v:variables',
    \ ]
\ }

" syntastic
" @see https://github.com/scrooloose/syntastic
" @see http://pear.phpmd.org
"
" Python
" sudo apt-get install pylint
"
" PHP
" sudo apt-get install php-pear
"
" sudo pear install PHP_CodeSniffer
"
" sudo pear channel-discover pear.phpmd.org
" sudo pear channel-discover pear.pdepend.org
" sudo pear install pear.pdepend.org/PHP_Depend
" sudo pear install phpmd/PHP_PMD
"
Plugin 'scrooloose/syntastic.git'
" overwrite by vim-flake8 plugin
let g:syntastic_python_checkers = ['pylint', 'flake8']
let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']

Plugin 'taglist.vim'
" taglist
"
" the ; search for tags file from current directory till parent directory
" resursively until it finds a tags file
"
" works for php
"
" sudo apt-get install exuberant-ctags
"
set tags=tags;
nmap <leader>t :TlistToggle<CR>
nmap <leader>f <C-]>
nmap <leader>g <C-T>
nmap <leader>gt :!/usr/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" ----
"  vim-hackernews
" @see https://github.com/ryanss/vim-hackernews
Plugin 'ryanss/vim-hackernews'
" ----

" ----
" nimrod
" syntax file for Nim programming language
" @see https://github.com/zah/nimrod.vim/
Plugin 'zah/nimrod.vim'
" ----

" ----
"  rainbow parentheses
"  @see https://github.com/kien/rainbow_parentheses.vim
Plugin 'kien/rainbow_parentheses.vim'
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
" ----

" ----
" vim bundle for racket lang
" @see https://github.com/wlangstroth/vim-racket
Plugin 'wlangstroth/vim-racket'
" ----

" ----
" vim bundle for vim-mkdir
" @see https://github.com/pbrisbin/vim-mkdir
Plugin 'pbrisbin/vim-mkdir'
" ----

" ----
" Fuzzy file, buffer, mru, tag, etc finder.
" @see https://github.com/kien/ctrlp.vim
Plugin 'kien/ctrlp.vim'
nmap <leader>o :CtrlP<CR>
" ----

" ----
" Vim plugins for Drupal
" @see https://www.drupal.org/node/1389448#vundle
Plugin 'git://drupalcode.org/project/vimrc.git', {'rtp': 'bundle/vim-plugin-for-drupal/'}
" ----

" ----
" No more :set paste !!!
Plugin 'ConradIrwin/vim-bracketed-paste'
" ----
"
" Vim plugin for git
" see https://github.com/tpope/vim-fugitive
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-git'

nnoremap <leader>W :Gwrite<CR>
nnoremap <leader>C :Gcommit -v<CR>
nnoremap <leader>S :Gstatus \| 7<CR>
inoremap <leader>W <Esc><leader>W
inoremap <leader>C <Esc><leader>C
inoremap <leader>S <Esc><leader>S

" Vim plugin for ruby
" see https://github.com/vim-ruby/vim-ruby
Plugin 'vim-ruby/vim-ruby'

" Vim plugin for bundler
" see https://github.com/tpope/vim-bundler.git
Plugin 'tpope/vim-bundler.git'

" VimWiki from http://vimwiki.github.io
Plugin 'vimwiki/vimwiki'

" Colorscheme
Plugin 'fatih/molokai'
colorscheme molokai
let g:molokai_original = 1

" Plugin vim-yaml
Plugin 'stephpy/vim-yaml'

filetype plugin indent on      " Automatically detect file types.

" " }}}
