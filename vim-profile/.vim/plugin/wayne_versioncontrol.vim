function Svndiff()
"   execute '!svn diff ' . expand('%:p')
	silent execute '!svn cat ' . expand('%:p') . ' > c:\WINDOWS\Temp\svndiff.tmp'
	execute ':vert diffsplit c:\WINDOWS\Temp\svndiff.tmp'
endfunction

function Svncommit(...)
	w
	let command = '!svn commit'
	if a:0 > 0
		let command = command . ' -m "' . iconv(a:1, &enc, "chinese") . '"'
	endif
	let command = command . ' "' . expand('%:p') .'"'
	execute command
endfunction

function Svnupdate()
	execute '!svn update "' . expand('%:p') . '"'
endfunction

function Svnlog()
	execute '!svn log "' . expand('%:p') '"'
endfunction 


command -nargs=0 Diff :call Svndiff()
command -nargs=? Commit :call Svncommit(<f-args>)
command -nargs=0 Update :call Svnupdate()
command -nargs=0 Log :call Svnlog()
