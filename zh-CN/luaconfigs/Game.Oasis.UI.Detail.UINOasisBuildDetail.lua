-- params : ...
-- function num : 0 , upvalues : _ENV
local UINOasisBuildDetail = class("UINOasisBuildDetail", UIBaseNode)
local base = UIBaseNode
local UINStOUpItem = require("Game.StrategyOverview.UI.Side.UINStOUpItem")
local UINStOConsumeItem = require("Game.StrategyOverview.UI.Side.UINStOConsumeItem")
local UINStOUnlockConditionItem = require("Game.StrategyOverview.UI.Side.UINStOUnlockConditionItem")
UINOasisBuildDetail.ctor = function(self, oasisMain, resLoader)
  -- function num : 0_0
  self.oasisMain = oasisMain
  self.resLoader = resLoader
end

UINOasisBuildDetail.OnInit = function(self)
  -- function num : 0_1 , upvalues : _ENV, UINStOUpItem, UINStOConsumeItem, UINStOUnlockConditionItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Preview, self, self._OnClickPreview)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Upgrade, self, self._OnClickUpgrade)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Close, self, self.HideOasisBuildDetail)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Bg, self, self.HideOasisBuildDetail)
  ;
  ((self.ui).upItem):SetActive(false)
  self.upItemPool = (UIItemPool.New)(UINStOUpItem, (self.ui).upItem)
  ;
  ((self.ui).consumeItem):SetActive(false)
  self.consumeItemPool = (UIItemPool.New)(UINStOConsumeItem, (self.ui).consumeItem)
  ;
  ((self.ui).conditionItem):SetActive(false)
  self.conditionItemPool = (UIItemPool.New)(UINStOUnlockConditionItem, (self.ui).conditionItem)
end

UINOasisBuildDetail.InitOasisBuildDetail = function(self, buildingData, isInfo)
  -- function num : 0_2 , upvalues : _ENV
  self:Show()
  self.buildingData = buildingData
  self.isInfo = isInfo
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(((buildingData.dynData).stcData).name)
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Intro).text = (LanguageUtil.GetLocaleText)(((buildingData.dynData).stcData).intro_long)
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_EnName).text = ((buildingData.dynData).stcData).name_en
  local path = PathConsts:GetOasisBuildingIconPath((buildingData.dynData).icon_res)
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).img_Pic).enabled = false
  ;
  (self.resLoader):LoadABAssetAsync(path, function(texture)
    -- function num : 0_2_0 , upvalues : self
    if texture == nil then
      return 
    end
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Pic).texture = texture
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Pic).enabled = true
  end
)
  -- DECOMPILER ERROR at PC49: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).sprite = CRH:GetSprite(((buildingData.dynData).stcData).small_icon)
  ;
  (((self.ui).tex_Intro).gameObject):SetActive(isInfo)
  self:RefreshOasisBuildDetailState()
  ;
  (UIUtil.HideTopStatus)()
  ;
  (UIUtil.Push2BackStack)(self, self.Hide)
end

