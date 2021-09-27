local UINGameSetPanel = class("UINGameSetPanel", UIBaseNode)
local base = UIBaseNode
local UIMultiSwitchTogItem = require("Game.Setting.UI.UIMultiSwitchTogItem")
UINGameSetPanel.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINGameSetPanel.InitGameSetPanel = function(self, ctrl)
  -- function num : 0_1 , upvalues : _ENV
  self.setCtrl = ctrl
  self.multiSwitchToggleItemList = {}
  local systemSaveData = (self.setCtrl):GetSystemSaveData()
  local currentChipDescCallback = BindCallback(systemSaveData, systemSaveData.GetIsShowDetailDescribeValue, eGameSetDescType.chip)
  local resolutionOptionName = ((ConfigData.game_set_describe)[eGameSetDescType.chip]).option_group_name
  local chipDescCallback = BindCallback(self, self.OnToogleCallback, eGameSetDescType.chip)
  self:InitGameSetMultiDisplayItem(currentChipDescCallback, resolutionOptionName, (self.ui).chipDescItem, chipDescCallback)
  local currentSkillDescCallback = BindCallback(systemSaveData, systemSaveData.GetIsShowDetailDescribeValue, eGameSetDescType.skill)
  local resolutionOptionName = ((ConfigData.game_set_describe)[eGameSetDescType.skill]).option_group_name
  local skillDescCallback = BindCallback(self, self.OnToogleCallback, eGameSetDescType.skill)
  self:InitGameSetMultiDisplayItem(currentSkillDescCallback, resolutionOptionName, (self.ui).skillDescItem, skillDescCallback)
end

UINGameSetPanel.OnToogleCallback = function(self, eGameSetDescType, value, togItem)
  -- function num : 0_2
  local isDetail = false
  if togItem.index == 0 and value then
    isDetail = false
  end
  if togItem.index == 1 and value then
    isDetail = true
  end
  ;
  (self.setCtrl):SetShowDetailDescribe(eGameSetDescType, isDetail)
end

UINGameSetPanel.InitGameSetMultiDisplayItem = function(self, curValue, strList, togGroup, bindEvent, isReverse)
  -- function num : 0_3 , upvalues : UIMultiSwitchTogItem, _ENV
  local itemGo = ((self.ui).multiTogItem):Instantiate(togGroup.transform)
  itemGo:SetActive(true)
  local multiSwitchTogItem = (UIMultiSwitchTogItem.New)()
  multiSwitchTogItem:Init(itemGo)
  multiSwitchTogItem:InitUIMultiSwitchTogItem(curValue, strList, isReverse, bindEvent, self)
  ;
  (table.insert)(self.multiSwitchToggleItemList, multiSwitchTogItem)
end

UINGameSetPanel.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UINGameSetPanel

