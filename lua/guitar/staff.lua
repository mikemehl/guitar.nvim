---@module 'guitar.staff'
local staff = {}

local function get_max_tuning_string(tuning)
  local max = 1
  for _, n in ipairs(tuning) do
    if string.len(n) > max then
      max = string.len(n)
    end
  end
  return max
end

local function has_barline(barlines, barline)
  for _, bl in ipairs(barlines) do
    if bl == barline then
      return true
    end
  end
  return false
end

---@class Staff
---@field barlines number[]
---@field strings string[]
---@field length number
---@field private __tune_column_size number
---@field private __state string
local Staff = {}

---@return Staff
---@param length number?
---@param barlines number[]?
---@param strings string[]?
function staff.new(strings, length, barlines)
  local s = {
    barlines = barlines or {},
    strings = strings or {},
    length = length or 80,
    __tune_column_size = 1,
  }
  if strings then
    s.__tune_column_size = get_max_tuning_string(strings)
  end
  setmetatable(s, { __index = Staff })
  return s
end

---@private
function Staff:generate()
  local out = ""
  for _, n in ipairs(self.strings) do
    out = out .. n
    while #out < self.__tune_column_size do
      out = out .. " "
    end
    out = out .. "|"
    for i = 1, self.length, 1 do
      if has_barline(self.barlines, i) then
        out = out .. "|"
      else
        out = out .. "-"
      end
    end
    out = out .. "|\n"
  end
  self.__state = out
end

---@return boolean
---@param col number
function Staff:add_barline(col)
  if col >= self.length then
    return false
  end
  table.insert(self.barlines, col)
  table.sort(self.barlines)
  return true
end

---@return string
function Staff:get()
  self:generate()
  return self.__state
end

return staff
