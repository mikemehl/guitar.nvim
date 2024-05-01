---@module 'guitar'
---@class Guitar
local guitar = {}
local config = require("guitar.config")

---@param args GuitarConfig
function guitar.setup(args)
  config.set(args)
end

---@return string
function guitar.hello()
  return config.get().msg
end

return guitar
