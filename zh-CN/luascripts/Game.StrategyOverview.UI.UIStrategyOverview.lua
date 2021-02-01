-- params : ...
-- function num : 0 , upvalues : _ENV
local UIStrategyOverview = class("UIStrategyOverview", UIBaseWindow)
local base = UIBaseWindow
local UINStOList = require("Game.StrategyOverview.UI.StOList.UINStOList")
local UIStOSideNode = require("Game.StrategyOverview.UI.Side.UIStOSideNode")
local UINBuildLogicLvPreview = require("Game.StrategyOverview.UI.BuildLogicLvPreview.UINBuildLogicLvPreview")
local CS_ResLoader = CS.ResLoader
UIStrategyOverview.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, CS_ResLoader, UINStOList, UIStOSideNode, UINBuildLogicLvPreview
  (UIUtil.SetTopStatus)(self, self._OnClickClose, {ConstGlobalItem.NormalGold, ConstGlobalItem.BuildBlueprint})
  self.resLoader = (CS_ResLoader.Create)()
  self.stOList = (UINStOList.New)(self)
  ;
  (self.stOList):Init((self.ui).stOList)
  self.stOSide = (UIStOSideNode.New)(self)
  ;
  (self.stOSide):Init((self.ui).side)
  self.previewNode = (UINBuildLogicLvPreview.New)()
  ;
  (self.previewNode):Init((self.ui).previewNode)
  ;
  (self.previewNode):Hide()
  self.__onItemRefresh = BindCallback(self, self._OnItemRefresh)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__onItemRefresh)
  MsgCenter:AddListener(eMsgEventId.UpdateARGItem, self.__onItemRefresh)
end

UIStrategyOverview.InitUIStO = function(self, stOCtrl, techDataList)
  -- function num : 0_1
  self.stOCtrl = stOCtrl
  ;
  (self.stOList):InitStOList(self.resLoader, techDataList)
end

UIStrategyOverview.ShowStOTechSide = function(self, buildingData)
  -- function num : 0_2
  (self.stOSide):InitStOSideNode(buildingData)
end

UIStrategyOverview.OnStOBuildUpgradeComplete = function(self, buildingData)
  -- function num : 0_3
  (self.stOList):OnBuildUpgradeStOList(buildingData)
  ;
  (self.stOSide):OnBuildUpgradeStOSide(buildingData)
end

UIStrategyOverview.UpdateUIStOBuilding = function(self, buildingData)
  -- function num : 0_4
  (self.stOList):RefreshAllStOListTech(buildingData)
  ;
  (self.stOSide):OnBuildUpgradeStOSide(buildingData)
end

UIStrategyOverview._OnItemRefresh = function(self, itemIdDic)
  -- function num : 0_5 , upvalues : _ENV
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
    (self.stOList):RefreshAllStOListTech()
    ;
    (self.stOSide):RefreshStOSide()
  end
end

UIStrategyOverview._OnClickClose = function(self)
  -- function num : 0_6 , upvalues : _ENV
  ControllerManager:DeleteController(ControllerTypeId.StrategyOverview)
end

UIStrategyOverview.ShowStOPreview = function(self, buildingData)
  -- function num : 0_7
  (self.previewNode):Show()
  ;
  (self.previewNode):InitBuildLogicLvPreview(buildingData)
end

UIStrategyOverview.OnDelete = function(self)
  -- function num : 0_8 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__onItemRefresh)
  MsgCenter:RemoveListener(eMsgEventId.UpdateARGItem, self.__onItemRefresh)
  ;
  (self.stOList):Delete()
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

