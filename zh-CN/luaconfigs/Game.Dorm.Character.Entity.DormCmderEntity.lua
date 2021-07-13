-- params : ...
-- function num : 0 , upvalues : _ENV
local DormCmderEntity = class("DormCmderEntity")
DormCmderEntity.ctor = function(self)
  -- function num : 0_0
end

DormCmderEntity.InitDormCmderEntity = function(self, gameObject)
  -- function num : 0_1 , upvalues : _ENV
  self.gameObject = gameObject
  self.transform = gameObject.transform
  self.animator = (self.gameObject):FindComponent(eUnityComponentID.Animator)
  self.cmderCharacter = (CS.DormAStarCharacter)(self.gameObject)
  ;
  (self.cmderCharacter):AddAStarComponents(true)
end

DormCmderEntity.CmderAddToRoom = function(self, roomEntity, initPos)
  -- function num : 0_2 , upvalues : _ENV
  (self.transform):SetParent(roomEntity.characterHolder)
  if initPos == nil then
    initPos = Vector3.zero
  end
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.transform).localPosition = initPos
end

DormCmderEntity.ShowDormCmder = function(self)
  -- function num : 0_3
  (self.gameObject):SetActive(true)
end

DormCmderEntity.HideDormCmder = function(self)
  -- function num : 0_4
  (self.gameObject):SetActive(false)
end

DormCmderEntity.CmderStartMove = function(self, moveData)
  -- function num : 0_5
  (self.cmderCharacter):MoveByJoystickData(moveData)
  self:SetDormCmderWalkSpeed(moveData.power)
end

DormCmderEntity.CmderEndMove = function(self)
  -- function num : 0_6
  self:SetDormCmderWalkSpeed(0)
end

DormCmderEntity.AnimatorCrossFade = function(self, aniName, transTime)
  -- function num : 0_7
  if not transTime then
    transTime = 0.25
  end
  ;
  (self.animator):CrossFade(aniName, transTime)
end

DormCmderEntity.SetDormCmderWalkSpeed = function(self, speed)
  -- function num : 0_8
  (self.animator):SetFloat("DormWalkSpeed", speed)
end

DormCmderEntity.OnDelete = function(self)
  -- function num : 0_9
  self.cmderCharacter = nil
end

return DormCmderEntity

