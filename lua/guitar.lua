---@module 'guitar'
---@class Guitar
local guitar = {}

function guitar.setup(_)
  --  TODO: Config and such
end

---comment
---@param win number
---@param pos [ number, number ]
---@return boolean?, string?
function guitar.add_staff(win_in, pos_in)
  local win = win_in or vim.api.nvim_get_current_win()
  assert(win)
  local pos = pos_in or vim.api.nvim_win_get_cursor(win)
  assert(pos)
  assert(#pos == 2)
  assert(type(pos[1]) == "number")
  assert(type(pos[2]) == "number")
  return true, nil
end

return guitar
