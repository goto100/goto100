function UploadToServer(...)
	let sfxcl = '"C:\Program Files\VanDyke Software\SecureFX\sfxcl"'
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
			echo newPath
			execute '!' . sfxcl . ' /overwrite always ' . path . ' /S /' . serverName . ' ' . newPath
			return
		endif
	endfor
	echo 'no matched path.'
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
