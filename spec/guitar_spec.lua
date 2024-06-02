local guitar = require("guitar")

describe("add_staff", function()
  local buf = 0
  local win = 0

  before_each(function()
    guitar.setup()
    buf = vim.api.nvim_create_buf(true, false)
    win = vim.api.nvim_open_win(buf, false, { relative = 'win', row = 10, col = 10, width = 12, height = 12 })
    vim.api.nvim_set_current_win(win)
  end)

  after_each(function()
    vim.api.nvim_win_close(win, true)
    vim.api.nvim_buf_delete(buf, { force = true })
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

  it("can delete staffs", function()
    local status, errstr = guitar.add_staff()
    assert(status)
    assert(errstr == nil)

    vim.api.nvim_win_set_cursor(win, { 1, 0 })
    status, errstr = guitar.remove_staff(win)
    assert(status)
    assert(errstr == nil)

    local text = vim.api.nvim_buf_get_lines(buf, 0, 7, false)
    assert.are.same(text, {
      "",
    })
    local num_staffs = guitar.get_num_staffs(buf)
    assert.are.equals(num_staffs, 0)
  end)

  it("can move between staffs", function()
    pending("Write tests for movement between staffs")
  end)
end)
