" Pandoc Markdown Preview
" Sets the file's current directory as root (only for the current window)
" and then calls Pandoc to do the conversion. It'll then launch the
" pdf viewer (default using rifle) to display the preview file.
if exists('g:pandoc_preview_loaded')
  finish
endif
let g:pandoc_preview_loaded = 1


let g:pandoc_preview_pdf_cmd = get(g:, 'pandoc_preview_pdf_cmd', 'rifle')
let g:pandoc_path = get(g:, 'pandoc_path', 'pandoc')
let g:pandoc_generate_pdf_dir = get(g:, 'pandoc_generate_pdf_dir', '')

function! s:PandocGenerateFile()
    silent exec 'lcd %:p:h'
    if exists('g:pandoc_path')
        let response = system(printf("%s %s %s %s", 
                                        \shellescape(g:pandoc_path), 
                                        \'-o',
                                        \s:PdfFileName(),
                                        \shellescape(expand('%'))))
        if (match(response, 'Error') != -1)
            echo response
            return 1
        else
            return 0
        endif
    else
        return 0
    endif
endfunction

function! s:PdfFileName()
    return shellescape(((strlen(g:pandoc_generate_pdf_dir) == 0) ? expand('%:p:h') : g:pandoc_generate_pdf_dir).'/'.expand('%:t:r').'.pdf')
endfunction
 
function! s:PandocMarkdownPreview()
    silent exec 'lcd %:p:h'
    if (s:PandocGenerateFile() == 0) && exists('g:pandoc_preview_pdf_cmd')
        let pdf = s:PdfFileName()
		call system(printf("%s %s &", \shellescape(g:pandoc_preview_pdf_cmd), \pdf))
        echo pdf.' was generated.'
    
        augroup Preview
            autocmd!
            autocmd BufWritePost <buffer> call <SID>PandocGenerateFile()
        augroup END
    endif
endfunction

command! PandocCompile call <SID>PandocGenerateFile()
command! PandocPreview call <SID>PandocMarkdownPreview()

finish
