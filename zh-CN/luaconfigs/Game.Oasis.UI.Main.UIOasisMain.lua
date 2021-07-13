-- params : ...
-- function num : 0 , upvalues : _ENV
local UIOasisMain = class("UIOasisMain", UIBaseWindow)
local base = UIBaseWindow
local UINOasisResOutput = require("Game.Oasis.UI.ResOutput.UINOasisResOutput")
local UINOasisBuildSelect = require("Game.Oasis.UI.Select.UINOasisBuildSelect")
local UINOasisBuildDetail = require("Game.Oasis.UI.Detail.UINOasisBuildDetail")
local UINBuildLogicLvPreview = require("Game.StrategyOverview.UI.BuildLogicLvPreview.UINBuildLogicLvPreview")
local BuildingBelong = require("Game.Oasis.Data.BuildingBelong")
local UINPaticleNode = require("Game.Oasis.UI.Particle.UINOasisParticle")
local cs_ResLoader = CS.ResLoader
local resourceItems = {1003, 1004, 3005}
UIOasisMain.OnInit = function(self)
  -- function num : 0_0 , upvalues : cs_ResLoader, UINOasisResOutput, UINOasisBuildSelect, UINOasisBuildDetail, UINBuildLogicLvPreview, UINPaticleNode, _ENV, resourceItems
  self.resLoader = (cs_ResLoader.Create)()
  self.oasisResNode = (UINOasisResOutput.New)()
  ;
  (self.oasisResNode):Init((self.ui).resNode)
  self.oasisSelectNode = (UINOasisBuildSelect.New)(self)
  ;
  (self.oasisSelectNode):Init((self.ui).selectNode)
  ;
  (self.oasisSelectNode):Hide()
  self.buildDetailNode = (UINOasisBuildDetail.New)(self, self.resLoader)
  ;
  (self.buildDetailNode):Init((self.ui).detailNode)
  ;
  (self.buildDetailNode):Hide()
  self.buildPreviewNode = (UINBuildLogicLvPreview.New)()
  ;
  (self.buildPreviewNode):Init((self.ui).logicPreviewNode)
  ;
  (self.buildPreviewNode):Hide()
  self.paticleNode = (UINPaticleNode.New)(self)
  ;
  (self.paticleNode):Init((self.ui).particlesNode)
  ;
  (self.paticleNode):Hide()
  local unlockFactory = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Factory)
  if unlockFactory then
    resourceItems = {1003, 1004, 3005, 1201}
  end
  ;
  (UIUtil.SetTopStatus)(self, self._BackToHome, resourceItems, nil, nil)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_SkySetting, self, self._OnClickSkySetting)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_HideUI, self, self._OnClickHideUI)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Editor, self, self._OnClickEditor)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Collect, self, self._OnClickCollectRes)
end

UIOasisMain.InitOasisMain = function(self, oasisCtrl)
  -- function num : 0_1
  self.oasisCtrl = oasisCtrl
  ;
  (self.oasisResNode):InitOasisResOutput(oasisCtrl)
  self:RefreshOasisEditBlueDot()
  self:_RefreshSkySettingShow(true)
end

UIOasisMain.OnEnterOasisEditMode = function(self, enter)
  -- function num : 0_2
  (((self.ui).btn_Editor).gameObject):SetActive(not enter)
  self:_RefreshSkySettingShow(not enter)
  ;
  (((self.ui).btn_HideUI).gameObject):SetActive(not enter)
  self.inEditor = enter
  self:_RefreshCollectResBtn()
  if enter then
    (self.oasisResNode):Hide()
  else
    ;
    (self.oasisResNode):Show()
  end
end

UIOasisMain._RefreshSkySettingShow = function(self, show)
  -- function num : 0_3 , upvalues : _ENV
  local unlockSkySetting = ((PlayerDataCenter.AllBuildingData).built)[eBuildingId.SkyBuilding] ~= nil
  ;
  (((self.ui).btn_SkySetting).gameObject):SetActive(not show or unlockSkySetting)
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UIOasisMain.RefreshOasisEditBlueDot = function(self)
  -- function num : 0_4 , upvalues : _ENV, BuildingBelong
  local canBuildNew = false
  for k,dynData in pairs((PlayerDataCenter.AllBuildingData).unbuilt) do
    if dynData.belong == BuildingBelong.Oasis and dynData:CanBuild() then
      canBuildNew = true
      break
    end
  end
  do
    ;
    ((self.ui).obj_BlueDot):SetActive(canBuildNew)
  end
end

UIOasisMain._OnClickSkySetting = function(self)
  -- function num : 0_5
  (self.oasisCtrl):EnterOasisSkyMode()
end

UIOasisMain._OnClickHideUI = function(self)
  -- function num : 0_6
  (self.oasisCtrl):ShowOasisUI(false)
end

UIOasisMain._OnClickEditor = function(self)
  -- function num : 0_7
  (self.oasisCtrl):EnterEditMode()
  self:OnEnterOasisEditMode(true)
end

UIOasisMain._OnClickCollectRes = function(self)
  -- function num : 0_8
  (self.oasisCtrl):CollectAllOasisBuildingRes()
end

UIOasisMain.ShowOasisMainCollectResBtn = function(self, show)
  -- function num : 0_9
  self.showCollectRes = show
  self:_RefreshCollectResBtn()
end

UIOasisMain._RefreshCollectResBtn = function(self)
  -- function num : 0_10
  if self.showCollectRes then
    local show = not self.inEditor
  end
  if (((self.ui).btn_Collect).gameObject).activeInHierarchy ~= show then
    (((self.ui).btn_Collect).gameObject):SetActive(show)
  end
end

UIOasisMain.OnShow = function(self)
  -- function num : 0_11 , upvalues : base
  (base.OnShow)(self)
  ;
  (self.oasisResNode):Show()
end

UIOasisMain.OnHide = function(self)
  -- function num : 0_12 , upvalues : base
  (self.oasisResNode):Hide()
  ;
  (base.OnHide)(self)
end

UIOasisMain._BackToHome = function(self)
  -- function num : 0_13
  (self.oasisCtrl):OasisBackToHome()
end

UIOasisMain.OnDelete = function(self)
  -- function num : 0_14 , upvalues : base
  (self.oasisResNode):Delete()
  ;
  (self.oasisSelectNode):Delete()
  ;
  (self.buildDetailNode):Delete()
  ;
  (self.buildPreviewNode):Delete()
  ;
  (self.paticleNode):Delete()
  if self.resLoader ~= nil then
    (self.resLoader):Put2Pool()
    self.resLoader = nil
  end
  ;
  (base.OnDelete)(self)
end

return UIOasisMain

