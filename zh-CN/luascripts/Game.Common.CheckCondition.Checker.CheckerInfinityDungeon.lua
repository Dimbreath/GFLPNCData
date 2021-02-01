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
  local str = ""
  if needLevel == -1 then
    str = (string.format)(ConfigData:GetTipContent(TipContent.LockTip_Endless), tostring(sectorId), tostring(index * 10))
  else
    str = (string.format)(ConfigData:GetTipContent(TipContent.LockTip_EndlessLevel), tostring(sectorId), tostring(index * 10), tostring(needLevel))
  end
  ConfigData:ReleaseDynCfg(eDynConfigData.endless)
  return str
end

return CheckerInfinityDungeon

