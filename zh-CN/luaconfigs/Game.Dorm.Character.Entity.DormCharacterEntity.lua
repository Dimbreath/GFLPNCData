-- params : ...
-- function num : 0 , upvalues : _ENV
local DormCharacterEntity = class("DormCharacterEntity")
local DormUtil = require("Game.Dorm.DormUtil")
local eDormFntType = require("Game.Dorm.Enum.eDormFntType")
local DormCharacterAI = require("Game.Dorm.Character.AI.DormCharacterAI")
local speed = 0.5
local UnBindActiveTime = 30
DormCharacterEntity.ctor = function(self, heroData, x, y, roomCharCtrl, isBind)
  -- function num : 0_0 , upvalues : _ENV, DormCharacterAI
  self.__loaded = false
  self.heroData = heroData
  self.x = x
  self.y = y
  self.roomCharCtrl = roomCharCtrl
  self.roomData = roomCharCtrl.roomData
  self.roomEntity = roomCharCtrl.roomEntity
  self.isBind = isBind or false
  if self.isBind then
    self.originRoomCharCtrl = self.roomCharCtrl
  end
  self.isOperate = false
  self.endUnBindTime = false
  local aiCfg = (ConfigData.dorm_ai)[((self.heroData).heroCfg).dorm_ai]
  if aiCfg == nil then
    error("hero ai config is null,heroId:" .. tostring((self.heroData).dataId) .. " aiId:" .. tostring(((self.heroData).heroCfg).dorm_ai))
    return 
  end
  self.aiCtrl = (DormCharacterAI.New)(aiCfg, self)
end

DormCharacterEntity.InitCharacterGo = function(self, gameObject)
  -- function num : 0_1 , upvalues : DormUtil, _ENV
  self.__loaded = true
  self.gameObject = gameObject
  self.transform = gameObject.transform
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self.transform).localPosition = (DormUtil.GetFntUnityCoord)(self.x, self.y)
  self.animator = (self.gameObject):FindComponent(eUnityComponentID.Animator)
  self.astarCharcter = (CS.DormAStarCharacter)(self.gameObject)
  ;
  (self.astarCharcter):AddAStarComponents(false)
  self:StartAIBehavior()
end

DormCharacterEntity.StartAIBehavior = function(self)
  -- function num : 0_2 , upvalues : _ENV, UnBindActiveTime
  if self.__getReady then
    (self.aiCtrl):InterruptAIState()
    ;
    (self.aiCtrl):RandNewAction()
    if not self.isBind then
      self.unbindTimer = (TimerManager:GetTimer(UnBindActiveTime, self.EndUnBindCharacter, self, true)):Start()
    end
  else
    self.__getReady = true
  end
end

DormCharacterEntity.EndUnBindCharacter = function(self)
  -- function num : 0_3
  self.endUnBindTime = true
  self.unbindTimer = nil
end

DormCharacterEntity.StartExChangeUnBindChar = function(self)
  -- function num : 0_4
  (self.roomCharCtrl):ExchangeUnBindCharacter(self)
end

DormCharacterEntity.ChangeOtherDormRoom = function(self)
  -- function num : 0_5
  return (self.roomCharCtrl):ChangeCharacterToOtherRoom(self)
end

DormCharacterEntity.SetNewRoomCtrl = function(self, roomCharCtrl)
  -- function num : 0_6
  self.roomCharCtrl = roomCharCtrl
  self.roomData = roomCharCtrl.roomData
  self.roomEntity = roomCharCtrl.roomEntity
end

DormCharacterEntity.AnimatorCrossFade = function(self, aniName, transTime)
  -- function num : 0_7
  if not transTime then
    transTime = 0.25
  end
  ;
  (self.animator):CrossFade(aniName, transTime)
end

DormCharacterEntity.AnimatorStand = function(self)
  -- function num : 0_8
  (self.animator):SetTrigger("DormStand")
end

DormCharacterEntity.AnimatorFloat = function(self)
  -- function num : 0_9
  (self.animator):SetTrigger("DormFloat")
end

DormCharacterEntity.AnimatorWalk1 = function(self)
  -- function num : 0_10
  self:AnimatorCrossFade("Dorm_Walk1")
end

DormCharacterEntity.HidePauseCharacter = function(self)
  -- function num : 0_11 , upvalues : DormUtil
  if not self.__loaded then
    return 
  end
  self.__position = (self.transform).position
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.transform).position = DormUtil.CharacterNoShowPos
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.animator).speed = 0
  if self.curTweener ~= nil then
    (self.curTweener):Pause()
  end
  if self.operateTimer ~= nil then
    (self.operateTimer):Pause()
  end
  if self.unbindTimer ~= nil then
    (self.unbindTimer):Pause()
  end
end

DormCharacterEntity.ShowResumeCharacter = function(self)
  -- function num : 0_12
  if not self.__loaded then
    return 
  end
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  if self.__position ~= nil then
    (self.transform).position = self.__position
  end
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.animator).speed = 1
  if self.curTweener ~= nil then
    (self.curTweener):Play()
  end
  if self.operateTimer ~= nil then
    (self.operateTimer):Resume()
  end
  if self.unbindTimer ~= nil then
    (self.unbindTimer):Resume()
  end
end

DormCharacterEntity.ResetToDoorCoord = function(self)
  -- function num : 0_13
  local logicX, logicY = (self.roomData):GetDoorCoord()
  self:SetLogicPos(logicX, logicY)
end

DormCharacterEntity.SetCharacterOperateStart = function(self)
  -- function num : 0_14
  self.isOperate = true
  if self.astarCharcter ~= nil then
    (self.astarCharcter):ForceStopMove()
  end
  if self.curTweener ~= nil then
    (self.curTweener):Kill()
    self.curTweener = nil
  end
  if self.operateTimer ~= nil then
    (self.operateTimer):Stop()
    self.operateTimer = nil
  end
  ;
  (self.aiCtrl):InterruptAIState()
  self:AnimatorFloat()
