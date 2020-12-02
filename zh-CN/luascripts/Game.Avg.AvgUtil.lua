-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgUtil = {}
local CheckerTypeId, CheckerGlobalConfig = (table.unpack)(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
AvgUtil.ChangeUltSkillOrder = function(change)
  -- function num : 0_0 , upvalues : _ENV
  local window = UIManager:GetWindow(UIWindowTypeID.BattleSkillModule)
  if window ~= nil then
    (window.ultSkillNode):ChangeUltSkillUIOrder(change)
  end
end

AvgUtil.GetConditionText = function(id, param1, param2)
  -- function num : 0_1 , upvalues : CheckerTypeId, _ENV, AvgUtil
  local str = nil
  if id == CheckerTypeId.CompleteStage then
    local stageCfg = (ConfigData.sector_stage)[param1]
    if stageCfg == nil then
      error("Cant\'t find sector_stage cfg,id = " .. tostring(param1))
    end
    local newDesc = (string.format)(ConfigData:GetTipContent(TipContent.FunctionUnlockDescription_SectorStage), tostring(stageCfg.sector) .. "-" .. tostring(stageCfg.num) .. "[" .. (LanguageUtil.GetLocaleText)(stageCfg.name) .. "]")
    str = (AvgUtil.__AddDecription)(str, newDesc, false)
  else
    do
      if id == CheckerTypeId.CompleteDungeon then
        local stageCfg = (ConfigData.battle_dungeon)[param1]
        if stageCfg == nil then
          error("Cant\'t find battleDungeon cfg,id = " .. tostring(param1))
        end
        local newDesc = (string.format)(ConfigData:GetTipContent(TipContent.FunctionUnlockDescription_BattleDungeon), (LanguageUtil.GetLocaleText)(stageCfg.name))
        str = (AvgUtil.__AddDecription)(str, newDesc, false)
        str = (string.format)((LanguageUtil.GetLocaleText)(str), tostring(param1))
      else
        do
          do
            if id == CheckerTypeId.PlayerLevel then
              local newDesc = (string.format)(ConfigData:GetTipContent(TipContent.FunctionUnlockDescription_Level), tostring(param1))
              str = (AvgUtil.__AddDecription)(str, newDesc, false)
            end
            return str
          end
        end
      end
    end
  end
end

AvgUtil.__AddDecription = function(oldDesc, newDesc, lineWrap)
  -- function num : 0_2 , upvalues : _ENV
  if (string.IsNullOrEmpty)(oldDesc) then
    return newDesc
  end
  if lineWrap then
    oldDesc = oldDesc .. ",\n" .. newDesc
  else
    oldDesc = oldDesc .. "," .. newDesc
  end
  return oldDesc
end

return AvgUtil

