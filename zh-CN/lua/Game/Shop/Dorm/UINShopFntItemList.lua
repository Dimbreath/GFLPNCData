local UINShopFntItemList = {}
local UINShopFntItemList = class("UINShopFntItemList", UIBaseNode)
local base = UIBaseNode
local UINShopFntItem = require("Game.Shop.Dorm.UINShopFntItem")
local cs_Canvas = (CS.UnityEngine).Canvas
UINShopFntItemList.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.ItemDic = {}
  self.dataList = {}
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).fntListNode).onInstantiateItem = BindCallback(self, self.__OnNewItem)
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).fntListNode).onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.__SortAndRefreshFntData = BindCallback(self, self.SortAndRefreshFntData)
end

UINShopFntItemList.SortAndRefreshFntData = function(self, isInit)
  -- function num : 0_1 , upvalues : _ENV, cs_Canvas
  (table.sort)(self.dataList, function(a, b)
    -- function num : 0_1_0
    if a.isSoldOut ~= b.isSoldOut then
      return b.isSoldOut
    end
    do return a.shelfId < b.shelfId end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  local num = #self.dataList
  ;
  (cs_Canvas.ForceUpdateCanvases)()
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).fntListNode).totalCount = num
  if isInit then
    ((self.ui).fntListNode):RefillCells()
  else
    ;
    ((self.ui).fntListNode):RefreshCells()
  end
end

UINShopFntItemList.RefreshShopFntItems = function(self, shopGoodsDic, purchaseRoot, autoSelectDataId)
  -- function num : 0_2 , upvalues : _ENV
  self.purchaseRoot = purchaseRoot
  self.dataList = {}
  for shelfId,goodData in pairs(shopGoodsDic) do
    (table.insert)(self.dataList, goodData)
  end
  self:SortAndRefreshFntData(true)
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
    -- function num : 0_2_0 , upvalues : _ENV, goodsData, self
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
      -- function num : 0_2_0_0 , upvalues : self
      self:SortAndRefreshFntData()
    end
, true, resIds)
    win:OnClickAdd(true)
  end
)
  end
end

UINShopFntItemList.__OnNewItem = function(self, go)
  -- function num : 0_3 , upvalues : UINShopFntItem
  local goodItem = (UINShopFntItem.New)()
  goodItem:Init(go)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.ItemDic)[go] = goodItem
end

UINShopFntItemList.__OnChangeItem = function(self, go, index)
  -- function num : 0_4 , upvalues : _ENV
  local goodItem = (self.ItemDic)[go]
  if goodItem == nil then
    error("Can\'t find goodItem by gameObject")
    return 
  end
  local goodData = (self.dataList)[index + 1]
  if goodData == nil then
    error("Can\'t find goodData by index, index = " .. tostring(index))
  end
  goodItem:InitNormalGoodsItem(goodData, self.purchaseRoot, self.__SortAndRefreshFntData)
end

UINShopFntItemList.GetDormCoinQuickBuyFunc = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if self.__quickCoinBuyFunc ~= nil then
    return self.__quickCoinBuyFunc
  end
  self.__quickCoinBuyFunc = {[ConstGlobalItem.DormCoin] = function()
    -- function num : 0_5_0 , upvalues : _ENV
    local ShopEnum = require("Game.Shop.ShopEnum")
    local quickBuyData = (ShopEnum.eQuickBuy).dormCoin
    local shopId = quickBuyData.shopId
    local shelfId = quickBuyData.shelfId
    local goodData = nil
    local ctrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
    ctrl:GetShopData(shopId, function(shopData)
      -- function num : 0_5_0_0 , upvalues : goodData, shelfId, _ENV, quickBuyData
      goodData = (shopData.shopGoodsDic)[shelfId]
      UIManager:ShowWindowAsync(UIWindowTypeID.QuickBuy, function(win)
        -- function num : 0_5_0_0_0 , upvalues : _ENV, goodData, quickBuyData
        if win == nil then
          error("can\'t open QuickBuy win")
          return 
        end
        win:SlideIn()
        win:InitBuyTarget(goodData, nil, true, quickBuyData.resourceIds)
        win:OnClickAdd(true)
      end
)
    end
)
  end
}
  return self.__quickCoinBuyFunc
end

UINShopFntItemList.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnDelete)(self)
end

return UINShopFntItemList

