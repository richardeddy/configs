" Maintainer:	Richard Eddy <richard.eddy@gmail.com>
" Last change:	3/25/2016

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

let mapleader=","

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'fboender/bexec'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'atom/fuzzy-finder'
Plugin 'othree/html5.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'tomtom/tcomment_vim'
Plugin 'tomtom/tlib_vim'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tsaleh/vim-align'
Plugin 'atweiden/vim-dragvisuals'
Plugin 'clones/vim-cecutil'
Plugin 'altercation/vim-colors-solarized'
Plugin 'alvan/vim-closetag'
Plugin 'easymotion/vim-easymotion'
Plugin 'xolox/vim-easytags'
Plugin 'tpope/vim-fugitive'
Plugin 'xolox/vim-misc'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'
Plugin 'tpope/vim-surround'
Plugin 'Valloric/YouCompleteMe'
Plugin 'taku-o/vim-vis'
Plugin 'nixon/vim-vmath'
Plugin 'ternjs/tern_for_vim'

"Butane shortcuts
" Close the buffer.
noremap <leader>bd :Bclose<CR> 
" List buffers
noremap <leader>bs :ls<CR>
" Next buffer.
noremap <leader>bn :bn<CR> 
" Previous buffer.
noremap <leader>bp :bp<CR> 
" Toggle to most recently used buffer.
noremap <leader>bt :b#<CR> 
" Close the buffer & discard changes.

"# filenames like *.xml, *.html, *.xhtml, ...
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.xml"

" All of your Plugins must be added before the following line
call vundle#end()            " required

au VimEnter * !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
au VimLeave * !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock'

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=200         " keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set ignorecase          " turn case-sensitivity off
set smartcase           " case-insenstive unless you add case
set incsearch		" do incremental searching
set relativenumber	" turn on relative numbering
"set clipboard=unnamed   " use the windows clipboard
set showmode		" show the mode in the status line
set autoread
set tabstop=8       " The width of a TAB is set to 8.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.
set shiftwidth=4    " Indents will have a width of 4
set softtabstop=4   " Sets the number of columns for a TAB
set background=dark
colorscheme desert

highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
"inoremap <C-U> <C-G>u<C-U>

" Unmap the arrow keys
no <down> ddp
no <left> <Nop>
no <right> <Nop>
no <up> ddkP
ino <down> <Nop>
ino <left> <Nop>
ino <right> <Nop>
ino <up> <Nop>
vno <down> <Nop>
vno <left> <Nop>
vno <right> <Nop>
vno <up> <Nop>

" gO to create a new line below cursor in normal mode
nmap g<C-O> o<ESC>k
" g<Ctrl+o> to create a new line above cursor (Ctrl to prevent collision with 'go' command)
nmap gO O<ESC>j

"quick pairs
imap <leader>' ''<ESC>i
imap <leader>" ""<ESC>i
imap <leader>( ()<ESC>i
imap <leader>[ []<ESC>i
imap <leader>{ {}<ESC>i
imap <leader>{{ {<CR><CR>}<ESC>ki<C-t>
nnoremap ; :
nnoremap : ;
nnoremap <Leader>nt :NERDTreeToggle<CR>

"We have C-t and C-d in insert mode, but I want to tab and shift tab in other
"modes as well
nnoremap <tab> >> 
nnoremap <S-Tab> <<
vnoremap <tab> >>
vnoremap <S-Tab> <<

nmap <silent> <unique> <leader>be :Bexec()<CR>
vmap <silent> <unique> <F5> :BexecVisual()<CR>

vmap <expr>  ++  VMATH_YankAndAnalyse()
nmap         ++  vip++

" open files with shortcuts
nnoremap <F8> :silent !google-chrome <cfile><CR>
nnoremap <leader>_ :tabnew ~/.vimrc<CR>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

syntax enable

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

endif " has("autocmd")

set autoindent		" always set autoindenting on
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd BufNewFile,BufRead *.scss set ft=scss.css

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif
