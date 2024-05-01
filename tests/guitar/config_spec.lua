local config = require("guitar.config")

describe("config", function()
  local test_staff

  before_each(function() end)

  it("is initialized to the default config", function()
    local expected_cfg = {
      msg = "Hello!",
      tuning = { "E", "B", "G", "D", "A", "E" },
      length = 80,
    }
    local returned_cfg = config.get()
    assert.are.same(expected_cfg, returned_cfg)
  end)
end)
