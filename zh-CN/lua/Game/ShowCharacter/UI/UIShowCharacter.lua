local UIShowCharacter = class("UIShowCharacter", UIBaseWindow)
local base = UIBaseWindow
UIShowCharacter.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.AddButtonListener)((self.ui).btn_Return, self, self.ExitButtonClicked)
  self.ctrl = ControllerManager:GetController(ControllerTypeId.ShowCharacter, true)
end

UIShowCharacter.InitSettingGraph = function(self)
  -- function num : 0_1
end

UIShowCharacter.ExitButtonClicked = function(self)
  -- function num : 0_2
  (self.ctrl):ExitShowCharacterScene()
end

UIShowCharacter.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  self.ctrl = nil
  ;
  (base.OnDelete)(self)
end

return UIShowCharacter

