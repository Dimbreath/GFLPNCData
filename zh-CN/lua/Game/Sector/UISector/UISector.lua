local UISector = class("UISector", UIBaseWindow)
local base = UIBaseWindow
local UINResourceGroup = require("Game.CommonUI.ResourceGroup.UINResourceGroup")
local UISctBuildResItem = require("Game.Sector.UISector.UISctBuildResItem")
local eDifficulty = (require("Game.Sector.Enum.SectorLevelDetailEnum")).eDifficulty
UISector.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UISctBuildResItem
  (UIUtil.AddButtonListener)((self.ui).btn_StrategyOverview, self, self.OnClickStrategyOverview)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_RecommeJump, self, self.OnClickRecommeStage)
  self.onClickGetRes = BindCallback(self, self.OnClickGetRes)
  ;
  ((self.ui).resItem):SetActive(false)
  self.resItemPool = (UIItemPool.New)(UISctBuildResItem, (self.ui).resItem)
  ;
  ((self.ui).outputInfo):SetActive(false)
  self.__RefreshStrategyOverviewBtn = BindCallback(self, self.RefreshStrategyOverviewBtn)
  RedDotController:AddListener(RedDotDynPath.StrategyOverviewPath, self.__RefreshStrategyOverviewBtn)
end

UISector.InitUISector = function(self, sctCtrl)
  -- function num : 0_1
  self.sctCtrl = sctCtrl
  self.isLoadCompleted = true
  self:RefreshStrategyOverviewBtn()
  self:RefreshRecommeStage()
end

UISector.OnShow = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnShow)(self)
  if self.isLoadCompleted then
    self:RefreshRecommeStage()
  end
end

UISector.OnClickGetRes = function(self)
  -- function num : 0_3
  (self.sctCtrl):CollectAllSctBuildRes()
end

UISector.OnClickBackBtn = function(self)
  -- function num : 0_4
  if self.sctCtrl ~= nil then
    (self.sctCtrl):OnBtnHomeClicked()
  end
end

UISector.RefreshStrategyOverviewBtn = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local isUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_SectorBuilding)
  ;
  (((self.ui).btn_StrategyOverview).gameObject):SetActive(isUnlock)
  if not isUnlock then
    return 
  end
  local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.StrategyOverview, RedDotStaticTypeId.CareerRewardBuild)
  if ok and node:GetRedDotCount() > 0 then
    ((self.ui).redDot_StrategyOverview):SetActive(true)
    ;
    ((self.ui).blueRed_StrategyOverview):SetActive(false)
  else
    ok = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.StrategyOverview)
    ;
    ((self.ui).blueRed_StrategyOverview):SetActive(not ok or node:GetRedDotCount() > 0)
    ;
    ((self.ui).redDot_StrategyOverview):SetActive(false)
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

UISector.OnClickStrategyOverview = function(self)
  -- function num : 0_6
  (self.sctCtrl):ShowStrategyOverview()
end

UISector.RefreshRecommeStage = function(self)
  -- function num : 0_7 , upvalues : _ENV, eDifficulty
  local norCfg = (PlayerDataCenter.sectorStage):GetCanCompleteStage(eDifficulty.normal)
  local nightmareCfg = (PlayerDataCenter.sectorStage):GetCanCompleteStage(eDifficulty.nightmare)
  local endlessCfg = ((PlayerDataCenter.infinityData):GetCanCompleteInfinityMinPower())
  local sectorCfg = nil
  if norCfg == nil then
    sectorCfg = nightmareCfg
  else
    if nightmareCfg == nil then
      sectorCfg = norCfg
    else
      sectorCfg = norCfg.combat <= nightmareCfg.combat and norCfg or nightmareCfg
    end
  end
  if sectorCfg == nil and endlessCfg == nil then
    self:__SetRecommeStageInfo(false, nil, 0)
    return 
  end
  if sectorCfg == nil or endlessCfg ~= nil and endlessCfg.combat < sectorCfg.combat then
    self:__SetRecommeStageInfo(true, endlessCfg, fmtPower)
  else
    self:__SetRecommeStageInfo(false, sectorCfg, fmtPower)
  end
end

UISector.__SetRecommeStageInfo = function(self, isEndless, cfg)
  -- function num : 0_8 , upvalues : _ENV, eDifficulty
  if cfg == nil then
    self.recommeStage = nil
    ;
    ((self.ui).obj_SectorRecommend):SetActive(false)
    ;
    (((self.ui).tex_RecommeClear).gameObject):SetActive(true)
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).tex_RecommeClear).text = ConfigData:GetTipContent(321)
    return 
  end
  ;
  ((self.ui).obj_SectorRecommend):SetActive(true)
  ;
  (((self.ui).tex_RecommeClear).gameObject):SetActive(false)
  -- DECOMPILER ERROR at PC43: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_RecommeSector).text = (LanguageUtil.GetLocaleText)(((ConfigData.sector)[cfg.sector]).name)
  if isEndless then
    ((self.ui).tex_RecommeStage):SetIndex(2, tostring(cfg.index * 10))
  else
    if cfg.difficulty == eDifficulty.normal then
      ((self.ui).tex_RecommeStage):SetIndex(0, tostring(cfg.sector), tostring(cfg.num))
    else
      if cfg.difficulty == eDifficulty.nightmare then
        ((self.ui).tex_RecommeStage):SetIndex(1, tostring(cfg.sector), tostring(cfg.num))
      end
    end
  end
  if isEndless then
    self.recommeStage = {difficulty = eDifficulty.infinity, endlessCfg = cfg, dungeonId = cfg.id}
  else
    self.recommeStage = cfg
  end
end

UISector.OnClickRecommeStage = function(self)
  -- function num : 0_9 , upvalues : _ENV, eDifficulty
  if self.recommeStage == nil then
    return 
  end
  if (self.sctCtrl):HasUnfinishEp() and not (self.sctCtrl):IsUnfinishEp(self.recommeStage) then
    ExplorationManager:TryToShowCurrentLevelTips()
    return 
  end
  if (self.recommeStage).difficulty == eDifficulty.infinity then
    (self.sctCtrl):OnSectorItemClicked(((self.recommeStage).endlessCfg).sector, (self.recommeStage).difficulty, self.recommeStage)
  else
    ;
    (self.sctCtrl):OnSectorItemClicked((self.recommeStage).sector, (self.recommeStage).difficulty, self.recommeStage)
  end
end

UISector.HideAllButtomGo = function(self)
  -- function num : 0_10 , upvalues : _ENV
  self.__isShow = {}
  for index,go in pairs((self.ui).allButtomGo) do
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R6 in 'UnsetPending'

    if go.activeSelf then
      (self.__isShow)[index] = go
      go:SetActive(false)
    end
  end
end

UISector.ReShowllButtomGo = function(self)
  -- function num : 0_11 , upvalues : _ENV
  for index,go in pairs(self.__isShow) do
    go:SetActive(true)
  end
  self.__isShow = nil
end

UISector.OnDelete = function(self)
  -- function num : 0_12 , upvalues : _ENV, base
  (self.resItemPool):DeleteAll()
  self.isLoadCompleted = false
  RedDotController:RemoveListener(RedDotDynPath.StrategyOverviewPath, self.__RefreshStrategyOverviewBtn)
  ;
  (base.OnDelete)(self)
end

return UISector

