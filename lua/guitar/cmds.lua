---@module 'guitar.cmds'
local cmds = {}
local config = require("guitar.config")
local staff = require("guitar.staff")

---Map from row numbers to array of buffer numbers.
---@alias StaffPos table<number, number[]>

---@type StaffPos[]
local staffs = {}

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

---@return {win: number, buf: number, col: number, row: number}
---Returns a table with the current window, buffer, cursor column, and cursor row
local function get_coords()
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

---@param row number
---@param buf number
---@return boolean
local function track_staff(row, buf)
  if not staffs[row] then
    staffs[row] = {}
  end
  table.insert(staffs[row], buf)
  return true
end

---@param row number
---@param buf number
---@return boolean
local function untrack_staff(row, buf)
  if not staffs[row] then
    return false
  end
  for i = #staffs[row], 1, -1 do
    if staffs[row][i] == buf then
      table.remove(staffs[row], i)
      return true
    end
  end
  return false
end

local function has_staff(row, buf)
  if not staffs[row] then
    return false
  end
  for i = #staffs[row], 1, -1 do
    if staffs[row][i] == buf then
      return true
    end
  end
  return false
end

---@return boolean
function cmds.add_staff()
  local coords = get_coords()
  local cfg = config.get()
  local s = staff.new(cfg.tuning, cfg.length):get()
  -- vim.api.nvim_buf_set_lines(coords.buf, coords.row, coords.row, false, vim.fn.split(s, "\n"))
  vim.api.nvim_put(vim.fn.split(s, "\n"), "l", false, false)
  return track_staff(coords.row, coords.buf)
end

---@return boolean
function cmds.remove_staff()
  local coords = get_coords()
  local cfg = config.get()
  if not has_staff(coords.row, coords.buf) then
    vim.notify_once("No staff at cursor position.", vim.log.levels.WARN)
    return false
  end
  local row = coords.row - 1
  vim.api.nvim_buf_set_lines(coords.buf, row, row + cfg.length, false, {})
  return untrack_staff(coords.row, coords.buf)
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
