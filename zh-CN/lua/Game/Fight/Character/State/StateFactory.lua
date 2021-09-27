local DormFightConst = require("Game.Fight.DormFightConst")
local StateFactory = {}
StateFactory.CreateState = function(stateType)
  -- function num : 0_0 , upvalues : DormFightConst, _ENV
  local res = nil
  if stateType == (DormFightConst.StateEnum).AttackLayer_Attack then
    res = ((require("Game.Fight.Character.State.Attack.AttackState")).New)()
  else
    if stateType == (DormFightConst.StateEnum).AttackLayer_Born then
      res = ((require("Game.Fight.Character.State.Attack.BornState")).New)()
    else
      if stateType == (DormFightConst.StateEnum).AttackLayer_Drop then
        res = ((require("Game.Fight.Character.State.Attack.DropState")).New)()
      else
        if stateType == (DormFightConst.StateEnum).AttackLayer_Hit then
          res = ((require("Game.Fight.Character.State.Attack.HitState")).New)()
        else
          if stateType == (DormFightConst.StateEnum).AttackLayer_Idle then
            res = ((require("Game.Fight.Character.State.Attack.IdleState")).New)()
          else
            if stateType == (DormFightConst.StateEnum).AttackLayer_KnockOut then
              res = ((require("Game.Fight.Character.State.Attack.KnockOutState")).New)()
            else
              if stateType == (DormFightConst.StateEnum).MovementLayer_Born then
                res = ((require("Game.Fight.Character.State.Movement.BornState")).New)()
              else
                if stateType == (DormFightConst.StateEnum).MovementLayer_Drop then
                  res = ((require("Game.Fight.Character.State.Movement.DropState")).New)()
                else
                  if stateType == (DormFightConst.StateEnum).MovementLayer_Hit then
                    res = ((require("Game.Fight.Character.State.Movement.HitState")).New)()
                  else
                    if stateType == (DormFightConst.StateEnum).MovementLayer_Idle then
                      res = ((require("Game.Fight.Character.State.Movement.IdleState")).New)()
                    else
                      if stateType == (DormFightConst.StateEnum).MovementLayer_KnockOut then
                        res = ((require("Game.Fight.Character.State.Movement.KnockOutState")).New)()
                      else
                        if stateType == (DormFightConst.StateEnum).MovementLayer_Move then
                          res = ((require("Game.Fight.Character.State.Movement.MoveState")).New)()
                        else
                          if stateType == (DormFightConst.StateEnum).MovementLayer_Run then
                            res = ((require("Game.Fight.Character.State.Movement.RunState")).New)()
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  return res
end

return StateFactory

