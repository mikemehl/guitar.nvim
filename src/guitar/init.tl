local ui = require("guitar.ui")

local tw: ui.TabWindow = ui.TabWindow.new()

if pcall(function() if tw == nil then error("Unable to create tab window") end end) then
  tw:hide()
else
  vim.notify_once("Unable to create tab window", vim.log.levels.ERROR)
end


return {
  ui = ui,
  xml = require("guitar.xml"),
}
