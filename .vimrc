""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use Vim settings, rather than Vi settings (usually better).
" This must be first, because it changes other options as a side effect.
set nocompatible

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tabstop=4 expandtab
colorscheme desert

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif

" Add a highlight group to look out for trailing whitespace.
" Thanks to: http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight TrailingWhitespace ctermbg=red guibg=red
autocmd colorscheme * highlight TrailingWhitespace ctermbg=red guibg=red
2match TrailingWhitespace /\s\+$/
" Explanation of the following: whitespace: \s , one or more: \+ ,
"   current cursor position: \%# , negate: \@<! , end of line: $
autocmd InsertEnter * 2match TrailingWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * 2match TrailingWhitespace /\s\+$/
autocmd BufWinEnter * 2match TrailingWhitespace /\s\+$/
" The following apparently avoids a memory leak.
autocmd BufWinLeave * call clearmatches()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn off text wrapping.
set nowrap

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Adjust the '>' command.
set shiftwidth=4

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable folding.
set foldmethod=marker

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Treat .md files like plain text files.
au BufNewFile,BufRead *.md setlocal ft=""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Treat glossary files like TeX files.
au BufNewFile,BufRead *.glo setlocal ft=tex

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set the folding for Python files
au  BufNewFile,BufRead *.py setlocal foldmethod=indent foldnestmax=2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set the maximum line length.
set textwidth=79

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the limit on the line length for select file types.
autocmd FileType tex setlocal textwidth=0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Replace tabs with only two spaces in html and shell script files.
autocmd FileType bib,html,sh,css,tex setlocal tabstop=2 shiftwidth=2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable ftplugin
filetype plugin on
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Prevent the commands `J` and `gq` from inserting an extra space after each
" period.
set nojoinspaces
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Wrap text with the command `gq' while maintaining the indentation.
set autoindent
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Display the row and column number.
set ruler
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Display the line number on the left side.
set number
