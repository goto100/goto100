function AutoUploadToServer()
	if g:WUploader_Auto_Upload == 1
		call UploadToServer()
	endif
endfunction

function UploadToServer(...)
	let scp = 'pscp'
	let path = expand('%:p')

	for mapping in g:server_mappings
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
			if g:WUploader_Echo_Info == 1
				echo newPath
			endif
			w
			silent execute '!' . scp . ' ' . path . ' ' . serverName . ':' . newPath
			return
		endif
	endfor
	if g:WUploader_Echo_Info == 1
		echo 'no matched path.'
	endif
endfunction 

function ChangeDefaultServer(name)
	let path = expand('%:p')
	for mapping in g:server_mappings
		if stridx(path, mapping['src']) == 0
			echo 'changed default server name from ' . mapping['defaultServerName'] . ' to ' . a:name
			let mapping['defaultServerName'] = a:name
			return
		endif
	endfor
	echo 'no matched path.'
endfunction


command -nargs=1 ChangeDefaultServer :call ChangeDefaultServer(<f-args>)
command -nargs=? Upload :call UploadToServer(<f-args>)

autocmd BufWritePost,FileWritePost * call AutoUploadToServer()
