-- params : ...
-- function num : 0 , upvalues : _ENV
local UINDungeonChipItem = class("UINDungeonChipItem", UIBaseNode)
local base = UIBaseNode
local UINChipItem = require("Game.CommonUI.Item.UINChipItem")
UINDungeonChipItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINChipItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.__showAlpha = 1
  self.chipItem = (UINChipItem.New)()
  ;
  (self.chipItem):Init((self.ui).obj_propGlobalItem)
  self.__OnItemClick = BindCallback(self, self.OnItemClick)
end

UINDungeonChipItem.InitChipItem = function(self, chipData, index, selectCallback)
  -- function num : 0_1
  self.chipData = chipData
  self.index = index
  self.selectCallback = selectCallback
  ;
  (self.chipItem):InitChipItem(chipData, true, self.__OnItemClick)
  self:SetTransplanet(false)
end

UINDungeonChipItem.OnItemClick = function(self)
  -- function num : 0_2
  if self.selectCallback ~= nil then
    (self.selectCallback)(self.index)
  end
end

UINDungeonChipItem.SetSelect = function(self, bool)
  -- function num : 0_3
  (((self.ui).img_OnSelect).gameObject):SetActive(bool)
end

UINDungeonChipItem.SetTransplanet = function(self, bool)
  -- function num : 0_4
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  if bool then
    ((self.ui).canvasGroup).alpha = 0
  else
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).canvasGroup).alpha = self.__showAlpha
  end
end

UINDungeonChipItem.SetDungeonChipItemShowAlpha = function(self, alpha)
  -- function num : 0_5
  self.__showAlpha = alpha
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).canvasGroup).alpha = alpha
end

UINDungeonChipItem.GetChipItemWorldPos = function(self)
  -- function num : 0_6
  return ((self.chipItem).transform).position
end

UINDungeonChipItem.OnDelete = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnDelete)(self)
end

return UINDungeonChipItem

