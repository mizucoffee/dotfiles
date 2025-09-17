let s:dein_dir = expand('$XDG_CONFIG_HOME/nvim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let s:toml_dir = expand('$XDG_CONFIG_HOME/nvim/toml')
  call dein#load_toml(s:toml_dir . '/dein.toml', {'lazy': 0})
  call dein#load_toml(s:toml_dir . '/dein_lazy.toml', {'lazy': 1})

  call dein#add('scrooloose/syntastic')
  call dein#add('lilydjwg/colorizer')
  call dein#add('vim-scripts/vim-auto-save')
  call dein#add('itchyny/lightline.vim')
  call dein#add('bronson/vim-trailing-whitespace')
  call dein#add('Yggdroot/indentLine')
  call dein#add('Shougo/neosnippet')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('dracula/vim')
  call dein#add('leafgarland/typescript-vim')
  call dein#add('digitaltoad/vim-pug')
  call dein#add('elzr/vim-json')
  call dein#add('mizucoffee/vim-sus')
  call dein#add('vim-syntastic/syntastic')
  call dein#add('januswel/prettier.vim')
  call dein#add('udalov/kotlin-vim')
  call dein#add('hashivim/vim-terraform')

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

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

autocmd BufRead,BufNewFile *.ejs set filetype=html

set conceallevel=0
let g:vim_json_syntax_conceal = 0

" ESLint configuration
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_javascript_checkers = ['eslint']

let g:syntastic_error_symbol = 'e'
let g:syntastic_style_error_symbol = 'se'
let g:syntastic_warning_symbol = 'sw'
let g:syntastic_style_warning_symbol = 'w'

highlight link SyntasticErrorSign SignColumn
highlight link SyntasticWarningSign SignColumn
highlight link SyntasticStyleErrorSign SignColumn
highlight link SyntasticStyleWarningSign SignColumn

filetype plugin indent on
color dracula
syntax enable

let g:deoplete#enable_at_startup = 1





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

"inoremap <expr><BS> deplete#smart_close_popup()."<C-h>"

imap <expr><CR> neosnippet#expandable() ? "<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "<C-y>" : "<CR>"
imap <expr><TAB> pumvisible() ? "<C-n>" : neosnippet#jumpable() ? "<Plug>(neosnippet_expand_or_jump)" : "<TAB>"


set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"let g:auto_save = 1

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:vim_json_syntax_conceal = 0
let g:syntastic_enable_signs = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1

let g:syntastic_javascript_checkers=['eslint']
let g:syntastic_mode_map = { 'mode': 'active',
      \ 'active_filetypes': ['javascript'],
      \ 'passive_filetypes': [] }

