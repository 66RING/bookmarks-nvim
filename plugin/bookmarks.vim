command! BookmarksToggle lua require("bookmarks").toggle()
noremap <silent> <Plug>(bookmarks_nvim) :lua require("bookmarks").toggle()<cr>




