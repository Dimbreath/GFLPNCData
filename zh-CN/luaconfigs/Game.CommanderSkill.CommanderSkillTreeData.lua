-- params : ...
-- function num : 0 , upvalues : _ENV
local CommanderSkillTreeData = class("CommanderSkillTreeData")
local CommanderSkillData = require("Game.CommanderSkill.CommanderSkillData")
local CommanderSkillTreeColor = {[1] = (Color.New)(0.81960784313725, 0.2156862745098, 0.30588235294118), [2] = (Color.New)(0.57, 0.82, 0.16, 1), [3] = (Color.New)(0.2156862745098, 0.54117647058824, 0.90196078431373), [4] = (Color.New)(0.49, 0.54, 0.63, 1)}
CommanderSkillTreeData.ctor = function(self, treeId, level, exp, unlock)
  -- function num : 0_0 , upvalues : _ENV, CommanderSkillData
  self.treeId = treeId
  if (ConfigData.commander_skill)[treeId] == nil then
    error("can\'t read commander_skill by id:" .. treeId)
    return 
  end
  self.treeCfg = (ConfigData.commander_skill)[treeId]
  self.level = level or 1
  local levelMax = #ConfigData.commander_skill_level
  self.level = self.level < levelMax and self.level or levelMax
  self.curExp = exp or 0
  self.isUnlock = unlock
  self.commanderSkillDataDic = {}
  self.slotSkillList = {[1] = 0, [2] = 0, [3] = 0}
  self.slotSkillOverloadList = {
[1] = {}
, 
[2] = {}
, 
[3] = {}
}
  self.slotUltimateSkillList = {[1] = 0, [2] = 0, [3] = 0}
  self.masterSkillList = {
[1] = {}
, 
[2] = {}
, 
[3] = {}
}
  self.passiveSkillList = {}
  local skillDicCfg = (ConfigData.commander_skill_unlock)[treeId]
  for skillId,skillCfg in pairs(skillDicCfg) do
    local commanderSkillData = (CommanderSkillData.New)(skillId, skillCfg)
    local isUnlock = commanderSkillData.unlockLevel <= self.level
    commanderSkillData:InitCmdSkillData(skillCfg.skill_type, isUnlock, skillCfg.place)
    commanderSkillData:UpdateCmdSkillLevel(self.level)
    -- DECOMPILER ERROR at PC92: Confused about usage of register: R14 in 'UnsetPending'

    ;
    (self.commanderSkillDataDic)[skillId] = commanderSkillData
    if skillCfg.skill_type == (CommanderSkillData.skillType).active then
      (table.insert)((self.slotSkillOverloadList)[skillCfg.place], skillId)
      -- DECOMPILER ERROR at PC116: Confused about usage of register: R14 in 'UnsetPending'

      if commanderSkillData.isUnlock and (self.slotSkillList)[skillCfg.place] == 0 then
        (self.slotSkillList)[skillCfg.place] = commanderSkillData.dataId
      end
      -- DECOMPILER ERROR at PC124: Confused about usage of register: R14 in 'UnsetPending'

      if commanderSkillData:IsCmdSkillUltimate() then
        (self.slotUltimateSkillList)[skillCfg.place] = commanderSkillData.dataId
      end
    elseif skillCfg.skill_type == (CommanderSkillData.skillType).master then
      (table.insert)((self.masterSkillList)[skillCfg.place], commanderSkillData)
      commanderSkillData:SetMasterSkilllevel(0)
    elseif skillCfg.skill_type == (CommanderSkillData.skillType).passive then
      (table.insert)(self.passiveSkillList, skillId)
    end
  end
  self:__SortSkill()
  self.OnSlotSkillChangeFuncList = {}
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

CommanderSkillTreeData.TryToUnlock = function(self)
  -- function num : 0_1 , upvalues : _ENV
  if (CheckCondition.CheckLua)((self.treeCfg).pre_condition, (self.treeCfg).pre_para1, (self.treeCfg).pre_para2) then
    (NetworkManager:GetNetwork(NetworkTypeID.CommanderSkill)):CS_COMMANDSKILL_Unlock(self.treeId)
    self.isUnlock = true
    return true
  end
  return false
end

CommanderSkillTreeData.GetCmdSkillTreeUnlockInfo = function(self)
  -- function num : 0_2 , upvalues : _ENV
  return (CheckCondition.GetUnlockInfoLua)((self.treeCfg).pre_condition, (self.treeCfg).pre_para1, (self.treeCfg).pre_para2)
end

CommanderSkillTreeData.SetLevel = function(self, level)
  -- function num : 0_3 , upvalues : _ENV, CommanderSkillData
  if type(level) ~= "number" then
    error("set commander skill tree level without num")
    return 
  end
  if level ~= self.level then
    self.level = level
    local levelMax = #ConfigData.commander_skill_level
    self.level = self.level < levelMax and self.level or levelMax
    MsgCenter:Broadcast(eMsgEventId.OnCommanderSkillLevelDiffer)
    for skillId,skillData in pairs(self.commanderSkillDataDic) do
      if not skillData.isUnlock and skillData.unlockLevel <= level then
        skillData.isUnlock = true
        if skillData.type == (CommanderSkillData.skillType).active and self:GetActiveSlotCurSkill(skillData.place) == 0 then
          self:SetSlotSkillList(skillData.place, skillId)
        end
      end
      if skillData.isUnlock then
        skillData:UpdateCmdSkillLevel(level)
      end
    end
  end
end

CommanderSkillTreeData.SetSlotSkillList = function(self, place, skillId)
  -- function num : 0_4 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self.slotSkillList)[place] = skillId
  MsgCenter:Broadcast(eMsgEventId.OnCommanderSkillOverLoad, place, (self.commanderSkillDataDic)[skillId])
