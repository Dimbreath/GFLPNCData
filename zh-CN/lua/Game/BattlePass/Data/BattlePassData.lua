local BattlePassData = class("BattlePassData")
local BattlePassEnum = require("Game.BattlePass.BattlePassEnum")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
BattlePassData.ctor = function(self, cfg)
  -- function num : 0_0
  self.passCfg = cfg
  self.id = cfg.id
end

BattlePassData.CreateBattlePass = function(battlepass, cfg)
  -- function num : 0_1 , upvalues : BattlePassData, _ENV, ActivityFrameEnum
  local passData = (BattlePassData.New)(cfg)
  local activityFrameCtr = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
  local activityId = activityFrameCtr:GetIdByActTypeAndActId((ActivityFrameEnum.eActivityType).BattlePass, passData.id)
  passData.__activityData = activityFrameCtr:GetActivityFrameData(activityId or 0)
  passData:__UpdateBattlePass(battlepass)
  return passData
end

BattlePassData.__UpdateBattlePass = function(self, battlepass)
  -- function num : 0_2 , upvalues : BattlePassEnum, _ENV, ActivityFrameEnum
  if (self.passCfg).condition ~= (BattlePassEnum.ConditionType).AchievementLevel or not (PlayerDataCenter.playerLevel).level then
    self.level = battlepass.lv
    self.exp = battlepass.exp
    self.unlockSenior = battlepass.unlockSenior
    self.taken = battlepass.taken
    self.extraPickLevel = battlepass.extraPickLevel
    self.weeklyExp = battlepass.weeklyExp
    self.unlockUltimate = battlepass.unlockUltimate
    self.weeklyNextExpiredTm = battlepass.weeklyNextExpiredTm
    self.maxlevel = ((ConfigData.battlepass).max_level)[self.id]
    self:__UpdateHaveRewardTake()
    if (self.passCfg).condition == (BattlePassEnum.ConditionType).AchievementLevel and self.maxlevel <= self.level and self.unlockSenior and not self.__haveRewardTake then
      local activityCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
      activityCtrl:HideActivityByExtraLogic((ActivityFrameEnum.eActivityType).BattlePass, self.id)
    end
  end
end

BattlePassData.UpdateBattlePass = function(self, battlepass)
  -- function num : 0_3
  self:__UpdateBattlePass(battlepass)
end

BattlePassData.GetBattlePassEndTime = function(self)
  -- function num : 0_4
  if self.__activityData == nil then
    return -1
  end
  return (self.__activityData).endTime
end

BattlePassData.IsBattlePassValid = function(self)
  -- function num : 0_5
  if self.__activityData == nil then
    return false
  end
  return (self.__activityData):GetCouldRuningActivity()
end

BattlePassData.GetBattlePassActivityId = function(self)
  -- function num : 0_6
  if self.__activityData == nil then
    return 0
  end
  return (self.__activityData).id
end

BattlePassData.IsBattleType = function(self)
  -- function num : 0_7 , upvalues : BattlePassEnum
  do return (self.passCfg).condition == (BattlePassEnum.ConditionType).BattlePassLevel end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BattlePassData.IsPassFullLevel = function(self)
  -- function num : 0_8
  do return self.maxlevel <= self.level end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BattlePassData.GetWeeklyExpLimit = function(self)
  -- function num : 0_9
  return (self.passCfg).weekly_exp
end

BattlePassData.GetPassCurLevelExp = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local level = (math.min)(self.level, self.maxlevel)
  local passLevelCfg = ((ConfigData.battlepass)[self.id])[level]
  if passLevelCfg == nil then
    error("battle pass cfg is null,id:" .. tostring(self.id) .. " level:" .. tostring(self.level))
    return 0
  end
  return passLevelCfg.exp
end

BattlePassData.TryGetExpUpgradeLevel = function(self, exp)
  -- function num : 0_11 , upvalues : _ENV
  local tmp_exp = exp
  local curExp = self.exp
  local levelup = 0
  while tmp_exp > 0 do
    local levelexp = 0
    if self.maxlevel <= self.level then
      levelexp = (((ConfigData.battlepass)[self.id])[self.maxlevel]).exp
    else
      levelexp = (((ConfigData.battlepass)[self.id])[self.level]).exp
    end
    local needExp = levelexp - curExp
    if tmp_exp < needExp then
      curExp = curExp + tmp_exp
    end
    curExp = 0
    levelup = levelup + 1
    tmp_exp = tmp_exp - needExp
  end
  do
    return levelup, curExp
  end
