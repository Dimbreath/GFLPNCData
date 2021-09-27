local UISettingDescribe = class("UISettingDescribe", UIBaseWindow)
local base = UIBaseWindow
local UINSettingDescribeTogItem = require("Game.Setting.UI.UINSettingDescribeTogItem")
UISettingDescribe.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.AddButtonListener)((self.ui).btn_Confirm, self, self.OnConfirmClicked)
  self.ctrl = ControllerManager:GetController(ControllerTypeId.Setting, true)
  self.isOn = false
  self.onToggleValueCallback = BindCallback(self, self.OnToggleValueCallback)
end

UISettingDescribe.InitSettingDescribe = function(self, onConfirmCallback)
  -- function num : 0_1
  self.onConfirmCallback = onConfirmCallback
  local skillID = 100503
  local showDetailDescList = {false, true}
  self:InitSkillToggleItem(skillID, showDetailDescList)
end

UISettingDescribe.InitSkillToggleItem = function(self, skillID, showDetailDescList)
  -- function num : 0_2 , upvalues : _ENV, UINSettingDescribeTogItem
  local isInit = true
  for index,go in ipairs((self.ui).togGoList) do
    local item = (UINSettingDescribeTogItem.New)()
    item:Init(go)
    item:InitSettingDescribeItem(index, skillID, showDetailDescList[index], self.onToggleValueCallback)
    if isInit then
      item:SetIsON()
      isInit = false
    end
  end
end

UISettingDescribe.OnToggleValueCallback = function(self, index, value)
  -- function num : 0_3
  if self.selIndex == index then
    return 
  end
  self.selIndex = index
  if index == 2 and value then
    self.isOn = true
  end
  if index == 1 and value then
    self.isOn = false
  end
end

UISettingDescribe.OnConfirmClicked = function(self)
  -- function num : 0_4
  self:SetDetailDescribe()
  self:Delete()
  if self.onConfirmCallback ~= nil then
    (self.onConfirmCallback)()
  end
end

UISettingDescribe.SetDetailDescribe = function(self)
  -- function num : 0_5 , upvalues : _ENV
  for index,cfg in ipairs(ConfigData.game_set_describe) do
    (self.ctrl):SetShowDetailDescribe(index, self.isOn)
  end
end

UISettingDescribe.OnDelete = function(self)
  -- function num : 0_6 , upvalues : _ENV, base
  PersistentManager:SaveModelData((PersistentConfig.ePackage).SystemData)
  self.ctrl = nil
  ;
  (base.OnDelete)(self)
end

return UISettingDescribe

