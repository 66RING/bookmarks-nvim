local M={}

function M.str_split(str, pattern)
  local t = {}
  if pattern == nil then
    pattern = "[^%s]+"
  end
  local t={}
  -- "([^"..sep.."]+)"
  for str in string.gmatch(str, pattern) do
    table.insert(t, str)
  end
  return t
end



-- -- M.str_split(str)
-- lines = M.str_split(str, "(.-)\n")
-- for k, v in pairs(lines) do
  -- print(v)
  -- local m = M.str_split(v, ".%s+(.-)%s+.-%s+(.-)$")
  -- print(m[1]..': '..m[2])
  -- for m, l,  v in string.gmatch(str, "%s-(%w+)%s-(%d+)%s+%d+%s+(.-)\n") do
  --   print(m.."\t"..l.."\t"..v)
  --   -- table.insert(t, str)
  -- end
-- end

return M
