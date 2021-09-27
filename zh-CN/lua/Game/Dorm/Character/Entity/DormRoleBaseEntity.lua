local DormRoleBaseEntity = class("DormRoleBaseEntity")
local DormUtil = require("Game.Dorm.DormUtil")
local DormEnum = require("Game.Dorm.DormEnum")
local cs_DormAStarUtils = CS.DormAStarUtils
local speed = 0.5
DormRoleBaseEntity.GetBelongRoomEntity = function(self)
  -- function num : 0_0
  return nil
end

DormRoleBaseEntity.GetDormRoleResName = function(self)
  -- function num : 0_1
end

DormRoleBaseEntity.GetDormMoveSpeed = function(self)
  -- function num : 0_2
end

DormRoleBaseEntity.TargetPosPossible = function(self, pos)
  -- function num : 0_3
  return (self:GetCharAStarComp()):IsPathPossible((self.transform).position, pos)
end

DormRoleBaseEntity.GetCharAStarComp = function(self)
  -- function num : 0_4
  return nil
end

DormRoleBaseEntity.DoMoveAStar = function(self, pos, completeAction, timeout, reachVelocity, noEndSpeedZero)
  -- function num : 0_5
  if not reachVelocity then
    reachVelocity = false
  end
  if not noEndSpeedZero then
    noEndSpeedZero = false
  end
  local possible = self:TargetPosPossible(pos)
  if not possible then
    return false
  end
  ;
  (self:GetCharAStarComp()):MoveDestPos(pos, function(success)
    -- function num : 0_5_0 , upvalues : noEndSpeedZero, self, completeAction
    if not noEndSpeedZero then
      self:SetMoveAniSpeed(0)
    end
    if completeAction ~= nil then
      completeAction(success)
    end
  end
, reachVelocity, timeout)
  return true
end

DormRoleBaseEntity.ListenerAIEvent = function(self, eventId, action)
  -- function num : 0_6
  (self.aiCtrl):AddListenerForDormAI(eventId, action)
end

DormRoleBaseEntity.SetNavmeshCutActive = function(self, active)
  -- function num : 0_7
  (self:GetCharAStarComp()):SetNavMeshCutEnabled(active)
end

DormRoleBaseEntity.SetStarAIPathActive = function(self, active)
  -- function num : 0_8
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  ((self:GetCharAStarComp()).aiPath).canMove = active
end

DormRoleBaseEntity.SetUnityPos = function(self, pos)
  -- function num : 0_9
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.transform).localPosition = pos
end

DormRoleBaseEntity.SetUnityWorldPos = function(self, pos)
  -- function num : 0_10
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.transform).position = pos
end

DormRoleBaseEntity.SetLocalRotation = function(self, angle)
  -- function num : 0_11
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.transform).localEulerAngles = angle
end

DormRoleBaseEntity.SetObjectActive = function(self, active)
  -- function num : 0_12
  (self.gameObject):SetActive(active)
end

DormRoleBaseEntity.AnimatorCrossFade = function(self, aniName, transTime)
  -- function num : 0_13
  if not transTime then
    transTime = 0.25
  end
  ;
  (self.animator):CrossFade(aniName, transTime)
end

DormRoleBaseEntity.AnimatorTrigger = function(self, trigger)
  -- function num : 0_14
  (self.animator):SetTrigger(trigger)
end

DormRoleBaseEntity.AnimatorStand = function(self)
  -- function num : 0_15
  (self.animator):ResetTrigger("DormFloat")
  ;
  (self.animator):SetTrigger("DormStand")
end

DormRoleBaseEntity.AnimatorFloat = function(self)
  -- function num : 0_16
  (self.animator):ResetTrigger("DormStand")
  ;
  (self.animator):SetTrigger("DormFloat")
end

DormRoleBaseEntity.SetMoveAniSpeed = function(self, value)
  -- function num : 0_17
  (self.animator):SetFloat("DormWalkSpeed", value)
end

DormRoleBaseEntity.DormLogicToWorld = function(self, logicpos)
  -- function num : 0_18 , upvalues : DormUtil
  local x, y = (DormUtil.FntCoord2XY)(logicpos)
  local destPos = (DormUtil.GetFntUnityCoord)(x, y)
  local worldPos = ((self.transform).parent):TransformPoint(destPos)
  return worldPos
end

DormRoleBaseEntity.DoMoveInteractCurve = function(self, curveId, interActionId, pos)
  -- function num : 0_19 , upvalues : DormUtil
  local dormConfig = (DormUtil.GetDormConfigAsset)()
  self.curTweener = (dormConfig:StartInteractMove(self:GetDormRoleResName(), interActionId, curveId - 1, self.transform, pos)):OnComplete(function()
    -- function num : 0_19_0 , upvalues : self
    self.curTweener = nil
  end
)
end