end

BattlePassData.GetPassLevelReward = function(self, startlevel, endlevel, containBase, containSenior)
  -- function num : 0_12 , upvalues : _ENV
  local rewardDic = {}
  for level = startlevel, endlevel do
    if self.maxlevel >= level or not containBase then
      local passLevelCfg = ((ConfigData.battlepass)[self.id])[level]
      if passLevelCfg ~= nil then
        if containBase then
          for index,itemId in pairs(passLevelCfg.base_item_ids) do
            local count = (passLevelCfg.base_item_nums)[index]
            rewardDic[itemId] = (rewardDic[itemId] or 0) + count
          end
        end
        do
          if containSenior then
            for index,itemId in pairs(passLevelCfg.senior_item_ids) do
              local count = (passLevelCfg.senior_item_nums)[index]
              rewardDic[itemId] = (rewardDic[itemId] or 0) + count
            end
          end
          do
            -- DECOMPILER ERROR at PC49: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC49: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC49: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC49: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC49: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
  local item_ids = {}
  local item_nums = {}
  for itemId,_ in pairs(rewardDic) do
    (table.insert)(item_ids, itemId)
  end
  ;
  (table.sort)(item_ids)
  for _,itemId in pairs(item_ids) do
    local itemCount = rewardDic[itemId]
    ;
    (table.insert)(item_nums, itemCount)
  end
  return item_ids, item_nums
end

BattlePassData.GetNoTakenLimitRewardCount = function(self)
  -- function num : 0_13
  local count = 0
  do
    if self.maxlevel < self.level then
      if self.maxlevel >= self.extraPickLevel or not self.extraPickLevel then
        local lastExtraPickLevel = self.maxlevel
      end
      count = self.level - lastExtraPickLevel
    end
    return count
  end
end

BattlePassData.GetPassDefaultShowLevel = function(self)
  -- function num : 0_14
  if self:IsPassFullLevel() then
    return self.maxlevel
  end
  for level = 1, self.level - 1 do
    local reward = (self.taken)[level]
    if reward == nil or not reward.base then
      return level
    end
    if self.unlockSenior and not reward.senior then
      return level
    end
  end
  return self.level
end

BattlePassData.__UpdateHaveRewardTake = function(self)
  -- function num : 0_15 , upvalues : _ENV, ActivityFrameEnum
  local havaReward = false
  if self:IsBattlePassValid() then
    local passLevelsCfg = (ConfigData.battlepass)[self.id]
    local maxLevel = (math.min)(self.level, self.maxlevel)
    for level = 1, maxLevel do
      local passLevelCfg = passLevelsCfg[level]
      if passLevelCfg ~= nil then
        local reward = (self.taken)[level]
        if (reward == nil or not reward.base) and #passLevelCfg.base_item_ids > 0 then
          havaReward = true
          break
        end
        if self.unlockSenior and (reward == nil or not reward.senior) and #passLevelCfg.senior_item_ids > 0 then
          havaReward = true
          break
        end
      end
    end
  end
  do
    self.__haveRewardTake = havaReward
    local activityFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
    activityFrameCtrl:SetReddot((ActivityFrameEnum.eActivityType).BattlePass, self.id, havaReward and 1 or 0)
  end
end

BattlePassData.PassHaveRewardTake = function(self)
  -- function num : 0_16
  return self.__haveRewardTake
end

BattlePassData.GetIsThisLeveHaveNewReward = function(self, level)
  -- function num : 0_17 , upvalues : _ENV
  local passLevelCfg = (ConfigData.battlepass)[self.id]
  do
    if passLevelCfg[level] ~= nil then
      local reward = (self.taken)[level]
      if reward == nil then
        return true
      end
      if not reward.base or level <= self.maxlevel and self.unlockSenior and not reward.senior then
        return true
      end
    end
    return false
  end
end

return BattlePassData

