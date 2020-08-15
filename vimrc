
"Allow vim to use system clipboard
xnoremap "+y y:call system("wl-copy", @")<cr>
noremap "+p :let @"=substitute(system("wl-paste --no-newline"), '<C-v><C-m>', '', 'g')<cr>p
noremap "*p :let @"=substitute(system("wl-paste --no-newline --primary"), '<C-v><C-m>', '', 'g')<cr>p
nmap <F8> :TagbarToggle<cr>

let python_highlight_all=1
syntax on

let g:termdebug_popup = 0
let g:termdebug_wide = 163

"Set the new split directions
set splitbelow
set splitright

set number

"set foldmethod=indent
"set foldlevel=99

"set autoindent
"set fileformat=unix
"set expandtab
"set tabstop=4
"set softtabstop=4
"set shiftwidth=4

set exrc
set secure

set hlsearch

"autocmd Filetype cpp,hpp setlocal tabstop=2 softtabstop=2 shiftwidth=2

"autocmd BufWritePre *.py execute ':Black'
"autocmd BufWritePre *.js execute ':Prettier'
"autocmd BufWritePre *.cpp,*hpp execute ':ClangFormat'


call plug#begin('~/.vim/plugged')

Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --clang-completer' }
Plug 'vim-syntastic/syntastic'
Plug 'psf/black'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'
Plug 'prettier/vim-prettier'
Plug 'morhetz/gruvbox'
Plug 'rhysd/vim-clang-format'
Plug 'majutsushi/tagbar'
Plug 'jiangmiao/auto-pairs'

call plug#end()

let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_auto_trigger=1
let g:ycm_max_num_candidates=10
let g:ycm_semantic_triggers = {'cpp': ['re![a-zA-Z]+']}

"Settings for syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_cpp_check_header = 1
let g:syntastic_python_pylint_args = "--load-plugins=pylint_django"
let g:syntastic_cpp_checkers = ['clang_check']

let g:airline_theme='murmur'
let g:airline_powerline_fonts = 1

colorscheme gruvbox
set background=dark

"Enables powerline for one window
set laststatus=2

let g:AutoPairsCenterLine=0
