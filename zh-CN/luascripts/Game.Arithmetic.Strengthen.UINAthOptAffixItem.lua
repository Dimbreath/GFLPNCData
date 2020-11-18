-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthOptAffixItem = class("UINAthOptAffixItem", UIBaseNode)
local base = UIBaseNode
local ArthmeticEnum = require("Game.Arithmetic.ArthmeticEnum")
local affixQuality = 4
UINAthOptAffixItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).rootToggle, self, self.OnSelectAthOptItem)
end

UINAthOptAffixItem.InitAthOptAffixItem = function(self, index, affixId, quality, value, selectEvent, checkOptEnableEvent)
  -- function num : 0_1 , upvalues : affixQuality, _ENV
  self.index = index
  self.selectEvent = selectEvent
  self.checkOptEnableEvent = checkOptEnableEvent
  self.quality = quality
  self.enableOpt = affixQuality == quality
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).rootToggle).interactable = self.enableOpt
  ;
  ((self.ui).img_bg):SetActive(self.enableOpt)
  ;
  (((self.ui).tex_Disable).gameObject):SetActive(not self.enableOpt)
  ;
  ((self.ui).tex_Disable):SetIndex(0)
  local affixcfg = (ConfigData.ath_affix_pool)[affixId]
  if affixcfg == nil then
    error("Cant\'t find ath_affix_pool, id = " .. tostring(affixId))
    return 
  end
  self.affixcfg = affixcfg
  self:RefreshAffix(value)
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UINAthOptAffixItem.SetSelected = function(self)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  ((self.ui).rootToggle).isOn = true
end

UINAthOptAffixItem.OnSelectAthOptItem = function(self, isOn)
  -- function num : 0_3
  if not isOn then
    return 
  end
  if self.selectEvent ~= nil then
    (self.selectEvent)(self.index)
  end
end

UINAthOptAffixItem.RefreshAffix = function(self, value)
  -- function num : 0_4 , upvalues : _ENV, ArthmeticEnum
  self.value = value
  local attrId = (self.affixcfg).affix_para
  local attrName, attrValue = ConfigData:GetAttribute(attrId, value)
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_AttriName).text = attrName
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_AttriName).color = (ArthmeticEnum.AthQualityColor)[self.quality]
  local valueUpperLimit = (self.affixcfg).upper_limit
  local _, valueUpperLimitStr = ConfigData:GetAttribute(attrId, valueUpperLimit)
  ;
  ((self.ui).tex_Value):SetIndex(0, attrValue, valueUpperLimitStr)
  local fillAmount = value / valueUpperLimit
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R9 in 'UnsetPending'

  ;
  ((self.ui).img_Process).fillAmount = fillAmount
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R9 in 'UnsetPending'

  ;
  ((self.ui).img_ProcessBack).fillAmount = fillAmount
  -- DECOMPILER ERROR at PC40: Confused about usage of register: R9 in 'UnsetPending'

  ;
  ((self.ui).tex_ProcessChange).text = nil
  if value == valueUpperLimit then
    self.enableOpt = false
    -- DECOMPILER ERROR at PC46: Confused about usage of register: R9 in 'UnsetPending'

    ;
    ((self.ui).rootToggle).interactable = false
    ;
    ((self.ui).img_bg):SetActive(false)
    ;
    (((self.ui).tex_Disable).gameObject):SetActive(true)
    ;
    ((self.ui).tex_Disable):SetIndex(1)
  end
end

UINAthOptAffixItem.OptAffixChange = function(self, newValue, isAdd)
  -- function num : 0_5 , upvalues : _ENV
  local fillAmount = newValue / (self.affixcfg).upper_limit
  if newValue == (self.affixcfg).upper_limit then
    self.enableOpt = false
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).rootToggle).interactable = false
    if self.checkOptEnableEvent ~= nil then
      (self.checkOptEnableEvent)()
    end
  end
  if self.changeValueTween ~= nil then
    (self.changeValueTween):Kill(true)
  end
  if isAdd then
    local _, addValue = ConfigData:GetAttribute((self.affixcfg).affix_para, newValue - self.value)
    -- DECOMPILER ERROR at PC37: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).tex_ProcessChange).text = "+" .. addValue
    -- DECOMPILER ERROR at PC42: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).tex_ProcessChange).color = (self.ui).green
    -- DECOMPILER ERROR at PC47: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).img_ProcessBack).color = (self.ui).green
    self.changeValueTween = (((self.ui).img_ProcessBack):DOFillAmount(fillAmount, 1)):OnComplete(function()
    -- function num : 0_5_0 , upvalues : self, newValue
    self:RefreshAffix(newValue)
  end
)
  end
end

UINAthOptAffixItem.OptimizeEnable = function(self)
  -- function num : 0_6
  return self.enableOpt
end

UINAthOptAffixItem.OnDelete = function(self)
  -- function num : 0_7 , upvalues : base
  if self.changeValueTween ~= nil then
    (self.changeValueTween):Kill()
    self.changeValueTween = nil
  end
  ;
  (base.OnDelete)(self)
end

return UINAthOptAffixItem

