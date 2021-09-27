local UIClickContinue = class("UIClickContinue", UIBaseWindow)
local base = UIBaseWindow
UIClickContinue.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.AddButtonListener)((self.ui).bgButton, self, self.OnClickBg)
end

UIClickContinue.InitContinue = function(self, clickEvent, showText, textIndex, bgColor, clickClose)
  -- function num : 0_1
  if textIndex == nil then
    textIndex = 0
  else
    textIndex = false
  end
  if not showText then
    showText = false
  end
  self.clickEvent = clickEvent
  ;
  (((self.ui).text).gameObject):SetActive(showText)
  if showText then
    ((self.ui).text):SetIndex(textIndex)
  end
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R6 in 'UnsetPending'

  if bgColor ~= nil then
    ((self.ui).bgImage).color = bgColor
  end
  if clickClose == nil then
    self.clickClose = true
  else
    self.clickClose = clickClose
  end
end

UIClickContinue.OnClickBg = function(self)
  -- function num : 0_2
  if self.clickEvent ~= nil then
    (self.clickEvent)()
  end
  if self.clickClose then
    self:Delete()
  end
end

UIClickContinue.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UIClickContinue

