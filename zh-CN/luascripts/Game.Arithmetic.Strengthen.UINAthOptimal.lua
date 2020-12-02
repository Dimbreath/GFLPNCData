-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthOptimal = class("UINAthOptimal", UIBaseNode)
local base = UIBaseNode
local UINItemWithCost = require("Game.Arithmetic.Strengthen.UINItemWithCost")
local UINAthOptAffixItem = require("Game.Arithmetic.Strengthen.UINAthOptAffixItem")
local UINAthEmptyAffix = require("Game.Arithmetic.Strengthen.UINAthEmptyAffix")
local cs_MessageCommon = CS.MessageCommon
UINAthOptimal.ctor = function(self, affixToggleGroup)
  -- function num : 0_0
  self.affixToggleGroup = affixToggleGroup
end

UINAthOptimal.OnInit = function(self)
  -- function num : 0_1 , upvalues : _ENV, cs_MessageCommon, UINItemWithCost, UINAthEmptyAffix
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Optimiz, self, self.OnClickOptimalBtn)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).slider, self, self.OnSliderValueChange)
  self.__onUpdateItemEvent = BindCallback(self, self.OnItemUpdateEvent)
  self.__onSelectAffixEvent = BindCallback(self, self.SeletAffix)
  self.__checkOptEnableEvent = BindCallback(self, self.CheckOptEnable)
  ;
  (((CS.EventTriggerListener).Get)(((self.ui).slider).gameObject)):onClick("+", function()
    -- function num : 0_1_0 , upvalues : self, cs_MessageCommon, _ENV
    if not self.enableOpt then
      (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(279))
    end
  end
)
  ;
  ((self.ui).itemWithCount):SetActive(false)
  self.consumeItemPool = (UIItemPool.New)(UINItemWithCost, (self.ui).itemWithCount)
  self.athNetwork = NetworkManager:GetNetwork(NetworkTypeID.Arithmetic)
  ;
  ((self.ui).emptyAffixItem):SetActive(false)
  self.emptyAffixPool = (UIItemPool.New)(UINAthEmptyAffix, (self.ui).emptyAffixItem)
end

UINAthOptimal.InitAthOptimal = function(self, athData, affixItemPool)
  -- function num : 0_2 , upvalues : _ENV
  if self.athData ~= athData then
    self.affixIndex = nil
    self.curAfficElem = nil
  end
  self.athData = athData
  self:__UpdateConsumeItem()
  self:UpdateCumulate()
  self.affixItemPool = affixItemPool
  local firstAffixIndex = nil
  ;
  (self.affixItemPool):HideAll()
  ;
  (self.emptyAffixPool):HideAll()
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.affixToggleGroup).allowSwitchOff = true
  for i = 1, 4 do
    local affix = (athData.affixList)[i]
    if affix ~= nil then
      local affixItem = (self.affixItemPool):GetOne()
      affixItem:InitAthOptAffixItem(i, affix, self.__onSelectAffixEvent, self.__checkOptEnableEvent)
      local select = (firstAffixIndex == nil and affixItem:OptimizeEnable())
      if select then
        firstAffixIndex = i
      end
      affixItem:SetAthAffixSelected(select)
      -- DECOMPILER ERROR at PC54: Confused about usage of register: R11 in 'UnsetPending'

      ;
      (affixItem.gameObject).name = tostring(i)
    else
      local emptyItem = (self.emptyAffixPool):GetOne()
      emptyItem:InitAthEmptyAffix((self.ui).affixList)
    end
  end
  -- DECOMPILER ERROR at PC65: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.affixToggleGroup).allowSwitchOff = false
  local enableOpt = firstAffixIndex ~= nil
  self:__RefreshEnableOpt(enableOpt)
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

