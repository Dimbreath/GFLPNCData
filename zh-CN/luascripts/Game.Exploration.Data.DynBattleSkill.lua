-- params : ...
-- function num : 0 , upvalues : _ENV
local DynBattleSkill = class("DynBattleSkill")
local CS_GameData_Ins = (CS.GameData).instance
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
DynBattleSkill.ctor = function(self, dataId, level, skillType)
  -- function num : 0_0 , upvalues : _ENV
  self.dataId = dataId
  self.level = level
  self.type = skillType
  self.itemId = 0
  local skillcfg = (ConfigData.battle_skill)[self.dataId]
  if skillcfg == nil then
    error("battle skill cfg is null,id:" .. tostring(self.dataId))
    return 
  end
  if not (string.IsNullOrEmpty)(skillcfg.lua_script) then
    require(PathConsts.LuaSkillScriptsPath .. skillcfg.lua_script)
  end
end

DynBattleSkill.Update = function(self, level)
  -- function num : 0_1
  self.level = level
end

DynBattleSkill.CreateByChip = function(self, dataId, level, itemId)
  -- function num : 0_2 , upvalues : DynBattleSkill, ExplorationEnum
  local skill = (DynBattleSkill.New)(dataId, level, (ExplorationEnum.eBattleSkillType).Chip)
  skill.itemId = itemId
  return skill
end

DynBattleSkill.GetLevelDescribe = function(self)
  -- function num : 0_3 , upvalues : CS_GameData_Ins
  local skillCfg = (CS_GameData_Ins.listBattleSkillDatas):GetDataById(self.dataId)
  return skillCfg:GetLevelDescribe(self.level)
end

DynBattleSkill.GetIcon = function(self)
  -- function num : 0_4 , upvalues : CS_GameData_Ins
  local skillCfg = (CS_GameData_Ins.listBattleSkillDatas):GetDataById(self.dataId)
  return skillCfg.Icon
end

DynBattleSkill.GetName = function(self)
  -- function num : 0_5 , upvalues : CS_GameData_Ins
  local skillCfg = (CS_GameData_Ins.listBattleSkillDatas):GetDataById(self.dataId)
  return skillCfg.Name
end

DynBattleSkill.IsCommonAttack = function(self)
  -- function num : 0_6 , upvalues : CS_GameData_Ins
  local skillCfg = (CS_GameData_Ins.listBattleSkillDatas):GetDataById(self.dataId)
  return skillCfg:IsCommonAttack()
end

DynBattleSkill.GetSkillTag = function(self)
  -- function num : 0_7 , upvalues : CS_GameData_Ins
  local skillCfg = (CS_GameData_Ins.listBattleSkillDatas):GetDataById(self.dataId)
  return skillCfg.SkillTag
end

DynBattleSkill.GetSkillTypeColor = function(self)
  -- function num : 0_8 , upvalues : CS_GameData_Ins
  local skillCfg = (CS_GameData_Ins.listBattleSkillDatas):GetDataById(self.dataId)
  return skillCfg.TypeColor
end

DynBattleSkill.GetSkillLabeIdList = function(self, level)
  -- function num : 0_9 , upvalues : _ENV
  local labelDic = ((ConfigData.battle_skill).skill_label_Dic)[self.dataId]
  if labelDic == nil then
    return 
  end
  local compareLv = 1
  compareLv = level == nil and self.level or level
  local tab = {}
  for id,unlockLevel in pairs(labelDic) do
    if unlockLevel <= compareLv then
      (table.insert)(tab, id)
    end
  end
  return tab
end

DynBattleSkill.PreloadSkill = function(self, effectPoolCtrl)
  -- function num : 0_10 , upvalues : _ENV
  local skillcfg = (ConfigData.battle_skill)[self.dataId]
  if skillcfg == nil then
    return 
  end
  local resloader = effectPoolCtrl.resloader
  for _,effctId in pairs(skillcfg.effect_id) do
    local effectCfg = (ConfigData.battle_creation)[effctId]
    if effectCfg ~= nil then
      resloader:LoadABAsset(effectCfg.src_name .. PathConsts.PrefabExtension)
    end
  end
end

return DynBattleSkill

