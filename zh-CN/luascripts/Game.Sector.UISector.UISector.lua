-- params : ...
-- function num : 0 , upvalues : _ENV
local UISector = class("UISector", UIBaseWindow)
local base = UIBaseWindow
local UINResourceGroup = require("Game.CommonUI.ResourceGroup.UINResourceGroup")
local UISctBuildResItem = require("Game.Sector.UISector.UISctBuildResItem")
UISector.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UISctBuildResItem
  (UIUtil.AddButtonListener)((self.ui).btn_StrategyOverview, self, self.OnClickStrategyOverview)
  self.onClickGetRes = BindCallback(self, self.OnClickGetRes)
  ;
  ((self.ui).resItem):SetActive(false)
  self.resItemPool = (UIItemPool.New)(UISctBuildResItem, (self.ui).resItem)
  ;
  ((self.ui).outputInfo):SetActive(false)
  self.CollectResWin = UIManager:ShowWindow(UIWindowTypeID.CommonCollectRes)
  ;
  ((self.CollectResWin).transform):SetParent((self.ui).Tran_CommonResNode)
  ;
  (self.CollectResWin):SetCommonCollectRes(self.onClickGetRes)
  ;
  (self.CollectResWin):Hide()
end

UISector.InitUISector = function(self, sctCtrl)
  -- function num : 0_1
  self.sctCtrl = sctCtrl
  self.isLoadCompleted = true
  self:RefreshStrategyOverviewBtn()
end

UISector.OnlyShowSctUITop = function(self, onlyShow)
  -- function num : 0_2
  self.__onlyShowTop = onlyShow
  if onlyShow then
    (self.CollectResWin):Hide()
  else
    self:__ShowOutputInfo(self.__showOutputInfo)
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

UISector.UpdateUIAllSctBuildRes = function(self, allResDic, hasRes)
  -- function num : 0_5 , upvalues : _ENV
  self.__showOutputInfo = hasRes
  if self.__onlyShowTop then
    return 
  end
  self:__ShowOutputInfo(self.__showOutputInfo)
  if not self.__showOutputInfo then
    return 
  end
  local allResList = {}
  for k,v in pairs(allResDic) do
    (table.insert)(allResList, v)
  end
  ;
  (table.sort)(allResList, function(a, b)
    -- function num : 0_5_0
    do return a.id < b.id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  for k,allResData in ipairs(allResList) do
    if (self.ui).resShowCount < k then
      return 
    end
    local resList = {}
    ;
    (table.insert)(resList, allResData)
    ;
    (self.CollectResWin):UpdateProduction(k, resList)
  end
end

UISector.__ShowOutputInfo = function(self, showOutputInfo)
  -- function num : 0_6
  if self.CollectResWin == nil then
    return 
  end
  if showOutputInfo then
    (self.CollectResWin):Show()
  else
    ;
    (self.CollectResWin):Hide()
  end
end

UISector.RefreshStrategyOverviewBtn = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local isUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_SectorBuilding)
  ;
  (((self.ui).btn_StrategyOverview).gameObject):SetActive(isUnlock)
  if not isUnlock then
    return 
  end
  local isShowBlueRed = false
  for i,sectorId in ipairs((ConfigData.sector).id_sort_list) do
    local sectorCfg = (ConfigData.sector)[sectorId]
    local sectorUnlock = (PlayerDataCenter.sectorStage):IsSectorUnlock(sectorCfg.id)
    local hasEmptyQueue = not (PlayerDataCenter.AllBuildingData):FullSectorBuildQue()
    if sectorUnlock and hasEmptyQueue and sectorCfg.building ~= nil then
      for i,buildId in ipairs(sectorCfg.building) do
        local buildData = ((PlayerDataCenter.AllBuildingData).unbuilt)[buildId]
        if buildData ~= nil and buildData:Unlock() and buildData:CanBuild() then
          isShowBlueRed = true
          break
        end
        buildData = ((PlayerDataCenter.AllBuildingData).sectorBuilt)[buildId]
        if buildData ~= nil and buildData.state == proto_object_BuildingState.BuildingStateNormal and buildData:CanUpgrade() then
          isShowBlueRed = true
          break
        end
      end
    end
  end
  do
    if not isShowBlueRed then
      ((self.ui).blueRed_StrategyOverview):SetActive(isShowBlueRed)
    end
  end
end

UISector.OnClickStrategyOverview = function(self)
  -- function num : 0_8 , upvalues : _ENV
  local strategyOverviewCtr = ControllerManager:GetController(ControllerTypeId.StrategyOverview, true)
  strategyOverviewCtr:InitStOCtrl()
end

UISector.OnDelete = function(self)
  -- function num : 0_9 , upvalues : base
  if self.CollectResWin ~= nil then
    (self.CollectResWin):Delete()
    self.CollectResWin = nil
  end
  ;
  (self.resItemPool):DeleteAll()
  self.isLoadCompleted = false
  ;
  (base.OnDelete)(self)
end

return UISector

