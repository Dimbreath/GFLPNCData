local base = require("Game.Exploration.Ctrl.ExplorationPlayerCtrl")
local ExplorationTDPlayerCtrl = class("ExplorationTDPlayerCtrl", base)
ExplorationTDPlayerCtrl.__TryShowNewReward = function(self)
  -- function num : 0_0 , upvalues : _ENV
  local lastRewardDataList = ((self.dynPlayer).dynRewardBag):TryGetLastEpRewardBagDataList()
  if lastRewardDataList == nil then
    return 
  end
  if #lastRewardDataList > 0 then
    print("todo体力商店飞入动画")
  end
end

return ExplorationTDPlayerCtrl

