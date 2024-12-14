if exists('b:loaded_footnote_vim') | finish | endif
let b:loaded_footnote_vim = 1

let s:cpo_save = &cpo
set cpo&vim

" Mappings

if !hasmapto('<Plug>AddVimFootnote', 'i') && mapcheck('<Leader>f', 'i') is# ''
    imap <buffer> <Leader>f <Plug>AddVimFootnote
endif
if !hasmapto('<Plug>AddVimFootnote', 'n') && mapcheck('<Leader>f', 'n') is# ''
    nmap <buffer> <Leader>f <Plug>AddVimFootnote
endif

if !hasmapto('<Plug>EditVimFootnote', 'i') && mapcheck('<Leader>e', 'i') is# ''
    imap <buffer> <Leader>e <Plug>EditVimFootnote
endif
if !hasmapto('<Plug>EditVimFootnote', 'n') && mapcheck('<Leader>e', 'n') is# ''
    nmap <buffer> <Leader>e <Plug>EditVimFootnote
endif

if !hasmapto('<Plug>ReturnFromFootnote', 'i') && mapcheck('<Leader>r', 'i') is# ''
    imap <buffer> <Leader>r <Plug>ReturnFromFootnote
endif
if !hasmapto('<Plug>ReturnFromFootnote', 'n') && mapcheck('<Leader>r', 'n') is# ''
    nmap <buffer> <Leader>r <Plug>ReturnFromFootnote
endif

nnoremap <buffer> <Plug>AddVimFootnote :<C-U>call markdownfootnotes#VimFootnotes('a')<CR>
inoremap <buffer> <Plug>AddVimFootnote <C-O>:<C-U>call markdownfootnotes#VimFootnotes('a')<CR>

nnoremap <buffer> <Plug>EditVimFootnote :<C-U>call markdownfootnotes#VimEditFootnote()<CR>
inoremap <buffer> <Plug>EditVimFootnote <C-O>:<C-U>call markdownfootnotes#VimEditFootnote()<CR>

nnoremap <Plug>ReturnFromFootnote :<C-U>q<CR><Right>
inoremap <Plug>ReturnFromFootnote <C-O>:<C-U>q<CR><Right>

" :Footnote commands
command! -buffer -nargs=0 FootnoteNextNumber call markdownfootnotes#GetNextNote()
command! -buffer -nargs=0 FootnoteAdd call markdownfootnote#VimAddFootnote()
command! -buffer -nargs=0 FootnoteEdit call markdownfootnote#VimEditFootnote()

let &cpo = s:cpo_save
