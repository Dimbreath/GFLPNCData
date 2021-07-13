-- params : ...
-- function num : 0 , upvalues : _ENV
local UINStcChallengeInfo = class("UINStcChallengeInfo", UIBaseNode)
local base = UIBaseNode
local SectorLevelDetailEnum = require("Game.Sector.Enum.SectorLevelDetailEnum")
UINStcChallengeInfo.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINStcChallengeInfo.InitPeriodicChallenge = function(self, eChallengeType)
  -- function num : 0_1 , upvalues : SectorLevelDetailEnum
  self.detailType = (SectorLevelDetailEnum.eDetailType).PeriodicChallenge
  self.eChallengeType = eChallengeType
  ;
  ((self.ui).obj_imageAdd):SetActive(false)
  ;
  ((self.ui).tex_TypeTile):SetIndex(0)
  ;
  ((self.ui).tex_TypeTileEn):SetIndex(0)
  ;
  ((self.ui).imageIcon):SetIndex(0)
  self:RefreshPeriodicChallenge()
end

UINStcChallengeInfo.InitWeeklyChallenge = function(self, isSectorBtn)
  -- function num : 0_2 , upvalues : SectorLevelDetailEnum
  self.detailType = (SectorLevelDetailEnum.eDetailType).WeeklyChallenge
  self.isSectorBtn = isSectorBtn
  ;
  ((self.ui).obj_imageAdd):SetActive(true)
  ;
  ((self.ui).tex_TypeTile):SetIndex(1)
  ;
  ((self.ui).tex_TypeTileEn):SetIndex(1)
  ;
  ((self.ui).imageIcon):SetIndex(1)
  self:RefreshWeeklyChallenge()
end

UINStcChallengeInfo.RefreshStcChallengeInfo = function(self)
  -- function num : 0_3 , upvalues : SectorLevelDetailEnum
  if self.detailType == (SectorLevelDetailEnum.eDetailType).PeriodicChallenge then
    self:RefreshPeriodicChallenge()
  else
    if self.detailType == (SectorLevelDetailEnum.eDetailType).WeeklyChallenge then
      self:RefreshWeeklyChallenge()
    end
  end
end

UINStcChallengeInfo.RefreshPeriodicChallenge = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local _, _, moduleId = ExplorationManager:HasUncompletedEp()
  local isInEp = moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_DailyChallenge
  ;
  ((self.ui).obj_Continue):SetActive(isInEp)
  local counterElem = (PlayerDataCenter.periodicChallengeData):GetChallengeCounterElem(self.eChallengeType)
  if counterElem ~= nil then
    self.netxRefreshTimeStamp = counterElem.nextExpiredTm
    self:SetRemaindTime()
  end
  local isFinish, stageNumber, maxReward = (PlayerDataCenter.periodicChallengeData):GetDailyChallengeStage()
  if isFinish then
    ((self.ui).tex_TimeTitle):SetIndex(1)
    ;
    ((self.ui).obj_passMarker):SetActive(true)
  else
    ((self.ui).tex_TimeTitle):SetIndex(0)
    ;
    ((self.ui).obj_passMarker):SetActive(false)
  end
  ;
  ((self.ui).tex_BaseRewardNum):SetIndex(0, tostring(stageNumber), tostring(maxReward))
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

UINStcChallengeInfo.RefreshWeeklyChallenge = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local _, _, moduleId = ExplorationManager:HasUncompletedEp()
  local isInEp = moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge
  ;
  ((self.ui).obj_Continue):SetActive(isInEp)
  local isunlockExtraReward = (PlayerDataCenter.allWeeklyChallengeData):IsUnlockExtraReward()
  ;
  ((self.ui).obj_imageAdd):SetActive(isunlockExtraReward)
  local counterElem = (PlayerDataCenter.allWeeklyChallengeData):GetCounterElem()
  if counterElem ~= nil then
    self.netxRefreshTimeStamp = counterElem.nextExpiredTm
    self:SetRemaindTime()
  end
  local isFinish, baseReward, baseRewardMax, extraReward, extraRewardMax = (PlayerDataCenter.allWeeklyChallengeData):GetWeeklyChallengeReward()
  if isFinish then
    ((self.ui).tex_TimeTitle):SetIndex(1)
    ;
    ((self.ui).obj_passMarker):SetActive(true)
  else
    ((self.ui).tex_TimeTitle):SetIndex(0)
    ;
    ((self.ui).obj_passMarker):SetActive(false)
  end
  ;
  ((self.ui).tex_BaseRewardNum):SetIndex(0, tostring(baseReward), tostring(baseRewardMax))
  if isunlockExtraReward then
    ((self.ui).tex_AddRewardNum):SetIndex(0, tostring(extraReward), tostring(extraRewardMax))
  end
  if self.isSectorBtn then
    local isDouble = (PlayerDataCenter.allWeeklyChallengeData):GetIsUnderDoubleReward()
  end
  ;
  ((self.ui).obj_wc_double):SetActive(isDouble)
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

UINStcChallengeInfo.SetRemaindTime = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if self.timer ~= nil then
    (self.timer):Stop()
    self.timer = nil
  end
  if self.netxRefreshTimeStamp == nil or self.netxRefreshTimeStamp <= PlayerDataCenter.timestamp then
    return 
  end
  self:RefreshRemaindTime()
  self.timer = (TimerManager:GetTimer(1, self.RefreshRemaindTime, self, false, false, false)):Start()
end

UINStcChallengeInfo.RefreshRemaindTime = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local remaindTime = (math.max)((math.floor)(self.netxRefreshTimeStamp - PlayerDataCenter.timestamp), 0)
  local d, h, m, s = TimestampToTimeInter(remaindTime, false, true)
  if h < 10 or not tostring(h) then
    local hStr = "0" .. tostring(h)
  end
  if m < 10 or not tostring(m) then
    local mStr = "0" .. tostring(m)
  end
  if s < 10 or not tostring(s) then
    local sStr = "0" .. tostring(s)
  end
  if d > 0 then
    ((self.ui).tex_Timer):SetIndex(0, tostring(d), hStr, mStr, sStr)
  else
    ;
    ((self.ui).tex_Timer):SetIndex(1, hStr, mStr, sStr)
  end
  if remaindTime <= 0 and self.timer ~= nil then
    (self.timer):Stop()
    self.timer = nil
  end
end

UINStcChallengeInfo.OnDelete = function(self)
  -- function num : 0_8 , upvalues : base
  if self.timer ~= nil then
    (self.timer):Stop()
    self.timer = nil
  end
  ;
  (base.OnDelete)(self)
end

return UINStcChallengeInfo

