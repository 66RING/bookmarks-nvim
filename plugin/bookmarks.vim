" Credits {{{1
" Pieces of code have been taken from:
"
" vim-peekaboo {{{2
" =============================================================================
" Mantainer: https://github.com/junegunn
" Url: https://github.com/junegunn/vim-peekaboo
" Licence: MIT
" =============================================================================}}}
"
" }}}


function! s:bookmarks_start() abort
  " unmap <buffer> *
  lua require("bookmarks").show_marks()
  redraw

  let l:zoom = 0
  while 1
    let l:ch  = getchar()
    let l:reg = nr2char(l:ch)

    if reg != ' '
      break
    endif
    if zoom
      tab close
    endif
    if !zoom
      tab split
    endif
    let zoom = !zoom
    redraw
  endwhile

  lua require("bookmarks").close()
  exec "'".l:reg
endfunction

noremap <silent> <Plug>(bookmarks_nvim) :<c-u>call <SID>bookmarks_start()<cr>





