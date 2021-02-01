-- params : ...
-- function num : 0 , upvalues : _ENV
local CheckerSectorStage = {}
CheckerSectorStage.LengthCheck = function(param)
  -- function num : 0_0
  if #param >= 2 then
    return true
  end
  return false
end

CheckerSectorStage.ParamsCheck = function(param)
  -- function num : 0_1 , upvalues : _ENV
  return (PlayerDataCenter.sectorStage):IsStageComplete(param[2])
end

CheckerSectorStage.GetUnlockInfo = function(param)
  -- function num : 0_2 , upvalues : _ENV
  local sectorStageId = param[2]
  local sectorStageCfg = (ConfigData.sector_stage)[sectorStageId]
  if sectorStageCfg ~= nil then
    local diffstr = nil
    local difficult = sectorStageCfg.difficulty
    if difficult == 1 then
      diffstr = ConfigData:GetTipContent(TipContent.DifficultyName_1)
    else
      if difficult == 2 then
        diffstr = ConfigData:GetTipContent(TipContent.DifficultyName_2)
      else
        diffstr = ConfigData:GetTipContent(TipContent.DifficultyName_3)
      end
    end
    return (string.format)(ConfigData:GetTipContent(TipContent.LockTip_Sector), tostring(sectorStageCfg.sector), tostring(sectorStageCfg.sector), tostring(sectorStageCfg.num), diffstr)
  end
  do
    return ""
  end
end

return CheckerSectorStage

