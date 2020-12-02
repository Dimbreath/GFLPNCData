-- params : ...
-- function num : 0 , upvalues : _ENV
local PlayerSkillData = class("PlayerSkillData")
local cs_GameData_ins = (CS.GameData).instance
PlayerSkillData.ctor = function(self, dataId, level)
  -- function num : 0_0 , upvalues : cs_GameData_ins, _ENV
  self.dataId = dataId
  self.level = level
  local battleSkillCfg = (cs_GameData_ins.listBattleSkillDatas):GetDataById(self.dataId)
  if battleSkillCfg == nil then
    error("Battle Skill Cfg is null,Id:" .. tostring(self.dataId))
    return 
  end
  self.battleSkillCfg = battleSkillCfg
  self.mpCost = (self.battleSkillCfg).PlayerMpCost
end

PlayerSkillData.GetName = function(self)
  -- function num : 0_1
  return (self.battleSkillCfg).Name
end

PlayerSkillData.GetIcon = function(self)
  -- function num : 0_2
  return (self.battleSkillCfg).Icon
end

PlayerSkillData.GetDescribe = function(self)
  -- function num : 0_3
  return (self.battleSkillCfg).Describe
end

PlayerSkillData.GetCurLevelDescribe = function(self)
  -- function num : 0_4
  return (self.battleSkillCfg):GetLevelDescribe(self.level)
end

PlayerSkillData.GetID = function(self)
  -- function num : 0_5
  return self.dataId
end

return PlayerSkillData

