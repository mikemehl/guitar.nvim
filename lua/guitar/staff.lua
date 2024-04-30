---@module 'guitar.staff'
local staff = {}

---@param note string
---@param length number?
---@return string
function staff.create_string(note, length)
  local l = length or 80
  local line = note .. "|"
  for _ = 1, l, 1 do
    line = line .. "-"
  end
  line = line .. "|"
  return line
end

---@param tuning string[]
---@param length number?
---@return string
function staff.create(tuning, length)
  local l = length or 80
  local out = ""
  for _, n in ipairs(tuning) do
    out = out .. staff.create_string(n, l) .. "\n"
  end
  return out
end

return staff
