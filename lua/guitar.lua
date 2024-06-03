---@module 'guitar'
---@class Guitar
local guitar = {}

---@type string[6]
local STAFF_TEMPLATE = {
  "|--------------------------------------------------------------------------------|",
  "|--------------------------------------------------------------------------------|",
  "|--------------------------------------------------------------------------------|",
  "|--------------------------------------------------------------------------------|",
  "|--------------------------------------------------------------------------------|",
  "|--------------------------------------------------------------------------------|",
}


---@class GuitarStatic
---@field package nsid number?

---@type GuitarStatic
local priv = {
  nsid = nil,
}

function guitar.setup(_)
  --  TODO: Config and such
  priv.nsid = vim.api.nvim_create_namespace("guitar.nvim")
  vim.keymap.set('n', '<Plug>GuitarAddStaff', guitar.add_staff, { noremap = true })
  vim.keymap.set('n', '<Plug>GuitarDeleteStaff', guitar.remove_staff, { noremap = true })
  vim.keymap.set('n', '<Plug>GuitarNextStaff', guitar.next_staff_forward, { noremap = true })
  vim.keymap.set('n', '<Plug>GuitarPreviousStaff', guitar.next_staff_backward, { noremap = true })
end

---@param win number
---@param pos [ number, number ]
---@return boolean?, string?
function guitar.add_staff(win_in, pos_in)
  local win = win_in or vim.api.nvim_get_current_win()
  local pos = pos_in or vim.api.nvim_win_get_cursor(win)
  local buf = vim.api.nvim_win_get_buf(win)
  vim.api.nvim_buf_set_lines(buf, pos[1], pos[1], false, STAFF_TEMPLATE)
  vim.api.nvim_buf_set_extmark(buf, priv.nsid, pos[1], 0, { end_row = pos[1] + #STAFF_TEMPLATE - 1, end_col = 0 })
  return true, nil
end

function guitar.remove_staff(win_in, pos_in)
  local win = win_in or vim.api.nvim_get_current_win()
  local pos = pos_in or vim.api.nvim_win_get_cursor(win)
  local buf = vim.api.nvim_win_get_buf(win)
  local extmark = vim.api.nvim_buf_get_extmarks(buf, priv.nsid, pos[1], pos[1], {})
  if not extmark or not extmark[1] then return false, "no extmark found" end
  if not vim.api.nvim_buf_del_extmark(buf, priv.nsid, extmark[1][1]) then
    return false, "could not delete extmark"
  end
  local del_start = extmark[1][2]
  local del_end = del_start + 6
  vim.api.nvim_buf_set_lines(buf, del_start, del_end, false, {})
  return true, nil
end

function guitar.next_staff_forward(win_in, pos_in)
  local win = win_in or vim.api.nvim_get_current_win()
  local pos = pos_in or vim.api.nvim_win_get_cursor(win)
  local buf = vim.api.nvim_win_get_buf(win)
  local extmark = vim.api.nvim_buf_get_extmarks(buf, priv.nsid, pos, -1, {})
  if not extmark or not extmark[1] then return false, nil end
  for _, mark in ipairs(extmark) do
    if mark[2] ~= pos[1] then
      vim.api.nvim_win_set_cursor(win, { mark[2], mark[3] })
      break
    end
  end
  return true, nil
end

function guitar.next_staff_backward(win_in, pos_in)
  local win = win_in or vim.api.nvim_get_current_win()
  local pos = pos_in or vim.api.nvim_win_get_cursor(win)
  local buf = vim.api.nvim_win_get_buf(win)
  local extmark = vim.api.nvim_buf_get_extmarks(buf, priv.nsid, pos, 0, {})
  if not extmark or not extmark[1] then return false, nil end
  for _, mark in ipairs(extmark) do
    if mark[2] ~= pos[1] then
      vim.api.nvim_win_set_cursor(win, { mark[2], mark[3] })
      break
    end
  end
  return true, nil
end

function guitar.get_num_staffs(buf)
  assert(buf)
  local extmarks = vim.api.nvim_buf_get_extmarks(0, priv.nsid, 0, -1, {})
  assert(extmarks)
  return #extmarks
end

return guitar
