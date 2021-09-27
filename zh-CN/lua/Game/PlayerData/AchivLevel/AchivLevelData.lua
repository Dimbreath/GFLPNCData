local AchivLevelData = class("AchivLevelData")
local CommonLogicUtil = require("Game.Common.CommonLogicUtil.CommonLogicUtil")
AchivLevelData.ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.pickedRewardLevels = {}
  self.pickedAchivsAll = {}
  self.pickedAchNum = nil
  self.pickedRewardAchivs = {}
  for k,v in ipairs(ConfigData.achievement) do
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R6 in 'UnsetPending'

    (self.pickedRewardAchivs)[v.task_type] = {}
  end
end

AchivLevelData.InitPickedLevels = function(self, dataTab)
  -- function num : 0_1
  if not dataTab then
    self.pickedRewardLevels = {}
    self:__InitLevelRewardRedDot()
  end
end

AchivLevelData.InitPickedAchivs = function(self, dataTab)
  -- function num : 0_2 , upvalues : _ENV
  if not dataTab then
    self.pickedAchivsAll = {}
    for taskId,completedTimestamp in pairs(self.pickedAchivsAll) do
      local taskCfg = (ConfigData.task)[taskId]
      if taskCfg == nil then
        error("Cant\'t find task by id, id = " .. tostring(taskId))
      else
        local achivTab = (self.pickedRewardAchivs)[taskCfg.type]
        if achivTab == nil then
          error("Cant\'t find pickedRewardAchivs by type, type = " .. tostring(taskCfg.type))
        else
          local pickedAchivData = self:__NewPickedAchivData(taskId, completedTimestamp)
          ;
          (table.insert)(achivTab, pickedAchivData)
        end
      end
    end
  end
end

AchivLevelData.AddPickedAchivs = function(self, pickedTab)
  -- function num : 0_3 , upvalues : _ENV
  local update = false
  for taskId,completedTimestamp in pairs(pickedTab) do
    local taskCfg = (ConfigData.task)[taskId]
    if taskCfg == nil then
      error("Cant\'t find task by id, id = " .. tostring(taskId))
      return 
    end
    local achivTab = (self.pickedRewardAchivs)[taskCfg.type]
    if achivTab == nil then
      error("Cant\'t find pickedRewardAchivs by type, type = " .. tostring(taskCfg.type))
      return 
    end
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (self.pickedAchivsAll)[taskId] = completedTimestamp
    if self.pickedAchNum ~= nil then
      self.pickedAchNum = self.pickedAchNum + 1
    end
    local pickedAchivData = self:__NewPickedAchivData(taskId, completedTimestamp)
    ;
    (table.insert)(achivTab, pickedAchivData)
    update = true
  end
  if update then
    MsgCenter:Broadcast(eMsgEventId.UpdatePickedAchivTask)
  end
end

AchivLevelData.__NewPickedAchivData = function(self, taskId, completedTimestamp)
  -- function num : 0_4
  local pickedAchivData = {taskId = taskId, completedTimestamp = completedTimestamp}
  return pickedAchivData
end

AchivLevelData.AddPickedLevel = function(self, levelTab)
  -- function num : 0_5 , upvalues : _ENV
  local update = false
  for id,bool in pairs(levelTab) do
    -- DECOMPILER ERROR at PC6: Confused about usage of register: R8 in 'UnsetPending'

    (self.pickedRewardLevels)[id] = bool
    update = true
  end
  if update then
    self:UpdateLevelRewardRedDot()
    MsgCenter:Broadcast(eMsgEventId.UpdatePickedRewardLevel, false, false)
  end
end

AchivLevelData.__InitLevelRewardRedDot = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local node = RedDotController:AddRedDotNodeWithPath(RedDotDynPath.AchivLevelReward, RedDotStaticTypeId.Main, RedDotStaticTypeId.AchivLevel, RedDotStaticTypeId.AchivLevelReward)
  local count = self:__GenLevelRewardRedDotCount()
  node:SetRedDotCount(count)
end

AchivLevelData.UpdateLevelRewardRedDot = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.AchivLevel, RedDotStaticTypeId.AchivLevelReward)
  if ok then
    local count = self:__GenLevelRewardRedDotCount()
    node:SetRedDotCount(count)
  end
end

AchivLevelData.__GenLevelRewardRedDotCount = function(self)
  -- function num : 0_8 , upvalues : _ENV
  local count = 0
  for i = 2, (PlayerDataCenter.playerLevel).level do
    if (self.pickedRewardLevels)[i] == nil then
      count = count + 1
    end
  end
  return count
end

AchivLevelData.GetPickedAchNum = function(self)
  -- function num : 0_9 , upvalues : _ENV
  if self.pickedAchNum == nil then
    self.pickedAchNum = (table.count)(self.pickedAchivsAll)
  end
  return self.pickedAchNum
end

AchivLevelData.GetTotalAchNum = function(self)
  -- function num : 0_10 , upvalues : _ENV
  return self:GetPickedAchNum() + (PlayerDataCenter.allTaskData).achievementTaskNum
end

AchivLevelData.GetLevelLogics = function(self, level)
  -- function num : 0_11 , upvalues : _ENV, CommonLogicUtil
  local cfg = (ConfigData.achievement_level)[level]
  local front_cfg = (ConfigData.achievement_level)[level - 1]
  return (CommonLogicUtil.MinLogicCfg)(cfg, front_cfg)
end

return AchivLevelData

