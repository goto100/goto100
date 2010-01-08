set nocompatible
"source $VIMRUNTIME/vimrc_example.vim
"source $VIMRUNTIME/mswin.vim
"behave mswin

set runtimepath^=~/.vim

colorscheme desertEx
syntax on
filetype plugin indent on

let $Lang="zh_CN.UTF-8"

if executable('C:/cygwin/bin/bash.exe')
	set shell=C:/cygwin/bin/bash.exe
	set shellcmdflag=-c
	set shellslash
	set shellredir=>%s\ 2>&1
	set shellpipe=2>&1\|\ tee
	set shellxquote=\'
endif
set encoding=utf-8
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

set fileencoding=utf-8
set fileencodings=utf-8,gb2312,gbk,gb18030,big5
"set fileencodings+=ucs-bom

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set incsearch
set hlsearch
set number
set linebreak
set nowrap
"set scrolloff=1
set sidescrolloff=1
set sidescroll=1
set makeprg=make
set tabstop=4
set shiftwidth=4
set fdc=4 
set fdm=syntax
set cindent
set autoindent
set smarttab
set linespace=2
set nobackup
set cursorline
set sessionoptions+=unix,slash
set fileformat=unix
set foldmethod=marker
set modeline
set guifont=Courier_New:h12:cANSI
set helplang=cn

"不加载matchparen插件，避免访问远程文件时移动光标很慢
let g:loaded_matchparen = 1

" netrw
let g:netrw_ignorenetrc = 0
let g:netrw_cygwin = 1
let g:netrw_silent = 1

" Tag list (ctags)
let g:Tlist_Ctags_Cmd = 'ctags'
let g:Tlist_Show_One_File = 1            "不同时显示多个文件的tag，只显示当前文件的
let g:Tlist_Exit_OnlyWindow = 1          "如果taglist窗口是最后一个窗口，则退出vim
let g:Tlist_Use_Right_Window = 0         "在右侧窗口中显示taglist窗口 
let g:Tlist_Show_Menu = 1

" wayne_uploader
let b:server_mappings = []
call add(b:server_mappings, { 'src': 'D:\works\xn.trunk\src\main\webapp\', 'defaultServerName' : 'FED', 'servers': [
			\ {'name': 'FED', 'path': '/opt/www/'},
			\ {'name': '205', 'path': '/home/xiangwei/www/'}
			\ ]})
call add(b:server_mappings, { 'src': 'D:\works\xn.inc\', 'defaultServerName' : 'FED', 'servers': [
			\ {'name': 'FED', 'path': '/opt/www/inc/'},
			\ {'name': '205', 'path': '/home/xiangwei/www/inc/'}
			\ ]})
call add(b:server_mappings, { 'src': 'D:\works\xn.static\', 'defaultServerName' : 'FED', 'servers': [
			\ {'name': 'FED', 'path': '/opt/static/'},
			\ ]})



""""""""""""""""""""
" autocmd
""""""""""""""""""""
autocmd GUIEnter * simalt ~x "Window Maximize

autocmd BufWritePost,FileWritePost D:/works/xn.static/jspro/xn.core.js silent execute '!D:/works/xn.static/jspro/build.bat &'
autocmd BufWritePost,FileWritePost D:/works/xn.static/jspro/xn.ui.js silent execute '!D:/works/xn.static/jspro/build.bat &'
autocmd BufWritePost,FileWritePost D:/works/xn.static/jspro/xn.form.js silent execute '!D:/works/xn.static/jspro/build.bat &'
autocmd BufWritePost,FileWritePost D:/works/xn.static/jspro/xn.widgets.js silent execute '!D:/works/xn.static/jspro/build.bat &'

autocmd BufReadPost *
			\ if line("'\"") > 1 && line("'\"") <= line("$") |
			\   exe "normal! g`\"" |
			\ endif


"""""""""""""""""""""
" Maps
"""""""""""""""""""""
map <F9> :TlistToggle<cr>


