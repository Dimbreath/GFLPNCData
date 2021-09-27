local DormAIStateConfig = {}
local eDormActionType = {Stand = 0, Fnt = 1, Idle = 2, Visit = 3, UnbindExit = 4}
local states = {[eDormActionType.Stand] = require("Game.Dorm.Character.AI.DormAIStandState"), [eDormActionType.Fnt] = require("Game.Dorm.Character.AI.DormAIFntState"), [eDormActionType.Idle] = require("Game.Dorm.Character.AI.DormAIIdleState"), [eDormActionType.Visit] = require("Game.Dorm.Character.AI.DormAIVisitState"), [eDormActionType.UnbindExit] = require("Game.Dorm.Character.AI.DormAIUnbindExit")}
DormAIStateConfig.eDormActionType = eDormActionType
DormAIStateConfig.GetState = function(typeId)
  -- function num : 0_0 , upvalues : states, _ENV
  local stateClass = states[typeId]
  if stateClass == nil then
    error("dorm action type not define,type:" .. tostring(typeId))
  end
  return stateClass
end

DormAIStateConfig.GetDormFntState = function()
  -- function num : 0_1 , upvalues : states, eDormActionType
  return states[eDormActionType.Fnt]
end

DormAIStateConfig.GetDormVisitState = function()
  -- function num : 0_2 , upvalues : states, eDormActionType
  return states[eDormActionType.Visit]
end

DormAIStateConfig.GetDormUnbindExitState = function()
  -- function num : 0_3 , upvalues : states, eDormActionType
  return states[eDormActionType.UnbindExit]
end

DormAIStateConfig.GetDormIdleState = function()
  -- function num : 0_4 , upvalues : states, eDormActionType
  return states[eDormActionType.Idle]
end

return DormAIStateConfig

