local record TabWindow
  bufid: number
  winid: number
  new: function(): TabWindow | nil
  hide: function(self): nil
end

function TabWindow.new(): TabWindow | nil
  local tw: TabWindow = setmetatable({
    bufid = 0,
    winid = 0,
  }, {__index = TabWindow})

  tw.bufid = nvim_create_buf(false, false)
  if tw.bufid == 0 then return nil end
  tw.winid = nvim_open_win(tw.bufid, false, {
    relative = "editor",
    anchor = "NW",
    width = 20,
    height = 20,
    row = 1,
    col = 1,
    focusable = true,
    zindex = 250,
    title = "Tab Window",
    title_pos = "center",
  })
  if tw.winid == 0 then return nil end
  nvim_win_hide(tw.winid)
  return tw
end

function TabWindow:hide(): nil
  nvim_win_hide(self.winid)
end

return {
  TabWindow = TabWindow
}
