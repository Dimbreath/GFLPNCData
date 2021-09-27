local DynBattleSkill = class("DynBattleSkill")
local CS_GameData_Ins = (CS.GameData).instance
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local cs_FormulaUtility = CS.FormulaUtility
local cs_FilePathHelper = (CS.FilePathHelper).Instance
DynBattleSkill.ctor = function(self, dataId, level, skillType, unlockAdvance)
  -- function num : 0_0 , upvalues : _ENV
  self.dataId = dataId
  self.level = level
  self.type = skillType
  self.itemId = 0
  self.unlockAdvance = unlockAdvance or false
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
  -- function num : 0_2 , upvalues : DynBattleSkill, _ENV
  local skill = (DynBattleSkill.New)(dataId, level, eBattleSkillLogicType.Chip)
  skill.itemId = itemId
  return skill
end

DynBattleSkill.GetLevelDescribe = function(self, level, unlockAdvance, isShowDetail)
  -- function num : 0_3 , upvalues : CS_GameData_Ins
  local skillCfg = (CS_GameData_Ins.listBattleSkillDatas):GetDataById(self.dataId)
  if not level then
    local lv = self.level
  end
  if not unlockAdvance then
    local unAdv = self.unlockAdvance
  end
  return skillCfg:GetLevelDescribe(lv, unAdv, isShowDetail)
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

DynBattleSkill.PreloadSkill = function(self, effectPoolCtrl, dynHero)
  -- function num : 0_10 , upvalues : _ENV, cs_FilePathHelper
  local skillcfg = (ConfigData.battle_skill)[self.dataId]
  if skillcfg == nil then
    return 
  end
  local resloader = effectPoolCtrl.resloader
  for _,effctId in pairs(skillcfg.effect_id) do
    local effectCfg = (ConfigData.battle_creation)[effctId]
    if effectCfg ~= nil and effectCfg.src_name ~= nil then
      if effectCfg.load_type == 1 then
        local path = cs_FilePathHelper:GetSkinCharacterSkillEffectPath(dynHero:GetResModelName(), dynHero:GetResModelName(true), effectCfg.src_name)
        resloader:LoadABAsset(path)
      else
        do
          do
            resloader:LoadABAsset(effectCfg.src_name .. PathConsts.PrefabExtension)
            -- DECOMPILER ERROR at PC42: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC42: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC42: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC42: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC42: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
end

DynBattleSkill.GetCurrentSkillCDTime = function(self)
  -- function num : 0_11 , upvalues : cs_FormulaUtility
  return (cs_FormulaUtility.CalculateSkillCd)(self.dataId, self.level)
end

return DynBattleSkill

