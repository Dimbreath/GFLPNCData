-- params : ...
-- function num : 0 , upvalues : _ENV
local UINShopHeroGoodsList = class("UINShopHeroGoodsList", UIBaseNode)
local base = UIBaseNode
local UINShopHeroGoodsItem = require("Game.Shop.UINShopHeroGoodsItem")
local cs_Canvas = (CS.UnityEngine).Canvas
UINShopHeroGoodsList.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.ItemDic = {}
  self.dataList = {}
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).heroItemList).onInstantiateItem = BindCallback(self, self.__OnNewItem)
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).heroItemList).onChangeItem = BindCallback(self, self.__OnChangeItem)
  self._OnItemRefresh = BindCallback(self, self.OnItemRefresh)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self._OnItemRefresh)
end

UINShopHeroGoodsList.InitList = function(self, resloader, purchaseRoot)
  -- function num : 0_1
  self.purchaseRoot = purchaseRoot
  self.resloader = resloader
end

UINShopHeroGoodsList.RefreshShelfItems = function(self, shopGoodsDic, autoSelectId)
  -- function num : 0_2 , upvalues : _ENV, cs_Canvas
  self.dataList = {}
  for shelfId,goodData in pairs(shopGoodsDic) do
    (table.insert)(self.dataList, goodData)
  end
  local num = #self.dataList
  ;
  (cs_Canvas.ForceUpdateCanvases)()
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).heroItemList).totalCount = num
  ;
  ((self.ui).heroItemList):RefillCells()
  if autoSelectId == nil then
    return 
  end
  local selecData = nil
  for k,v in pairs(shopGoodsDic) do
    if v.shelfId == autoSelectId then
      selecData = v
      break
    end
  end
  do
    if selecData ~= nil then
      local itemCfg = (ConfigData.item)[selecData.itemId]
      if itemCfg.type == eItemType.Skin then
        UIManager:ShowWindowAsync(UIWindowTypeID.HeroSkin, function(win)
    -- function num : 0_2_0 , upvalues : selecData, _ENV, self
    if win == nil then
      return 
    end
    local skinId = selecData.itemId
    local skinIds = {}
    for i,v in ipairs(self.dataList) do
      (table.insert)(skinIds, v.itemId)
    end
    win:InitSkinBySkinList(skinId, skinIds, true, function()
      -- function num : 0_2_0_0 , upvalues : self
      self:RefreshItemView()
    end
)
  end
)
      else
        UIManager:ShowWindowAsync(UIWindowTypeID.QuickBuy, function(win)
    -- function num : 0_2_1 , upvalues : _ENV, self, selecData
    if win == nil then
      error("can\'t open QuickBuy win")
      return 
    end
    local resIds = {}
    ;
    (table.insert)(resIds, (self.goodData).currencyId)
    if (self.goodData).currencyId == ConstGlobalItem.PaidSubItem and not (table.contain)(resIds, ConstGlobalItem.PaidItem) then
      (table.insert)(resIds, 1, ConstGlobalItem.PaidItem)
    end
    win:SlideIn()
    win:InitBuyTarget(selecData, function()
      -- function num : 0_2_1_0 , upvalues : _ENV, self, selecData
      for k,v in pairs(self.ItemDic) do
        if v.goodData == selecData then
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
  end
end

UINShopHeroGoodsList.__OnNewItem = function(self, go)
  -- function num : 0_3 , upvalues : UINShopHeroGoodsItem
  local goodItem = (UINShopHeroGoodsItem.New)()
  goodItem:Init(go)
  goodItem:InitItem(self.resloader)
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.ItemDic)[go] = goodItem
end

UINShopHeroGoodsList.__OnChangeItem = function(self, go, index)
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
  goodItem:InitNormalGoodsItem(goodData, self, self.purchaseRoot)
end

UINShopHeroGoodsList.RefreshItemView = function(self)
  -- function num : 0_5 , upvalues : _ENV
  for k,v in pairs(self.ItemDic) do
    v:RefreshCurrencyUI()
    v:RefreshLimitUI()
  end
end

UINShopHeroGoodsList.m_GetItemGoByIndex = function(self, index)
  -- function num : 0_6
  if (((self.ui).heroItemList).content).childCount <= index then
    return nil
  end
  local go = ((self.ui).heroItemList):GetCellByIndex(index)
  do
    if go ~= nil then
      local goodItem = (self.ItemDic)[go]
      return goodItem
    end
    return nil
  end
end

UINShopHeroGoodsList.OnItemRefresh = function(self, itemUpdate)
  -- function num : 0_7 , upvalues : _ENV
  for index,goodData in ipairs(self.dataList) do
    if itemUpdate[goodData.itemId] ~= nil then
      local item = self:m_GetItemGoByIndex(index - 1)
      if item ~= nil then
        item:RefreshFrgNum()
      end
    end
  end
end

UINShopHeroGoodsList.OnDelete = function(self)
  -- function num : 0_8 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self._OnItemRefresh)
  ;
  (base.OnDelete)(self)
end

return UINShopHeroGoodsList

