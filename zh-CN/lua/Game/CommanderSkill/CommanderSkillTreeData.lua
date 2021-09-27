local CommanderSkillTreeData = class("CommanderSkillTreeData")
local CommanderSkillData = require("Game.CommanderSkill.CommanderSkillData")
local CommanderSkillTreeColor = {[1] = (Color.New)(0.81960784313725, 0.2156862745098, 0.30588235294118), [2] = (Color.New)(0.57, 0.82, 0.16, 1), [3] = (Color.New)(0.2156862745098, 0.54117647058824, 0.90196078431373), [4] = (Color.New)(0.49, 0.54, 0.63, 1)}
CommanderSkillTreeData.ctor = function(self, treeId)
  -- function num : 0_0 , upvalues : _ENV, CommanderSkillData
  self.treeId = treeId
  if (ConfigData.commander_skill)[treeId] == nil then
    error("can\'t read commander_skill by id:" .. treeId)
    return 
  end
  self.treeCfg = (ConfigData.commander_skill)[treeId]
  self.commanderSkillDataDic = {}
  self.slotSkillList = {[1] = 0, [2] = 0, [3] = 0}
  self.slotSkillOverloadList = {
[1] = {}
, 
[2] = {}
, 
[3] = {}
}
  local skillDicCfg = (ConfigData.commander_skill_unlock)[treeId]
  for skillId,skillCfg in pairs(skillDicCfg) do
    local commanderSkillData = (CommanderSkillData.New)(skillId, skillCfg)
    commanderSkillData:InitCmdSkillData(skillCfg.skill_type, skillCfg.place)
    -- DECOMPILER ERROR at PC47: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (self.commanderSkillDataDic)[skillId] = commanderSkillData
    if skillCfg.skill_type == (CommanderSkillData.skillType).active then
      (table.insert)((self.slotSkillOverloadList)[skillCfg.place], skillId)
      local isUnlock = commanderSkillData:IsCmdSkillUnlock()
      -- DECOMPILER ERROR at PC72: Confused about usage of register: R10 in 'UnsetPending'

      if isUnlock and (self.slotSkillList)[skillCfg.place] == 0 then
        (self.slotSkillList)[skillCfg.place] = commanderSkillData.dataId
      end
    end
  end
  self:__SortSkill()
end

CommanderSkillTreeData.IsCmdTreeUnlock = function(self)
  -- function num : 0_1 , upvalues : _ENV
  return (CheckCondition.CheckLua)((self.treeCfg).pre_condition, (self.treeCfg).pre_para1, (self.treeCfg).pre_para2)
end

CommanderSkillTreeData.GetCmdSkillTreeUnlockInfo = function(self)
  -- function num : 0_2 , upvalues : _ENV
  return (CheckCondition.GetUnlockInfoLua)((self.treeCfg).pre_condition, (self.treeCfg).pre_para1, (self.treeCfg).pre_para2)
end

CommanderSkillTreeData.SetSlotSkillList = function(self, place, skillId)
  -- function num : 0_3 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self.slotSkillList)[place] = skillId
  MsgCenter:Broadcast(eMsgEventId.OnCommanderSkillOverLoad, place, (self.commanderSkillDataDic)[skillId])
end

CommanderSkillTreeData.GetName = function(self)
  -- function num : 0_4 , upvalues : _ENV
  return (LanguageUtil.GetLocaleText)((self.treeCfg).name)
end

CommanderSkillTreeData.GetIcon = function(self)
  -- function num : 0_5
  local icon = (self.treeCfg).icon
  return icon
end

CommanderSkillTreeData.GetColor = function(self)
  -- function num : 0_6 , upvalues : CommanderSkillTreeColor
  local colorIndex = (self.treeCfg).color
  if colorIndex < 1 or colorIndex > 4 then
    return CommanderSkillTreeColor[4]
  end
  return CommanderSkillTreeColor[colorIndex]
end

CommanderSkillTreeData.GetDescribe = function(self)
  -- function num : 0_7 , upvalues : _ENV
  return (LanguageUtil.GetLocaleText)((self.treeCfg).describe)
end

CommanderSkillTreeData.GetUnlockNum = function(self, index)
  -- function num : 0_8 , upvalues : _ENV
  local totalNum = #(self.slotSkillOverloadList)[index]
  local unlockNum = 0
  for _,skillId in ipairs((self.slotSkillOverloadList)[index]) do
    if ((self.commanderSkillDataDic)[skillId]):IsCmdSkillUnlock() then
      unlockNum = unlockNum + 1
    end
  end
  return totalNum, unlockNum
end

CommanderSkillTreeData.__SortSkill = function(self)
  -- function num : 0_9 , upvalues : _ENV
  for place,list in ipairs(self.slotSkillOverloadList) do
    (table.sort)(list, sortFunc)
    local skillId = list[1]
    local skillData = (self.commanderSkillDataDic)[skillId]
    if skillData ~= nil then
      skillData:SetCmdSkillSlotDefault()
    end
  end
end

CommanderSkillTreeData.GetActiveSlotCurSkill = function(self, slotIndex)
  -- function num : 0_10
  if (self.slotSkillList)[slotIndex] ~= nil then
    return (self.slotSkillList)[slotIndex]
  else
    return 0
  end
end

CommanderSkillTreeData.GetActiveSlotOverloadSkill = function(self, slotIndex)
  -- function num : 0_11
  if (self.slotSkillOverloadList)[slotIndex] ~= nil then
    return (self.slotSkillOverloadList)[slotIndex]
  else
    return {}
  end
end

CommanderSkillTreeData.ApplySavingData = function(self, cstSkillList)
  -- function num : 0_12 , upvalues : _ENV
  local skillDicCfg = (ConfigData.commander_skill_unlock)[self.treeId]
  for _,skillId in ipairs(cstSkillList) do
    local cmdSkillData = (self.commanderSkillDataDic)[skillId]
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R9 in 'UnsetPending'

    if cmdSkillData ~= nil then
      (self.slotSkillList)[cmdSkillData.place] = skillId
    end
  end
end

CommanderSkillTreeData.GetUsingCmdSkillList = function(self)
  -- function num : 0_13 , upvalues : _ENV
  local list = {}
  for _,skillId in ipairs(self.slotSkillList) do
    if skillId ~= 0 then
      (table.insert)(list, skillId)
    end
  end
  return list
end

CommanderSkillTreeData.CSTHasOverloadSkill2Install = function(self)
  -- function num : 0_14 , upvalues : _ENV
  local hasOverloadSkill2Install = false
  for index,skillId in ipairs(self.slotSkillList) do
    local skillData = (self.commanderSkillDataDic)[skillId]
    if skillData ~= nil and skillData:CmdSkillIsSlotDefault() then
      for _,overloadeSkillId in ipairs((self.slotSkillOverloadList)[index]) do
        if overloadeSkillId ~= skillId and ((self.commanderSkillDataDic)[overloadeSkillId]):IsCmdSkillUnlock() then
          hasOverloadSkill2Install = true
          break
        end
      end
    end
  end
  return hasOverloadSkill2Install
end

return CommanderSkillTreeData

