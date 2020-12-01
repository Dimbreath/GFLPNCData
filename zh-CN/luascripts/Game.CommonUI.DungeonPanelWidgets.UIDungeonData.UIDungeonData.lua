-- params : ...
-- function num : 0 , upvalues : _ENV
local UIDungeonData = class("UIDungeonData")
local ChapterState = (require("Game.CommonUI.DungeonPanelWidgets.UIDungeonData.UIDungeonConfig")).ChapterState
UIDungeonData.ctor = function(self)
  -- function num : 0_0
  self.moduelUnlock = false
  self.moduelUnlockDes = nil
  self.moduelId = -1
  self.itemId = nil
  self.itemName = nil
  self.itemNameEn = nil
  self.itemIcon = nil
  self.itemBgImg = nil
  self.desName = nil
  self.desInfo = nil
  self.dailyProgress = 0
  self.totalProgress = 0
  self.totalCompleteChapterCount = 0
  self.totalChapterCount = 0
  self.dungeonCfgList = nil
  self.dungeonUnlockDict = {}
  self.dungeonCompleteDict = {}
  self.sortParam = nil
  self.storyList = {}
  self.totalDailyLimit = 0
  self.usedDailyLimit = 0
  self.double = 0
  self.usedDouble = 0
end

UIDungeonData.CalcSelfUnlock = function(self)
  -- function num : 0_1 , upvalues : _ENV
  local funcUnLockCrtl = ControllerManager:GetController(ControllerTypeId.FunctionUnlock, true)
  self.moduelUnlock = funcUnLockCrtl:ValidateUnlock(self.moduelId)
  if not self.moduelUnlock then
    self.moduelUnlockDes = funcUnLockCrtl:GetFuncUnlockDecription(self.moduelId)
  end
end

UIDungeonData.CalcUnLockedAndProgress = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self.dungeonCfgList == nil then
    return 
  end
  local dailyCompleteCount = 0
  local totalCompleteCount = 0
  if self.moduelId == -1 then
    return 
  end
  local dailyDungeonCompletedDict = nil
  if (PlayerDataCenter.dungeonDailyBattleTimes)[self.moduelId] ~= nil then
    dailyDungeonCompletedDict = ((PlayerDataCenter.dungeonDailyBattleTimes)[self.moduelId]).data
  end
  self.totalChapterCount = #self.dungeonCfgList
  if self.totalChapterCount <= 0 then
    self.usedDailyLimit = 0
    self.usedDouble = 0
    self.dailyProgress = 0
    self.totalProgress = 0
    return 
  end
  local tempDict = {}
  for _,v in ipairs(self.dungeonCfgList) do
    tempDict[v.id] = v
    local isFulfillCondition = ((CheckCondition.CheckLua)(v.pre_condition, v.pre_para1, v.pre_para2))
    local fillConditionText = nil
    if not isFulfillCondition then
      fillConditionText = (CheckCondition.GetUnlockInfoLua)(v.pre_condition, v.pre_para1, v.pre_para2)
    end
    -- DECOMPILER ERROR at PC58: Confused about usage of register: R12 in 'UnsetPending'

    ;
    (self.dungeonUnlockDict)[v.id] = fillConditionText
  end
  self.usedDailyLimit = 0
  self.usedDouble = 0
  if dailyDungeonCompletedDict ~= nil then
    for k,v in pairs(dailyDungeonCompletedDict) do
      if tempDict[k] ~= nil then
        dailyCompleteCount = dailyCompleteCount + 1
        self.usedDailyLimit = self.usedDailyLimit + v
        self.usedDouble = self.usedDouble + v
      end
    end
  end
  do
    self.dailyProgress = (dailyCompleteCount) * 100 // self.totalChapterCount
    if PlayerDataCenter.dungeonTotalBattleTimes ~= nil then
      for k,v in pairs(PlayerDataCenter.dungeonTotalBattleTimes) do
        -- DECOMPILER ERROR at PC98: Confused about usage of register: R10 in 'UnsetPending'

        if tempDict[k] ~= nil then
          (self.dungeonCompleteDict)[k] = true
          totalCompleteCount = totalCompleteCount + 1
        end
      end
    end
    do
      self.totalCompleteChapterCount = totalCompleteCount
      self.totalProgress = (totalCompleteCount) * 100 // self.totalChapterCount
    end
  end
end

UIDungeonData.GetChapterState = function(self, chapterId)
  -- function num : 0_3 , upvalues : ChapterState
  local itemState = ChapterState.lock
  if (self.dungeonCompleteDict)[chapterId] == true then
    itemState = ChapterState.completed
    return itemState
  end
  if (self.dungeonUnlockDict)[chapterId] == nil then
    itemState = ChapterState.unlock
    return itemState
  end
  return itemState, (self.dungeonUnlockDict)[chapterId]
end

UIDungeonData.ForceUpdate = function(self)
  -- function num : 0_4
  self:CalcSelfUnlock()
  self:CalcUnLockedAndProgress()
end

UIDungeonData.IsDouble = function(self, dungeon_type)
  -- function num : 0_5 , upvalues : _ENV
  if not dungeon_type then
    dungeon_type = ((self.dungeonCfgList)[1]).dungeon_type
  end
  local timePassCtrl = ControllerManager:GetController(ControllerTypeId.TimePass, true)
  local weekNum = timePassCtrl:GetLogicWeekNum()
  if weekNum == nil then
    self.isDouble = false
    return false
  else
    local logics = (PlayerDataCenter.serverLogic)[eLogicType.DungeonRewardRate]
    if logics == nil then
      self.isDouble = false
      return false
    end
    for _,logic in pairs(logics) do
      if logic[1] == dungeon_type and logic[2] == weekNum then
        self.isDouble = true
        return true
      end
    end
  end
