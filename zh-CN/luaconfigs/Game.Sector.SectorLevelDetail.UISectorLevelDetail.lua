-- params : ...
-- function num : 0 , upvalues : _ENV
local UISectorLevelDetail = class("UISectorLevelDetail", UIBaseWindow)
local base = UIBaseWindow
local UINLevelDetail = require("Game.Sector.SectorLevelDetail.UINLevelDtail")
local SectorLevelDetailEnum = require("Game.Sector.Enum.SectorLevelDetailEnum")
local cs_MessageCommon = CS.MessageCommon
UISectorLevelDetail.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINLevelDetail
  (UIUtil.AddButtonListener)((self.ui).btn_Close, self, self.OnClickSectorLevelDetailBackBtn)
  self.resloader = ((CS.ResLoader).Create)()
  self.levelDetailNode = (UINLevelDetail.New)()
  ;
  (self.levelDetailNode):Init((self.ui).detailNode)
  ;
  (self.levelDetailNode):InitLevelDtail(self.resloader)
  self.isPushBack2Stack = false
  ;
  (((self.ui).tex_Tips).gameObject):SetActive(false)
end

UISectorLevelDetail.InitSectorLevelDetail = function(self, sectorId, sectorStageId, isLocked)
  -- function num : 0_1 , upvalues : _ENV
  if self.isPushBack2Stack then
    (UIUtil.PopFromBackStack)()
  end
  ;
  (UIUtil.SetTopStatus)(self, self.OnClickSectorLevelDetailBackBtn, {ConstGlobalItem.SKey})
  self.isPushBack2Stack = true
  self.stageId = sectorStageId
  local stageCfg = (ConfigData.sector_stage)[sectorStageId]
  if stageCfg == nil then
    error("Can\'t find sector stageCfg, stageId = " .. tostring(sectorStageId))
    return 
  end
  self.stageCfg = stageCfg
  self:GetBackgroundTexture(sectorId)
  ;
  (self.levelDetailNode):InitLevelDetailNode(self.stageCfg, sectorId, isLocked)
  ;
  (((self.ui).tex_Tips).gameObject):SetActive(false)
end

UISectorLevelDetail.InitSectorLevelAvgDetail = function(self, sectorId, avgCfg, playAvgCompleteFunc, isLocked)
  -- function num : 0_2 , upvalues : _ENV
  if self.isPushBack2Stack then
    (UIUtil.PopFromBackStack)()
  end
  ;
  (UIUtil.SetTopStatus)(self, self.OnClickSectorLevelDetailBackBtn, {ConstGlobalItem.SKey})
  self.isPushBack2Stack = true
  self:GetBackgroundTexture(sectorId)
  ;
  (self.levelDetailNode):InitAvgDetail(avgCfg, playAvgCompleteFunc, sectorId, isLocked)
  ;
  (((self.ui).tex_Tips).gameObject):SetActive(false)
end

UISectorLevelDetail.InitInfinityLevelDetailNode = function(self, sectorId, levelData)
  -- function num : 0_3 , upvalues : _ENV
  if self.isPushBack2Stack then
    (UIUtil.PopFromBackStack)()
  end
  ;
  (UIUtil.SetTopStatus)(self, self.OnClickSectorLevelDetailBackBtn, {ConstGlobalItem.SKey})
  self.isPushBack2Stack = true
  self:GetBackgroundTexture(sectorId)
  ;
  (self.levelDetailNode):InitInfinityLevelDetailNode(levelData, sectorId)
  ;
  (((self.ui).tex_Tips).gameObject):SetActive(true)
  local isComplete = (PlayerDataCenter.infinityData):IsInfinityDungeonCompleted((levelData.cfg).id)
  local tips = ""
  if isComplete then
    tips = ConfigData:GetTipContent(TipContent.EndLessRepetitionTips)
  else
    tips = ConfigData:GetTipContent(TipContent.EndLessUnfinishedTips)
  end
  -- DECOMPILER ERROR at PC54: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_Tips).text = tips
end