end

DormCharacterEntity.SetCharacterOperateEnd = function(self, interPointEntity)
  -- function num : 0_15 , upvalues : _ENV
  self.isOperate = false
  if interPointEntity ~= nil then
    (self.aiCtrl):StartFntInterPointState(interPointEntity.interPoint)
  else
    local newX, newY = (self.roomCharCtrl):FindActivePosNearby(self.x, self.y)
    if self.x ~= nil and self.x ~= nil then
      newX = self.x
      newY = self.y
    end
    self:AnimatorStand()
    self:SetLogicPos(newX, newY)
    self.operateTimer = (TimerManager:GetTimer(0.5, function()
    -- function num : 0_15_0 , upvalues : self
    self.operateTimer = nil
    ;
    (self.aiCtrl):RandNewAction()
  end
, nil, true)):Start()
  end
end

DormCharacterEntity.QuickExitAIState = function(self)
  -- function num : 0_16
  (self.aiCtrl):QuickExitState()
end

DormCharacterEntity.SetObjectActive = function(self, active)
  -- function num : 0_17
  (self.gameObject):SetActive(active)
end

DormCharacterEntity.OnUpdate = function(self)
  -- function num : 0_18
  if self.isOperate then
    return 
  end
  ;
  (self.aiCtrl):OnUpdate()
end

DormCharacterEntity.SetLogicPos = function(self, x, y)
  -- function num : 0_19 , upvalues : DormUtil
  self.x = x
  self.y = y
  local destPos = (DormUtil.GetFntUnityCoord)(x, y)
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.transform).localPosition = destPos
end

DormCharacterEntity.TargetPosPossible = function(self, pos)
  -- function num : 0_20
  return (self.astarCharcter):IsPathPossible((self.transform).position, pos)
end

DormCharacterEntity.DormLogicToWorld = function(self, logicpos)
  -- function num : 0_21 , upvalues : DormUtil
  local x, y = (DormUtil.FntCoord2XY)(logicpos)
  local destPos = (DormUtil.GetFntUnityCoord)(x, y)
  local worldPos = ((self.transform).parent):TransformPoint(destPos)
  return worldPos
end

DormCharacterEntity.DoMoveLogic = function(self, pos, completeAction)
  -- function num : 0_22
  local worldPos = self:DormLogicToWorld(pos)
  return self:DoMoveAStar(worldPos, completeAction)
end

DormCharacterEntity.DoMoveAStar = function(self, pos, completeAction)
  -- function num : 0_23
  local possible = self:TargetPosPossible(pos)
  if not possible then
    return false
  end
  ;
  (self.astarCharcter):MoveDestPos(pos, completeAction)
  return true
end

DormCharacterEntity.SetUnityPos = function(self, pos)
  -- function num : 0_24
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.transform).localPosition = pos
end

DormCharacterEntity.SetUnityWorldPos = function(self, pos)
  -- function num : 0_25
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.transform).position = pos
end

DormCharacterEntity.DoMoveUnityPos = function(self, pos, completeAction)
  -- function num : 0_26 , upvalues : _ENV, speed
  local destPos = pos
  local moveTime = (Vector3.Distance)((self.transform).localPosition, destPos) / speed
  local forward = destPos - (self.transform).localPosition
  forward = (Vector3.New)(forward.x, forward.y, forward.z)
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R6 in 'UnsetPending'

  if forward:Magnitude() > 0 then
    (self.transform).rotation = (Quaternion.LookRotation)(forward, Vector3.up)
  end
  self.curTweener = ((self.transform):DOLocalMove(destPos, moveTime)):OnComplete(function()
    -- function num : 0_26_0 , upvalues : self, completeAction
    self.curTweener = nil
    if completeAction ~= nil then
      completeAction()
    end
  end
)
end

DormCharacterEntity.DoMoveInteractCurve = function(self, curveId, pos)
  -- function num : 0_27 , upvalues : DormUtil
  local dormConfig = (DormUtil.GetDormConfigAsset)()
  self.curTweener = (dormConfig:StartInteractMove(curveId - 1, self.transform, pos)):OnComplete(function()
    -- function num : 0_27_0 , upvalues : self
    self.curTweener = nil
  end
)
end

DormCharacterEntity.SetLocalRotation = function(self, angle)
  -- function num : 0_28
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.transform).localEulerAngles = angle
end

DormCharacterEntity.SetCharacterPosFromUnity = function(self, unityPos)
  -- function num : 0_29 , upvalues : DormUtil, eDormFntType
  local newX, newY = (DormUtil.UnityCoord2Fnt)(unityPos, eDormFntType.Furniture)
  local oldX = self.x
  local oldY = self.y
  local move = newX ~= oldX or newY ~= oldY
  if move and not (DormUtil.IsFntCoordLegal)(newX, newY) then
    move = false
  end
  if move then
    self:SetLogicPos(newX, newY)
  end
  do return move, newX, newY end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

DormCharacterEntity.OnDelete = function(self)
  -- function num : 0_30 , upvalues : _ENV
  if self.astarCharcter ~= nil then
    (self.astarCharcter):ForceStopMove()
    self.astarCharcter = nil
  end
  if self.curTweener ~= nil then
    (self.curTweener):Kill()
    self.curTweener = nil
  end
  if self.operateTimer ~= nil then
    (self.operateTimer):Stop()
    self.operateTimer = nil
  end
  if self.unbindTimer ~= nil then
    (self.unbindTimer):Stop()
    self.unbindTimer = nil
  end
  DestroyUnityObject(self.gameObject)
end

return DormCharacterEntity

