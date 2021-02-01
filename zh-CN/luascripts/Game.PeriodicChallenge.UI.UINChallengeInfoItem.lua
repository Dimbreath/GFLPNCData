-- params : ...
-- function num : 0 , upvalues : _ENV
local UINChallengeInfoItem = class("UINChallengeInfoItem", UIBaseNode)
local base = UIBaseNode
local PeridicChallengeEnum = require("Game.PeriodicChallenge.PeridicChallengeEnum")
UINChallengeInfoItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.netxRefreshTimeStamp = nil
  self.dailyChallengeId = nil
  self.__Refresh = BindCallback(self, self.OnTimeRefresh)
  MsgCenter:AddListener(eMsgEventId.ChallengeOutOfData, self.__Refresh)
end

UINChallengeInfoItem.InitChallengeInfoItem = function(self, eChallengeType, infoTransform)
  -- function num : 0_1 , upvalues : _ENV, PeridicChallengeEnum
  self.eChallengeType = eChallengeType
  self:SetChallengeType(eChallengeType)
  if infoTransform ~= nil then
    self:SetParent2Node(infoTransform)
  end
  self.dailyChallengeId = (PlayerDataCenter.periodicChallengeData):GetChallengeId(eChallengeType)
  if eChallengeType == (PeridicChallengeEnum.eChallengeType).daliy then
    local counterElem = (PlayerDataCenter.periodicChallengeData):GetChallengeCounterElem(eChallengeType)
    if counterElem ~= nil then
      self.netxRefreshTimeStamp = counterElem.nextExpiredTm
      self:SetRemaindTime()
    end
    if self.dailyChallengeId ~= nil then
      local cfg = (ConfigData.daily_challenge)[self.dailyChallengeId]
      self:SetReward(cfg, counterElem)
      self:SetLevelName(cfg)
    end
  end
end

UINChallengeInfoItem.OnTimeRefresh = function(self)
  -- function num : 0_2
  self:InitChallengeInfoItem(self.eChallengeType)
end

UINChallengeInfoItem.SetChallengeType = function(self, eChallengeType)
  -- function num : 0_3
  ((self.ui).tex_TypeTile):SetIndex(eChallengeType)
end

UINChallengeInfoItem.SetLevelName = function(self, cfg)
  -- function num : 0_4 , upvalues : _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).text_LevelName).text = (LanguageUtil.GetLocaleText)(cfg.name)
end

UINChallengeInfoItem.SetReward = function(self, cfg, counterElem)
  -- function num : 0_5 , upvalues : _ENV
  local maxReward = 100
  local itemCfg = (ConfigData.item)[ConstGlobalItem.PaidSubItem]
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_RewardName).text = (LanguageUtil.GetLocaleText)(itemCfg.name)
  local pickedNum = 0
  local isFinish, stageNumber = (PlayerDataCenter.periodicChallengeData):GetDailyChallengeStage()
  if isFinish then
    pickedNum = maxReward
  else
    pickedNum = stageNumber
  end
  ;
  ((self.ui).tex_RewardNum):SetIndex(0, tostring(pickedNum), tostring(maxReward))
end

UINChallengeInfoItem.SetRemaindTime = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if self.netxRefreshTimeStamp == nil then
    if self.timer ~= nil then
      return 
    end
    return 
  end
  if self.timer ~= nil then
    return 
  else
    self:__RefreshRemaindTime()
  end
  self.timer = (TimerManager:GetTimer(3, self.__RefreshRemaindTime, self, false, false, false)):Start()
end

UINChallengeInfoItem.__RefreshRemaindTime = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local remaindTime = (math.max)((math.floor)(self.netxRefreshTimeStamp - PlayerDataCenter.timestamp), 0)
  local _, hour, min, _ = TimestampToTimeInter(remaindTime)
  if hour <= 0 then
    ((self.ui).tex_Timer):SetIndex(1, tostring(min))
  else
    ;
    ((self.ui).tex_Timer):SetIndex(0, tostring(hour), tostring(min))
  end
end

UINChallengeInfoItem.SetParent2Node = function(self, parentTransform)
  -- function num : 0_8
  (self.transform):SetParent(parentTransform)
end

UINChallengeInfoItem.OnDelete = function(self)
  -- function num : 0_9 , upvalues : _ENV, base
  if self.timer ~= nil then
    (self.timer):Stop()
    self.timer = nil
  end
  MsgCenter:RemoveListener(eMsgEventId.ChallengeOutOfData, self.__Refresh)
  ;
  (base.OnDelete)(self)
end

return UINChallengeInfoItem

