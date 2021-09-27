local DormFightConst = require("Game.Fight.DormFightConst")
local DormFightCharacterStateBase = require("Game.Fight.Character.State.DormFightCharacterStateBase")
local MovementIdleState = class("MovementIdleState", DormFightCharacterStateBase)
MovementIdleState.OnEnter = function(self, prevState)
  -- function num : 0_0 , upvalues : DormFightConst
  local animatorCtrl = (self._owner):GetFeature((DormFightConst.FeatureEnum).AnimatorController)
  if animatorCtrl ~= nil then
    animatorCtrl:PlayIdleAnimation()
  end
end

MovementIdleState.OnEvent = function(self, eventType, arg1)
  -- function num : 0_1 , upvalues : DormFightConst
  if eventType == (DormFightConst.EventEnum).Move then
    self:TransferTo((DormFightConst.StateEnum).MovementLayer_Move)
  else
    if eventType == (DormFightConst.EventEnum).Run then
      self:TransferTo((DormFightConst.StateEnum).MovementLayer_Run)
    else
      if eventType == (DormFightConst.EventEnum).KnockOut then
        self:TransferTo((DormFightConst.StateEnum).MovementLayer_KnockOut)
      end
    end
  end
end

return MovementIdleState

