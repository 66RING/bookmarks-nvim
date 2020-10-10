local M = {
  is_open = false,
  buf_bookmarks = 0
}

function open()
  local has_set_win, mark_window = pcall(vim.api.nvim_get_var,"bookmarks_window")

  if has_set_win==false then
    mark_window = 'vertical botright 30new'
  end

  marks = vim.api.nvim_exec("marks", true)
  local format_str = "%5s  %5s  %s"
  format = get_marks(format_str)

  -- render window
  vim.api.nvim_exec(mark_window, false)
  vim.api.nvim_exec("setlocal filetype=bookmarks nonumber norelativenumber buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap modifiable statusline=Marks nocursorline nofoldenable", false)
  M.buf_bookmarks = vim.api.nvim_get_current_buf()
  M.is_open = true

  -- hightlight
  -- TODO

  vim.api.nvim_put(format, "l", false, true)
end

function get_marks(format_str)
  marks = vim.api.nvim_exec("marks", true)
  marks = marks.."\n"
  local t = {}
  for mk, li, view in string.gmatch(marks, "%s?(.-)%s+(.-)%s+%w+%s-(.-)\n") do
    if(string.sub(view, 2, 2) == '/') then
      view = " "..string.match(view, ".+/(.-)$")
    end
    formated = string.format(format_str, mk, li, view)
    table.insert(t, formated)
  end
  return t
end

function close()
  vim.api.nvim_exec("silent! execute 'bd '"..M.buf_bookmarks, false)
  M.buf_bookmarks = 0
  M.is_open = false
end

function M.toggle()
  if M.is_open then
    return
  end
  open()
  vim.api.nvim_exec("redraw", false)
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
        vim.api.nvim_exec("tab close", false)
        vim.api.nvim_exec("redraw", false)
    else
        vim.api.nvim_exec("tab split", false)
        vim.api.nvim_exec("redraw", false)
    end
    zoom = not zoom
  end

  close()
  if ch ~= 27 then
    vim.api.nvim_exec("'"..reg, false)
  end
end

return M


