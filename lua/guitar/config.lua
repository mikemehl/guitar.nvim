---@module 'guitar.config'
local config = {}

---@class GuitarConfig
---@field msg string
---@field tuning string[]
---@field length number
local GuitarConfig = {}

local __config = {}

---@return GuitarConfig
function config.default()
  local c = {
    msg = "Hello!",
    tuning = { "E", "B", "G", "D", "A", "E" },
    length = 80,
  }
  setmetatable(c, { __index = GuitarConfig })
  return c
end

---@return GuitarConfig
function config.get()
  return __config
end

---@param cfg GuitarConfig
function config.set(cfg)
  __config = vim.tbl_deep_extend("force", config.default(), cfg)
end

__config = config.default()

return config
