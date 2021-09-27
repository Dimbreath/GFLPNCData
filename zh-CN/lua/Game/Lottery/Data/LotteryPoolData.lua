local LotteryPoolData = class("LotteryPoolData")
local LotteryEnum = require("Game.Lottery.LotteryEnum")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local CheckerTypeId, CheckerGlobalConfig = (table.unpack)(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
LotteryPoolData.ctor = function(self, poolId)
  -- function num : 0_0 , upvalues : _ENV
  self.poolId = poolId
  local ltrCfg = (ConfigData.lottery_para)[poolId]
  if ltrCfg == nil then
    error("Cant get lottery_para, poolId = " .. tostring(poolId))
    return 
  end
  self.ltrCfg = ltrCfg
end

LotteryPoolData.UpdLtrPoolData = function(self, LotteryStatistic)
  -- function num : 0_1
  self.total = LotteryStatistic.total
  self.pt = LotteryStatistic.pt
  self.dayNum = LotteryStatistic.dayNum
  self.specialDiscountPick = LotteryStatistic.specialDiscountPick
  self.singleFreePick = LotteryStatistic.singleFreePick
  self.pickBig = LotteryStatistic.pickBig
end

LotteryPoolData.IsLtrPoolOpen = function(self)
  -- function num : 0_2 , upvalues : _ENV, ActivityFrameEnum
  local open = false
  local activityFrame = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
  local actUid = activityFrame:GetIdByActTypeAndActId((ActivityFrameEnum.eActivityType).Lotter, (self.ltrCfg).lottery_id)
  if actUid == nil or actUid == 0 then
    open = false
  else
    open = activityFrame:GetActivityFrameState(actUid) == (ActivityFrameEnum.eActivityState).Opening
  end
  local limitNum = (self.ltrCfg).count_limit
  local countLimit = limitNum ~= 0 and limitNum <= self:GetLtrPoolTotalNum()
  if open then
    open = not countLimit
  end
  do return open end
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

LotteryPoolData.IsLtrExecTypeOpen = function(self, execType)
  -- function num : 0_3
  return ((self.ltrCfg).drawTypeDic)[execType]
end

LotteryPoolData.IsGuaranteeOpen = function(self)
  -- function num : 0_4
  if (self.ltrCfg).guaranteeType ~= nil and (self.ltrCfg).guaranteeType ~= 0 then
    return true
  else
    return false
  end
end

LotteryPoolData.IsHeroInfoBtnOpen = function(self)
  -- function num : 0_5 , upvalues : _ENV
  for k,v in pairs((self.ltrCfg).heroUpAllDic) do
    do return {true, k} end
  end
  return {false, 0}
end

LotteryPoolData.GetHeroUpPara = function(self)
  -- function num : 0_6
  return (self.ltrCfg).hero_up_para
end

LotteryPoolData.GetLtrPoolTotalNum = function(self)
  -- function num : 0_7
  return self.total or 0
end

LotteryPoolData.GetLtrPoolRemainNum = function(self)
  -- function num : 0_8
  local limitNum = (self.ltrCfg).count_limit
  if limitNum == 0 then
    return 0
  else
    return limitNum - self:GetLtrPoolTotalNum()
  end
end

LotteryPoolData.GetLtrPoolLimitNum = function(self)
  -- function num : 0_9
  return (self.ltrCfg).count_limit
end

LotteryPoolData.IsLtrExecOneceFree = function(self)
  -- function num : 0_10 , upvalues : _ENV
  if (self.ltrCfg).cd == 0 then
    return 
  end
  if self.singleFreePick == nil or (self.singleFreePick).times == 0 or (self.singleFreePick).tm < PlayerDataCenter.timestamp then
    return true
  end
end

LotteryPoolData.IsLtrExecSpecialOneceTimeOk = function(self)
  -- function num : 0_11 , upvalues : LotteryEnum, _ENV
  if not self:IsLtrExecTypeOpen((LotteryEnum.eLtrExecType).SpecialOnce) then
    return 
  end
  if self.specialDiscountPick == nil or (self.specialDiscountPick).times == 0 or (self.specialDiscountPick).tm < PlayerDataCenter.timestamp then
    return true
  end
end

LotteryPoolData.GetLtrExecSpecialOneceRemainingTs = function(self)
  -- function num : 0_12 , upvalues : _ENV
  if self.specialDiscountPick == nil then
    return -1
  end
  local remainingTs = (self.specialDiscountPick).tm - PlayerDataCenter.timestamp
  return remainingTs
end

LotteryPoolData.GetStartAndEndTime = function(self)
  -- function num : 0_13 , upvalues : _ENV, ActivityFrameEnum
  local activityFrame = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
  local actUid = activityFrame:GetIdByActTypeAndActId((ActivityFrameEnum.eActivityType).Lotter, (self.ltrCfg).lottery_id)
  local actInfo = activityFrame:GetActivityFrameData(actUid)
  if actInfo == nil then
    return -1, -1
  else
    return actInfo.startTime, actInfo.endTime
  end
end

LotteryPoolData.IsLtrPoolLimitTime = function(self)
  -- function num : 0_14
  local _, endTime = self:GetStartAndEndTime()
  do return endTime ~= -1 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

LotteryPoolData.HasLtrPt = function(self)
  -- function num : 0_15
  return (self.ltrCfg).is_pt
end

LotteryPoolData.GetLtrPtNum = function(self)
  -- function num : 0_16
  if not self:HasLtrPt() then
    return 0
  end
  return self.pt or 0
end

LotteryPoolData.GetLotteryDataNavTag = function(self)
  -- function num : 0_17
  return (self.ltrCfg).nav_tag
end

LotteryPoolData.GetLtrPoolDataCfg = function(self)
  -- function num : 0_18
  return self.ltrCfg
end

LotteryPoolData.GetTagNameAndIconIndex = function(self)
  -- function num : 0_19 , upvalues : _ENV
  return (LanguageUtil.GetLocaleText)((self.ltrCfg).nav_tagName), (self.ltrCfg).nav_tagIcon
end

LotteryPoolData.GetLtrFreeChoiceHeroIdList = function(self)
  -- function num : 0_20 , upvalues : _ENV
  local ltrSelectionCfg = (ConfigData.lottery_selection)[self.poolId]
  if ltrSelectionCfg == nil then
    error("Cant get lottery_selection, poolId = " .. tostring(self.poolId))
    return table.emptytable
  end
  local heroId2ItemIdMapDic = {}
  local heroIdList = {}
  for k,itemId in ipairs(ltrSelectionCfg.item_rewardIds) do
    local itemCfg = (ConfigData.item)[itemId]
    if itemCfg.action_type == eItemActionType.HeroCard then
      local heroId = (itemCfg.arg)[1]
      ;
      (table.insert)(heroIdList, heroId)
      heroId2ItemIdMapDic[heroId] = itemId
    else
      do
        do
          error("item is not hero, item id = " .. tostring(itemId))
          -- DECOMPILER ERROR at PC46: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC46: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC46: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  return heroIdList, heroId2ItemIdMapDic
end

LotteryPoolData.IsLtrFreeChoicePrompt = function(self)
  -- function num : 0_21
  return (self.ltrCfg).is_prompt
end

return LotteryPoolData

