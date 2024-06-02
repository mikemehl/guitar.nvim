local guitar = require("guitar")

describe("setup", function()
  it("works with default", function()
    assert(guitar.hello() == "Hello!", "my first function with param = Hello!")
  end)

  it("works with custom var", function()
    guitar.setup({ msg = "custom" })
    assert(guitar.hello() == "custom", "my first function with param = custom")
  end)
end)