UISectorLevelDetail.InitPeriodicChallengeDetailNode = function(self, challengeId, eChallengeType)
  -- function num : 0_4 , upvalues : _ENV, SectorLevelDetailEnum
  if self.isPushBack2Stack then
    (UIUtil.PopFromBackStack)()
  end
  ;
  (UIUtil.SetTopStatus)(self, self.OnClickSectorLevelDetailBackBtn, {ConstGlobalItem.SKey})
  self.isPushBack2Stack = true
  self:GetBackgroundTexture(nil, challengeId, (SectorLevelDetailEnum.eDetailType).PeriodicChallenge)
  ;
  (self.levelDetailNode):InitPeriodicChallengeDetailNode(challengeId, eChallengeType)
end

UISectorLevelDetail.InitWeeklyChallengeDetailNode = function(self, challengeId, isLocked)
  -- function num : 0_5 , upvalues : _ENV, SectorLevelDetailEnum
  if self.isPushBack2Stack then
    (UIUtil.PopFromBackStack)()
  end
  ;
  (UIUtil.SetTopStatus)(self, self.OnClickSectorLevelDetailBackBtn, {ConstGlobalItem.SKey})
  self.isPushBack2Stack = true
  self:GetBackgroundTexture(nil, challengeId, (SectorLevelDetailEnum.eDetailType).WeeklyChallenge)
  ;
  (self.levelDetailNode):InitWeeklyChallengeDetailNode(challengeId, isLocked)
end

UISectorLevelDetail.GetLevelDetailWidthAndDuration = function(self)
  -- function num : 0_6
  return (self.levelDetailNode):GetNLevelDetailWidthAndDuration()
end

UISectorLevelDetail.SetLevelDetaiHideStartEvent = function(self, hideStartEvent)
  -- function num : 0_7
  self.hideStartEvent = hideStartEvent
end

UISectorLevelDetail.SetLevelDetaiHideEndEvent = function(self, hideEndEvent)
  -- function num : 0_8
  self.hideEndEvent = hideEndEvent
end

UISectorLevelDetail.OnClickSectorLevelDetailBackBtn = function(self)
  -- function num : 0_9
  self.isPushBack2Stack = false
  if self.levelDetailNode ~= nil then
    (self.levelDetailNode):PlayMoveTween(false)
  end
  if self.hideStartEvent ~= nil then
    (self.hideStartEvent)()
  end
end

UISectorLevelDetail.OnShow = function(self)
  -- function num : 0_10 , upvalues : base
  (base.OnShow)(self)
  ;
  (self.levelDetailNode):OnShow()
end

UISectorLevelDetail.OnHide = function(self)
  -- function num : 0_11
  (self.levelDetailNode):OnHide()
  if self.hideEndEvent ~= nil then
    (self.hideEndEvent)()
  end
end

UISectorLevelDetail.GetBackgroundTexture = function(self, sectorId, challengeId, detailType)
  -- function num : 0_12 , upvalues : _ENV, SectorLevelDetailEnum
  local path = nil
  if sectorId ~= nil and self.sectorId ~= sectorId then
    self.sectorId = sectorId
    local sectorCfg = (ConfigData.sector)[sectorId]
    if sectorCfg ~= nil then
      path = PathConsts:GetSectorBackgroundPath(sectorCfg.pic_small)
    end
  else
    do
      if challengeId ~= nil and detailType == (SectorLevelDetailEnum.eDetailType).PeriodicChallenge then
        local challengeCfg = (ConfigData.daily_challenge)[challengeId]
        if challengeCfg ~= nil then
          path = PathConsts:GetSectorBackgroundPath(challengeCfg.pic_small)
        end
      else
        do
          if challengeId ~= nil and detailType == (SectorLevelDetailEnum.eDetailType).WeeklyChallenge then
            local challengeCfg = (ConfigData.weekly_challenge)[challengeId]
            if challengeCfg ~= nil then
              path = PathConsts:GetSectorBackgroundPath(challengeCfg.pic_small)
            end
          else
            do
              do return  end
              -- DECOMPILER ERROR at PC65: Confused about usage of register: R5 in 'UnsetPending'

              if not (string.IsNullOrEmpty)(path) then
                ((self.ui).img_LevelPic).texture = (self.resloader):LoadABAsset(path)
              end
            end
          end
        end
      end
    end
  end
end

UISectorLevelDetail.OnDelete = function(self)
  -- function num : 0_13 , upvalues : base
  (self.levelDetailNode):Delete()
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
  ;
  (base.OnDelete)(self)
end

return UISectorLevelDetail

