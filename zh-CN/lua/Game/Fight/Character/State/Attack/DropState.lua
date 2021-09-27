local DormFightConst = require("Game.Fight.DormFightConst")
local DormFightCharacterStateBase = require("Game.Fight.Character.State.DormFightCharacterStateBase")
local AttackDropState = class("AttackDropState", DormFightCharacterStateBase)
AttackDropState.OnUpdate = function(self, deltaTime)
  -- function num : 0_0 , upvalues : DormFightConst
  if self:CheckIsGrounded() then
    self:TransferTo((DormFightConst.StateEnum).AttackLayer_Idle)
  end
end

return AttackDropState

