Pandoc Preview plugin
=====================

Introduction
------------

[pandoc-preview.vim](http://github.com/yulan6248/pandoc-preview.vim) is just a minimalistic plugin that I use personally for previewing pandoc. There are two commands that come with the plugin: 

* `PandocPreview`: compile the pdf file and launch it with the configured pdf reader; after that each time the file is written the pdf will be updated
* `PandocCompile`: compile the pdf file only 

Quick start
-----------

1. Configure your pdf reader by adding this to your .vimrc (this step is quite necessary as the default might not exist in your system):

    ~~~vim
    let g:pandoc_preview_pdf_cmd = "zathura" 
    ~~~

2. Add a keybinding (for best effect put it in `~/.vim/ftplugin/{markdown.vim, pandoc.vim}`):

    ~~~vim
    nnoremap <leader>v :PandocPreview<cr>
    ~~~

3. Now open a `.md` and press the key!

Configurations
--------------

The following variables can be changed as you like

* `g:pandoc_preview_pdf_cmd`: the cmd used to open the pdf
* `g:pandoc_path`: the path to your pandoc binary
* `g:pandoc_generate_pdf_dir`: the directory where the generated pdf will be put; default to the same directory as the file currently being edited
