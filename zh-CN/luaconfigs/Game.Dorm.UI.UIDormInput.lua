-- params : ...
-- function num : 0 , upvalues : _ENV
local UIDormInput = class("UIDormInput", UIBaseWindow)
local base = UIBaseWindow
UIDormInput.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.__onJoystickMove = BindCallback(self, self.OnJoystickMove)
  ;
  ((self.ui).joystick):onTouchMove("+", self.__onJoystickMove)
  self.__onJoystickUp = BindCallback(self, self.OnJoystickUp)
  ;
  ((self.ui).joystick):onTouchUp("+", self.__onJoystickUp)
end

UIDormInput.InitDormInput = function(self, joystickMoveAction, joystickUpAction)
  -- function num : 0_1
  self.__joyStickMoveAction = joystickMoveAction
  self.__joystickUpAction = joystickUpAction
end

UIDormInput.OnJoystickMove = function(self, moveData)
  -- function num : 0_2
  if self.__joyStickMoveAction ~= nil then
    (self.__joyStickMoveAction)(moveData)
  end
end

UIDormInput.OnJoystickUp = function(self)
  -- function num : 0_3
  if self.__joystickUpAction ~= nil then
    (self.__joystickUpAction)()
  end
end

UIDormInput.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  self.__joyStickMoveAction = nil
  ;
  (base.OnDelete)(self)
end

return UIDormInput

