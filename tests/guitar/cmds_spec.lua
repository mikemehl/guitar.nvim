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
    assert(
      #buflines == #expected_buf,
      "Unexpected number of lines in buffer: " .. tostring(#buflines) .. " but expected " .. tostring(#expected_buf)
    )
    for i = 1, #buflines, 1 do
      assert(
        expected_buf[i] == buflines[i],
        "Line " .. tostring(i) .. "does not match\nExpected: \n" .. expected_buf[i] .. "\nGot:\n" .. buflines[i] .. "\n"
      )
    end
  end)
end)
