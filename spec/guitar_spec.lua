local guitar = require("guitar")

describe("add_staff", function()
  local buf = 0
  setup(function()
    guitar.setup()
    buf = vim.api.nvim_create_buf(true, false)
    local win = vim.api.nvim_open_win(buf, false, { relative = 'win', row = 10, col = 10, width = 12, height = 12 })
    vim.api.nvim_set_current_win(win)
  end)

  it("can add staffs", function()
    local status, errstr = guitar.add_staff()
    assert(status)
    assert(errstr == nil)
    local text = vim.api.nvim_buf_get_lines(buf, 0, 7, false)
    assert.are.same(text, {
      "",
      "|--------------------------------------------------------------------------------|",
      "|--------------------------------------------------------------------------------|",
      "|--------------------------------------------------------------------------------|",
      "|--------------------------------------------------------------------------------|",
      "|--------------------------------------------------------------------------------|",
      "|--------------------------------------------------------------------------------|",
    })
    local num_staffs = guitar.get_num_staffs(buf)
    assert.are.equals(num_staffs, 1)
  end)
end)
