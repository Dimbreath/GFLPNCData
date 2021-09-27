local DormFightConst = require("Game.Fight.DormFightConst")
local DormFightCharacterFeatureBase = require("Game.Fight.Character.Feature.DormFightCharacterFeatureBase")
local StateFactory = require("Game.Fight.Character.State.StateFactory")
local CS_UnityEngine_ForceMode = (CS.UnityEngine).ForceMode
local DormFightModelController = class("DormFightModelController", DormFightCharacterFeatureBase)
local StateLayer = {Movement = 1, Attack = 2}
DormFightModelController.ctor = function(self, _)
  -- function num : 0_0
  self._curStateList = {}
  self._cachedStateDict = {}
  self._velocity = 0
  self._targetVelocity = 0
  self._propertyCtrl = nil
  self._lastCheckGroundedFrame = 0
  self._lastCheckGroundedResult = false
  self._lastCheckHitWallFrame = 0
  self._lastCheckHitWallResult = false
  self.transform = nil
  self.rigidBody = nil
  self.ragBody = nil
  self.characterCo = nil
  self.collider = nil
  self.modelRoot = nil
end

DormFightModelController.OnInit = function(self)
  -- function num : 0_1 , upvalues : DormFightConst, StateLayer
  self.transform = (self._owner).transform
  self.rigidBody = (self._owner).rigidBody
  self.ragBody = (self._owner).ragBody
  self.collider = (self._owner).collider
  self.characterCo = (self._owner).characterCo
  self.modelRoot = (self._owner).modelRoot
  self._propertyCtrl = (self._owner):GetFeature((DormFightConst.FeatureEnum).PropertyController)
  self:TransferTo(StateLayer.Movement, (DormFightConst.StateEnum).MovementLayer_Born)
  self:TransferTo(StateLayer.Attack, (DormFightConst.StateEnum).AttackLayer_Born)
end

DormFightModelController.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : _ENV
  self:UpdateVelocity(deltaTime)
  for _,state in ipairs(self._curStateList) do
    state:OnUpdate(deltaTime)
  end
end

DormFightModelController.OnDestroy = function(self)
  -- function num : 0_3
end

DormFightModelController.GetComp = function(self)
  -- function num : 0_4
  return (self._owner):GetComp()
end

DormFightModelController.GetPosition = function(self)
  -- function num : 0_5
  return (self._owner):GetPosition()
end

DormFightModelController.SetHandDetectHit = function(self, hitEnabled)
  -- function num : 0_6
  (self._owner):SetHandDetectHit(hitEnabled)
end

DormFightModelController.SetTargetVelocity = function(self, velocity)
  -- function num : 0_7
  self._targetVelocity = velocity
end

DormFightModelController.UpdateVelocity = function(self, deltaTime)
  -- function num : 0_8 , upvalues : _ENV, DormFightConst
  if (math.abs)(self._velocity - self._targetVelocity) > 1e-05 then
    if self._targetVelocity < self._velocity then
      local acceleratedVelocity = (self._propertyCtrl):GetProperty((DormFightConst.PropertyEnum).NegativeAcceleratedVelocity)
      self._velocity = (math.max)(self._targetVelocity, self._velocity + acceleratedVelocity * deltaTime)
    else
      do
        do
          local acceleratedVelocity = (self._propertyCtrl):GetProperty((DormFightConst.PropertyEnum).AcceleratedVelocity)
          self._velocity = (math.min)(self._targetVelocity, self._velocity + acceleratedVelocity * deltaTime)
          local velocity = (Vector3.forward * (self.rigidBody).rotation).normalized * self._velocity
          velocity.y = ((self.rigidBody).velocity).velocity
          -- DECOMPILER ERROR at PC52: Confused about usage of register: R3 in 'UnsetPending'

          ;
          (self.rigidBody).velocity = velocity
        end
      end
    end
  end
end

DormFightModelController.IsInState = function(self, stateType)
  -- function num : 0_9 , upvalues : _ENV
  local res = false
  for _,v in ipairs(self._curStateList) do
    if v:GetStateType() == stateType then
      res = true
      break
    end
  end
  do
    return res
  end
end

DormFightModelController.PostEvent = function(self, eventType, ...)
  -- function num : 0_10 , upvalues : _ENV
  for _,v in ipairs(self._curStateList) do
    v:OnEvent(eventType, ...)
  end
end

