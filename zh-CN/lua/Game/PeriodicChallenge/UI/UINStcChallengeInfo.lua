local UINStcChallengeInfo = class("UINStcChallengeInfo", UIBaseNode)
local base = UIBaseNode
local SectorLevelDetailEnum = require("Game.Sector.Enum.SectorLevelDetailEnum")
local eDungeonEnum = require("Game.Dungeon.eDungeonEnum")
UINStcChallengeInfo.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINStcChallengeInfo.InitDailyDgEnterBtn = function(self)
  -- function num : 0_1 , upvalues : SectorLevelDetailEnum
  self.detailType = (SectorLevelDetailEnum.eDetailType).DailyDungeon
  ;
  ((self.ui).tex_TypeTile):SetIndex(0)
  ;
  ((self.ui).tex_TypeTileEn):SetIndex(0)
  ;
  ((self.ui).imageIcon):SetIndex(0)
  self:RefreshDailyDgEnterBtn()
end

UINStcChallengeInfo.InitWeeklyChallenge = function(self, isSectorBtn)
  -- function num : 0_2 , upvalues : SectorLevelDetailEnum
  self.detailType = (SectorLevelDetailEnum.eDetailType).WeeklyChallenge
  self.isSectorBtn = isSectorBtn
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
  if self.detailType == (SectorLevelDetailEnum.eDetailType).DailyDungeon then
    self:RefreshDailyDgEnterBtn()
  else
    if self.detailType == (SectorLevelDetailEnum.eDetailType).WeeklyChallenge then
      self:RefreshWeeklyChallenge()
    end
  end
end

UINStcChallengeInfo.RefreshDailyDgEnterBtn = function(self)
  -- function num : 0_4 , upvalues : _ENV, eDungeonEnum
  local isFinish, inDungeon = (PlayerDataCenter.dungeonDyncData):GetDailyDungeonState()
  ;
  ((self.ui).obj_Continue):SetActive(inDungeon)
  local counterElem = (ControllerManager:GetController(ControllerTypeId.TimePass)):getCounterElemData(proto_object_CounterModule.CounterModuleRefreshableDungeon, (eDungeonEnum.eMatDungeonGroup).DailyDungeon)
  if counterElem ~= nil then
    self.netxRefreshTimeStamp = counterElem.nextExpiredTm
    self:SetRemaindTime()
  end
  if isFinish then
    ((self.ui).tex_TimeTitle):SetIndex(1)
    ;
    ((self.ui).obj_passMarker):SetActive(true)
  else
    ;
    ((self.ui).tex_TimeTitle):SetIndex(0)
    ;
    ((self.ui).obj_passMarker):SetActive(false)
  end
end

UINStcChallengeInfo.RefreshWeeklyChallenge = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local _, _, moduleId = ExplorationManager:HasUncompletedEp()
  local isInEp = moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge
  ;
  ((self.ui).obj_Continue):SetActive(isInEp)
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
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

UINStcChallengeInfo.SetRemaindTime = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if self.timerId ~= nil then
    TimerManager:StopTimer(self.timerId)
    self.timerId = nil
  end
  if self.netxRefreshTimeStamp == nil or self.netxRefreshTimeStamp <= PlayerDataCenter.timestamp then
    return 
  end
  self:RefreshRemaindTime()
  self.timerId = TimerManager:StartTimer(1, self.RefreshRemaindTime, self, false, false, false)
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
  if remaindTime <= 0 and self.timerId ~= nil then
    TimerManager:StopTimer(self.timerId)
    self.timerId = nil
  end
end

UINStcChallengeInfo.OnDelete = function(self)
  -- function num : 0_8 , upvalues : _ENV, base
  if self.timerId ~= nil then
    TimerManager:StopTimer(self.timerId)
    self.timerId = nil
  end
  ;
  (base.OnDelete)(self)
end

return UINStcChallengeInfo

