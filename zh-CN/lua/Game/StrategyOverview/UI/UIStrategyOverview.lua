local UIStrategyOverview = class("UIStrategyOverview", UIBaseWindow)
local base = UIBaseWindow
local UINStOList = require("Game.StrategyOverview.UI.StOList.UINStOList")
local UIStOSideNode = require("Game.StrategyOverview.UI.Side.UIStOSideNode")
local UINBuildLogicLvPreview = require("Game.StrategyOverview.UI.BuildLogicLvPreview.UINBuildLogicLvPreview")
local UINStoCareerList = require("Game.StrategyOverview.UI.CareerList.UINStOCareerList")
local BuildingEnum = require("Game.Oasis.Data.BuildingEnum")
local CS_ResLoader = CS.ResLoader
local cs_MessageCommon = CS.MessageCommon
local LockGoType = {Normal = 1, Rhombus = 2}
UIStrategyOverview.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, CS_ResLoader, UINStOList, UIStOSideNode, UINBuildLogicLvPreview, UINStoCareerList, BuildingEnum, LockGoType
  (UIUtil.SetTopStatus)(self, self._OnClickClose, {ConstGlobalItem.NormalGold, ConstGlobalItem.BuildBlueprint})
  self.resLoader = (CS_ResLoader.Create)()
  self.stOList = (UINStOList.New)(self, self.ui)
  ;
  (self.stOList):Init((self.ui).stOList)
  ;
  (self.stOList):Hide()
  self.stOSide = (UIStOSideNode.New)(self)
  ;
  (self.stOSide):Init((self.ui).side)
  self.previewNode = (UINBuildLogicLvPreview.New)()
  ;
  (self.previewNode):Init((self.ui).previewNode)
  ;
  (self.previewNode):Hide()
  self.stOCareerList = (UINStoCareerList.New)(self, self.ui)
  ;
  (self.stOCareerList):Init((self.ui).careerList)
  ;
  (self.stOCareerList):Hide()
  self.__onItemRefresh = BindCallback(self, self._OnItemRefresh)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__onItemRefresh)
  MsgCenter:AddListener(eMsgEventId.UpdateARGItem, self.__onItemRefresh)
  self.__RefreshStOBuleDot = BindCallback(self, self.RefreshStOBuleDot)
  RedDotController:AddListener(RedDotDynPath.StrategyOverviewPath, self.__RefreshStOBuleDot)
  -- DECOMPILER ERROR at PC96: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tran_rect).localPosition = (Vector3.New)(0, -50, 0)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).tog_GotoOverview, self, self.OnValueChangeOverview)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).tog_GotoCareer, self, self.OnValueChangeCareer)
  self.lockGoList = {}
  self.lockRhombusGoList = {}
  local UINStOTechItemBaseEdge = require("Game.StrategyOverview.UI.StOItemEdge.UINStOTechItemBaseEdge")
  local UINStOTechItemRewardEdge = require("Game.StrategyOverview.UI.StOItemEdge.UINStOTechItemRewardEdge")
  local UINStOTechItemRhombusEdge = require("Game.StrategyOverview.UI.StOItemEdge.UINStOTechItemRhombusEdge")
  self.TechItemEdgeCfgTable = {
[(BuildingEnum.TechItemEdgeType).SmallEdge] = {tableClass = UINStOTechItemBaseEdge, prefab = (self.ui).prefab_NorEdge, scale = 0.75}
, 
[(BuildingEnum.TechItemEdgeType).MiddleEdge] = {tableClass = UINStOTechItemBaseEdge, prefab = (self.ui).prefab_BigEdge}
, 
[(BuildingEnum.TechItemEdgeType).RhombusEdge] = {tableClass = UINStOTechItemRhombusEdge, prefab = (self.ui).prefab_RhombusEdge, lockGoType = LockGoType.Rhombus}
, 
[(BuildingEnum.TechItemEdgeType).RewardEdge] = {tableClass = UINStOTechItemRewardEdge, prefab = (self.ui).prefab_rewardEdge}
}
end

UIStrategyOverview.OnShow = function(self)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.OnShow)(self)
  AudioManager:PlayAudioById(1066)
end

UIStrategyOverview.InitUIStO = function(self, stOCtrl, techDataList)
  -- function num : 0_2
  self:InitData(stOCtrl, self.stOList, (self.ui).tog_GotoOverview, techDataList)
  ;
  (self.stOList):InitStOList(self.resLoader, techDataList)
end

UIStrategyOverview.InitCareerStO = function(self, stOCtrl, techDataList)
  -- function num : 0_3
  self:InitData(stOCtrl, self.stOCareerList, (self.ui).tog_GotoCareer, techDataList)
  ;
  (self.stOCareerList):InitStOCareer(self.resLoader, techDataList)
