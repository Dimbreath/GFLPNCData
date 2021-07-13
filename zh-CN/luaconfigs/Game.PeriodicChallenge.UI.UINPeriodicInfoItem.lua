-- params : ...
-- function num : 0 , upvalues : _ENV
local UINPeriodicInfoItem = class("UINPeriodicInfoItem", UIBaseNode)
local base = UIBaseNode
local SectorLevelDetailEnum = require("Game.Sector.Enum.SectorLevelDetailEnum")
UINPeriodicInfoItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINPeriodicInfoItem.InitPeriodicInfoItem = function(self, id, eChallenge, titleIndex)
  -- function num : 0_1 , upvalues : SectorLevelDetailEnum, _ENV
  self.detailType = (SectorLevelDetailEnum.eDetailType).PeriodicChallenge
  self.eChallenge = eChallenge
  self.dungeonId = id
  local cfg = (ConfigData.daily_challenge)[self.dungeonId]
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).text_LevelName).text = (LanguageUtil.GetLocaleText)(cfg.name)
  self:RefreshPeriodicInfoItem()
  self:RefreshTitle(titleIndex)
end

UINPeriodicInfoItem.InitWeeklyInfoItem = function(self, id, titleIndex)
  -- function num : 0_2 , upvalues : SectorLevelDetailEnum, _ENV
  self.detailType = (SectorLevelDetailEnum.eDetailType).WeeklyChallenge
  self.dungeonId = id
  local cfg = (ConfigData.weekly_challenge)[self.dungeonId]
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).text_LevelName).text = (LanguageUtil.GetLocaleText)(cfg.name)
  self:RefreshWeeklyInfoItem()
  self:RefreshTitle(titleIndex)
end

UINPeriodicInfoItem.RefreshInfoItem = function(self)
  -- function num : 0_3 , upvalues : SectorLevelDetailEnum
  if self.detailType == (SectorLevelDetailEnum.eDetailType).PeriodicChallenge then
    self:RefreshPeriodicInfoItem()
  else
    if self.detailType == (SectorLevelDetailEnum.eDetailType).WeeklyChallenge then
      self:RefreshWeeklyInfoItem()
    end
  end
end

UINPeriodicInfoItem.RefreshTitle = function(self, titleIndex)
  -- function num : 0_4
  ((self.ui).tex_TypeTile):SetIndex(titleIndex)
  ;
  ((self.ui).tex_TypeTile_En):SetIndex(titleIndex)
end

UINPeriodicInfoItem.RefreshPeriodicInfoItem = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local _, dungeonId, moduleId = ExplorationManager:HasUncompletedEp()
  local isInEp = moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_DailyChallenge
  ;
  ((self.ui).obj_Continue):SetActive(isInEp)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UINPeriodicInfoItem.RefreshWeeklyInfoItem = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local _, dungeonId, moduleId = ExplorationManager:HasUncompletedEp()
  local isInEp = moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge
  ;
  ((self.ui).obj_Continue):SetActive(not isInEp or dungeonId == self.dungeonId)
  local data = ((PlayerDataCenter.allWeeklyChallengeData).dataDic)[self.dungeonId]
  local isunlock = (data ~= nil and data:IsUnlockWeeklyChallenge())
  if isunlock then
    ((self.ui).lock):SetActive(false)
  else
    ((self.ui).lock):SetActive(true)
    -- DECOMPILER ERROR at PC56: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self.ui).text_lock).text = (CheckCondition.GetUnlockInfoLua)((data.cfg).pre_condition, (data.cfg).pre_para1, (data.cfg).pre_para2)
  end
  -- DECOMPILER ERROR: 7 unprocessed JMP targets
end

return UINPeriodicInfoItem

