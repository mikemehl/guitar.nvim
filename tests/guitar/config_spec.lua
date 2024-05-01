local config = require("guitar.config")

describe("config", function()
  local test_staff

  ---@return boolean, string?
  local function cmp_table(a, b)
    for k, v in pairs(a) do
      if type(v) ~= "table" then
        if v ~= b[k] then
          return false, tostring(k)
        end
      else
        local rc, rcmsg = cmp_table(v, b[k])
        if not rc then
          return rc, rcmsg
        end
      end
    end
    return true, nil
  end

  before_each(function() end)

  it("is initialized to the default config", function()
    local expected_cfg = {
      msg = "Hello!",
      tuning = { "E", "B", "G", "D", "A", "E" },
      length = 80,
    }
    local returned_cfg = config.get()
    local rc, rcmsg = cmp_table(expected_cfg, returned_cfg)
    assert(rc, "Returned config does not match: ", tostring(rcmsg))
  end)
end)