end

UIStrategyOverview.InitData = function(self, stOCtrl, StOList, tog, techDataList)
  -- function num : 0_4
  self.stOCtrl = stOCtrl
  self._cancleTogFunEnble = true
  tog.isOn = true
  StOList:Show()
  self._cancleTogFunEnble = false
  self.currentShowList = self.stOList
  self:RefreshLevelShow()
  self:RefreshStOBuleDot()
end

UIStrategyOverview.ShowStOTechSide = function(self, buildingData)
  -- function num : 0_5
  (self.stOSide):InitStOSideNode(buildingData)
end

UIStrategyOverview.OnStOBuildUpgradeComplete = function(self, buildingData)
  -- function num : 0_6
  (self.currentShowList):OnBuildUpgradeStOList(buildingData)
  ;
  (self.stOSide):OnBuildUpgradeStOSide(buildingData)
  self:RefreshLevelShow()
end

UIStrategyOverview.UpdateUIStOBuilding = function(self, buildingData)
  -- function num : 0_7
  (self.currentShowList):RefreshAllStOListTech(buildingData)
  ;
  (self.stOSide):OnBuildUpgradeStOSide(buildingData)
  self:RefreshLevelShow()
end

UIStrategyOverview._OnItemRefresh = function(self, itemIdDic)
  -- function num : 0_8 , upvalues : _ENV
  local noChanged = true
  for itemId,_ in pairs(itemIdDic) do
    if ((ConfigData.buildingLevel).resConsumeDic)[itemId] ~= nil then
      noChanged = false
      break
    end
  end
  do
    if noChanged then
      return 
    end
    ;
    (self.currentShowList):RefreshAllStOListTech()
    ;
    (self.stOSide):RefreshStOSide()
  end
end

UIStrategyOverview._OnClickClose = function(self)
  -- function num : 0_9 , upvalues : _ENV
  ControllerManager:DeleteController(ControllerTypeId.StrategyOverview)
end

UIStrategyOverview.ShowStOPreview = function(self, buildingData)
  -- function num : 0_10
  (self.previewNode):Show()
  ;
  (self.previewNode):InitBuildLogicLvPreview(buildingData)
end

UIStrategyOverview.OnValueChangeOverview = function(self, flag)
  -- function num : 0_11 , upvalues : _ENV
  if self._cancleTogFunEnble then
    return 
  end
  if not flag then
    (self.stOList):Hide()
    return 
  end
  ;
  (self.stOList):Show()
  if not (self.stOList).isInit then
    local strategyCtrl = ControllerManager:GetController(ControllerTypeId.StrategyOverview)
    local techList = strategyCtrl:GetTechDataList()
    ;
    (self.stOList):InitStOList(self.resLoader, techList)
  end
  do
    self.currentShowList = self.stOList
    ;
    (self.currentShowList):EnterStOList()
  end
end

UIStrategyOverview.OnValueChangeCareer = function(self, flag)
  -- function num : 0_12 , upvalues : _ENV, cs_MessageCommon
  if self._cancleTogFunEnble then
    return 
  end
  if not flag then
    (self.stOCareerList):Hide()
    return 
  end
  if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_SectorBuilding1) then
    (cs_MessageCommon.ShowMessageTipsWithErrorSound)(FunctionUnlockMgr:GetFuncUnlockDecription(proto_csmsg_SystemFunctionID.SystemFunctionID_SectorBuilding1))
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).tog_GotoOverview).isOn = true
    return 
  end
  ;
  (self.stOCareerList):Show()
  if not (self.stOCareerList).isInit then
    local strategyCtrl = ControllerManager:GetController(ControllerTypeId.StrategyOverview)
    local techList = strategyCtrl:GetCareerMaster()
    ;
    (self.stOCareerList):InitStOCareer(self.resLoader, techList)
  end
  do
    self.currentShowList = self.stOCareerList
    ;
    (self.stOCareerList):EnterStOList()
  end
end

UIStrategyOverview.GetStOTechLock = function(self, edgeType)
  -- function num : 0_13 , upvalues : LockGoType, _ENV
  local lockType = LockGoType.Normal
  do
    if edgeType ~= nil then
      local edgeElement = (self.TechItemEdgeCfgTable)[edgeType]
      if edgeElement ~= nil and edgeElement.lockGoType ~= nil then
        lockType = edgeElement.lockGoType
      end
    end
    local lockGo = nil
    if lockType == LockGoType.Normal then
      if #self.lockGoList > 0 then
        lockGo = (table.remove)(self.lockGoList)
      else
        lockGo = ((self.ui).prefab_obj_IsLock):Instantiate()
      end
    else
      if #self.lockRhombusGoList > 0 then
        lockGo = (table.remove)(self.lockRhombusGoList)
      else
        lockGo = ((self.ui).prefab_obj_IsLockRhombus):Instantiate()
      end
    end
    return lockGo
  end
