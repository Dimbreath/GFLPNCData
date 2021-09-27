local UISettingGraph = class("UISettingGraph", UIBaseWindow)
local UIGuideSettingGraphTogItem = require("Game.Setting.UI.UIGuideSettingGraphTogItem")
local base = UIBaseWindow
local cs_ResLoader = CS.ResLoader
UISettingGraph.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, cs_ResLoader
  (UIUtil.AddButtonListener)((self.ui).btn_Confirm, self, self.ConfirmClicked)
  self.presetPerformanceLevel = {1, 3, 4}
  self.resLoader = (cs_ResLoader.Create)()
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.ui).togItemList = {}
  ;
  (((self.ui).tex_WarningText).gameObject):SetActive(false)
  ;
  ((self.ui).multiTogItem):SetActive(false)
end

UISettingGraph.InitSettingGraph = function(self, confirmCallback)
  -- function num : 0_1 , upvalues : _ENV, UIGuideSettingGraphTogItem
  self.ctrl = ControllerManager:GetController(ControllerTypeId.Setting, true)
  local performanceLevelName = (ConfigData:GetPerformanceTypeinfoByName("mode")).option_group_name
  self.recommendPerformanceLevel = (GameSystemInfo.GetGuideDefaultPerformance)()
  for _,presetPerformanceLevel in ipairs(self.presetPerformanceLevel) do
    local index = presetPerformanceLevel
    local name = performanceLevelName ~= nil and performanceLevelName[index] ~= nil and (LanguageUtil.GetLocaleText)(performanceLevelName[index]) or ""
    local image = self:__GetPerformanceLevelShowImage(presetPerformanceLevel)
    local isOn = index == self.recommendPerformanceLevel
    local toggleItemObj = ((self.ui).multiTogItem):Instantiate(((self.ui).settingGroup).transform)
    ;
    (toggleItemObj.gameObject):SetActive(true)
    local guideSettingGraphTogItem = (UIGuideSettingGraphTogItem.New)()
    guideSettingGraphTogItem:Init(toggleItemObj)
    local OnPerformanceLevelChangedCallback = BindCallback(self, self.OnPerformanceLevelChanged)
    guideSettingGraphTogItem:InitGuideSettingGraphTogItem(index, isOn, isOn, index == 4, name, image, (self.ui).settingGroup, OnPerformanceLevelChangedCallback)
    -- DECOMPILER ERROR at PC77: Confused about usage of register: R15 in 'UnsetPending'

    ;
    ((self.ui).togItemList)[index] = guideSettingGraphTogItem
  end
  self.confirmCallback = confirmCallback
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

UISettingGraph.OnPerformanceLevelChanged = function(self, value, togItem)
  -- function num : 0_2
  if value then
    (self.ctrl):SetPerformanceLevel(togItem.index)
    ;
    (((self.ui).tex_WarningText).gameObject):SetActive(self.recommendPerformanceLevel < togItem.index)
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UISettingGraph.__GetPerformanceLevelShowImage = function(self, presetPerformanceLevel)
  -- function num : 0_3 , upvalues : _ENV
  local performance_setting = (ConfigData.performance_setting)[presetPerformanceLevel]
  local PerformanceLevelImagePath = performance_setting ~= nil and performance_setting.guide_graph or nil
  if PerformanceLevelImagePath ~= nil then
    local fullPath = PathConsts:GetImagePath(PerformanceLevelImagePath)
    local image = (self.resLoader):LoadABAsset(fullPath)
    return image
  end
  do
    return nil
  end
end

UISettingGraph.ConfirmClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  (self.ctrl):ForceSetToCurrentPerformanceLevel()
  PersistentManager:SaveModelData((PersistentConfig.ePackage).SystemData)
  self:Delete()
  if self.confirmCallback ~= nil then
    (self.confirmCallback)()
  end
end

UISettingGraph.OnHide = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnHide)(self)
end

UISettingGraph.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  if self.resLoader ~= nil then
    (self.resLoader):Put2Pool()
    self.resLoader = nil
  end
  self.ctrl = nil
  ;
  (base.OnDelete)(self)
end

return UISettingGraph

