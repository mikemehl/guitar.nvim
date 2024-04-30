---@module 'guitar'
---@class Guitar
---@field config GuitarConfig
local guitar = {}
local config = require("guitar.config")

guitar.config = config.default()

---@param args GuitarConfig
function guitar.setup(args)
  guitar.config = vim.tbl_deep_extend("force", guitar.config, args or {})
end

---@return string
function guitar.hello()
  return guitar.config.msg
end

return guitar
