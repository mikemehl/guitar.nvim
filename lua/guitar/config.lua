---@module 'guitar.config'
local config = {}

---@class GuitarConfig
---@field msg string
local GuitarConfig = {}

---@return GuitarConfig
function config.default()
  local c = {
    msg = "Hello!",
  }
  setmetatable(c, { __index = GuitarConfig })
  return c
end

return config
