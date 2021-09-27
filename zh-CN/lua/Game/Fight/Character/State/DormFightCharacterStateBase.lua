local DormFightConst = require("Game.Fight.DormFightConst")
local DormFightCharacterStateBase = class("DormFightCharacterStateBase")
DormFightCharacterStateBase.ctor = function(self)
  -- function num : 0_0 , upvalues : DormFightConst
  self._owner = nil
  self._layer = -1
  self._stateType = (DormFightConst.StateEnum).Undefined
end

DormFightCharacterStateBase.Init = function(self, owner, layer, stateType)
  -- function num : 0_1
  self._owner = owner
  self._layer = layer
  if not stateType then
    self._stateType = self._stateType
    self:OnInit()
  end
end

DormFightCharacterStateBase.GetStateType = function(self)
  -- function num : 0_2
  return self._stateType
end

DormFightCharacterStateBase.GetLayer = function(self)
  -- function num : 0_3
  return self._layer
end

DormFightCharacterStateBase.CheckIsGrounded = function(self)
  -- function num : 0_4
  return self._owner and (self._owner):CheckIsGrounded() or false
end

DormFightCharacterStateBase.CheckHitWall = function(self)
  -- function num : 0_5
  return self._owner and (self._owner):CheckHitWall() or false
end

DormFightCharacterStateBase.TransferTo = function(self, stateType)
  -- function num : 0_6
  if self._owner == nil then
    return 
  end
  ;
  (self._owner):TransferTo(self._layer, stateType)
end

DormFightCharacterStateBase.OnInit = function(self)
  -- function num : 0_7
end

DormFightCharacterStateBase.OnEnter = function(self, prevState)
  -- function num : 0_8
end

DormFightCharacterStateBase.OnExit = function(self, nextState)
  -- function num : 0_9
end

DormFightCharacterStateBase.OnUpdate = function(self, deltaTime)
  -- function num : 0_10
end

DormFightCharacterStateBase.OnEvent = function(self, eventType, ...)
  -- function num : 0_11
end

return DormFightCharacterStateBase

