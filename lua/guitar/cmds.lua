---@module 'guitar.cmds'
local cmds = {}
local config = require("guitar.config")

---@class EditPos
---@field win number
---@field buf number
---@field col number
---@field row number

---@class StaffLoc
---@field row number
---@field end_row number

---@return boolean
---@param staff_loc StaffLoc
---@param edit_pos EditPos
local function cursor_on(staff_loc, edit_pos)
  return not (edit_pos.row >= staff_loc.row and edit_pos.row <= staff_loc.end_row)
end

---@class StaffPos
---@field loc StaffLoc
---@field length number
---@field tuning string[]
---@field tuning_max_len number
---@field barlines number[]
local StaffPos = {}

---@type StaffPos[]
local staffs = {}

---@return StaffPos?
---@param loc EditPos
local function staff_exists(loc)
  for _, s in ipairs(staffs) do
    if cursor_on(s.loc, loc) then
      return s
    end
  end
  return nil
end

---@return StaffPos?, string?
---@param loc EditPos
function StaffPos.new(loc, tuning)
  if staff_exists(loc) then
    return nil, "Staff exists at row " .. tostring(loc.row)
  end
  local o = {
    loc = {
      row = loc.row,
      end_row = loc.row + #tuning,
    },
    length = 1,
    tuning = tuning,
    tuning_max_len = 0,
    barlines = {},
  }
  for _, v in ipairs(tuning) do
    if string.len(v) > o.tuning_max_len then
      o.tuning_max_len = string.len(v)
    end
  end
  setmetatable(o, { __index = StaffPos })
  table.insert(staffs, o)
  return o, nil
end

function StaffPos:draw()
  local staff_out = {}
  local staff_fmt_string = "%" .. tostring(self.tuning_max_len) .. "|" .. string.rep("-", self.length)
  for i, s in ipairs(self.tuning) do
    staff_out[i] = string.format(staff_fmt_string, s)
  end
  vim.api.nvim_buf_set_lines(self.loc.row, self.loc.end_row, false, staff_out)
end

function StaffPos:erase()
  vim.api.nvim_buf_set_lines(self.loc.row, self.loc.end_row, false, {})
end

---@return boolean
---Returns true if the user is in visual mode.
local function is_visual()
  return vim.api.nvim_get_mode().mode == "visual"
end

---@return boolean
---Returns true if the user is in normal mode.
local function is_normal()
  return vim.api.nvim_get_mode().mode == "normal"
end

---@return EditPos
---Returns a table with the current window, buffer, cursor column, and cursor row
local function get_editpos()
  local buf = vim.api.nvim_get_current_buf()
  local win = vim.api.nvim_get_current_win()
  local coords = vim.api.nvim_win_get_cursor(win)
  return {
    win = win,
    buf = buf,
    row = coords[1],
    col = coords[2],
  }
end

---@return boolean, string?
function cmds.add_staff()
  local pos = get_editpos()
  local s, err = StaffPos.new(pos, config.get().tuning)
  if err ~= nil or s == nil then
    return false, err
  end
  s:draw()
  return true, nil
end

---@return boolean, string?
function cmds.remove_staff()
  local pos = get_editpos()
  local new_staffs = {}
  local found_staff = staff_exists(pos)
  if not found_staff then
    return false, "No staff at row " .. tostring(pos.row)
  end
  for _, s in ipairs(staffs) do
    if s.loc.row ~= found_staff.loc.row then
      table.insert(new_staffs, s)
    end
  end
  staffs = new_staffs
  return true, nil
end

function cmds.add_bar_line() end

function cmds.remove_bar_line() end

function cmds.add_palm_mute() end

function cmds.remove_palm_mute() end

function cmds.add_pull_off() end

function cmds.remove_pull_off() end

function cmds.add_hammer_on() end

function cmds.remove_hammer_on() end

function cmds.add_slide() end

function cmds.remove_slide() end

function cmds.add_bend() end

function cmds.remove_bend() end

function cmds.add_vibrato() end

function cmds.remove_vibrato() end

function cmds.add_tremolo() end

function cmds.remove_tremolo() end

function cmds.add_repetition() end

function cmds.remove_repition() end

function cmds.add_note() end

function cmds.remove_note() end

return cmds
