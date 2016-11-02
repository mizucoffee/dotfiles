syntax on

set number
set title
set ambiwidth=double
set tabstop=2
set expandtab
set shiftwidth=2
set smartindent
set nolist
set hidden
set backspace=indent,eol,start
set showmatch

set showmode
set ruler
set pumheight=10
set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf8
set nowrap
"set whichwrap=b,s,[,],,~
set laststatus=2
set statusline=%F%r%h%=
set nocompatible
set noswapfile

set nohlsearch
set incsearch
set hlsearch

set showcmd
set scrolloff=5
set wildmenu wildmode=list:full
set cursorline

set wrapscan
set wildignorecase
set endofline
set whichwrap=b,s,<,>,[,],,~

noremap <C-K><C-K> :source ~/.vimrc <CR>
map     <C-n>      :NERDTreeToggle  <CR>
autocmd BufNewFile *.html 0r $HOME/.vim/template/html.txt

let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_auto_select = 1
let g:auto_save = 1

if &compatible
  set nocompatible
endif
set runtimepath^=~/.vim/dein/repos/github.com/Shougo/dein.vim/

call dein#begin(expand('~/.vim/plugins/'))

" call dein#add(~/.vim/dein/repos/github.com/Shougo/dein.vim/)
call dein#add('Shougo/neocomplete.vim')
call dein#add('scrooloose/nerdtree')
call dein#add('Shougo/neomru.vim')
call dein#add('Shougo/neosnippet')
call dein#add('mattn/emmet-vim')
call dein#add('tpope/vim-surround')
call dein#add('scrooloose/syntastic')
call dein#add('lilydjwg/colorizer')
call dein#add('vim-scripts/vim-auto-save')
call dein#add('itchyny/lightline.vim')
call dein#add('bronson/vim-trailing-whitespace')
call dein#add('Yggdroot/indentLine')
call dein#add('Shougo/neosnippet')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('scrooloose/syntastic')

call dein#end()
filetype plugin indent on

if dein#check_install()
  call dein#install()
endif

if &term =~ "xterm"
    let &t_SI .= "\e[?2004h"
    let &t_EI .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif

let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#min_keyword_length = 3
let g:neocomplete#enable_auto_delimiter = 1
let g:neocomplete#auto_completion_start_length = 1
inoremap <expr><BS> neocomplete#smart_close_popup()."<C-h>"

imap <expr><CR> neosnippet#expandable() ? "<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "<C-y>" : "<CR>"
imap <expr><TAB> pumvisible() ? "<C-n>" : neosnippet#jumpable() ? "<Plug>(neosnippet_expand_or_jump)" : "<TAB>"

let g:syntastic_enable_signs = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1

let g:syntastic_javascript_checkers=['eslint']
let g:syntastic_mode_map = { 'mode': 'passive',
                           \ 'active_filetypes': ['javascript'],
                           \ 'passive_filetypes': [] }