end

UIStrategyOverview.ReturnStOTechLock = function(self, edgeType, lockGo)
  -- function num : 0_14 , upvalues : LockGoType, _ENV
  (lockGo.transform):SetParent(((self.ui).prefabPool).transform)
  local lockType = LockGoType.Normal
  do
    if edgeType ~= nil then
      local edgeElement = (self.TechItemEdgeCfgTable)[edgeType]
      if edgeElement ~= nil and edgeElement.lockGoType ~= nil then
        lockType = edgeElement.lockGoType
      end
    end
    if lockType == LockGoType.Normal then
      (table.insert)(self.lockGoList, lockGo)
    else
      ;
      (table.insert)(self.lockRhombusGoList, lockGo)
    end
  end
end

UIStrategyOverview.GetFX_LevelUp = function(self)
  -- function num : 0_15
  return (self.ui).prefab_fX_LevelUp
end

UIStrategyOverview.SelectStOTechItem = function(self, parentGroup, buildingData)
  -- function num : 0_16 , upvalues : _ENV
  (((self.ui).prefab_obj_OnSelelct).transform):SetParent(parentGroup.transform)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (((self.ui).prefab_obj_OnSelelct).transform).localPosition = Vector3.zero
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (((self.ui).prefab_obj_OnSelelct).transform).localScale = Vector3.one
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (((self.ui).prefab_obj_OnSelelct).transform).localRotation = (Quaternion.Euler)(0, 0, 0)
  self:ShowStOTechSide(buildingData)
end

UIStrategyOverview.RefreshLevelShow = function(self)
  -- function num : 0_17 , upvalues : _ENV
  ((self.ui).tex_Level_StO):SetIndex(0, tostring((PlayerDataCenter.AllBuildingData).stoTotalLevel))
  ;
  ((self.ui).tex_Level_Career):SetIndex(0, tostring((PlayerDataCenter.AllBuildingData).careerTotalLevel))
end

UIStrategyOverview.GetTechItemEdge = function(self, nodeType)
  -- function num : 0_18 , upvalues : BuildingEnum
  local edgeCfg = (self.TechItemEdgeCfgTable)[nodeType or 0]
  if edgeCfg == nil then
    edgeCfg = (self.TechItemEdgeCfgTable)[(BuildingEnum.TechItemEdgeType).MiddleEdge]
  end
  local copyPrefab = (edgeCfg.prefab):Instantiate()
  local tableClass = ((edgeCfg.tableClass).New)()
  tableClass:Init(copyPrefab)
  tableClass:SetPreData(nodeType, edgeCfg.scale or 1)
  return tableClass
end

UIStrategyOverview.RefreshStOBuleDot = function(self)
  -- function num : 0_19 , upvalues : _ENV
  local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.StrategyOverview, RedDotStaticTypeId.SectorBuilding)
  ;
  ((self.ui).blueDot_StO):SetActive(not ok or node:GetRedDotCount() > 0)
  ok = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.StrategyOverview, RedDotStaticTypeId.CareerRewardBuild)
  if ok and node:GetRedDotCount() > 0 then
    ((self.ui).redDot_Career):SetActive(true)
    ;
    ((self.ui).blueDot_Career):SetActive(false)
  else
    -- DECOMPILER ERROR at PC58: Overwrote pending register: R2 in 'AssignReg'

    ok = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.StrategyOverview, RedDotStaticTypeId.CareerBuilding)
    ;
    ((self.ui).blueDot_Career):SetActive(not ok or node:GetRedDotCount() > 0)
    ;
    ((self.ui).redDot_Career):SetActive(false)
  end
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

UIStrategyOverview.OnDelete = function(self)
  -- function num : 0_20 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__onItemRefresh)
  MsgCenter:RemoveListener(eMsgEventId.UpdateARGItem, self.__onItemRefresh)
  RedDotController:RemoveListener(RedDotDynPath.StrategyOverviewPath, self.__RefreshStOBuleDot)
  ;
  (self.stOList):Delete()
  ;
  (self.stOCareerList):Delete()
  ;
  (self.stOSide):Delete()
  ;
  (self.previewNode):Delete()
  if self.resLoader ~= nil then
    (self.resLoader):Put2Pool()
    self.resLoader = nil
  end
  ;
  (base.OnDelete)(self)
end

return UIStrategyOverview

