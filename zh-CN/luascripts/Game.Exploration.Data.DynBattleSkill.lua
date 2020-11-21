-- params : ...
-- function num : 0 , upvalues : _ENV
local DynBattleSkill = class("DynBattleSkill")
local CS_GameData_Ins = (CS.GameData).instance
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
DynBattleSkill.ctor = function(self, dataId, level, skillType)
    -- function num : 0_0
    self.dataId = dataId
    self.level = level
    self.type = skillType
    self.itemId = 0
end

DynBattleSkill.Update = function(self, level)
    -- function num : 0_1
    self.level = level
end

DynBattleSkill.CreateByChip = function(self, dataId, level, itemId)
    -- function num : 0_2 , upvalues : DynBattleSkill, ExplorationEnum
    local skill = (DynBattleSkill.New)(dataId, level,
                                       (ExplorationEnum.eBattleSkillType).Chip)
    skill.itemId = itemId
    return skill
end

DynBattleSkill.GetLevelDescribe = function(self)
    -- function num : 0_3 , upvalues : CS_GameData_Ins
    local skillCfg = (CS_GameData_Ins.listBattleSkillDatas):GetDataById(
                         self.dataId)
    return skillCfg:GetLevelDescribe(self.level)
end

DynBattleSkill.GetIcon = function(self)
    -- function num : 0_4 , upvalues : CS_GameData_Ins
    local skillCfg = (CS_GameData_Ins.listBattleSkillDatas):GetDataById(
                         self.dataId)
    return skillCfg.Icon
end

DynBattleSkill.GetName = function(self)
    -- function num : 0_5 , upvalues : CS_GameData_Ins
    local skillCfg = (CS_GameData_Ins.listBattleSkillDatas):GetDataById(
                         self.dataId)
    return skillCfg.Name
end

DynBattleSkill.IsCommonAttack = function(self)
    -- function num : 0_6 , upvalues : CS_GameData_Ins
    local skillCfg = (CS_GameData_Ins.listBattleSkillDatas):GetDataById(
                         self.dataId)
    return skillCfg:IsCommonAttack()
end

DynBattleSkill.GetSkillTag = function(self)
    -- function num : 0_7 , upvalues : CS_GameData_Ins
    local skillCfg = (CS_GameData_Ins.listBattleSkillDatas):GetDataById(
                         self.dataId)
    return skillCfg.SkillTag
end

DynBattleSkill.GetSkillTypeColor = function(self)
    -- function num : 0_8 , upvalues : CS_GameData_Ins
    local skillCfg = (CS_GameData_Ins.listBattleSkillDatas):GetDataById(
                         self.dataId)
    return skillCfg.TypeColor
end

return DynBattleSkill

