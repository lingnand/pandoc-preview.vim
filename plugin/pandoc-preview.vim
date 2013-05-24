" Pandoc Markdown Preview
" Sets the file's current directory as root (only for the current window)
" and then calls Pandoc to do the conversion. It'll then launch the
" default pdf viewer (using rifle) to display the preview file.
function! PandocGenerateFile()
    silent exec 'lcd %:p:h'
    let response = system('pandoc -o '.shellescape(expand('%:r').'.pdf').' '.shellescape(expand('%')))
    if (match(response, 'Error') != -1)
        echo response
        return 1
    else
        return 0
    endif
endfunction
 
function! PandocMarkdownPreview()
    silent exec 'lcd %:p:h'
    if (PandocGenerateFile() == 0)
        call system('rifle '.shellescape(expand('%:r').'.pdf'))
        echo expand('%:r').'.pdf was generated.'
    
        augroup Preview
            autocmd!
            autocmd BufWritePost <buffer> call PandocGenerateFile()
        augroup END
    endif
endfunction
