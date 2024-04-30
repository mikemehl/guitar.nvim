local staff = require("guitar.staff")

describe("staff", function()
  local test_staff

  before_each(function()
    test_staff = staff.new({ "D", "A", "F", "C", "G", "C" })
  end)

  it("returns a tablature staff", function()
    local expected_string = [[D|--------------------------------------------------------------------------------|
A|--------------------------------------------------------------------------------|
F|--------------------------------------------------------------------------------|
C|--------------------------------------------------------------------------------|
G|--------------------------------------------------------------------------------|
C|--------------------------------------------------------------------------------|
]]
    assert(test_staff:get() == expected_string, "Bad staff returned")
  end)

  it("can add barlines", function()
    assert(test_staff:add_barline(12) == true, "Add barline returned false")
    local expected_string = [[D|-----------|--------------------------------------------------------------------|
A|-----------|--------------------------------------------------------------------|
F|-----------|--------------------------------------------------------------------|
C|-----------|--------------------------------------------------------------------|
G|-----------|--------------------------------------------------------------------|
C|-----------|--------------------------------------------------------------------|
]]
    assert(test_staff:get() == expected_string, "Bad staff returned")
  end)

  it("won't add barlines longer than the staff", function()
    assert(test_staff:add_barline(1024) == false, "Add barline returned true for out of range column")
  end)
end)
