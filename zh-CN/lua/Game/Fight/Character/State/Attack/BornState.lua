local DormFightConst = require("Game.Fight.DormFightConst")
local DormFightCharacterStateBase = require("Game.Fight.Character.State.DormFightCharacterStateBase")
local AttackBornState = class("AttackBornState", DormFightCharacterStateBase)
AttackBornState.OnUpdate = function(self, deltaTime)
  -- function num : 0_0 , upvalues : DormFightConst
  if self:CheckIsGrounded() then
    self:TransferTo((DormFightConst.StateEnum).AttackLayer_Idle)
  else
    self:TransferTo((DormFightConst.StateEnum).AttackLayer_Drop)
  end
end

return AttackBornState

