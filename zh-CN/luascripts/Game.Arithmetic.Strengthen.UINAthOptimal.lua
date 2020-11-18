-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthOptimal = class("UINAthOptimal", UIBaseNode)
local base = UIBaseNode
local UIAthIconItem = require("Game.Arithmetic.SortList.UIAthIconItem")
local UINAthAttrItem = require("Game.Arithmetic.Common.UINAthAttrItem")
local UINAthOptAffixItem = require("Game.Arithmetic.Strengthen.UINAthOptAffixItem")
local cs_MessageCommon = CS.MessageCommon
local consumeItemId = (ConfigData.game_config).athOptimizeConsumeItemId
UINAthOptimal.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UIAthIconItem, UINAthAttrItem, UINAthOptAffixItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Optimal, self, self.OnClickOptimalBtn)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).slider, self, self.OnSliderValueChange)
  ;
  ((self.ui).mainAttriItem):SetActive(false)
  ;
  ((self.ui).tog_SubAttriItem):SetActive(false)
  self.__onUpdateItemEvent = BindCallback(self, self.OnItemUpdateEvent)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__onUpdateItemEvent)
  self.__onSelectAffixEvent = BindCallback(self, self.SeletAffix)
  self.__checkOptEnableEvent = BindCallback(self, self.CheckOptEnable)
  self.athIconItem = (UIAthIconItem.New)()
  ;
  (self.athIconItem):Init((self.ui).uI_ATHIconItem)
  self.mainAttrPool = (UIItemPool.New)(UINAthAttrItem, (self.ui).mainAttriItem)
  self.affixItemPool = (UIItemPool.New)(UINAthOptAffixItem, (self.ui).tog_SubAttriItem)
  self.athNetwork = NetworkManager:GetNetwork(NetworkTypeID.Arithmetic)
end

UINAthOptimal.InitAthOptimal = function(self, athData)
  -- function num : 0_1 , upvalues : _ENV
  self.athData = athData
  self:__UpdateConsumeItem()
  ;
  ((self.ui).tex_ATHName):SetIndex(0, athData:GetName())
  ;
  ((self.ui).tex_ATHDensity):SetIndex(0, GetPreciseDecimalStr((self.athData):GetAthDensity(), 2))
  ;
  (self.athIconItem):InitAthIconItem(athData)
  ;
  (self.mainAttrPool):HideAll()
  for k,v in ipairs(athData.attrList) do
    local attrItem = (self.mainAttrPool):GetOne()
    attrItem:InitAthAttrItem(v.id, v.value)
  end
  self:UpdateCumulate()
  local firstAffixIndex = nil
  ;
  ((self.ui).affixToggleGroup):SetAllTogglesOff()
  ;
  (self.affixItemPool):HideAll()
  for k,v in ipairs(athData.affixList) do
    local affixItem = (self.affixItemPool):GetOne()
    affixItem:InitAthOptAffixItem(R11_PC65, v.id, v.quality, v.value, self.__onSelectAffixEvent, self.__checkOptEnableEvent)
    if firstAffixIndex == nil and affixItem:OptimizeEnable() then
      firstAffixIndex = 
      affixItem:SetSelected()
    end
  end
  local enableOpt = firstAffixIndex ~= nil
  ;
  ((self.ui).optimalGroup):SetActive(enableOpt)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UINAthOptimal.__UpdateConsumeItem = function(self)
  -- function num : 0_2 , upvalues : _ENV, consumeItemId
  local consumeItemCfg = (ConfigData.item)[consumeItemId]
  if consumeItemCfg == nil then
    error("Can\'t find itemCfg, id = " .. tostring(consumeItemId))
    return 
  end
  local consumeItemCount = PlayerDataCenter:GetItemCount(consumeItemId)
  self.__consumeItemName = (LanguageUtil.GetLocaleText)(consumeItemCfg.name)
  ;
  ((self.ui).tex_Consume):SetIndex(0, self.__consumeItemName, tostring(consumeItemCount))
  local icon = CRH:GetSprite(consumeItemCfg.icon)
  -- DECOMPILER ERROR at PC38: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).img_ConsumeIconL).sprite = icon
  -- DECOMPILER ERROR at PC41: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).img_ConsumeIconR).sprite = icon
  local color = ItemQualityColor[consumeItemCfg.quality]
  -- DECOMPILER ERROR at PC47: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).img_ConsumeQualityL).color = color
  -- DECOMPILER ERROR at PC50: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).img_ConsumeQualityR).color = color
  ;
  ((self.ui).tex_TakeNum):SetIndex(0, tostring((ConfigData.game_config).athOptimizeConsumeItemNum))
end

UINAthOptimal.UpdateCumulate = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local failureCount = (ConfigData.game_config).athOptimizeFailureCount
  local curFailure = (PlayerDataCenter.allAthData).failure
  if failureCount < curFailure then
    curFailure = failureCount
  end
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).img_Cumulate).fillAmount = curFailure / failureCount
  ;
  ((self.ui).tex_Cumulate):SetIndex(0, tostring(curFailure), tostring(failureCount))
  self.__nextMustSuccess = curFailure == failureCount
  ;
  ((self.ui).tex_NextMustSuccess):SetActive(self.__nextMustSuccess)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UINAthOptimal.OnItemUpdateEvent = function(self, itemUpdate)
  -- function num : 0_4 , upvalues : consumeItemId, _ENV
  if itemUpdate[consumeItemId] ~= nil then
    local consumeItemCount = PlayerDataCenter:GetItemCount(consumeItemId)
    ;
    ((self.ui).tex_Consume):SetIndex(0, self.__consumeItemName, tostring(consumeItemCount))
  end
