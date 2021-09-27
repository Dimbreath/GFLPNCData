local DormFightConst = require("Game.Fight.DormFightConst")
local DormFightCharacterStateBase = require("Game.Fight.Character.State.DormFightCharacterStateBase")
local MovementBornState = class("MovementBornState", DormFightCharacterStateBase)
MovementBornState.OnUpdate = function(self, deltaTime)
  -- function num : 0_0 , upvalues : DormFightConst
  if self:CheckIsGrounded() then
    self:TransferTo((DormFightConst.StateEnum).MovementLayer_Idle)
  else
    self:TransferTo((DormFightConst.StateEnum).MovementLayer_Drop)
  end
end

return MovementBornState

