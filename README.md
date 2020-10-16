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
- `<space>`, zoom to see more detail

For instance, press `'` will bring up a window of `:marks`

![bringup](./demo/img.png)

Press `<space>` to zoom and see more detail

![bringup](./demo/detail.png)


## Options

| Config               | Default         | Description                           |
|----------------------|-----------------|---------------------------------------|
| `g:bookmarks_window` | `vert bo 30new` | Command for creating bookmarks window |

## TODO

- hilight
