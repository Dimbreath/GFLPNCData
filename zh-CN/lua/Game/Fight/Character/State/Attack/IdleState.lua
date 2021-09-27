local DormFightConst = require("Game.Fight.DormFightConst")
local DormFightCharacterStateBase = require("Game.Fight.Character.State.DormFightCharacterStateBase")
local AttackIdleState = class("AttackIdleState", DormFightCharacterStateBase)
AttackIdleState.OnEnter = function(self, prevState)
  -- function num : 0_0
end

AttackIdleState.OnEvent = function(self, eventType, arg1)
  -- function num : 0_1 , upvalues : DormFightConst
  if eventType == (DormFightConst.EventEnum).Hit then
    (self._owner):Hit(arg1)
    self:TransferTo((DormFightConst.StateEnum).AttackLayer_Hit)
  else
    if eventType == (DormFightConst.EventEnum).KnockOut then
      (self._owner):KnockOut(arg1)
      self:TransferTo((DormFightConst.StateEnum).AttackLayer_KnockOut)
    else
      if eventType == (DormFightConst.EventEnum).Attack then
        self:TransferTo((DormFightConst.StateEnum).AttackLayer_Attack)
      end
    end
  end
end

return AttackIdleState

