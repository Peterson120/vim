set nocompatible
filetype off
:au BufNewFile 	*.java 0r ~/.vim/templates/skeleton.java	" Template Java
:au BufNewFile 	*.py 0r ~/.vim/templates/skeleton.py		" Template Python
:au BufNewFile 	*.cs 0r ~/.vim/templates/skeleton.cs		" Template C#
:au BufNewFile 	*.c 0r ~/.vim/templates/skeleton.c			" Template C
:au BufNewFile 	*.cpp 0r ~/.vim/templates/skeleton.cpp 		" Template C++
:au BufNewFile	*.asm 0r ~/.vim/templates/skeleton.asm		" Template NASM
:au FileType	text set spell
:au! BufEnter	*.data <buffer> set spell
let g:vimspector_enable_mappings = 'VISUAL_STUDIO'
"Plugins
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'w0rp/ale'
Plugin 'junegunn/vim-easy-align'
Plugin 'easymotion/vim-easymotion'
Plugin 'tpope/vim-commentary'
" Plugin 'adelarsq/vim-matchit'
Plugin 'machakann/vim-sandwich'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'preservim/NERDTree'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdcommenter'
Plugin 'puremourning/vimspector'
Plugin 'ycm-core/YouCompleteMe'
" Plugin 'jiangmiao/auto-pairs'

call vundle#end()

" Reference chart of values:
"   Ps = 0  -> blinking block.
"   Ps = 1  -> blinking block (default).
"   Ps = 2  -> steady block.
"   Ps = 3  -> blinking underline.
"   Ps = 4  -> steady underline.
"   Ps = 5  -> blinking bar (xterm).
"   Ps = 6  -> steady bar (xterm).

"				|	Insert number here
"				v
let &t_SI = "\e[5 q" "line cursor for insert mode
let &t_EI = "\e[1 q" "block cursor for everything else

syntax on 						"syntax highlighting
set softtabstop=0				" no sottabstop
set showmatch					" show bracket and quotation mark matches and html
retab							" replace tabs with spaces
set nolist						" no $ at end of lines and no ^i for indent
set tabstop=4					" auto indent to nearest 4 spaces after tabbing
set shiftwidth=4				" set spacing for tabs to four spaces
set hlsearch					" highlight search matches
set paste						" allow pasting in vim
set ic							" ignorecase by default
set mouse=a						" allow mouse in a(all) terminal environments
filetype plugin indent on		" Load ftplugin/*.vim and Indent.vim
set autoindent					" indent according to last indent
set smartindent					" indent according to language
set t_Co=256					" vim with 256 colours
set number 						" show line number
set hlsearch					" highlight search results
setlocal foldmethod=syntax      " folding via syntax for this filetype
set foldlevel=99   				" start with folds open
set whichwrap+=<,>,h,l,[,]		" Wrap l,r arrow keys
set clipboard=unnamedplus		" Use system clipboard

" SYSNTASTIC {
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" }

let g:asmsyntax = 'nasm'	" Force .asm to use NASM syntax highlighting
" VIMSPECTOR {
let g:syntastic_java_checkers = []
let g:EclimFileTypeValidate = 0
let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-cpptools', 'CodeLLDB', 'vscode-java-debug', 'netcoredbg' ]
let g:ycm_java_jdtls_extension_path = [
  \ '</path/to/Vimspector/gadgets/<os>'
  \ ]
nmap <F5> <Plug>VimspectorContinue
nmap <F6> <Plug>VimspectorPause	
nmap <F1> <Plug>VimspectorBreakpoints
nmap <F4> <Plug>VimpectorRestart
nmap <F8> <Plug>VimspectorRunToCursor
nmap <F9> <Plug>VimspectorToggleBreakpoint
nmap <F10> <Plug>VimspectorStepOver
nmap <F12> <Plug>VimspectorStepInto
" }

" NERDCOMMENTER {
let g:NERDCreateDefaultMappings = 1 	" Create default mappings
let g:NERDSpaceDelims = 1 				" Add spaces after comment delimiters by default
let g:NERDTrimTrailingWhitespace = 1 	" Enable trimming of trailing whitespace when uncommenting
" }

" MAPS {
" Keep Pasted Line in clipboard
vnoremap p "_dP
" normal mode on escape
tnoremap <Esc> <C-\><C-n>
" clear search on enter
nnoremap <silent> <CR> :noh<CR><Esc>
" center on search
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz
nnoremap <C-o> <C-o>zz
nnoremap <C-i> <C-i>zz
" change working directory for current window
nnoremap <leader><leader>cwd :lcd %:p:h<CR>
" }

" EasyAlign {
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" }

" vim-sandwich {
" set vim-surround keymap for vim-sandwich
runtime surround.vim
" }

" treat .dot files without the prefix {
function s:changeft()
  let ext = expand('%:e')
    let filename_orig = @%
      if ext != "dot"
          return
            endif
              let file_dot_stripped = substitute(filename_orig, '.dot', '', '')
                execute "file " file_dot_stripped
                  filetype detect
                    execute "file " filename_orig
                    endfunction
                    autocmd BufWinEnter *.dot :call s:changeft()
" }

" Set colour scheme
:source ~/.vim/colors/monokai.vim

for f in split(glob('~/.vim/plugin/*.vim'), '\n') " Source Plugins
    exe 'source' f
endfor
