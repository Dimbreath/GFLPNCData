-- params : ...
-- function num : 0 , upvalues : _ENV
local UINChipItem = class("UINChipItem", UIBaseNode)
local base = UIBaseNode
local UINChipLevel = require("Game.CommonUI.Chip.UINChipLevel")
UINChipItem.ctor = function(self)
  -- function num : 0_0
  self.isUnlock = false
end

UINChipItem.OnInit = function(self)
  -- function num : 0_1 , upvalues : _ENV, UINChipLevel
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btnRoot, self, self.OnClickChipEvent)
  self.level = (UINChipLevel.New)()
  ;
  (self.level):Init((self.ui).obj_Level)
  ;
  ((self.ui).obj_Level):SetActive(false)
end

UINChipItem.InitChipItem = function(self, chipData, showCount, onClickEvent, isNotAsLastSibling)
  -- function num : 0_2 , upvalues : _ENV
  self.chipData = chipData
  self.showCount = showCount or false
  self.__onClickEvent = onClickEvent
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).btnRoot).interactable = onClickEvent ~= nil
  local color = chipData:GetColor()
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).quality).color = color
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).img_LevelCol).color = color
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).icon).sprite = CRH:GetSprite(chipData:GetIcon())
  self:Show()
  if not isNotAsLastSibling then
    isNotAsLastSibling = false
  end
  if not isNotAsLastSibling then
    (self.transform):SetAsLastSibling()
  end
  self:UpdateChipItem()
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
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

UINChipItem.UpdateChipItem = function(self, dynPlayer)
  -- function num : 0_5 , upvalues : _ENV
  local office = self.showCount and -8 or 0
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (((self.ui).icon).transform).localPosition = (Vector3.New)(0, office, 0)
  if not self.showCount then
    ((self.ui).obj_Level):SetActive(self.showCount)
    return 
  end
  ;
  (self.level):InitChipLevel(self.chipData, dynPlayer)
  ;
  ((self.ui).obj_Level):SetActive(self.showCount)
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
    color.a = isUnlock and 1 or 0.4
    -- DECOMPILER ERROR at PC24: Confused about usage of register: R3 in 'UnsetPending'

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

UINChipItem.RefreshLevelTween = function(self)
  -- function num : 0_11
  (self.level):RefreshFlashTween()
end

UINChipItem.OnDelete = function(self)
  -- function num : 0_12 , upvalues : base
  (base.OnDelete)(self)
end

return UINChipItem

