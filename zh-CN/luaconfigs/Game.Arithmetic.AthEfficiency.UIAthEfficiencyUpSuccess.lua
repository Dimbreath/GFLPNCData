-- params : ...
-- function num : 0 , upvalues : _ENV
local UIAthEfficiencyUpSuccess = class("UIAthEfficiencyUpSuccess", UIBaseWindow)
local base = UIBaseWindow
UIAthEfficiencyUpSuccess.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.AddButtonListener)((self.ui).btn_Close, self, self.__OnClickClose)
end

UIAthEfficiencyUpSuccess.InitAthEffiUpSuccess = function(self, fromValue, toValue)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R3 in 'UnsetPending'

  ((self.ui).tex_CurNum).text = fromValue
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_NewNum).text = toValue
  AudioManager:PlayAudioById(1074)
end

UIAthEfficiencyUpSuccess.SetBackClickAction = function(self, clickAction)
  -- function num : 0_2
  self.__clickAction = clickAction
end

UIAthEfficiencyUpSuccess.__OnClickClose = function(self)
  -- function num : 0_3
  do
    if self.__clickAction ~= nil then
      local bindfunc = self.__clickAction
      self.__clickAction = nil
      bindfunc()
    end
    self:Delete()
  end
end

UIAthEfficiencyUpSuccess.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UIAthEfficiencyUpSuccess

