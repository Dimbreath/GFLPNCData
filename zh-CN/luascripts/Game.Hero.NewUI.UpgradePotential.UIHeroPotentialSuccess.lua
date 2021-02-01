-- params : ...
-- function num : 0 , upvalues : _ENV
local UIHeroPotentialSuccess = class("UIHeroPotentialSuccess", UIBaseWindow)
local base = UIBaseWindow
UIHeroPotentialSuccess.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.AddButtonListener)((self.ui).btn_Close, self, self.OnBtnCloseClick)
end

UIHeroPotentialSuccess.OnInitHeroLimitUpSuccess = function(self, curLimit, nextLimit)
  -- function num : 0_1 , upvalues : _ENV
  ((self.ui).uiAdapter):AdaptBgUI()
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_CurLimit).text = tostring(curLimit or 0)
  if nextLimit ~= nil then
    ((self.ui).tex_NextLimit):SetIndex(0, tostring(nextLimit))
  else
    ;
    ((self.ui).tex_NextLimit):SetIndex(1)
  end
end

UIHeroPotentialSuccess.SetBtnCloseAction = function(self, action)
  -- function num : 0_2
  self.onBtnCloseAction = action
end

UIHeroPotentialSuccess.OnBtnCloseClick = function(self)
  -- function num : 0_3
  do
    if self.onBtnCloseAction ~= nil then
      local bindFunc = self.onBtnCloseAction
      self.onBtnCloseActio = nil
      bindFunc()
    end
    self:Delete()
  end
end

UIHeroPotentialSuccess.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UIHeroPotentialSuccess

