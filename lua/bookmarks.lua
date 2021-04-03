local M = {
  is_open = false,
  bookmarks_buf = 0
}

local function get_marks()
  local format_str = "%5s  %5s  %s"
  local marks = vim.api.nvim_exec("marks", true)
  marks = marks.."\n"
  local t = {}
  for mk, li, view in string.gmatch(marks, "%s?(.-)%s+(.-)%s+%w+%s-(.-)\n") do
    if(string.sub(view, 2, 2) == '/') then
      view = " "..string.match(view, ".+/(.-)$")
    end
    local formated = string.format(format_str, mk, li, view)
    table.insert(t, formated)
  end
  return t
end

local function open_bookmarks()
  local format = get_marks()
  local nwin_cmd = vim.g.bookmarks_window or 'vertical botright 30new'

  -- render window
  vim.cmd(nwin_cmd)
  vim.cmd("setlocal filetype=bookmarks nonumber norelativenumber buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap modifiable statusline=Marks nocursorline nofoldenable")
  M.is_open = true
  M.bookmarks_buf = vim.fn.bufnr()

  -- hightlight
  -- TODO

  vim.api.nvim_put(format, "l", false, true)
end

local function close_bookmarks()
  vim.cmd("bd "..M.bookmarks_buf)
  vim.cmd("wincmd p")
  M.is_open = false
end

function M.toggle()
  if M.is_open then
    close_bookmarks()
    return
  end
  vim.cmd("echohl WarningMsg")
  vim.cmd("echo ''")
  vim.cmd("echo 'Jump to Mark:'")
  open_bookmarks()
  vim.cmd("redraw")

  local zoom = false
  local ch
  local reg
  while 1 do
    ch = vim.fn.getchar()
    reg = vim.fn.nr2char(ch)
    if reg ~= ' ' then
        break
    end
    if zoom then
        vim.cmd("tab close")
        vim.cmd("redraw")
    else
        vim.cmd("tab split")
        vim.cmd("redraw")
    end
    zoom = not zoom
  end

  close_bookmarks()
  vim.cmd("redraw")
  if ch ~= 27 then
    vim.cmd("'"..reg)
  else
    vim.cmd("echo ''")
    vim.cmd("echo 'Jump Cancelled'")
  end
  vim.cmd("echohl None")
end

return M


