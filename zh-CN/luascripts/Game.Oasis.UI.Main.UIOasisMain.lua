-- params : ...
-- function num : 0 , upvalues : _ENV
local UIOasisMain = class("UIOasisMain", UIBaseWindow)
local base = UIBaseWindow
local UINOasisResOutput = require("Game.Oasis.UI.ResOutput.UINOasisResOutput")
local UINOasisBuildSelect = require("Game.Oasis.UI.Select.UINOasisBuildSelect")
local UINOasisBuildDetail = require("Game.Oasis.UI.Detail.UINOasisBuildDetail")
local UINBuildLogicLvPreview = require("Game.StrategyOverview.UI.BuildLogicLvPreview.UINBuildLogicLvPreview")
local cs_ResLoader = CS.ResLoader
local resourceItems = {1003, 1004}
UIOasisMain.OnInit = function(self)
  -- function num : 0_0 , upvalues : cs_ResLoader, UINOasisResOutput, UINOasisBuildSelect, UINOasisBuildDetail, UINBuildLogicLvPreview, _ENV, resourceItems
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
  ;
  (UIUtil.SetTopStatus)(self, self._BackToHome, resourceItems)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Editor, self, self._OnClickEditor)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Collect, self, self._OnClickCollectRes)
end

UIOasisMain.InitOasisMain = function(self, oasisCtrl)
  -- function num : 0_1
  self.oasisCtrl = oasisCtrl
  self:RefreshOasisEditBlueDot()
end

UIOasisMain.OnEnterOasisEditMode = function(self, enter)
  -- function num : 0_2
  (((self.ui).btn_Editor).gameObject):SetActive(not enter)
  self.inEditor = enter
  self:_RefreshCollectResBtn()
  if enter then
    (self.oasisResNode):Hide()
  else
    ;
    (self.oasisResNode):Show()
  end
end

UIOasisMain.RefreshOasisEditBlueDot = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local canBuildNew = false
  for k,dynData in pairs((PlayerDataCenter.AllBuildingData).unbuilt) do
    if dynData:CanBuild() then
      canBuildNew = true
      break
    end
  end
  do
    ;
    ((self.ui).obj_BlueDot):SetActive(canBuildNew)
  end
end

UIOasisMain._OnClickEditor = function(self)
  -- function num : 0_4
  (self.oasisCtrl):EnterEditMode()
  self:OnEnterOasisEditMode(true)
end

UIOasisMain._OnClickCollectRes = function(self)
  -- function num : 0_5
  (self.oasisCtrl):CollectAllOasisBuildingRes()
end

UIOasisMain.ShowOasisMainCollectResBtn = function(self, show)
  -- function num : 0_6
  self.showCollectRes = show
  self:_RefreshCollectResBtn()
end

UIOasisMain._RefreshCollectResBtn = function(self)
  -- function num : 0_7
  if self.showCollectRes then
    (((self.ui).btn_Collect).gameObject):SetActive(not self.inEditor)
  end
end

UIOasisMain._BackToHome = function(self)
  -- function num : 0_8
  (self.oasisCtrl):OasisBackToHome()
end

UIOasisMain.OnDelete = function(self)
  -- function num : 0_9 , upvalues : base
  (self.oasisResNode):Delete()
  ;
  (self.oasisSelectNode):Delete()
  ;
  (self.buildDetailNode):Delete()
  ;
  (self.buildPreviewNode):Delete()
  if self.resLoader ~= nil then
    (self.resLoader):Put2Pool()
    self.resLoader = nil
  end
  ;
  (base.OnDelete)(self)
end

return UIOasisMain

