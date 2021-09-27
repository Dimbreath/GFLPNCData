local UIEventWeChatViewQRCode = class("UIEventWeChatViewQRCode", UIBaseWindow)
local base = UIBaseWindow
UIEventWeChatViewQRCode.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.AddButtonListener)((self.ui).background, self, self.OnClickClose)
  ;
  (UIUtil.HideTopStatus)()
end

UIEventWeChatViewQRCode.OnClickClose = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self:Delete()
  ;
  (UIUtil.ReShowTopStatus)()
end

return UIEventWeChatViewQRCode

