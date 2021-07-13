-- params : ...
-- function num : 0 , upvalues : _ENV
local UINChipItem = require("Game.CommonUI.Item.UINChipItem")
local base = UINChipItem
local UINChipItemPress = class("UINChipItemPress", base)
UINChipItemPress.OnInit = function(self)
  -- function num : 0_0 , upvalues : base, _ENV
  (base.OnInit)(self)
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).btnRoot).enabled = false
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).btn_RootPlus).enabled = true
  ;
  (((self.ui).btn_RootPlus).onPress):AddListener(BindCallback(self, self.__OnChipLongPress))
  ;
  (((self.ui).btn_RootPlus).onPressUp):AddListener(BindCallback(self, self.__OnChipPressUp))
end

UINChipItemPress.InitChipItemWithPress = function(self, chipData, showCount, longPressFunc, pressUpFunc)
  -- function num : 0_1 , upvalues : base
  (base.InitChipItem)(self, chipData, showCount)
  self.__longPressFunc = longPressFunc
  self.__pressUpFunc = pressUpFunc
end

UINChipItemPress.__OnChipLongPress = function(self)
  -- function num : 0_2
  if self.__longPressFunc ~= nil then
    (self.__longPressFunc)(self.chipData, self)
  end
end

UINChipItemPress.__OnChipPressUp = function(self)
  -- function num : 0_3
  if self.__pressUpFunc ~= nil then
    (self.__pressUpFunc)(self.chipData, self)
  end
end

return UINChipItemPress

