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
  if ((PlayerDataCenter.infinityData).completed)[infinitySategId] == nil then
    do return needLevel ~= -1 end
    do
      local processing = ((PlayerDataCenter.infinityData).processingUpdate)[infinitySategId]
      if processing ~= nil and needLevel <= processing then
        return true
      end
      do return false end
      -- DECOMPILER ERROR: 3 unprocessed JMP targets
    end
  end
end

CheckerInfinityDungeon.ParamsCheck = function(param)
  -- function num : 0_2 , upvalues : CheckerInfinityDungeon
  return (CheckerInfinityDungeon.IsFulfillInfinityLevel)(param[2], param[3])
end

CheckerInfinityDungeon.GetUnlockInfo = function(param)
  -- function num : 0_3 , upvalues : _ENV, eDynConfigData
  ConfigData:LoadDynCfg(eDynConfigData.endless)
  local infinitySategId = param[2]
  local needLevel = param[3]
  local cfg = ConfigData.endless
  local indexTable = (cfg.levelDic)[infinitySategId]
  local sectorId = indexTable.sectorId
  local index = indexTable.index
  if needLevel == -1 then
    return (string.format)("通关%d扇区%dm解锁", sectorId, index * 10)
  else
    return (string.format)("通关%d扇区%dm第%d层解锁", sectorId, index * 10, needLevel)
  end
  ConfigData:ReleaseDynCfg(eDynConfigData.endless)
end

return CheckerInfinityDungeon

