local utils = require("utils")
local M = {}

function M.show_marks(title, regs)
  local mark_window = 'vertical botright 30new'
  marks = vim.api.nvim_exec("marks", true)
  format = M.get_marks()

  -- render window
  vim.api.nvim_exec(mark_window, false)
  vim.api.nvim_exec("  setlocal nonumber norelativenumber buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap modifiable statusline=Marks nocursorline nofoldenable", false)

  -- hightlight
  -- TODO

  vim.api.nvim_put(format, "l", false, true)
end

function M.get_marks()
  marks = vim.api.nvim_exec("marks", true)
  local t = {}
  for k, v in pairs(utils.str_split(marks, ".-\n")) do
    table.insert(t, v)
  end
  return t
end

return M