end

UINAthOptimal.SeletAffix = function(self, affixIndex)
  -- function num : 0_5 , upvalues : _ENV
  local section = 0
  if self.affixIndex ~= nil and self.affixIndex == affixIndex then
    section = self.section
  end
  self.affixIndex = affixIndex
  local afficElem = ((self.athData).affixList)[affixIndex]
  self.curAffixCfg = (ConfigData.ath_affix_pool)[afficElem.id]
  if self.curAffixCfg == nil then
    error("Can\'t find ath_affix_pool, id = " .. tostring(afficElem.id))
    return 
  end
  self.curOptCfg = (ConfigData.ath_optimize)[(self.curAffixCfg).optimize_id]
  if self.curOptCfg == nil then
    error("Can\'t find ath_optimize cfg, id = " .. tostring((self.curAffixCfg).optimize_id))
    return 
  end
  self:SetSliderSection(section)
end

UINAthOptimal.SetSliderSection = function(self, section)
  -- function num : 0_6
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).slider).minValue = 0
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).slider).maxValue = (self.curOptCfg).density - 1
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).slider).wholeNumbers = true
  if self.__nextMustSuccess then
    section = ((self.ui).slider).maxValue
  end
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).slider).interactable = not self.__nextMustSuccess
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).slider).value = section
  self:RefreshPreview(section)
end

UINAthOptimal.RefreshPreview = function(self, section)
  -- function num : 0_7 , upvalues : _ENV
  self.section = section
  local optCfg = self.curOptCfg
  local addValue = optCfg.unit_section * section
  local baseMedian = ((optCfg.base_section)[1] + (optCfg.base_section)[2]) / 2
  local curMedian = baseMedian + addValue
  local successRate = baseMedian * optCfg.base_success / curMedian / 100
  if self.__nextMustSuccess then
    successRate = 100
  end
  ;
  ((self.ui).tex_SuccessRate):SetIndex(0, GetPreciseDecimalStr(successRate, 1))
  local attrId = (self.curAffixCfg).affix_para
  local value1 = (optCfg.base_section)[1] + addValue
  local value2 = (optCfg.base_section)[2] + addValue
  local _, valueStr1 = ConfigData:GetAttribute(attrId, value1)
  local _, valueStr2 = ConfigData:GetAttribute(attrId, value2)
  ;
  ((self.ui).tex_PromotingNum):SetIndex(0, valueStr1, valueStr2)
end

UINAthOptimal.OnSliderValueChange = function(self, value)
  -- function num : 0_8
  self:RefreshPreview(value)
end

UINAthOptimal.CheckOptEnable = function(self)
  -- function num : 0_9 , upvalues : _ENV
  local enableIndex = nil
  ;
  ((self.ui).affixToggleGroup):SetAllTogglesOff()
  for k,item in ipairs((self.affixItemPool).listItem) do
    if item:OptimizeEnable() then
      enableIndex = k
      item:SetSelected()
      break
    end
  end
  do
    if enableIndex == nil then
      ((self.ui).optimalGroup):SetActive(false)
    end
  end
end

UINAthOptimal.OnClickOptimalBtn = function(self)
  -- function num : 0_10 , upvalues : _ENV, consumeItemId, cs_MessageCommon
  local consumeItemCount = PlayerDataCenter:GetItemCount(consumeItemId)
  if consumeItemCount <= (ConfigData.game_config).athOptimizeConsumeItemNum then
    (cs_MessageCommon.ShowMessageTips)(self.__consumeItemName .. ConfigData:GetTipContent(TipContent.arithmetic_optimal_ItemInsufficient))
    return 
  end
  ;
  (self.athNetwork):CS_ATH_AthOptimize((self.athData).uid, self.affixIndex - 1, self.section, BindCallback(self, self.OnOptimalComplete))
end

UINAthOptimal.OnOptimalComplete = function(self, objList)
  -- function num : 0_11 , upvalues : cs_MessageCommon, _ENV
  local succeed = objList[0]
  self:UpdateCumulate()
  local newValue = (((self.athData).affixList)[self.affixIndex]).value
  ;
  (((self.affixItemPool).listItem)[self.affixIndex]):OptAffixChange(newValue, succeed)
  if succeed then
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.arithmetic_optimal_Success))
    ;
    ((self.ui).tex_ATHDensity):SetIndex(0, GetPreciseDecimalStr((self.athData):GetAthDensity(), 2))
  else
    ;
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.arithmetic_optimal_Failure))
    self:SetSliderSection(self.section)
  end
end

UINAthOptimal.OnDelete = function(self)
  -- function num : 0_12 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__onUpdateItemEvent)
  ;
  (self.mainAttrPool):DeleteAll()
  ;
  (self.affixItemPool):DeleteAll()
  ;
  (base.OnDelete)(self)
end

return UINAthOptimal

