-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgUtil = {}
local CheckerTypeId, CheckerGlobalConfig = (table.unpack)(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
AvgUtil.ChangeUltSkillOrder = function(change)
  -- function num : 0_0 , upvalues : _ENV
  local window = UIManager:GetWindow(UIWindowTypeID.BattleSkillModule)
  if window ~= nil then
    (window.ultSkillNode):ChangeUltSkillUIOrder(change)
  end
end

AvgUtil.ShowMainCamera = function(active)
  -- function num : 0_1 , upvalues : _ENV
  local sceneName = ((CS.GSceneManager).Instance).curSceneName
  if (string.IsNullOrEmpty)(sceneName) then
    return 
  end
  local camCtrl = nil
  if (string.contains)(sceneName, "Arena") then
    camCtrl = (CS.CameraController).Instance
  else
    if sceneName == (Consts.SceneName).Main then
      camCtrl = (CS.OasisCameraController).Instance
    end
  end
  -- DECOMPILER ERROR at PC41: Confused about usage of register: R3 in 'UnsetPending'

  if camCtrl ~= nil and camCtrl.MainCamera ~= nil and (camCtrl.MainCamera).enabled ~= active then
    (camCtrl.MainCamera).enabled = active
  end
end

AvgUtil.GetConditionText = function(id, param1, param2)
  -- function num : 0_2 , upvalues : CheckerTypeId, _ENV, ExplorationEnum, AvgUtil
  local str = nil
  if id == CheckerTypeId.CompleteStage then
    local stageCfg = (ConfigData.sector_stage)[param1]
    if stageCfg == nil then
      error("Cant\'t find sector_stage cfg,id = " .. tostring(param1))
    end
    local diffstr = nil
    local difficult = stageCfg.difficulty
    if difficult == (ExplorationEnum.eDifficultType).Normal then
      diffstr = ConfigData:GetTipContent(TipContent.DifficultyName_1)
    else
      if difficult == (ExplorationEnum.eDifficultType).Hard then
        diffstr = ConfigData:GetTipContent(TipContent.DifficultyName_2)
      else
        diffstr = ConfigData:GetTipContent(TipContent.DifficultyName_3)
      end
    end
    local newDesc = (string.format)(ConfigData:GetTipContent(TipContent.LockTip_Sector), tostring(stageCfg.sector), tostring(stageCfg.sector), tostring(stageCfg.num), diffstr)
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
  -- function num : 0_3 , upvalues : _ENV
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

