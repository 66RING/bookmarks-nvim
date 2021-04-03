# Bookmarks-nvim

Inspiring by [vim-peekaboo](https://github.com/junegunn/vim-peekaboo)

## Installation

Use your favorite plug-in manager

```vim
call dein#add('66RING/bookmarks-nvim')

" or

Plug '66RING/bookmarks-nvim'
```

## Usage

- `nmap ' <Plug>(bookmarks_nvim)`
- `:BookmarksToggle` or `lua require('bookmarks').toggle()`
- `<space>`, zoom to see more detail

For instance, press `'` will bring up a window of `:marks`

![bringup](https://raw.githubusercontent.com/66RING/bookmarks-nvim/master/.github/images/img.png)

Press `<space>` to zoom and see more detail

![bringup](https://raw.githubusercontent.com/66RING/bookmarks-nvim/master/.github/images/detail.png)


## Options

| Config               | Default         | Description                           |
|----------------------|-----------------|---------------------------------------|
| `g:bookmarks_window` | `vert bo 30new` | Command for creating bookmarks window |

## TODO

- hilight
