-- params : ...
-- function num : 0 , upvalues : _ENV
local CheckerInfinityDungeon = {}
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
CheckerInfinityDungeon.LengthCheck = function(param)
  -- function num : 0_0
  if #param >= 3 then
    return true
  end
  return false
end

CheckerInfinityDungeon.IsFulfillInfinityLevel = function(infinitySategId, needLevel)
  -- function num : 0_1 , upvalues : _ENV
  if needLevel == -1 then
    return (PlayerDataCenter.infinityData):IsInfinityDungeonCompleted(infinitySategId)
  else
    local processing = (PlayerDataCenter.infinityData):GetInfinityDungeonProcess(infinitySategId)
    if processing ~= nil and needLevel <= processing then
      return true
    end
  end
  do
    return false
  end
end

CheckerInfinityDungeon.ParamsCheck = function(param)
  -- function num : 0_2 , upvalues : CheckerInfinityDungeon
  return (CheckerInfinityDungeon.IsFulfillInfinityLevel)(param[2], param[3])
end

CheckerInfinityDungeon.GetUnlockInfo = function(param)
  -- function num : 0_3 , upvalues : _ENV
  local infinitySategId = param[2]
  local needLevel = param[3]
  local cfg = ConfigData.endless
  local indexTable = (cfg.levelDic)[infinitySategId]
  local sectorId = indexTable.sectorId
  local index = indexTable.index
  local str = ""
  if needLevel == -1 then
    str = (string.format)(ConfigData:GetTipContent(TipContent.LockTip_Endless), tostring(sectorId), tostring(index * 10))
  else
    str = (string.format)(ConfigData:GetTipContent(TipContent.LockTip_EndlessLevel), tostring(sectorId), tostring(index * 10), tostring(needLevel))
  end
  return str
end

return CheckerInfinityDungeon

