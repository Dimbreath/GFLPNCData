local UINShopNormalGoodsList = class("UINShopNormalGoodsList", UIBaseNode)
local base = UIBaseNode
local UINShopNormalGoogsItem = require("Game.Shop.UINShopNormalGoogsItem")
local cs_Canvas = (CS.UnityEngine).Canvas
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

UINShopNormalGoodsList.RefreshShelfItems = function(self, shopGoodsDic, purchaseRoot, autoSelectDataId)
  -- function num : 0_1 , upvalues : _ENV, cs_Canvas
  self.purchaseRoot = purchaseRoot
  self.dataList = {}
  for shelfId,goodData in pairs(shopGoodsDic) do
    (table.insert)(self.dataList, goodData)
  end
  local num = #self.dataList
  ;
  (cs_Canvas.ForceUpdateCanvases)()
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).goodListNode).totalCount = num
  ;
  ((self.ui).goodListNode):RefillCells()
  if autoSelectDataId == nil then
    return 
  end
  local goodsData = nil
  for k,v in pairs(shopGoodsDic) do
    if v.shelfId == autoSelectDataId then
      goodsData = v
    end
  end
  if goodsData ~= nil then
    UIManager:ShowWindowAsync(UIWindowTypeID.QuickBuy, function(win)
    -- function num : 0_1_0 , upvalues : _ENV, goodsData, self
    if win == nil then
      error("can\'t open QuickBuy win")
      return 
    end
    local resIds = {}
    ;
    (table.insert)(resIds, goodsData.currencyId)
    if goodsData.currencyId == ConstGlobalItem.PaidSubItem and not (table.contain)(resIds, ConstGlobalItem.PaidItem) then
      (table.insert)(resIds, 1, ConstGlobalItem.PaidItem)
    end
    win:SlideIn()
    win:InitBuyTarget(goodsData, function()
      -- function num : 0_1_0_0 , upvalues : _ENV, self, goodsData
      for k,v in pairs(self.ItemDic) do
        if v.goodData == goodsData then
          v:RefreshGoods()
        end
      end
    end
, true, resIds)
    win:OnClickAdd(true)
  end
)
  end
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
  goodItem:InitNormalGoodsItem(goodData, self.purchaseRoot)
end

UINShopNormalGoodsList.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UINShopNormalGoodsList