DormRoleBaseEntity.DoMoveUnityPos = function(self, pos, completeAction)
  -- function num : 0_20 , upvalues : _ENV, speed
  local destPos = pos
  local curPos = (self.transform).position
  local moveTime = (Vector3.Distance)(curPos, destPos) / (speed * self:GetDormMoveSpeed())
  local forward = destPos - curPos
  forward = (Vector3.New)(forward.x, forward.y, forward.z)
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R7 in 'UnsetPending'

  if forward:Magnitude() > 0 then
    (self.transform).rotation = (Quaternion.LookRotation)(forward, Vector3.up)
  end
  local lastPos = 0
  self.curTweener = (((self.transform):DOMove(destPos, moveTime)):OnComplete(function()
    -- function num : 0_20_0 , upvalues : self, completeAction
    self.curTweener = nil
    if completeAction ~= nil then
      completeAction()
    end
  end
)):OnUpdate(function()
    -- function num : 0_20_1 , upvalues : _ENV, self, lastPos, moveTime
    local curPos = (GR.GetTweenEaseValue)(self.curTweener)
    local pos = curPos - lastPos
    lastPos = curPos
    local avgPos = Time.deltaTime / moveTime
    local velocity = pos / avgPos
    self:SetMoveAniSpeed(velocity)
  end
)
end

DormRoleBaseEntity.SetLogicPos = function(self, x, y)
  -- function num : 0_21 , upvalues : DormUtil
  self.x = x
  self.y = y
  local destPos = (DormUtil.GetFntUnityCoord)(x, y)
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.transform).localPosition = destPos
end

DormRoleBaseEntity.SetCharacterPosFromUnity = function(self, unityPos)
  -- function num : 0_22 , upvalues : DormUtil, DormEnum
  local newX, newY = (DormUtil.UnityCoord2Fnt)(unityPos, (DormEnum.eDormFntType).Furniture)
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

DormRoleBaseEntity.QuickExitAIState = function(self)
  -- function num : 0_23
  if self.curTweener ~= nil then
    (self.curTweener):Kill()
    self.curTweener = nil
  end
  ;
  (self.aiCtrl):AIInterruptCurrState(true)
end

DormRoleBaseEntity.AIStartExitWait = function(self, action, ...)
  -- function num : 0_24
  (self.aiCtrl):AIStartExitWait(action, ...)
end

DormRoleBaseEntity.DormForceStopMove = function(self)
  -- function num : 0_25
  local astarCharcter = self:GetCharAStarComp()
  if astarCharcter ~= nil then
    astarCharcter:ForceStopMove()
  end
  self:SetMoveAniSpeed(0)
  if self.curTweener ~= nil then
    (self.curTweener):Kill()
    self.curTweener = nil
  end
end

DormRoleBaseEntity.StartCmderCheckMove = function(self, minDistance, action)
  -- function num : 0_26
  (self:GetCharAStarComp()):StartCheckMove(minDistance, action)
end

DormRoleBaseEntity.StopCmderCheckMove = function(self)
  -- function num : 0_27
  (self:GetCharAStarComp()):StopCheckMove()
end

DormRoleBaseEntity.StartCheckAnimator = function(self, aniName, action)
  -- function num : 0_28
  (self:GetCharAStarComp()):StartCheckAnimator(aniName, action)
end

DormRoleBaseEntity.StopCheckAnimator = function(self)
  -- function num : 0_29
  (self:GetCharAStarComp()):StopCheckAnimator()
end

DormRoleBaseEntity.StartSmoothLookAtTarget = function(self, transform, action)
  -- function num : 0_30
  (self:GetCharAStarComp()):StartSmoothLookAtTarget(transform, action)
end

DormRoleBaseEntity.StartSmoothRotate = function(self, qua, action)
  -- function num : 0_31
  (self:GetCharAStarComp()):StartSmoothRotate(qua, action)
end

DormRoleBaseEntity.GetRandomOnePoint = function(self, gscore)
  -- function num : 0_32 , upvalues : cs_DormAStarUtils
  if not gscore then
    gscore = 10000
  end
  local ok, pos = (cs_DormAStarUtils.RandomOnePoint)((self.transform).position, gscore)
  return ok, pos
end

DormRoleBaseEntity.GetRandomBFSPoint = function(self, depth)
  -- function num : 0_33 , upvalues : cs_DormAStarUtils
  if not depth then
    depth = 1
  end
  local ok, pos = (cs_DormAStarUtils.RandomBFSPoint)((self.transform).position, depth)
  return ok, pos
end

DormRoleBaseEntity.GetRandomPathPoint = function(self, length, spread)
  -- function num : 0_34 , upvalues : cs_DormAStarUtils
  if not length then
    length = 10
  end
  if not spread then
    spread = 10000
  end
  local ok, pos = (cs_DormAStarUtils.RandomPathPoint)((self.transform).position, length, spread)
  return ok, pos
end

DormRoleBaseEntity.GetRoleName = function(self)
  -- function num : 0_35
  return ""
end

DormRoleBaseEntity.OnDelete = function(self)
  -- function num : 0_36
  (self.aiCtrl):AIInterruptCurrState()
end

return DormRoleBaseEntity

