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

map <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
map <C-Tab> <Esc>:tabnext<CR>
map <C-S-Tab> <Esc>:tabprevious<CR>
map <C-t> <Esc>:tabnew<CR>

let g:netrw_ignorenetrc = 0
let g:netrw_cygwin = 1
let g:netrw_silent = 1

let loaded_matchparen = 1 "不加载matchparen插件，避免访问远程文件时移动光标很慢


let b:serverMappings = []
" 定义服务器信息
call add(b:serverMappings, { 'src': 'D:\works\xn.trunk\src\main\webapp\', 'defaultServerName' : 'FED', 'servers': [
			\ {'name': 'FED', 'path': '/opt/www/'},
			\ {'name': '205', 'path': '/home/xiangwei/www/'}
			\ ]})
call add(b:serverMappings, { 'src': 'D:\works\xn.inc\', 'defaultServerName' : 'FED', 'servers': [
			\ {'name': 'FED', 'path': '/opt/www/inc/'},
			\ {'name': '205', 'path': '/home/xiangwei/www/inc/'}
			\ ]})
call add(b:serverMappings, { 'src': 'D:\works\xn.static\', 'defaultServerName' : 'FED', 'servers': [
			\ {'name': 'FED', 'path': '/opt/static/'},
			\ ]})


" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
autocmd BufReadPost *
			\ if line("'\"") > 1 && line("'\"") <= line("$") |
			\   exe "normal! g`\"" |
			\ endif

command -nargs=0 Diff :call Svndiff()
function Svndiff()
"   execute '!svn diff ' . expand('%:p')
	silent execute '!svn cat ' . expand('%:p') . ' > c:\WINDOWS\Temp\svndiff.tmp'
	execute ':vert diffsplit c:\WINDOWS\Temp\svndiff.tmp'
endfunction

command -nargs=? Commit :call Svncommit(<f-args>)
function Svncommit(...)
	w
	let command = '!svn commit'
	if a:0 > 0
		let command = command . ' -m "' . iconv(a:1, &enc, "chinese") . '"'
	endif
	let command = command . ' "' . expand('%:p') .'"'
	execute command
endfunction

command -nargs=0 Update :call Svnupdate()
function Svnupdate()
	execute '!svn update "' . expand('%:p') . '"'
endfunction

command -nargs=0 Log :call Svnlog()
function Svnlog()
	execute '!svn log "' . expand('%:p') '"'
endfunction 

command -nargs=? Upload :call UploadToServer(<f-args>)
function UploadToServer(...)
	let sfxcl = '"C:\Program Files\VanDyke Software\SecureFX\sfxcl"'
	let path = expand('%:p')

	for mapping in b:serverMappings
		if stridx(path, mapping['src']) == 0
			if a:0 > 0
				let serverName = a:1
			else
				let serverName = mapping['defaultServerName']
			endif
			for server in mapping['servers']
				if server['name'] == serverName
					let newPath = server['path'] . tr(strpart(path, strlen(mapping['src'])), '\', '/')
					break
				endif
			endfor
			echo newPath
			execute '!' . sfxcl . ' /overwrite always ' . path . ' /S /' . serverName . ' ' . newPath
			return
		endif
	endfor
	echo 'no matched path.'
endfunction 

command -nargs=1 ChangeDefaultServer :call ChangeDefaultServer(<f-args>)
function ChangeDefaultServer(name)
	let path = expand('%:p')
	for mapping in b:serverMappings
		if stridx(path, mapping['src']) == 0
			echo 'changed default server name from ' . mapping['defaultServerName'] . ' to ' . a:name
			let mapping['defaultServerName'] = a:name
			return
		endif
	endfor
	echo 'no matched path.'
endfunction

autocmd GUIEnter * simalt ~x "Window Maximize

autocmd BufWritePost,FileWritePost D:/works/xn.static/jspro/xn.core.js silent execute '!D:/works/xn.static/jspro/build.bat &'
autocmd BufWritePost,FileWritePost D:/works/xn.static/jspro/xn.ui.js silent execute '!D:/works/xn.static/jspro/build.bat &'
autocmd BufWritePost,FileWritePost D:/works/xn.static/jspro/xn.form.js silent execute '!D:/works/xn.static/jspro/build.bat &'
autocmd BufWritePost,FileWritePost D:/works/xn.static/jspro/xn.widgets.js silent execute '!D:/works/xn.static/jspro/build.bat &'
