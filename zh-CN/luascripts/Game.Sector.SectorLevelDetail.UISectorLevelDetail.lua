-- params : ...
-- function num : 0 , upvalues : _ENV
local UISectorLevelDetail = class("UISectorLevelDetail", UIBaseWindow)
local base = UIBaseWindow
local UINLevelDetail = require("Game.Sector.SectorLevelDetail.UINLevelDtail")
local cs_MessageCommon = CS.MessageCommon
UISectorLevelDetail.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINLevelDetail
  (UIUtil.CreateTopBtnGroup)((self.ui).topButtonGroup, self, self.OnClickSectorLevelDetailBackBtn, true)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Close, self, self.OnClickSectorLevelDetailBackBtn)
  self.resloader = ((CS.ResLoader).Create)()
  self.levelDetailNode = (UINLevelDetail.New)()
  ;
  (self.levelDetailNode):Init((self.ui).detailNode)
  ;
  (self.levelDetailNode):InitLevelDtail(self.resloader)
  self.isPushBack2Stack = false
end

UISectorLevelDetail.InitSectorLevelDetail = function(self, sectorId, sectorStageId)
  -- function num : 0_1 , upvalues : _ENV
  if self.isPushBack2Stack then
    (UIUtil.PopFromBackStack)()
  end
  ;
  (UIUtil.Push2BackStack)(self, self.OnClickSectorLevelDetailBackBtn)
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
  (self.levelDetailNode):InitLevelDetailNode(self.stageCfg, sectorId)
end

UISectorLevelDetail.InitSectorLevelAvgDetail = function(self, sectorId, avgCfg, playAvgCompleteFunc)
  -- function num : 0_2 , upvalues : _ENV
  if self.isPushBack2Stack then
    (UIUtil.PopFromBackStack)()
  end
  ;
  (UIUtil.Push2BackStack)(self, self.OnClickSectorLevelDetailBackBtn)
  self.isPushBack2Stack = true
  self:GetBackgroundTexture(sectorId)
  ;
  (self.levelDetailNode):InitAvgDetail(avgCfg, playAvgCompleteFunc, sectorId)
end

UISectorLevelDetail.InitInfinityLevelDetailNode = function(self, sectorId, levelData)
  -- function num : 0_3 , upvalues : _ENV
  if self.isPushBack2Stack then
    (UIUtil.PopFromBackStack)()
  end
  ;
  (UIUtil.Push2BackStack)(self, self.OnClickSectorLevelDetailBackBtn)
  self.isPushBack2Stack = true
  self:GetBackgroundTexture(sectorId)
  ;
  (self.levelDetailNode):InitInfinityLevelDetailNode(levelData, sectorId)
end

UISectorLevelDetail.GetLevelDetailWidthAndDuration = function(self)
  -- function num : 0_4
  return (self.levelDetailNode):GetNLevelDetailWidthAndDuration()
end

UISectorLevelDetail.SetLevelDetaiHideStartEvent = function(self, hideStartEvent)
  -- function num : 0_5
  self.hideStartEvent = hideStartEvent
end

UISectorLevelDetail.SetLevelDetaiHideEndEvent = function(self, hideEndEvent)
  -- function num : 0_6
  self.hideEndEvent = hideEndEvent
end

UISectorLevelDetail.OnClickSectorLevelDetailBackBtn = function(self)
  -- function num : 0_7
  self.isPushBack2Stack = false
  if self.levelDetailNode ~= nil then
    (self.levelDetailNode):PlayMoveTween(false)
  end
  if self.hideStartEvent ~= nil then
    (self.hideStartEvent)()
  end
end

UISectorLevelDetail.OnShow = function(self)
  -- function num : 0_8 , upvalues : base
  (base.OnShow)(self)
  ;
  (self.levelDetailNode):OnShow()
end

UISectorLevelDetail.OnHide = function(self)
  -- function num : 0_9
  (self.levelDetailNode):OnHide()
  if self.hideEndEvent ~= nil then
    (self.hideEndEvent)()
  end
end

UISectorLevelDetail.GetBackgroundTexture = function(self, sectorId)
  -- function num : 0_10 , upvalues : _ENV
  if self.sectorId ~= sectorId then
    self.sectorId = sectorId
    local sectorCfg = (ConfigData.sector)[sectorId]
    if sectorCfg ~= nil then
      local path = PathConsts:GetSectorBackgroundPath(sectorCfg.pic_small)
      -- DECOMPILER ERROR at PC25: Confused about usage of register: R4 in 'UnsetPending'

      if not (string.IsNullOrEmpty)(path) then
        ((self.ui).img_LevelPic).texture = (self.resloader):LoadABAsset(path)
      end
    end
  end
end

UISectorLevelDetail.OnDelete = function(self)
  -- function num : 0_11 , upvalues : base
  (self.levelDetailNode):Delete()
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
  ;
  (base.OnDelete)(self)
end

return UISectorLevelDetail

