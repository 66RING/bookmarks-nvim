local M = {
  is_open = false,
  buf_bookmarks = 0
}

function open()
  local has_set_win, mark_window = pcall(vim.api.nvim_get_var,"bookmarks_window")

  if has_set_win==false then
    mark_window = 'vertical botright 30new'
  end

  local format_str = "%5s  %5s  %s"
  format = get_marks(format_str)

  -- render window
  vim.api.nvim_command(mark_window)
  vim.api.nvim_command("setlocal filetype=bookmarks nonumber norelativenumber buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap modifiable statusline=Marks nocursorline nofoldenable")
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
  vim.api.nvim_command("silent! execute 'bd '"..M.buf_bookmarks)
  M.buf_bookmarks = 0
  M.is_open = false
end

function M.toggle()
  if M.is_open then
    return
  end
  vim.api.nvim_command("echohl WarningMsg")
  vim.api.nvim_command("echo ''")
  vim.api.nvim_command("echo 'Jump to Mark:'")
  open()
  vim.api.nvim_command("redraw")
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
        vim.api.nvim_command("tab close")
        vim.api.nvim_command("redraw")
    else
        vim.api.nvim_command("tab split")
        vim.api.nvim_command("redraw")
    end
    zoom = not zoom
  end

  close()
  vim.api.nvim_command("redraw")
  if ch ~= 27 then
    vim.api.nvim_command("'"..reg)
  else
    vim.api.nvim_command("echo ''")
    vim.api.nvim_command("echo 'Jump Cancelled'")
  end
  vim.api.nvim_command("echohl None")
end

return M


