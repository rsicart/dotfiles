execute pathogen#infect()
set number
syntax on
filetype indent plugin on
set tabstop=4
set softtabstop=4
set shiftwidth=4
set mouse=a
set t_Co=256
set background=dark
set autoindent
set hlsearch
set ignorecase
set undofile
set undodir=~/.vim/undo
set wildmode=list:longest,list:full
set wildmenu
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/,CVS*,*.pyc
set wrap

autocmd FileType php abbr dlv {<CR>$locals = get_defined_vars();<CR>
            \$buffers = array(); while(ob_get_level()) $buffers[] = ob_get_clean();<CR>
            \$buffers = array_filter($buffers) ?: null;<CR>
            \header('Content-Type: text/html; charset=UTF-8');<CR>
            \var_dump(array_keys($locals), compact(array_keys($locals)), compact('buffers'));<CR>
            \function_exists('xdebug_print_function_stack') AND xdebug_print_function_stack();<CR>
            \die();<CR>}<ESC>>aB