UINOasisBuildDetail._RefreshNum = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local type_id = (((self.buildingData).dynData).stcData).type_id
  local typeIdList = ((ConfigData.building).buildingTypeDic)[type_id]
  if typeIdList == nil then
    error("Cant get ConfigData.building.buildingTypeDic, type_id = " .. tostring(type_id))
    return 
  end
  local num = 0
  for k,buildId in ipairs(typeIdList) do
    if ((PlayerDataCenter.AllBuildingData).built)[buildId] ~= nil then
      num = num + 1
    end
  end
  ;
  ((self.ui).tex_Count):SetIndex(0, tostring(num), tostring(#typeIdList))
end

UINOasisBuildDetail._RefreshLogic = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local buffDict = (self.buildingData):GetNextLevelBuffItem()
  local isMaxLevel = (self.buildingData):IsMaxLevel()
  ;
  (self.upItemPool):HideAll()
  for k,v in ipairs(buffDict) do
    if v ~= nil then
      local upItem = ((self.upItemPool):GetOne())
      local nextInfoValue = nil
      if self.isInfo then
        nextInfoValue = nil
      else
        nextInfoValue = v.nextInfoValue
      end
      upItem:InitStOUpItem(v.currentInfo, v.curValue, nextInfoValue, isMaxLevel)
    end
  end
  local customLogicList = nil
  if self.isInfo then
    customLogicList = (self.buildingData):GetBuildCustomLogicInfo()
  else
    local nextLevel = ((self.buildingData).level or 0) + 1
    customLogicList = (self.buildingData):GetBuildCustomLogicInfo()
  end
  do
    for k,v in ipairs(customLogicList) do
      if not (string.IsNullOrEmpty)(v) then
        local upItem = (self.upItemPool):GetOne()
        upItem:InitStOUpItem(v, "", "", isMaxLevel)
      end
    end
    ;
    ((self.ui).effList):SetActive(#(self.upItemPool).listItem > 0)
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
end

UINOasisBuildDetail.RefreshOasisBuildDetailState = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if not self.active then
    return 
  end
  ;
  ((self.ui).consume):SetActive(false)
  ;
  ((self.ui).unlockCondition):SetActive(false)
  local buildingData = self.buildingData
  local curLv = buildingData.level or 0
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Level).text = (string.format)("%02d", curLv)
  self:_RefreshNum()
  self:_RefreshLogic()
  if self.isInfo then
    return 
  end
  local nextLevel = curLv + 1
  if buildingData:IsMaxLevel() then
    local nextLevelCfg = (buildingData.levelConfig)[nextLevel]
    if (CheckCondition.CheckLua)(nextLevelCfg.pre_condition, nextLevelCfg.pre_para1, nextLevelCfg.pre_para2) then
      ((self.ui).consume):SetActive(true)
      self:_RefreshConsume(buildingData)
      local canUpgrade = buildingData:CanUpgrade()
      -- DECOMPILER ERROR at PC63: Confused about usage of register: R6 in 'UnsetPending'

      ;
      ((self.ui).btn_Upgrade).interactable = canUpgrade
    else
      do
        ;
        ((self.ui).unlockCondition):SetActive(true)
        self:_RefreshCondition(buildingData)
      end
    end
  end
end

UINOasisBuildDetail._RefreshConsume = function(self, buildingData)
  -- function num : 0_6 , upvalues : _ENV
  (self.consumeItemPool):HideAll()
  local costList = buildingData:GetNextLevelCostItem()
  for k,cost in ipairs(costList) do
    local consumeItem = (self.consumeItemPool):GetOne()
    consumeItem:InitStOConsumeItem(cost.resId, cost.resCount)
  end
end

UINOasisBuildDetail._RefreshCondition = function(self, buildingData)
  -- function num : 0_7 , upvalues : _ENV
  (self.conditionItemPool):HideAll()
  local unlockTab = buildingData:GetPreBuildingLevelInfo()
  for k,condition in ipairs(unlockTab) do
    local conditionItem = (self.conditionItemPool):GetOne()
    conditionItem:InitStOUnlockConditionItem(condition.unlock, condition.lockReason)
  end
end

UINOasisBuildDetail._OnClickPreview = function(self)
  -- function num : 0_8
  ((self.oasisMain).buildPreviewNode):Show()
  ;
  ((self.oasisMain).buildPreviewNode):InitBuildLogicLvPreview(self.buildingData, nil, true)
end

UINOasisBuildDetail._OnClickUpgrade = function(self)
  -- function num : 0_9
  ((self.oasisMain).oasisCtrl):StartUpgrade(self.buildingData)
end

UINOasisBuildDetail.HideOasisBuildDetail = function(self)
  -- function num : 0_10 , upvalues : _ENV
  UIManager:ShowWindowOnly(UIWindowTypeID.TopStatus)
  ;
  (UIUtil.OnClickBack)()
end

UINOasisBuildDetail.OnDelete = function(self)
  -- function num : 0_11 , upvalues : base
  (self.upItemPool):DeleteAll()
  ;
  (self.consumeItemPool):DeleteAll()
  ;
  (self.conditionItemPool):DeleteAll()
  ;
  (base.OnDelete)(self)
end

return UINOasisBuildDetail

