-- params : ...
-- function num : 0 , upvalues : _ENV
local UIOasisEditWindow = class("UIOasisEditWindow", UIBaseWindow)
local base = UIBaseWindow
UIOasisEditWindow.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.CloseEvent = nil
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_exit, self, self.OnClickCloseButton)
  local topStatus = UIManager:GetWindow(UIWindowTypeID.TopStatus)
  if topStatus ~= nil then
    topStatus:ShowButtons(false)
  end
end

UIOasisEditWindow.OnClickCloseButton = function(self)
  -- function num : 0_1
  if self.CloseEvent ~= nil then
    (self.CloseEvent)()
  end
end

UIOasisEditWindow.OnDelete = function(self)
  -- function num : 0_2 , upvalues : _ENV, base
  local topStatus = UIManager:GetWindow(UIWindowTypeID.TopStatus)
  if topStatus ~= nil then
    topStatus:ShowButtons(true)
  end
  ;
  (base.OnDelete)(self)
end

return UIOasisEditWindow

