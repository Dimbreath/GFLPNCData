local CommanderSkillData = class("CommanderSkillData")
local cs_GameData_ins = (CS.GameData).instance
CommanderSkillData.skillType = {active = 1, passive = 2, master = 3}
CommanderSkillData.ctor = function(self, dataId, skillCfg)
  -- function num : 0_0 , upvalues : CommanderSkillData, cs_GameData_ins, _ENV
  self.dataId = dataId
  self.skillCfg = skillCfg
  self.levelIconList = skillCfg.levelIconList
  self.type = (CommanderSkillData.skillType).passive
  self.place = 0
  self.isNewUnlock = false
  if skillCfg.unlockPreConditionList ~= nil then
    self.unlockCondition = (skillCfg.unlockPreConditionList)[1]
  end
  local battleSkillCfg = (cs_GameData_ins.listBattleSkillDatas):GetDataById(self.dataId)
  if battleSkillCfg == nil then
    error("Battle Skill Cfg is null,Id:" .. tostring(self.dataId))
    return 
  end
  self.battleSkillCfg = battleSkillCfg
  self.mpCost = (self.battleSkillCfg).PlayerMpCost
  self.cdTime = (BattleUtil.FrameToTime)((self.battleSkillCfg).CdTime)
end

CommanderSkillData.InitCmdSkillData = function(self, type, place)
  -- function num : 0_1
  self.type = type
  self.place = place
end

CommanderSkillData.GetName = function(self)
  -- function num : 0_2
  return (self.battleSkillCfg).Name
end

CommanderSkillData.GetIcon = function(self)
  -- function num : 0_3
  return (self.battleSkillCfg).Icon
end

CommanderSkillData.GetDescribe = function(self)
  -- function num : 0_4
  local des = (self.battleSkillCfg):GetLevelDescribe(1)
  if des == "" then
    des = (self.battleSkillCfg).Describe
  end
  return des
end

CommanderSkillData.GetID = function(self)
  -- function num : 0_5
  return self.dataId
end

CommanderSkillData.IsCmdSkillUnlock = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if self.unlockCondition == nil then
    return true
  end
  return (CheckCondition.CheckLua)((self.unlockCondition).pre_condition, (self.unlockCondition).pre_para1, (self.unlockCondition).pre_para2)
end

CommanderSkillData.SetCmdSkillSlotDefault = function(self)
  -- function num : 0_7
  self.isSlotDefault = true
end

CommanderSkillData.CmdSkillIsSlotDefault = function(self)
  -- function num : 0_8
  return self.isSlotDefault
end

CommanderSkillData.CmdSkillIsManualMode = function(self)
  -- function num : 0_9
  return (self.battleSkillCfg).ManualMode
end

CommanderSkillData.GetUnlockDes = function(self)
  -- function num : 0_10 , upvalues : _ENV
  if self.unlockCondition == nil then
    return nil
  end
  return (CheckCondition.GetUnlockInfoLua)((self.unlockCondition).pre_condition, (self.unlockCondition).pre_para1, (self.unlockCondition).pre_para2)
end

CommanderSkillData.GetCmdSkillIconById = function(skillId)
  -- function num : 0_11 , upvalues : cs_GameData_ins, _ENV
  local battleSkillCfg = (cs_GameData_ins.listBattleSkillDatas):GetDataById(skillId)
  if battleSkillCfg == nil then
    error("Battle Skill Cfg is null,Id:" .. tostring(skillId))
    return 
  end
  return battleSkillCfg.Icon
end

return CommanderSkillData

