---@module 'guitar.config'
local config = {}

---@class GuitarConfigDefaults
---@field tuning string[]
---@field length number
---@field spacing number

---@class GuitarConfig
---@field defaults GuitarConfigDefaults
local GuitarConfig = {}

local __config = {}

---@return GuitarConfig
function config.default()
  local c = {
    defaults = {
      tuning = { "E", "B", "G", "D", "A", "E" },
      length = 80,
      spacing = 1,
    },
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
