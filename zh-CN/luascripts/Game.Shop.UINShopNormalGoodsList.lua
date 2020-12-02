-- params : ...
-- function num : 0 , upvalues : _ENV
local UINShopNormalGoodsList = class("UINShopNormalGoodsList", UIBaseNode)
local base = UIBaseNode
local UINShopNormalGoogsItem = require("Game.Shop.UINShopNormalGoogsItem")
UINShopNormalGoodsList.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.ItemDic = {}
  self.dataList = {}
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).goodListNode).onInstantiateItem = BindCallback(self, self.__OnNewItem)
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).goodListNode).onChangeItem = BindCallback(self, self.__OnChangeItem)
end

UINShopNormalGoodsList.RefreshShelfItems = function(self, shopGoodsDic)
  -- function num : 0_1 , upvalues : _ENV
  self.dataList = {}
  for shelfId,goodData in pairs(shopGoodsDic) do
    (table.insert)(self.dataList, goodData)
  end
  local num = #self.dataList
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).goodListNode).totalCount = num
  ;
  ((self.ui).goodListNode):RefillCells()
end

UINShopNormalGoodsList.__OnNewItem = function(self, go)
  -- function num : 0_2 , upvalues : UINShopNormalGoogsItem
  local goodItem = (UINShopNormalGoogsItem.New)()
  goodItem:Init(go)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.ItemDic)[go] = goodItem
end

UINShopNormalGoodsList.__OnChangeItem = function(self, go, index)
  -- function num : 0_3 , upvalues : _ENV
  local goodItem = (self.ItemDic)[go]
  if goodItem == nil then
    error("Can\'t find goodItem by gameObject")
    return 
  end
  local goodData = (self.dataList)[index + 1]
  if goodData == nil then
    error("Can\'t find goodData by index, index = " .. tostring(index))
  end
  goodItem:InitNormalGoodsItem(goodData)
end

UINShopNormalGoodsList.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UINShopNormalGoodsList