UINAthOptimal.__RefreshEnableOpt = function(self, enableOpt)
  -- function num : 0_3
  self.enableOpt = enableOpt
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).btn_Optimiz).interactable = enableOpt
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).slider).enabled = enableOpt
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

  if not enableOpt then
    ((self.ui).slider).minValue = 0
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).slider).maxValue = 2
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).slider).value = 1
    self:__UpdateConsumeItem()
    ;
    ((self.ui).tex_UpValue):SetIndex(0, "0")
    ;
    ((self.ui).tex_SuccessValue):SetIndex(0, "0")
  end
end

UINAthOptimal.__UpdateConsumeItem = function(self)
  -- function num : 0_4 , upvalues : _ENV
  (self.consumeItemPool):HideAll()
  for k,itemId in ipairs((ConfigData.game_config).athOptimizeConsumeItemId) do
    local consumeNum = ((ConfigData.game_config).athOptimizeConsumeItemNum)[k]
    local itemCfg = (ConfigData.item)[itemId]
    if itemCfg == nil then
      error("Can\'t find itemCfg, id = " .. tostring(itemId))
    else
      local consumeItem = (self.consumeItemPool):GetOne()
      consumeItem:InitItemWithCost(itemCfg, consumeNum)
    end
  end
end

UINAthOptimal.UpdateCumulate = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local failureCount = (ConfigData.game_config).athOptimizeFailureCount
  local curFailure = (PlayerDataCenter.allAthData).failure
  self.nextMustSuccess = false
  if failureCount < curFailure then
    curFailure = failureCount
  end
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).img_FailRate).fillAmount = curFailure / failureCount
  ;
  ((self.ui).tex_FailRate):SetIndex(0, tostring(curFailure), tostring(failureCount))
  self.__nextMustSuccess = curFailure == failureCount
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UINAthOptimal.OnItemUpdateEvent = function(self, itemUpdate)
  -- function num : 0_6 , upvalues : _ENV
  for k,itemId in ipairs((ConfigData.game_config).athOptimizeConsumeItemId) do
    if itemUpdate[itemId] ~= nil then
      local consumeItem = ((self.consumeItemPool).listItem)[k]
      consumeItem:RefreshItemWithCost()
    end
  end
end

UINAthOptimal.SeletAffix = function(self, affixIndex, isOn)
  -- function num : 0_7 , upvalues : _ENV
  if not isOn then
    return 
  end
  local afficElem = ((self.athData).affixList)[affixIndex]
  self.curAffixCfg = (ConfigData.ath_affix_pool)[afficElem.id]
  if self.curAffixCfg == nil then
    error("Can\'t find ath_affix_pool, id = " .. tostring(afficElem.id))
    return 
  end
  self.curAffixLvCfg = (ConfigData.ath_affix_lv)[afficElem.level]
  if self.curAffixLvCfg == nil then
    error("Cant get ath_affix_lv, level = " .. afficElem.level)
    return 
  end
  local section = ((self.curAffixLvCfg).density - 1) // 2
  if self.affixIndex ~= nil and self.affixIndex == affixIndex then
    section = self.section
  end
  self.affixIndex = affixIndex
  self.curAfficElem = afficElem
  self:SetSliderSection(section)
end

UINAthOptimal.SetSliderSection = function(self, section)
  -- function num : 0_8
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).slider).minValue = 0
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).slider).maxValue = (self.curAffixLvCfg).density - 1
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
  -- function num : 0_9 , upvalues : _ENV
  self.section = section
  local optCfg = self.curAffixLvCfg
  local addValue = optCfg.unit_section * section
  local baseMedian = ((optCfg.base_section)[1] + (optCfg.base_section)[2]) / 2
  local curMedian = baseMedian + addValue
  local successRate = baseMedian * optCfg.base_success / curMedian / 100
  if self.__nextMustSuccess then
    successRate = 100
  end
  ;
  ((self.ui).tex_SuccessValue):SetIndex(0, GetPreciseDecimalStr(successRate, 1))
  local value1 = (optCfg.base_section)[1] + addValue
  local value2 = (optCfg.base_section)[2] + addValue
  ;
  ((self.ui).tex_UpValue):SetIndex(1, GetPreciseDecimalStr(value1, 0), GetPreciseDecimalStr(value2, 0))
