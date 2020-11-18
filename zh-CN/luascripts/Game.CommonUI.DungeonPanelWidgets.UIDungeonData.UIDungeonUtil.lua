-- params : ...
-- function num : 0 , upvalues : _ENV
local UIDungeonUtil = class("UIDungeonUtil")
UIDungeonUtil.GetDailyTotalAndUsedLimit = function(self, moduelId)
  -- function num : 0_0 , upvalues : _ENV
  local usedLimit = 0
  if PlayerDataCenter.dungeonDailyBattleTimes ~= nil and (PlayerDataCenter.dungeonDailyBattleTimes)[moduelId] ~= nil then
    local usedData = ((PlayerDataCenter.dungeonDailyBattleTimes)[moduelId]).data
    for k,v in pairs(usedData) do
      if v ~= nil then
        usedLimit = usedLimit + v
      end
    end
  end
  do
    return usedLimit
  end
end

return UIDungeonUtil

