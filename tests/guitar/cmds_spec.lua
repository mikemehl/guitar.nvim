local guitar = require("guitar")
local config = require("guitar.config")
local cmds = require("guitar.cmds")

describe("staff commands", function()
  local test_staff
  local test_buf
  local test_win

  before_each(function()
    guitar.setup(config.default())
    test_buf = vim.api.nvim_create_buf(false, false)
    test_win = vim.api.nvim_open_win(test_buf, true, { relative = "win", row = 0, col = 0, width = 80, height = 80 })
    vim.api.nvim_set_current_win(test_win)
    vim.api.nvim_set_current_buf(test_buf)
  end)

  after_each(function()
    vim.api.nvim_win_close(test_win, true)
    vim.api.nvim_buf_delete(test_buf, { force = true })
  end)

  it("adds a tablature staff to the current buffer", function()
    local expected_buf = {
      "E|--------------------------------------------------------------------------------|",
      "B|--------------------------------------------------------------------------------|",
      "G|--------------------------------------------------------------------------------|",
      "D|--------------------------------------------------------------------------------|",
      "A|--------------------------------------------------------------------------------|",
      "E|--------------------------------------------------------------------------------|",
      "",
    }
    assert(cmds.add_staff(), "Add staff returned false")
    local buflines = vim.api.nvim_buf_get_lines(test_buf, 0, -1, true)
    assert(buflines, "Unable to read buffer lines")
    assert.are.same(expected_buf, buflines)
  end)
  it("removes a tablature staff from the current buffer", function()
    assert.is_true(cmds.add_staff())
    assert.is_true(cmds.remove_staff())
    local buflines = vim.api.nvim_buf_get_lines(test_buf, 0, -1, true)
    assert.are.same(buflines, { "" })
  end)
end)
