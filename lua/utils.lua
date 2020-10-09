local M={}

function M.str_split(str, pattern)
  local t = {}
  if pattern == nil then
    pattern = "[^%s]+"
  end

  for str in string.gmatch(str, pattern) do
    table.insert(t, str)
  end
  return t
end


return M