end

return UIDungeonData

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIDungeonData = class("UIDungeonData")
local ChapterState = (require(
                         "Game.CommonUI.DungeonPanelWidgets.UIDungeonData.UIDungeonConfig")).ChapterState
UIDungeonData.ctor = function(self)
    -- function num : 0_0
    self.moduelUnlock = false
    self.moduelUnlockDes = nil
    self.moduelId = -1
    self.itemId = nil
    self.itemName = nil
    self.itemNameEn = nil
    self.itemIcon = nil
    self.itemBgImg = nil
    self.desName = nil
    self.desInfo = nil
    self.dailyProgress = 0
    self.totalProgress = 0
    self.totalCompleteChapterCount = 0
    self.totalChapterCount = 0
    self.dungeonCfgList = nil
    self.dungeonUnlockDict = {}
    self.dungeonCompleteDict = {}
    self.sortParam = nil
    self.storyList = {}
    self.totalDailyLimit = 0
    self.usedDailyLimit = 0
    self.double = 0
    self.usedDouble = 0
end

UIDungeonData.CalcSelfUnlock = function(self)
    -- function num : 0_1 , upvalues : _ENV
    local funcUnLockCrtl = ControllerManager:GetController(
                               ControllerTypeId.FunctionUnlock, true)
    self.moduelUnlock = funcUnLockCrtl:ValidateUnlock(self.moduelId)
    if not self.moduelUnlock then
        self.moduelUnlockDes = funcUnLockCrtl:GetFuncUnlockDecription(
                                   self.moduelId)
    end
end

UIDungeonData.CalcUnLockedAndProgress = function(self)
    -- function num : 0_2 , upvalues : _ENV
    if self.dungeonCfgList == nil then return end
    local dailyCompleteCount = 0
    local totalCompleteCount = 0
    if self.moduelId == -1 then return end
    local dailyDungeonCompletedDict = nil
    if (PlayerDataCenter.dungeonDailyBattleTimes)[self.moduelId] ~= nil then
        dailyDungeonCompletedDict =
            ((PlayerDataCenter.dungeonDailyBattleTimes)[self.moduelId]).data
    end
    self.totalChapterCount = #self.dungeonCfgList
    if self.totalChapterCount <= 0 then
        self.usedDailyLimit = 0
        self.usedDouble = 0
        self.dailyProgress = 0
        self.totalProgress = 0
        return
    end
    local tempDict = {}
    for _, v in ipairs(self.dungeonCfgList) do
        tempDict[v.id] = v
        local isFulfillCondition = ((CheckCondition.CheckLua)(v.pre_condition,
                                                              v.pre_para1,
                                                              v.pre_para2))
        local fillConditionText = nil
        if not isFulfillCondition then
            fillConditionText = (CheckCondition.GetUnlockInfoLua)(
                                    v.pre_condition, v.pre_para1, v.pre_para2)
        end -- DECOMPILER ERROR at PC58: Confused about usage of register: R12 in 'UnsetPending'
        
        (self.dungeonUnlockDict)[v.id] = fillConditionText
    end
    self.usedDailyLimit = 0
    self.usedDouble = 0
    if dailyDungeonCompletedDict ~= nil then
        for k, v in pairs(dailyDungeonCompletedDict) do
            if tempDict[k] ~= nil then
                dailyCompleteCount = dailyCompleteCount + 1
                self.usedDailyLimit = self.usedDailyLimit + v
                self.usedDouble = self.usedDouble + v
            end
        end
    end
    do
        self.dailyProgress = (dailyCompleteCount) * 100 //
                                 self.totalChapterCount
        if PlayerDataCenter.dungeonTotalBattleTimes ~= nil then
            for k, v in pairs(PlayerDataCenter.dungeonTotalBattleTimes) do
                -- DECOMPILER ERROR at PC98: Confused about usage of register: R10 in 'UnsetPending'

                if tempDict[k] ~= nil then
                    (self.dungeonCompleteDict)[k] = true
                    totalCompleteCount = totalCompleteCount + 1
                end
            end
        end
        do
            self.totalCompleteChapterCount = totalCompleteCount
            self.totalProgress = (totalCompleteCount) * 100 //
                                     self.totalChapterCount
        end
    end
end

UIDungeonData.GetChapterState = function(self, chapterId)
    -- function num : 0_3 , upvalues : ChapterState
    local itemState = ChapterState.lock
    if (self.dungeonCompleteDict)[chapterId] == true then
        itemState = ChapterState.completed
        return itemState
    end
    if (self.dungeonUnlockDict)[chapterId] == nil then
        itemState = ChapterState.unlock
        return itemState
    end
    return itemState, (self.dungeonUnlockDict)[chapterId]
end

UIDungeonData.ForceUpdate = function(self)
    -- function num : 0_4
    self:CalcSelfUnlock()
    self:CalcUnLockedAndProgress()
end

UIDungeonData.IsDouble = function(self, dungeon_type)
    -- function num : 0_5 , upvalues : _ENV
    if not dungeon_type then
        dungeon_type = ((self.dungeonCfgList)[1]).dungeon_type
    end
    local timePassCtrl = ControllerManager:GetController(
                             ControllerTypeId.TimePass, true)
    local weekNum = timePassCtrl:GetLogicWeekNum()
    if weekNum == nil then
        self.isDouble = false
        return false
    else
        local logics =
            (PlayerDataCenter.serverLogic)[eLogicType.DungeonRewardRate]
        if logics == nil then
            self.isDouble = false
            return false
        end
        for _, logic in pairs(logics) do
            if logic[1] == dungeon_type and logic[2] == weekNum then
                self.isDouble = true
                return true
            end
        end
    end
end

return UIDungeonData

