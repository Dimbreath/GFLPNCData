local UINDungeonServerGridItem = class("UINDungeonServerGridItem", UIBaseNode)
UINDungeonServerGridItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (((self.ui).btn_gridItem).onPressDown):AddListener(BindCallback(self, self.__OnGridLongPress))
  ;
  (((self.ui).btn_gridItem).onPressUp):AddListener(BindCallback(self, self.__OnGridPressUp))
end

UINDungeonServerGridItem.InitServerGridItem = function(self, serverGrid, longPressFunc, pressUpFunc)
  -- function num : 0_1
  self.serverGrid = serverGrid
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).img_BuffIcon).sprite = serverGrid:GetGridIconSprite()
  self.longPressFunc = longPressFunc
  self.pressUpFunc = pressUpFunc
end

UINDungeonServerGridItem.__OnGridLongPress = function(self)
  -- function num : 0_2
  if self.longPressFunc ~= nil then
    (self.longPressFunc)(self.serverGrid)
  end
end

UINDungeonServerGridItem.__OnGridPressUp = function(self)
  -- function num : 0_3
  if self.pressUpFunc ~= nil then
    (self.pressUpFunc)()
  end
end

return UINDungeonServerGridItem

