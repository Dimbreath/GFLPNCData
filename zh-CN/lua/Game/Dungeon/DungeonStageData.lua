local DungeonStageData = class("DungeonStageData")
DungeonStageData.eDungeonStageState = {lock = 0, unlock = 1, completed = 2, noData = 3}
DungeonStageData.CreateDungeonStageData = function(dungeonData, dungeonStageCfg)
  -- function num : 0_0 , upvalues : DungeonStageData
  local data = (DungeonStageData.New)()
  data.dungeonData = dungeonData
  data.dungeonStageCfg = dungeonStageCfg
  data:__UpdateStage()
  return data
end

DungeonStageData.ctor = function(self)
  -- function num : 0_1
  self.dungeonData = nil
  self.dungeonStageCfg = nil
  self.dungeonStageState = nil
  self.lockResone = nil
end

DungeonStageData.__UpdateStage = function(self)
  -- function num : 0_2 , upvalues : _ENV, DungeonStageData
  local isUnlock = (CheckCondition.CheckLua)((self.dungeonStageCfg).pre_condition, (self.dungeonStageCfg).pre_para1, (self.dungeonStageCfg).pre_para2)
  local isCompleted = (PlayerDataCenter.dungeonTotalBattleTimes)[self:GetDungeonStageId()] or 0 > 0
  if isUnlock then
    if isCompleted then
      self.dungeonStageState = (DungeonStageData.eDungeonStageState).completed
    else
      self.dungeonStageState = (DungeonStageData.eDungeonStageState).unlock
    end
  else
    self.dungeonStageState = (DungeonStageData.eDungeonStageState).lock
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

DungeonStageData.GetDungeonStageUnlockInfo = function(self)
  -- function num : 0_3 , upvalues : _ENV
  return (CheckCondition.GetUnlockInfoLua)((self.dungeonStageCfg).pre_condition, (self.dungeonStageCfg).pre_para1, (self.dungeonStageCfg).pre_para2)
end

DungeonStageData.GetDungeonStageId = function(self)
  -- function num : 0_4
  return (self.dungeonStageCfg).id
end

DungeonStageData.GetDungeonStageCfg = function(self)
  -- function num : 0_5
  return self.dungeonStageCfg
end

DungeonStageData.GetDungeonStageIsUnlock = function(self)
  -- function num : 0_6 , upvalues : DungeonStageData
  do return self.dungeonStageState ~= (DungeonStageData.eDungeonStageState).lock end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DungeonStageData.GetDungeonStageIsCompleted = function(self)
  -- function num : 0_7 , upvalues : DungeonStageData
  do return self.dungeonStageState == (DungeonStageData.eDungeonStageState).completed end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DungeonStageData.GetDungeonStageState = function(self)
  -- function num : 0_8
  return self.dungeonStageState
end

DungeonStageData.GetDungeonSeverType = function(self)
  -- function num : 0_9
  return (self.dungeonStageCfg).dungeon_type
end

DungeonStageData.GetThisCyclePlayedNum = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local dailyPlayedNum = 0
  local dungeonSysFuncId = (self.dungeonData):GetDungeonSystemFunctionId()
  local stageId = (self.dungeonStageCfg).id
  do
    if PlayerDataCenter.dungeonDailyBattleTimes ~= nil and (PlayerDataCenter.dungeonDailyBattleTimes)[dungeonSysFuncId] ~= nil then
      local dungeonStageDic = ((PlayerDataCenter.dungeonDailyBattleTimes)[dungeonSysFuncId]).data
      if dungeonStageDic[stageId] ~= nil then
        dailyPlayedNum = dungeonStageDic[stageId]
      end
    end
    return dailyPlayedNum
  end
end

DungeonStageData.GetCurDungeonDailyLimit = function(self)
  -- function num : 0_11
  local dailyLimit = (self.dungeonStageCfg).frequency_day
  if dailyLimit == -1 then
    return -1
  end
  local dailyPlayedNum = self:GetThisCyclePlayedNum()
  return dailyLimit - dailyPlayedNum, dailyLimit, dailyPlayedNum
end

DungeonStageData.GetIsReach2Limit = function(self)
  -- function num : 0_12
  local dailyLimit = (self.dungeonStageCfg).frequency_day
  if dailyLimit == -1 then
    return false
  end
  local dailyPlayedNum = self:GetThisCyclePlayedNum()
  do return dailyLimit <= dailyPlayedNum, dailyLimit, dailyPlayedNum end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DungeonStageData.IsHaveATHReward = function(self)
  -- function num : 0_13 , upvalues : _ENV
  local cfg = self.dungeonStageCfg
  if cfg == nil then
    return false
  end
  local norDrop = cfg.normal_drop
  for _,itemId in ipairs(norDrop) do
    local itemCfg = (ConfigData.item)[itemId]
    -- DECOMPILER ERROR at PC27: Unhandled construct in 'MakeBoolean' P1

    if itemCfg ~= nil and itemCfg.type == eItemType.Package and ((ConfigData.item).athGiftDic)[itemId] then
      return true
    end
    if itemCfg.type == eItemType.Arithmetic then
      return true
    end
  end
  for _,itemId in ipairs(cfg.first_reward_ids) do
    local itemCfg = (ConfigData.item)[itemId]
    -- DECOMPILER ERROR at PC59: Unhandled construct in 'MakeBoolean' P1

    if itemCfg ~= nil and itemCfg.type == eItemType.Package and ((ConfigData.item).athGiftDic)[itemId] then
      return true
    end
    if itemCfg.type == eItemType.Arithmetic then
      return true
    end
  end
  return false
end

DungeonStageData.GetNormalCostItemDic = function(self)
  -- function num : 0_14 , upvalues : _ENV
  if self.costItemDic then
    return self.costItemDic
  end
  local dic = {}
  for index,itemId in ipairs((self.dungeonStageCfg).cost_itemIds) do
    local num = ((self.dungeonStageCfg).cost_itemNums)[index]
    dic[itemId] = num
  end
  self.costItemDic = dic
  return dic
end

DungeonStageData.GetStaminaCost = function(self)
  -- function num : 0_15 , upvalues : _ENV
  if self.stamina then
    return self.stamina
  end
  for index,itemId in ipairs((self.dungeonStageCfg).cost_itemIds) do
    if itemId == ConstGlobalItem.SKey then
      local num = ((self.dungeonStageCfg).cost_itemNums)[index]
      self.stamina = num
      return num
    end
  end
end

DungeonStageData.Delete = function(self)
  -- function num : 0_16
end

return DungeonStageData

