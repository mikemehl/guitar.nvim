---@module 'guitar.config'
local config = {}

---@class GuitarConfig
---@field msg string
---@field tuning string[]
---@field length number
local GuitarConfig = {}

---@return GuitarConfig
function config.default()
  local c = {
    msg = "Hello!",
    tuning = { "E", "A", "D", "G", "B", "E" },
    length = 80,
  }
  setmetatable(c, { __index = GuitarConfig })
  return c
end

return config
