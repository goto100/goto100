set nocompatible
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
	"set shellxquote=\'
endif
set encoding=utf-8
set langmenu=zh_CN.UTF-8
language message zh_CN.UTF-8

" 解决gui菜单乱码问题
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

set fileencoding=utf-8
set fileencodings=utf-8,gb2312,gbk,gb18030,big5
"set fileencodings+=ucs-bom
set fileformats=unix,dos

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set undofile
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
set foldcolumn=4 
set foldmethod=syntax
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
set tags=tags;

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
let g:WUploader_Auto_Upload = 0		" 保存时自动上传
let g:WUploader_Echo_Info = 1
let g:server_mappings = []


" 主工程
call add(g:server_mappings, { 'src': 'D:\works\renren\sns.trunk\src\main\webapp\', 'defaultServerName' : 'FED', 'servers': [
			\ {'name': 'FED', 'path': '/opt/www/'},
			\ {'name': '30', 'path': '/opt/www/'},
			\ {'name': '206', 'path': '/opt/www/'},
			\ {'name': '21ly', 'path': '/opt/www_ly/'},
			\ {'name': '205', 'path': '/home/qiang.yan/www-trunk/'}
			\ ]})

" inc
call add(g:server_mappings, { 'src': 'D:\works\renren\xn.inc\', 'defaultServerName' : 'FED', 'servers': [
			\ {'name': 'FED', 'path': '/opt/www/inc/'},
			\ {'name': '205', 'path': '/home/xiangwei/www/inc/'},
			\ {'name': '206', 'path': '/home/www/inc/'},
			\ {'name': '13upload', 'path': '/data/ugc/web/upload/inc/'}
			\ ]})

" 静态
call add(g:server_mappings, { 'src': 'D:\works\renren\xn.static\', 'defaultServerName' : 'FED', 'servers': [
			\ {'name': 'FED', 'path': '/opt/static/'},
			\ {'name': '206', 'path': '/opt/static/'}
			\ ]})

" 分享
call add(g:server_mappings, { 'src': 'D:\works\renren\ugc.share\branches\new\xn_share_web\src\main\webapp\', 'defaultServerName' : '13', 'servers': [
			\ {'name': '13', 'path': '/data/ugc/web/share/'}
			\ ]})

" 相册
call add(g:server_mappings, { 'src': 'D:\works\renren\ugc.photo\branches\photo17.fed_refact\xn_photo_web\src\main\webapp\', 'defaultServerName' : '13', 'servers': [
			\ {'name': '13', 'path': '/data/ugc/web/photo/'}
			\ ]})

" 上传
call add(g:server_mappings, { 'src': 'D:\works\renren\ugc.upload\trunk\xn_upload_web\src\main\webapp\', 'defaultServerName' : '15', 'servers': [
			\ {'name': '15', 'path': '/data/ugc/web/upload/'}
			\ ]})

" 日志
call add(g:server_mappings, { 'src': 'D:\works\renren\ugc.blog\trunk\xn_blog_web\src\main\webapp\', 'defaultServerName' : '13', 'servers': [
			\ {'name': '13', 'path': '/data/ugc/web/blog/'}
			\ ]})

" 状态
call add(g:server_mappings, { 'src': 'D:\works\renren\ugc.status\trunk\xn_status_web\src\main\webapp\', 'defaultServerName' : '13', 'servers': [
			\ {'name': '13', 'path': '/data/ugc/web/status/'}
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
map <F5> :Upload<cr>
map <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<cr>
map <C-Tab> <Esc>:tabnext<cr>

