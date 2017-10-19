execute pathogen#infect()
set relativenumber              " line numbers
syntax on                       " highlight syntax
colorscheme pablo
filetype plugin indent on
set nosmartindent		" smart autoindenting when starting a new line
set noautoindent		" copy indent from current line when starting new line
set tabstop=4                   " number of visual spaces per TAB
set softtabstop=4               " number of spaces in tab when editing
set shiftwidth=4
set noexpandtab			" tabs are spaces
set mouse=a
set t_Co=256
set background=dark
set hlsearch
set ignorecase
set undofile
set undodir=~/.vim/undo
set wildmode=list:longest,list:full
set wildmenu                    " visual autocomplete for command menu
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/,CVS*,*.pyc
set wrap
set showcmd                     " show command in bottom bar
set cursorline                  " highlight current line
set lazyredraw                  " redraw window only when needed
set showmatch                   " hilight matching parentheses and similar symbols

"
" mappings
"
vnoremap // y/<C-R>"<CR>        " search for visual selected text


"
" Example mappings
"

" html skel mapping for normal mode only
nnoremap Html i<html><CR><TAB><head><CR><TAB></head><CR><TAB><body><CR><TAB></body><CR></html><C-ESC>

" html skel command example 1 (with function)
command! -nargs=0 Html call PrintHtmlTemplate()
function! PrintHtmlTemplate()
    read !echo "<html>\n\t<head>\n\t</head>\n\t<body>\n\t</body>\n</html>"
endfunction

" html skel command example 2 (oneliner)
command! -nargs=0 Html read !echo "<html>\n\t<head>\n\t</head>\n\t<body>\n\t</body>\n</html>"
