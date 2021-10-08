local DormRoleBaseEntity = require("Game.Dorm.Character.Entity.DormRoleBaseEntity")
local DormCmderEntity = class("DormCmderEntity", DormRoleBaseEntity)
local DormCharacterAI = require("Game.Dorm.Character.AI.DormCharacterAI")
local DormEnum = require("Game.Dorm.DormEnum")
local DormUtil = require("Game.Dorm.DormUtil")
DormCmderEntity.ctor = function(self)
  -- function num : 0_0 , upvalues : DormUtil
  self.__resName = (DormUtil.GetDormCmderResName)()
end

DormCmderEntity.InitDormCmderEntity = function(self, gameObject)
  -- function num : 0_1 , upvalues : _ENV, DormUtil, DormCharacterAI, DormEnum
  self.gameObject = gameObject
  self.transform = gameObject.transform
  self.animator = (self.gameObject):FindComponent(eUnityComponentID.Animator)
  self.cmderCharacter = ((CS.DormAStarCharacter).Create)(self.gameObject)
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self.cmderCharacter).speed = self:GetDormMoveSpeed()
  ;
  (self.cmderCharacter):AddAStarComponents(true)
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.cmderCharacter).aiPath).enableRotation = false
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R2 in 'UnsetPending'

  if (ConfigData.buildinConfig).DormStopCollideFeature then
    ((self.cmderCharacter).rvoController).lockWhenNotMoving = true
  end
  local cmderAIID = ((DormUtil.GetDormCmderConfig)()).ai_id
  local aiCfg = (ConfigData.dorm_ai)[cmderAIID]
  if aiCfg == nil then
    error("cmder ai config is null, aiId:" .. tostring(cmderAIID))
    return 
  end
  self.aiCtrl = (DormCharacterAI.New)(aiCfg, self)
  self.__OnStartFntInteract = BindCallback(self, self.__StartFntInteract)
  self.__OnStartExitInteract = BindCallback(self, self.__StartExitInteract)
  ;
  (self.aiCtrl):AddListenerForDormAI((DormEnum.CharacterAIEventId).StartFntInteract, self.__OnStartFntInteract)
  ;
  (self.aiCtrl):AddListenerForDormAI((DormEnum.CharacterAIEventId).ExitFntInteract, self.__OnStartExitInteract)
end

DormCmderEntity.GetRoleName = function(self)
  -- function num : 0_2
  return "教授"
end

DormCmderEntity.GetDormRoleResName = function(self)
  -- function num : 0_3
  return self.__resName
end

DormCmderEntity.GetCharAStarComp = function(self)
  -- function num : 0_4
  return self.cmderCharacter
end

DormCmderEntity.GetBelongRoomEntity = function(self)
  -- function num : 0_5
  return self.__roomEntity
end

DormCmderEntity.GetDormMoveSpeed = function(self)
  -- function num : 0_6 , upvalues : DormUtil
  return ((DormUtil.GetDormCmderConfig)()).dorm_move_spd
end

DormCmderEntity.CmderAddToRoom = function(self, roomEntity, initPos)
  -- function num : 0_7
  self.__roomEntity = roomEntity
  ;
  (self.transform):SetParent(roomEntity.characterHolder)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.transform).position = initPos
end

DormCmderEntity.ShowDormCmder = function(self)
  -- function num : 0_8
  (self.gameObject):SetActive(true)
end

DormCmderEntity.HideDormCmder = function(self)
  -- function num : 0_9
  (self.gameObject):SetActive(false)
end

DormCmderEntity.CmderStartMove = function(self, moveData)
  -- function num : 0_10
  (self.cmderCharacter):MoveByJoystickData(moveData)
  self:SetMoveAniSpeed(moveData.power)
end

DormCmderEntity.CmderEndMove = function(self)
  -- function num : 0_11
  (self:GetCharAStarComp()):StartSmoothDownSpeed()
end

DormCmderEntity.__StartFntInteract = function(self)
  -- function num : 0_12
  self:SetStarAIPathActive(false)
  self:SetNavmeshCutActive(false)
end

DormCmderEntity.__StartExitInteract = function(self)
  -- function num : 0_13
  self:SetNavmeshCutActive(true)
end

DormCmderEntity.HidePauseCmder = function(self)
  -- function num : 0_14 , upvalues : DormUtil
  (self:GetCharAStarComp()).isPause = true
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self:GetCharAStarComp()).aiPath).enabled = false
  self.__position = (self.transform).position
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.transform).position = DormUtil.CharacterNoShowPos
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.animator).speed = 0
  if self.curTweener ~= nil then
    (self.curTweener):Pause()
  end
end

DormCmderEntity.ShowResumeCmder = function(self)
  -- function num : 0_15
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  if self.__position ~= nil then
    (self.transform).position = self.__position
  end
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.animator).speed = 1
  ;
  (self:GetCharAStarComp()).isPause = false
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self:GetCharAStarComp()).aiPath).enabled = true
  if self.curTweener ~= nil then
    (self.curTweener):Play()
  end
end

DormCmderEntity.OnDelete = function(self)
  -- function num : 0_16 , upvalues : DormRoleBaseEntity
  (DormRoleBaseEntity.OnDelete)(self)
  self.cmderCharacter = nil
  self.aiCtrl = nil
end

return DormCmderEntity

