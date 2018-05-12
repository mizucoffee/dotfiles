syntax on

set number
set title
set ambiwidth=double
set tabstop=2
set expandtab
set shiftwidth=2
set smartindent
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
set nrformats-=octal
set backspace=indent,eol,start
set hidden
set whichwrap=b,s,<,>,[,],,~

set showmatch
set showmode
set ruler
set pumheight=10
set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf8
set nowrap
set laststatus=2
set statusline=%F%r%h%=
set nocompatible
set noswapfile
set clipboard^=unnamedplus

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

noremap <C-K><C-K> :source ~/.vimrc <CR>
map     <C-n>      :NERDTreeToggle  <CR>
" autocmd BufNewFile *.html 0r $XDG_CONFIG_HOME/nvim/.vim/template/html.txt
autocmd BufRead,BufNewFile *.ejs set filetype=html

let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_auto_select = 1
let g:auto_save = 1

if &compatible
  set nocompatible
endif
set runtimepath^=$XDG_CONFIG_HOME/nvim/.vim/dein/repos/github.com/Shougo/dein.vim/

call dein#begin(expand('$XDG_CONFIG_HOME/nvim/.vim/plugins/'))

" call dein#add($XDG_CONFIG_HOME/nvim/.vim/dein/repos/github.com/Shougo/dein.vim/)
call dein#add('Shougo/deoplete.nvim')
call dein#add('Shougo/neomru.vim')
call dein#add('Shougo/neosnippet')
call dein#add('scrooloose/nerdtree')
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
call dein#add('dracula/vim')

if !has('nvim')
  call dein#add('roxma/nvim-yarp')
  call dein#add('roxma/vim-hug-neovim-rpc')
endif

call dein#end()
filetype plugin indent on

color dracula
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

let g:deoplete#enable_at_startup = 1
"inoremap <expr><BS> deplete#smart_close_popup()."<C-h>"

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

