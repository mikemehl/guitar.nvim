---@return number[]
local function get_pos()
  return vim.api.nvim_win_get_cursor(0)
end

---@alias Tuning string[]

---@class Staff
---@field tuning Tuning
---@field row number
---@field end_row number
---@field buf number
---@field length number

---@type Number
local namespace = {}

---@type Tuning?
local tuning = nil

---@type Staff[]
local staffs = {}

---@type {row: number, tuning: Tuning}

---@param new_tuning Tuning
local function set_tuning(new_tuning)
  tuning = new_tuning
end

---@param staff Staff
---@return boolean
local function draw_staff(staff)
  if not tuning then
    return false
  end
  local tuning_len = 0
  for _, t in ipairs(tuning) do
    if string.len(t) > tuning_len then
      tuning_len = string.len(t)
    end
  end
  local fmtstr = "%-" .. tostring(tuning_len) .. "s|" .. string.rep("-", staff.length) .. "|"
  for i, t in ipairs(tuning) do
    vim.api.nvim_buf_set_lines(0, staff.row + i - 1, staff.row + i - 1, false, { string.format(fmtstr, t) })
  end
  return true
end

---@return boolean
---@param length number?
local function add_staff(length)
  if not tuning then
    vim.notify_once("Must specify a tuning before adding staffs.", vim.log.levels.ERROR)
    return false
  end
  local pos = get_pos()
  length = length or 80
  vim.print(pos)
  local new_staff = { ---@type Staff
    tuning = tuning,
    length = length,
    row = pos[1],
    end_row = pos[1] + #tuning,
    buf = vim.api.nvim_get_current_buf(),
  }
  draw_staff(new_staff)
  table.insert(staffs, new_staff)
  vim.api.nvim_buf_set_extmark(0, namespace, new_staff.row, 0, { end_row = new_staff.end_row })
  return true
end

namespace = vim.api.nvim_create_namespace("guitar")

_G.guitar = {
  add_staff = add_staff,
  set_tuning = set_tuning,
}

_G.guitar.set_tuning({ "D", "A", "F", "C", "G", "C" })

vim.keymap.set("n", "<leader>Ga", _G.guitar.add_staff)