end

CommanderSkillTreeData.GetName = function(self)
  -- function num : 0_5 , upvalues : _ENV
  return (LanguageUtil.GetLocaleText)((self.treeCfg).name)
end

CommanderSkillTreeData.GetIcon = function(self)
  -- function num : 0_6
  local icon = (self.treeCfg).icon
  return icon
end

CommanderSkillTreeData.GetColor = function(self)
  -- function num : 0_7 , upvalues : CommanderSkillTreeColor
  local colorIndex = (self.treeCfg).color
  if colorIndex < 1 or colorIndex > 4 then
    return CommanderSkillTreeColor[4]
  end
  return CommanderSkillTreeColor[colorIndex]
end

CommanderSkillTreeData.GetDescribe = function(self)
  -- function num : 0_8 , upvalues : _ENV
  return (LanguageUtil.GetLocaleText)((self.treeCfg).describe)
end

CommanderSkillTreeData.GetUnlockNum = function(self, index)
  -- function num : 0_9 , upvalues : _ENV
  local totalNum = #(self.slotSkillOverloadList)[index]
  local unlockNum = 0
  for _,skillId in ipairs((self.slotSkillOverloadList)[index]) do
    if ((self.commanderSkillDataDic)[skillId]).isUnlock then
      unlockNum = unlockNum + 1
    end
  end
  return totalNum, unlockNum
end

CommanderSkillTreeData.__SortSkill = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local sortFunc = function(id1, id2)
    -- function num : 0_10_0 , upvalues : self
    local skillData1 = (self.commanderSkillDataDic)[id1]
    local skillData2 = (self.commanderSkillDataDic)[id2]
    local unlockLevel1 = skillData1.unlockLevel
    local unlockLevel2 = skillData2.unlockLevel
    local isUlt1 = skillData1:IsCmdSkillUltimate()
    local isUlt2 = skillData2:IsCmdSkillUltimate()
    if unlockLevel1 == unlockLevel2 then
      if id1 >= id2 then
        do return isUlt1 ~= isUlt2 end
        do return unlockLevel1 < unlockLevel2 end
        do return isUlt2 end
        -- DECOMPILER ERROR: 5 unprocessed JMP targets
      end
    end
  end

  for place,list in ipairs(self.slotSkillOverloadList) do
    (table.sort)(list, sortFunc)
    local skillId = list[1]
    local skillData = (self.commanderSkillDataDic)[skillId]
    if skillData ~= nil then
      skillData:SetCmdSkillSlotDefault()
    end
  end
  ;
  (table.sort)(self.passiveSkillList, sortFunc)
end

CommanderSkillTreeData.GetActiveSlotCurSkill = function(self, slotIndex)
  -- function num : 0_11
  if (self.slotSkillList)[slotIndex] ~= nil then
    return (self.slotSkillList)[slotIndex]
  else
    return 0
  end
end

CommanderSkillTreeData.GetActiveSlotOverloadSkill = function(self, slotIndex)
  -- function num : 0_12
  if (self.slotSkillOverloadList)[slotIndex] ~= nil then
    return (self.slotSkillOverloadList)[slotIndex]
  else
    return {}
  end
end

CommanderSkillTreeData.UpdateTreeData = function(self, level, exp)
  -- function num : 0_13 , upvalues : _ENV
  self:SetLevel(level)
  self.curExp = exp
  MsgCenter:Broadcast(eMsgEventId.OnCommanderSkillTreeDataDiffer, self.treeId)
end

CommanderSkillTreeData.ApplySavingData = function(self, savingData)
  -- function num : 0_14 , upvalues : _ENV
  local skillDicCfg = (ConfigData.commander_skill_unlock)[self.treeId]
  for index,id in ipairs(savingData.skillActive) do
    local skillCfg = skillDicCfg[id]
    if skillCfg == nil then
      error((string.format)("Cant get commander_skill_unlock, treeId:%s, skillId:%s", self.treeId, id))
    else
      -- DECOMPILER ERROR at PC22: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (self.slotSkillList)[skillCfg.place] = id
    end
  end
  for skillId,data in pairs(savingData.skillProficient) do
    ((self.commanderSkillDataDic)[skillId]):SetMasterSkilllevel(data.level)
  end
end

CommanderSkillTreeData.CanThisTreeUpgrade = function(self, nowCouldAddExp)
  -- function num : 0_15 , upvalues : _ENV
  if #ConfigData.commander_skill_level <= self.level then
    return false
  end
  local needExp = ((ConfigData.commander_skill_level)[self.level]).exp - self.curExp
  if nowCouldAddExp == nil then
    nowCouldAddExp = (PlayerDataCenter.CommanderSkillModualData):GetAllCouldAddEXP()
  end
  do return needExp <= nowCouldAddExp end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

CommanderSkillTreeData.TryAddExp = function(self, addExp)
  -- function num : 0_16 , upvalues : _ENV
  local remaindExp = (addExp or 0) + self.curExp
  local addLevel = 0
  local curLevelExpLimit = ((ConfigData.commander_skill_level)[self.level]).exp
  while 1 do
    if curLevelExpLimit <= remaindExp then
      addLevel = addLevel + 1
      remaindExp = remaindExp - curLevelExpLimit
      local newLevel = self.level + (addLevel)
      if #ConfigData.commander_skill_level > newLevel then
        do
          curLevelExpLimit = ((ConfigData.commander_skill_level)[newLevel]).exp
          -- DECOMPILER ERROR at PC26: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC26: LeaveBlock: unexpected jumping out IF_STMT

          -- DECOMPILER ERROR at PC26: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC26: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  return self.level + (addLevel), addLevel, remaindExp, curLevelExpLimit
end

return CommanderSkillTreeData

