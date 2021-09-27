local UIHeroPowerUpSuccess = class("UIHeroPowerUpSuccess", UIBaseWindow)
local base = UIBaseWindow
UIHeroPowerUpSuccess.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.Push2BackStack)(self, self.OnBtnCloseClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Close, self, self.OnClickClose)
end

UIHeroPowerUpSuccess.InitHeroPowerUpSuccess = function(self, lastHeroPower, curHeroPower)
  -- function num : 0_1 , upvalues : _ENV
  ((self.ui).uiAdapter):AdaptBgUI()
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_OldPower).text = tostring(lastHeroPower)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_NewPower).text = tostring(curHeroPower)
  AudioManager:PlayAudioById(1076)
end

UIHeroPowerUpSuccess.SetBackClickAction = function(self, clickAction)
  -- function num : 0_2
  self.__clickAction = clickAction
end

UIHeroPowerUpSuccess.OnClickClose = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (UIUtil.OnClickBack)()
end

UIHeroPowerUpSuccess.OnBtnCloseClicked = function(self)
  -- function num : 0_4
  do
    if self.__clickAction ~= nil then
      local bindfunc = self.__clickAction
      self.__clickAction = nil
      bindfunc()
    end
    self:Delete()
  end
end

UIHeroPowerUpSuccess.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnDelete)(self)
end

return UIHeroPowerUpSuccess

