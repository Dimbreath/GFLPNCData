-- params : ...
-- function num : 0 , upvalues : _ENV
local UIFloatTextItem = class("UIFloatTextItem", UIBaseNode)
local base = UIBaseNode
UIFloatTextItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.__OnTweenComplete = BindCallback(self, self.OnTweenComplete)
  self.tween = ((((self.transform):DOLocalMove(Vector3.zero, (self.ui).stayTime)):OnComplete(self.__OnTweenComplete)):Pause()):SetAutoKill(false)
end

UIFloatTextItem.InitFloatTextItem = function(self, position, textContent, color, recoveryEvent)
  -- function num : 0_1 , upvalues : _ENV
  self.recoveryEvent = recoveryEvent
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.transform).localPosition = position
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).text).text = textContent
  if color == nil then
    color = (self.ui).defaultColor
  else
    color = false
  end
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).text).color = color
  local targetPos = (self.transform).localPosition + Vector3.up * 100
  ;
  ((self.tween):ChangeEndValue(targetPos)):Restart()
end

UIFloatTextItem.OnTweenComplete = function(self)
  -- function num : 0_2
  if self.recoveryEvent ~= nil then
    (self.recoveryEvent)(self)
  end
end

UIFloatTextItem.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  if self.tween ~= nil then
    (self.tween):Kill()
  end
  ;
  (base.OnDelete)(self)
end

return UIFloatTextItem

