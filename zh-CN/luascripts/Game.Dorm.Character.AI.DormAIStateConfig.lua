-- params : ...
-- function num : 0 , upvalues : _ENV
local DormAIStateConfig = {}
local eDormActionType = {Stand = 0, Fnt = 1, Idle = 2, Visit = 3}
local states = {[eDormActionType.Stand] = require("Game.Dorm.Character.AI.DormAIStandState"), [eDormActionType.Fnt] = require("Game.Dorm.Character.AI.DormAIFntState"), [eDormActionType.Idle] = require("Game.Dorm.Character.AI.DormAIIdleState"), [eDormActionType.Visit] = require("Game.Dorm.Character.AI.DormAIVisitState")}
DormAIStateConfig.eDormActionType = eDormActionType
DormAIStateConfig.GetState = function(typeId)
  -- function num : 0_0 , upvalues : states, _ENV
  local stateClass = states[typeId]
  if stateClass == nil then
    error("dorm action type not define,type:" .. tostring(typeId))
  end
  return stateClass
end

DormAIStateConfig.GetFntState = function(self)
  -- function num : 0_1 , upvalues : states, eDormActionType
  return states[eDormActionType.Fnt]
end

return DormAIStateConfig

