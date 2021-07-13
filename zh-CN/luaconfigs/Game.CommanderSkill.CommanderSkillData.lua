-- params : ...
-- function num : 0 , upvalues : _ENV
local CommanderSkillData = class("CommanderSkillData")
local cs_GameData_ins = (CS.GameData).instance
CommanderSkillData.skillType = {active = 1, passive = 2, master = 3}
CommanderSkillData.ctor = function(self, dataId, skillCfg)
  -- function num : 0_0 , upvalues : CommanderSkillData, cs_GameData_ins, _ENV
  self.dataId = dataId
  self.skillCfg = skillCfg
  self.unlockLevel = (skillCfg.unlockList)[1]
  self.unlockLevelList = skillCfg.unlockList
  self.maxLevel = #skillCfg.unlockList
  self.level = 1
  self.levelIconList = skillCfg.levelIconList
  self.isUnlock = false
  self.type = (CommanderSkillData.skillType).passive
  self.place = 0
  self.isNewUnlock = false
  local battleSkillCfg = (cs_GameData_ins.listBattleSkillDatas):GetDataById(self.dataId)
  if battleSkillCfg == nil then
    error("Battle Skill Cfg is null,Id:" .. tostring(self.dataId))
    return 
  end
  self.battleSkillCfg = battleSkillCfg
  self.mpCost = (self.battleSkillCfg).PlayerMpCost
end

CommanderSkillData.InitCmdSkillData = function(self, type, isUnlock, place)
  -- function num : 0_1
  self.type = type
  self.isUnlock = isUnlock
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

CommanderSkillData.GetDescribe = function(self, level)
  -- function num : 0_4
  if not level then
    local des = (self.battleSkillCfg):GetLevelDescribe(self.level)
    if des == "" then
      des = (self.battleSkillCfg).Describe
    end
    return des
  end
end

CommanderSkillData.GetCmdSkillBaseDescribe = function(self)
  -- function num : 0_5 , upvalues : _ENV
  return (LanguageUtil.GetLocaleText)((self.skillCfg).describe_base)
end

CommanderSkillData.GetCmdSkillAdvDescribe = function(self, level)
  -- function num : 0_6 , upvalues : _ENV
  local des = (LanguageUtil.GetLocaleText)(((self.skillCfg).levelDescDic)[level])
  return des
end

CommanderSkillData.IsAdvanceCmdSkill = function(self)
  -- function num : 0_7
  do return self.maxLevel > 1 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

CommanderSkillData.GetID = function(self)
  -- function num : 0_8
  return self.dataId
end

CommanderSkillData.UpdateCmdSkillLevel = function(self, treeLevel)
  -- function num : 0_9
  for lv = self.level, self.maxLevel do
    local unlockTreeLv = (self.unlockLevelList)[lv]
    if unlockTreeLv <= treeLevel then
      self.level = lv
    else
      break
    end
  end
end

CommanderSkillData.GetCmdSkillUnlockTreeLevel = function(self, skillLevel)
  -- function num : 0_10
  return (self.unlockLevelList)[skillLevel]
end

CommanderSkillData.SetMasterSkilllevel = function(self, level)
  -- function num : 0_11
  self.masterLevel = level or 0
end

CommanderSkillData.GetMasterSkilllevel = function(self)
  -- function num : 0_12
  return self.masterLevel
end

CommanderSkillData.GetMasterSkillAddVaule = function(self)
  -- function num : 0_13 , upvalues : _ENV
  local hasPercentSign = false
  local value = nil
  if self.masterLevel == 0 then
    value = "0"
  else
    value = (self.battleSkillCfg):GetLevelArgValue(self.masterLevel, 0)
    if (string.match)((self.battleSkillCfg).DescribeLv, "{0}%%") ~= nil then
      hasPercentSign = true
    end
  end
  if hasPercentSign then
    return tostring(GetPreciseDecimalStr(value, 0)) .. "%"
  end
  return tostring(GetPreciseDecimalStr(value, 0))
end

CommanderSkillData.IsCmdSkillUltimate = function(self)
  -- function num : 0_14
  return (self.skillCfg).is_ultimate
end

CommanderSkillData.SetCmdSkillSlotDefault = function(self)
  -- function num : 0_15
  self.isSlotDefault = true
end

CommanderSkillData.CmdSkillIsSlotDefault = function(self)
  -- function num : 0_16
  return self.isSlotDefault
end

CommanderSkillData.CmdSkillIsManualMode = function(self)
  -- function num : 0_17
  return (self.battleSkillCfg).ManualMode
end

return CommanderSkillData

