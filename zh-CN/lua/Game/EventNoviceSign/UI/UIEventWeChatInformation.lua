local UIEventWeChatInformation = class("UIEventWeChatInformation", UIBaseWindow)
local base = UIBaseWindow
UIEventWeChatInformation.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.AddButtonListener)((self.ui).btn_Close, self, self.OnClickBack)
  ;
  (UIUtil.AddButtonListener)((self.ui).background, self, self.OnClickBack)
  ;
  (UIUtil.HideTopStatus)()
end

UIEventWeChatInformation.InitWeChatInfo = function(self)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ((self.ui).tex_Content).text = ConfigData:GetTipContent(12000)
end

UIEventWeChatInformation.OnClickBack = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self:Delete()
  ;
  (UIUtil.ReShowTopStatus)()
end

return UIEventWeChatInformation

