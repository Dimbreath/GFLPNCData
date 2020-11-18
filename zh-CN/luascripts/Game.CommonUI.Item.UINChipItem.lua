-- params : ...
-- function num : 0 , upvalues : _ENV
local UINChipItem = class("UINChipItem", UIBaseNode)
local base = UIBaseNode
local ChipEnum = require("Game.PlayerData.Item.ChipEnum")
UINChipItem.ctor = function(self)
  -- function num : 0_0
  self.isUnlock = false
end

UINChipItem.OnInit = function(self)
  -- function num : 0_1 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btnRoot, self, self.OnClickChipEvent)
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).count).text = ""
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.ui).obj_Count = (self.transform):FindComponent("Count", eUnityComponentID.GameObject)
end

UINChipItem.InitChipItem = function(self, chipData, showCount, onClickEvent)
  -- function num : 0_2 , upvalues : _ENV
  self.chipData = chipData
  self.showCount = showCount or false
  self.__onClickEvent = onClickEvent
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).btnRoot).interactable = onClickEvent ~= nil
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).quality).color = chipData:GetColor()
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).icon).sprite = CRH:GetSprite(chipData:GetIcon())
  self:Show()
  ;
  (self.transform):SetAsLastSibling()
  if (self.ui).obj_Count ~= nil then
    ((self.ui).obj_Count):SetActive(self.showCount)
  end
  self:UpdateChipItem()
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UINChipItem.BindDefaultClickEvent = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local onClickEvent = BindCallback(self, self.__DefaultClickEvent)
  self.__onClickEvent = onClickEvent
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).btnRoot).interactable = onClickEvent ~= nil
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UINChipItem.__DefaultClickEvent = function(self, chipData)
  -- function num : 0_4 , upvalues : _ENV
  local heroList = (ExplorationManager:GetDynPlayer()).heroList
  local window = UIManager:ShowWindow(UIWindowTypeID.GlobalChipDetail)
  window:InitChipItemDetail(chipData, heroList, true)
end

UINChipItem.UpdateChipItem = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if self.showCount then
    (((self.ui).count).gameObject):SetActive(true)
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).count).text = tostring((self.chipData):GetCount())
  else
    ;
    (((self.ui).count).gameObject):SetActive(false)
  end
end

UINChipItem.OnClickChipEvent = function(self)
  -- function num : 0_6
  if self.__onClickEvent ~= nil then
    (self.__onClickEvent)(self.chipData, self)
  end
end

UINChipItem.ChipItemButtonEnable = function(self, enable)
  -- function num : 0_7
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).btnRoot).enabled = enable
end

UINChipItem.UnlockChipItem = function(self, isUnlock)
  -- function num : 0_8 , upvalues : _ENV
  self.isUnlock = isUnlock
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

  if not isUnlock or not Color.white then
    ((self.ui).icon).color = Color.gray
    local color = ((self.ui).quality).color
    color.a = 0.4
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).quality).color = color
  end
end

UINChipItem.IsUnlock = function(self)
  -- function num : 0_9
  return self.isUnlock
end

UINChipItem.GetChipData = function(self)
  -- function num : 0_10
  return self.chipData
end

UINChipItem.OnDelete = function(self)
  -- function num : 0_11 , upvalues : base
  (base.OnDelete)(self)
end

return UINChipItem

