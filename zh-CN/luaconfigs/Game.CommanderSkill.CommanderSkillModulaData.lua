-- params : ...
-- function num : 0 , upvalues : _ENV
local CommanderSkillModulaData = class("CommanderSkillModulaData")
local CommanderSkillTreeData = require("Game.CommanderSkill.CommanderSkillTreeData")
CommanderSkillModulaData.ctor = function(self, masterLevel, masterExp, treeMsg)
  -- function num : 0_0
  self.CommanderSkillTreeDataDic = {}
  self.masterLevel = masterLevel
  self.masterExp = masterExp
  self.masterSkillPoint = {[1] = 0, [2] = 0, [3] = 0}
  self.lastDiff = {differMsg = nil, oldTreelevel = nil, oldTreeExp = nil, oldMasterlevel = nil, oldMasterExp = nil}
  self:UpdateMasterPoint(masterLevel)
  self:InitCommanderSkillTreeDataDic(treeMsg)
end

CommanderSkillModulaData.InitCommanderSkillTreeDataDic = function(self, treeMsg)
  -- function num : 0_1 , upvalues : _ENV, CommanderSkillTreeData
  local treeCfg = ConfigData.commander_skill
  if treeCfg == nil then
    error("commander_skill read error")
  end
  if treeMsg == nil then
    for treeId,cfg in pairs(treeCfg) do
      local SkillTreeData = (CommanderSkillTreeData.New)(treeId)
      SkillTreeData:TryToUnlock()
      -- DECOMPILER ERROR at PC19: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (self.CommanderSkillTreeDataDic)[treeId] = SkillTreeData
    end
  else
    do
      for treeId,cfg in pairs(treeCfg) do
        local treeData = treeMsg[treeId]
        local SkillTreeData = nil
        if treeData == nil then
          SkillTreeData = (CommanderSkillTreeData.New)(treeId)
          SkillTreeData:TryToUnlock()
        else
          SkillTreeData = (CommanderSkillTreeData.New)(treeId, treeData.level, treeData.exp, true)
        end
        -- DECOMPILER ERROR at PC46: Confused about usage of register: R10 in 'UnsetPending'

        ;
        (self.CommanderSkillTreeDataDic)[treeId] = SkillTreeData
      end
    end
  end
end

CommanderSkillModulaData.UpdateMasterLevelAndExp = function(self, masterLevel, masterExp)
  -- function num : 0_2 , upvalues : _ENV
  if not masterLevel then
    self.masterLevel = self.masterLevel
    if not masterExp then
      self.masterExp = self.masterExp
      self:UpdateMasterPoint(masterLevel)
      MsgCenter:Broadcast(eMsgEventId.OnCommanderSkillMasterLevelDiffer)
    end
  end
end

CommanderSkillModulaData.UpdateMasterPoint = function(self, mastLevel)
  -- function num : 0_3 , upvalues : _ENV
  if mastLevel == 0 then
    return 
  end
  local levelCfg = ConfigData.commander_skill_master_level
  if levelCfg == nil or levelCfg[mastLevel] == nil then
    error("commander_skill_master_level read error")
    return 
  end
  for index,point in ipairs((levelCfg[mastLevel]).master_point) do
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R8 in 'UnsetPending'

    (self.masterSkillPoint)[index] = point
  end
end

CommanderSkillModulaData.CreatDefaultFormationCST = function(self, formId, isTempData)
  -- function num : 0_4 , upvalues : _ENV, CommanderSkillTreeData
  local defaultTreeId = (ConfigData.game_config).FormationDefaultCommanderSkillTree
  local CST = {}
  local defaultCSTSaving = {}
  defaultCSTSaving.skillActive = {}
  defaultCSTSaving.skillProficient = {}
  local skillDicCfg = (ConfigData.commander_skill_unlock)[defaultTreeId]
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R7 in 'UnsetPending'

  if (self.CommanderSkillTreeDataDic)[defaultTreeId] == nil then
    (self.CommanderSkillTreeDataDic)[defaultTreeId] = (CommanderSkillTreeData.New)(defaultTreeId)
  end
  local defaultTreeLevel = ((self.CommanderSkillTreeDataDic)[defaultTreeId]).level
  local slotSkillDic = {}
  for skillId,skillCfg in pairs(skillDicCfg) do
    local unlockLevel = (skillCfg.unlockList)[1]
    if skillCfg.skill_type == 1 and unlockLevel <= defaultTreeLevel and slotSkillDic[skillCfg.place] == nil then
      (table.insert)(defaultCSTSaving.skillActive, skillId)
      slotSkillDic[skillCfg.place] = skillId
    end
  end
  ;
  (table.sort)(defaultCSTSaving.skillActive, function(skillIdA, skillIdB)
    -- function num : 0_4_0 , upvalues : skillDicCfg
    do return (skillDicCfg[skillIdA]).place < (skillDicCfg[skillIdB]).place end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  if not isTempData then
    (NetworkManager:GetNetwork(NetworkTypeID.CommanderSkill)):CS_COMMANDSKILL_SaveFromFormation(formId, defaultTreeId, defaultCSTSaving)
  end
  CST.saving = defaultCSTSaving
  CST.treeId = defaultTreeId
  return CST
end

CommanderSkillModulaData.CreateSavingData = function(self, treeId)
  -- function num : 0_5 , upvalues : _ENV
  local treeData = (self.CommanderSkillTreeDataDic)[treeId]
  local defaultCSTSaving = {}
  defaultCSTSaving.skillActive = {}
  for k,skillId in ipairs(treeData.slotSkillList) do
    if skillId ~= 0 then
      (table.insert)(defaultCSTSaving.skillActive, skillId)
    end
  end
  defaultCSTSaving.skillProficient = {}
  for place,masterSkillList in ipairs(treeData.masterSkillList) do
    for _,skillData in ipairs(masterSkillList) do
      local level = skillData:GetMasterSkilllevel()
      -- DECOMPILER ERROR at PC38: Confused about usage of register: R15 in 'UnsetPending'

      if level > 0 then
        (defaultCSTSaving.skillProficient)[skillData.dataId] = {id = skillData.dataId, level = level}
      end
    end
  end
  return defaultCSTSaving
end

CommanderSkillModulaData.GetCSLastDiff = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local lastDiff = (table.deepCopy)(self.lastDiff)
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self.lastDiff).differMsg = nil
  return lastDiff
end

CommanderSkillModulaData.GetIsHaveCouldUpgradeCST = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local totalCouldAddExp = self:GetAllCouldAddEXP()
  for treeId,treeData in pairs(self.CommanderSkillTreeDataDic) do
    if treeData:CanThisTreeUpgrade(totalCouldAddExp) then
      return true
    end
  end
  return false
end

CommanderSkillModulaData.GetAllCouldAddEXP = function(self)
  -- function num : 0_8 , upvalues : _ENV
  local totalCouldAddExp = 0
  for _,id in ipairs(((ConfigData.item).growUpIds)[eItemActionType.CommanderSkillExp]) do
    if (PlayerDataCenter.itemDic)[id] ~= nil then
      local itemData = (PlayerDataCenter.itemDic)[id]
      local couldAddExp = itemData:GetActionArg(1) * itemData:GetCount()
      totalCouldAddExp = totalCouldAddExp + couldAddExp
    end
  end
  return totalCouldAddExp
end

return CommanderSkillModulaData

