local DormFightConst = require("Game.Fight.DormFightConst")
local DormFightCharacterStateBase = require("Game.Fight.Character.State.DormFightCharacterStateBase")
local MovementDropState = class("MovementDropState", DormFightCharacterStateBase)
MovementDropState.OnUpdate = function(self, deltaTime)
  -- function num : 0_0 , upvalues : DormFightConst
  if self:CheckIsGrounded() then
    self:TransferTo((DormFightConst.StateEnum).MovementLayer_Idle)
  end
end

return MovementDropState