DormFightModelController.GetState = function(self, stateType, layer)
  -- function num : 0_11 , upvalues : StateFactory
  local res = (self._cachedStateDict)[stateType]
  if res == nil then
    res = (StateFactory.CreateState)(stateType)
    res:Init(self, layer, stateType)
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (self._cachedStateDict)[stateType] = res
  end
  return res
end

DormFightModelController.TryGetCurState = function(self, layer)
  -- function num : 0_12 , upvalues : _ENV
  local index = -1
  local res = nil
  for i,v in ipairs(self._curStateList) do
    if v:GetLayer() == layer then
      index = i
      res = v
      break
    end
  end
  do
    return index, res
  end
end

DormFightModelController.TransferTo = function(self, layer, stateType)
  -- function num : 0_13 , upvalues : _ENV
  local index, prevState = self:TryGetCurState(layer)
  local nextState = self:GetState(stateType, layer)
  if prevState ~= nil then
    prevState:OnExit(nextState)
  end
  if index == -1 then
    (table.insert)(self._curStateList, nextState)
  else
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (self._curStateList)[index] = nextState
  end
  nextState:OnEnter(prevState)
end

DormFightModelController.CheckIsGrounded = function(self)
  -- function num : 0_14 , upvalues : _ENV
  local curFrame = Time.frameCount
  if curFrame == self._lastCheckGroundedFrame then
    return self._lastCheckGroundedResult
  end
  if IsNull(self.characterCo) then
    return false
  end
  local res = (self.characterCo):CheckIsGrounded()
  self._lastCheckGroundedFrame = curFrame
  self._lastCheckGroundedResult = res
  return res
end

DormFightModelController.CheckHitWall = function(self)
  -- function num : 0_15 , upvalues : _ENV
  local curFrame = Time.frameCount
  if curFrame == self._lastCheckHitWallFrame then
    return self._lastCheckHitWallResult
  end
  if IsNull(self.characterCo) then
    return false
  end
  local res = (self.characterCo):CheckHitWall()
  self._lastCheckHitWallFrame = curFrame
  self._lastCheckHitWallResult = res
  return res
end

DormFightModelController.Hit = function(self, velocity)
  -- function num : 0_16 , upvalues : _ENV, DormFightConst, CS_UnityEngine_ForceMode
  if velocity == nil or IsNull(self.ragBody) or IsNull((self.ragBody).RootBoneRb) then
    return 
  end
  local propertyCtrl = self:GetFeature((DormFightConst.FeatureEnum).PropertyController)
  local forceStrength = propertyCtrl ~= nil and propertyCtrl:GetProperty((DormFightConst.PropertyEnum).HitForceStrength) or 0
  local rb = (self.ragBody).RootBoneRb
  rb:AddForce(velocity.normalized * forceStrength, CS_UnityEngine_ForceMode.Impulse)
end

DormFightModelController.KnockOut = function(self, velocity)
  -- function num : 0_17 , upvalues : _ENV, DormFightConst, CS_UnityEngine_ForceMode
  if velocity == nil or IsNull(self.ragBody) or IsNull((self.ragBody).RootBoneRb) then
    return 
  end
  local propertyCtrl = self:GetFeature((DormFightConst.FeatureEnum).PropertyController)
  local forceStrength = propertyCtrl ~= nil and propertyCtrl:GetProperty((DormFightConst.PropertyEnum).KnockOutForceStrength) or 0
  local rb = (self.ragBody).RootBoneRb
  rb:AddForce(velocity.normalized * forceStrength, CS_UnityEngine_ForceMode.Impulse)
end

DormFightModelController.SetRogBodyEnabled = function(self, enabled)
  -- function num : 0_18
  ;
  (self.ragBody):BeginStateTransition(enabled and "dead" or "default")
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self.rigidBody).isKinematic = enabled
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self.collider).enabled = not enabled
end

DormFightModelController.SetIgnoreWallCollider = function(self, ignore)
  -- function num : 0_19
  (self._owner):SetIgnoreWallCollider(ignore)
end

DormFightModelController.GetHeadSpotPosition = function(self)
  -- function num : 0_20
  local position = (self.modelRoot).position
  position.y = position.y + 1
  return position
end

DormFightModelController.GetFootSpotPosition = function(self)
  -- function num : 0_21
  local position = (self.modelRoot).position
  position.y = position.y + 0.1
  return position
end

return DormFightModelController

