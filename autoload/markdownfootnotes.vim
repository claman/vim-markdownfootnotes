scriptencoding utf-8

function! markdownfootnotes#GetNextNote()
    " find the next footnote to insert (does not assume that they're in order)
    let s:cur_pos = getpos(".")

    let l:pattern = '\v^\[\^[0-9]+\]:'
    let l:matchpattern = '\v^\[\^\zs[0-9]+\ze\]:'
    let l:flags = 'W'

    call cursor(1,1)

    let l:count = 0
    let l:currentnotelist = []

    let l:temp = search(l:pattern, l:flags)
    if (l:temp != 0)
        " count matches and build list
        while 1
            " caps max number of footnotes in file at 500
            if l:temp == 0 || l:count > 500
                break
            endif
            let l:count += 1
            let l:currentnote = str2nr(matchstr(getline(l:temp), l:matchpattern))
            call add(l:currentnotelist, l:currentnote)

            let l:temp = search(l:pattern, l:flags)
        endwhile

        " check for the correct number of footnotes; if incorrect,
        " insert one at first possible location
        call sort(l:currentnotelist, 'n')
        if l:count == l:currentnotelist[-1]
            let l:footnotenumber = l:count + 1
        elseif l:currentnotelist[0] != 1
            " start at the lowest number possible
            let l:footnotenumber = 1
        else
            let l:c = 0
            while c < len(l:currentnotelist)
                " per dmoerner, 'somehow this splice works'
                let [l:prev, l:next] = l:currentnotelist[l:c:l:c + 1]
                if l:next - l:prev > 1
                    let l:footnotenumber = l:prev + 1
                    break
                else
                    let l:c += 1
                endif
            endwhile
        endif
    else
        let l:footnotenumber = 1
    endif

    call setpos(".", s:cur_pos)

    return l:footnotenumber
endfunction

function! markdownfootnotes#VimAddFootnote()
    let l:footnotenumber = markdownfootnotes#GetNextNote()
    " place footnote after nearest punctuation
    let l:pos = search('[,:.?!]', 'Wce')

    exe "normal a[^".l:footnotenumber."]\<esc>"
    :below 4split
    normal! G
    exe "normal o[^".l:footnotenumber."]: "
    " enter insert mode, as if `A` had been pressed
    startinsert!
endfunction

function! markdownfootnotes#VimEditFootnote()
    " Define search pattern for footnote definitions
    let l:footnotepattern = '\v\[\^[0-9]+\]'
    let l:flags = 'cW'

    " Find the next footnote and align it for return
    let [l:footnoteline, l:footnotepos] = searchpos(l:footnotepattern, l:flags)

        if l:footnoteline == 0
            echom "No more footnotes in document."
            return
        endif

        " Make sure we aren't aligned inside footnote when we return
        normal h
    " Get next footnote in a variable. Need to move back outside footnote to find it.
    let l:text = getline(l:footnoteline)
    let [l:footnotenumber, l:startpos, l:endpos] = matchstrpos(l:text, l:footnotepattern, l:footnotepos - 1)

    " Move to the correct footnote and align at the start
    :below 4split
    call search('\V' . l:footnotenumber . ': ', 'W')
    normal f:2l

endfunction
