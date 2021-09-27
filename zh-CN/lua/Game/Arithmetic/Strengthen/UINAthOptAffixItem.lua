local UINAthOptAffixItem = class("UINAthOptAffixItem", UIBaseNode)
local base = UIBaseNode
local ArthmeticEnum = require("Game.Arithmetic.ArthmeticEnum")
UINAthOptAffixItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).rootToggle, self, self.OnSelectAthOptItem)
end

UINAthOptAffixItem.InitAthOptAffixItem = function(self, index, affixElem, selectEvent, checkOptEnableEvent)
  -- function num : 0_1
  self:SetAthAffixEnableSelect(true)
  self:SetAthAffixSelected(false)
  self.index = index
  self.selectEvent = selectEvent
  self.checkOptEnableEvent = checkOptEnableEvent
  self:RefreshAffix(affixElem)
end

UINAthOptAffixItem.SetAthAffixEnableSelect = function(self, enableSelect)
  -- function num : 0_2
  self.enableSelect = enableSelect
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).rootToggle).interactable = enableSelect
end

UINAthOptAffixItem.SetAthAffixSelected = function(self, selected)
  -- function num : 0_3
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).rootToggle).isOn = selected
end

UINAthOptAffixItem.OnSelectAthOptItem = function(self, isOn)
  -- function num : 0_4
  if not self.enableSelect then
    return 
  end
  if self.selectEvent ~= nil then
    (self.selectEvent)(self.index, isOn)
  end
end

UINAthOptAffixItem.RefreshAffix = function(self, affixElem)
  -- function num : 0_5 , upvalues : _ENV, ArthmeticEnum
  self.affixElem = affixElem
  local affixcfg = (ConfigData.ath_affix_pool)[affixElem.id]
  if affixcfg == nil then
    error("Cant\'t find ath_affix_pool, id = " .. tostring(affixElem.id))
    return 
  end
  self.affixcfg = affixcfg
  local affixLevelCfg = (ConfigData.ath_affix_lv)[affixElem.level]
  if affixLevelCfg == nil then
    error("Cant get affixLevelCfg, level = " .. tostring(affixElem.level))
    return 
  end
  self.affixLevelCfg = affixLevelCfg
  local name, valueStr, icon = ConfigData:GetAttribute((self.affixcfg).affix_para, affixElem.value)
  -- DECOMPILER ERROR at PC43: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).sprite = CRH:GetSprite(icon)
  -- DECOMPILER ERROR at PC50: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).color = (ArthmeticEnum.AthQualityColor)[(self.affixElem).quality]
  ;
  ((self.ui).tex_Level):SetIndex(0, tostring(affixElem.level))
  local attrId = (self.affixcfg).affix_para
  local attrName, attrValue = ConfigData:GetAttribute(attrId, affixElem.value)
  ;
  ((self.ui).tex_Num):SetIndex(0, attrName, attrValue)
  -- DECOMPILER ERROR at PC80: Confused about usage of register: R10 in 'UnsetPending'

  ;
  (((self.ui).tex_Num).text).color = (ArthmeticEnum.AthQualityColor)[(self.affixElem).quality]
  ;
  (((self.ui).tex_curProcess).gameObject):SetActive(true)
  ;
  ((self.ui).bar):SetActive(true)
  local fillAmount = nil
  if (ConfigData.ath_affix_lv).maxAffixLevel <= (self.affixElem).level then
    ((self.ui).tex_curProcess):SetIndex(1)
    self:SetAthAffixEnableSelect(false)
    fillAmount = 1
  else
    local expMax = (self.affixLevelCfg).exp
    local curExp = (self.affixElem).exp
    fillAmount = curExp / expMax
    ;
    ((self.ui).tex_curProcess):SetIndex(0, tostring(curExp), tostring(expMax))
  end
  do
    -- DECOMPILER ERROR at PC128: Confused about usage of register: R11 in 'UnsetPending'

    ;
    ((self.ui).img_Befor).fillAmount = fillAmount
    -- DECOMPILER ERROR at PC131: Confused about usage of register: R11 in 'UnsetPending'

    ;
    ((self.ui).img_After).fillAmount = fillAmount
  end
end

UINAthOptAffixItem.OptAffixChange = function(self, affixElem)
  -- function num : 0_6 , upvalues : _ENV
  self:RefreshAffix(affixElem)
  if (ConfigData.ath_affix_lv).maxAffixLevel <= (self.affixElem).level and self.checkOptEnableEvent ~= nil then
    (self.checkOptEnableEvent)()
  end
end

UINAthOptAffixItem.OptimizeEnable = function(self)
  -- function num : 0_7
  return self.enableSelect
end

UINAthOptAffixItem.OnDelete = function(self)
  -- function num : 0_8 , upvalues : base
  (base.OnDelete)(self)
end

return UINAthOptAffixItem

