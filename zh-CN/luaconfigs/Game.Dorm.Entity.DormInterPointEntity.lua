-- params : ...
-- function num : 0 , upvalues : _ENV
local DormInterPointEntity = class("DormInterPointEntity")
DormInterPointEntity.ctor = function(self)
  -- function num : 0_0
end

DormInterPointEntity.InitInterPointEntity = function(self, interPoint, gameObject, unityPos)
  -- function num : 0_1
  self.interPoint = interPoint
  self.gameObject = gameObject
  self.transform = gameObject.transform
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.transform).position = unityPos
  self.__normalNode = ((self.transform):Find("Normal")).gameObject
  self.__selectNode = ((self.transform):Find("Select")).gameObject
  self:SetPointNormalActive(false)
  self:SetPointSelectActive(false)
end

DormInterPointEntity.SetPointNormalActive = function(self, active)
  -- function num : 0_2
  (self.__normalNode):SetActive(active)
end

DormInterPointEntity.SetPointSelectActive = function(self, active)
  -- function num : 0_3
  (self.__selectNode):SetActive(active)
end

DormInterPointEntity.GetSqrDistanceToScreenTouch = function(self, screenPos)
  -- function num : 0_4 , upvalues : _ENV
  local pos = (UIManager:GetMainCamera()):WorldToScreenPoint((self.transform).position)
  return (Vector2.Distance)(pos, screenPos)
end

return DormInterPointEntity

