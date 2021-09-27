local UINEpOverclockListItem = class("UINEpOverclockListItem", UIBaseNode)
UINEpOverclockListItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Select, self, self.OnBtnSelectClicked)
end

UINEpOverclockListItem.InitOverclockListItem = function(self, clockOptionData, overclockCtrl, clockSelectAction)
  -- function num : 0_1 , upvalues : _ENV
  self.clockOptionData = clockOptionData
  self.overclockId = clockOptionData.overclockId
  self.__clockSelectAction = clockSelectAction
  local overclockCfg = (ConfigData.overclock)[self.overclockId]
  local overclockLevel = (self.clockOptionData).overclockLevel or 1
  local overclockLevelCfg = overclockCfg[overclockLevel]
  if overclockLevelCfg == nil then
    error("not contain overclock id:" .. self.overclockId .. " Level:" .. overclockLevel)
    return 
  end
  self.overclockLevelCfg = overclockLevelCfg
  self:__RefreshClockLockState(overclockCtrl)
  self:__RefreshClockItemInfo(overclockCtrl)
end

UINEpOverclockListItem.__RefreshClockLockState = function(self, overclockCtrl)
  -- function num : 0_2
  local isUsed = overclockCtrl:IsUseOverclockOption(self.overclockId)
  ;
  ((self.ui).obj_IsUse):SetActive(isUsed)
  ;
  (((self.ui).btn_Select).gameObject):SetActive(not isUsed)
  if isUsed then
    ((self.ui).obj_lock):SetActive(false)
    return 
  end
  local isUnlock = (self.clockOptionData).isUnlock
  local isLimit = overclockCtrl:IsUseClockLimit()
  if not isUnlock or isLimit then
    ((self.ui).obj_lock):SetActive(true)
    ;
    ((self.ui).obj_texLock):SetActive(not isUnlock)
    ;
    ((self.ui).obj_isLimit):SetActive(isUnlock)
    -- DECOMPILER ERROR at PC51: Confused about usage of register: R5 in 'UnsetPending'

    if not isUnlock then
      ((self.ui).tex_Condition).text = (self.clockOptionData).unlockDes
    end
  else
    ;
    ((self.ui).obj_lock):SetActive(false)
  end
end

UINEpOverclockListItem.__RefreshClockItemInfo = function(self, overclockCtrl)
  -- function num : 0_3 , upvalues : _ENV
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).tex_desc).text = (LanguageUtil.GetLocaleText)((self.overclockLevelCfg).describe)
  local freeNum = overclockCtrl:GetLastFreeNum()
  if freeNum > 0 and (self.clockOptionData).isUnlock then
    (((self.ui).tex_orginal).gameObject):SetActive(true)
    ;
    ((self.ui).tex_price):SetIndex(0)
    -- DECOMPILER ERROR at PC33: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).tex_orginal).text = tostring((self.overclockLevelCfg).consumeNum)
  else
    ;
    (((self.ui).tex_orginal).gameObject):SetActive(false)
    ;
    ((self.ui).tex_price):SetIndex(1, tostring((self.overclockLevelCfg).consumeNum))
  end
  -- DECOMPILER ERROR at PC61: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).img_money).sprite = CRH:GetSprite(((ConfigData.item)[(self.overclockLevelCfg).consumeId]).icon)
end

UINEpOverclockListItem.OnBtnSelectClicked = function(self)
  -- function num : 0_4
  if not (self.clockOptionData).isUnlock then
    return 
  end
  if self.__clockSelectAction ~= nil then
    (self.__clockSelectAction)(self)
  end
end

UINEpOverclockListItem.OnDelete = function(self)
  -- function num : 0_5
end

return UINEpOverclockListItem

