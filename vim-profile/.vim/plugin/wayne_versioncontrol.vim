function SvnDiff()
"   execute '!svn diff ' . expand('%:p')
	let folder = expand('~') . '\AppData\Local\Temp\'
	silent execute '!svn cat ' . expand('%:p') . ' > ' . folder . 'svndiff.tmp'
	execute ':vert diffsplit ' . folder . 'svndiff.tmp'
endfunction

function SvnCommit(...)
	w
	let command = '!svn commit'
	if a:0 > 0
		let command = command . ' -m "' . iconv(a:1, &enc, "chinese") . '"'
	endif
	let command = command . ' "' . expand('%:p') . '"'
	execute command
endfunction

function SvnUpdate()
	silent execute '!svn update "' . expand('%:p') . '"'
endfunction

function SvnLog()
	execute '!svn log "' . expand('%:p') '"'
endfunction 

function SvnRevert()
	silent execute '!svn revert "' . expand('%:p') . '"'
endfunction


command -nargs=0 Diff :call SvnDiff()
command -nargs=? Commit :call SvnCommit(<f-args>)
command -nargs=0 Update :call SvnUpdate()
command -nargs=0 Revert :call SvnRevert()
command -nargs=0 Log :call SvnLog()