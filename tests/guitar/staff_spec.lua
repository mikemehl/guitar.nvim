local staff = require("guitar.staff")

describe("setup", function()
  it("returns a tablature line string", function()
    local expected_string = "E|--------------------------------------------------------------------------------|"
    assert(staff.create_string("E") == expected_string, "Bad line returned")
  end)

  it("returns a tablature staff", function()
    local expected_string = [[D|--------------------------------------------------------------------------------|
A|--------------------------------------------------------------------------------|
F|--------------------------------------------------------------------------------|
C|--------------------------------------------------------------------------------|
G|--------------------------------------------------------------------------------|
C|--------------------------------------------------------------------------------|
]]
    assert(staff.create({ "D", "A", "F", "C", "G", "C" }) == expected_string, "Bad staff returned")
  end)
end)