end

UINAthOptimal.OnSliderValueChange = function(self, value)
  -- function num : 0_10
  if not self.enableOpt then
    return 
  end
  self:RefreshPreview(value)
end

UINAthOptimal.CheckOptEnable = function(self)
  -- function num : 0_11 , upvalues : _ENV
  local enableIndex = nil
  ;
  (self.affixToggleGroup):SetAllTogglesOff()
  for k,item in ipairs((self.affixItemPool).listItem) do
    if item:OptimizeEnable() then
      enableIndex = k
      item:SetAthAffixSelected(true)
      break
    end
  end
  do
    if enableIndex == nil then
      self:__RefreshEnableOpt(false)
    end
  end
end

UINAthOptimal.OnClickOptimalBtn = function(self)
  -- function num : 0_12 , upvalues : _ENV, cs_MessageCommon
  for k,itemId in ipairs((ConfigData.game_config).athOptimizeConsumeItemId) do
    local consumeNum = ((ConfigData.game_config).athOptimizeConsumeItemNum)[k]
    local itemCfg = (ConfigData.item)[itemId]
    local consumeItemCount = PlayerDataCenter:GetItemCount(itemId)
    if consumeItemCount < consumeNum then
      local name = (LanguageUtil.GetLocaleText)(itemCfg.name)
      ;
      (cs_MessageCommon.ShowMessageTips)(name .. ConfigData:GetTipContent(TipContent.arithmetic_optimal_ItemInsufficient))
      return 
    end
  end
  if self.__OnOptimalComplete == nil then
    self.__OnOptimalComplete = BindCallback(self, self.OnOptimalComplete)
  end
  ;
  (self.athNetwork):CS_ATH_AthOptimize((self.athData).uid, self.affixIndex - 1, self.section, self.__OnOptimalComplete)
end

UINAthOptimal.OnOptimalComplete = function(self, objList)
  -- function num : 0_13 , upvalues : _ENV, cs_MessageCommon
  local succeed = objList[0]
  self:UpdateCumulate()
  local affixElem = ((self.athData).affixList)[self.affixIndex]
  if succeed then
    local fromLv = (self.curAfficElem).level
    do
      do
        local toLv = affixElem.level
        if fromLv ~= toLv then
          local fromValue = (self.curAfficElem).value
          do
            local toValue = affixElem.value
            local affixcfg = (ConfigData.ath_affix_pool)[affixElem.id]
            if affixcfg == nil then
              error("Cant\'t find ath_affix_pool, id = " .. tostring(affixElem.id))
              return 
            end
            local attrId = affixcfg.affix_para
            UIManager:ShowWindowAsync(UIWindowTypeID.HeroLevelUpSuccess, function(window)
    -- function num : 0_13_0 , upvalues : _ENV, fromLv, toLv, fromValue, toValue, attrId
    (UIManager:ShowWindow(UIWindowTypeID.HeroLevelUpSuccess)):AthAffixLevelUp(fromLv, toLv, fromValue, toValue, attrId)
  end
)
          end
        end
        do
          ;
          (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.arithmetic_optimal_Success))
          self.curAfficElem = affixElem
        end
        ;
        (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.arithmetic_optimal_Failure))
        ;
        (((self.affixItemPool).listItem)[self.affixIndex]):OptAffixChange(affixElem)
        self:SetSliderSection(self.section)
      end
    end
  end
end

UINAthOptimal.OnShow = function(self)
  -- function num : 0_14 , upvalues : _ENV
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__onUpdateItemEvent)
end

UINAthOptimal.OnHide = function(self)
  -- function num : 0_15 , upvalues : _ENV
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__onUpdateItemEvent)
end

UINAthOptimal.OnDelete = function(self)
  -- function num : 0_16 , upvalues : base
  (base.OnDelete)(self)
end

return UINAthOptimal

