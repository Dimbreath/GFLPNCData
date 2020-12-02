-- params : ...
-- function num : 0 , upvalues : _ENV
local UIStoreRoom = class("UIStoreRoom", UIBaseWindow)
local base = UIBaseWindow
local UIStoreRoomItem = require("Game.Exploration.UI.StoreRoom.UIOldStoreRoomItem")
UIStoreRoom.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UIStoreRoomItem
  self.currItemDic = {}
  self.StoreRoomItemPool = (UIItemPool.New)(UIStoreRoomItem, (self.ui).itemPrefab)
  ;
  ((self.ui).itemPrefab):SetActive(false)
  self.__onStoreItemClick = BindCallback(self, self.OnStoreItemClick)
  self.__onChipItemClick = BindCallback(self, self.OnChipItemClick)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Close, self, self.OnCloseClick)
end

UIStoreRoom.InitStoreRoom = function(self, ctrl, storeDataList)
  -- function num : 0_1 , upvalues : _ENV
  self.ctrl = ctrl
  ;
  (self.StoreRoomItemPool):HideAll()
  for _,storeData in ipairs(storeDataList) do
    local storeItem = (self.currItemDic)[storeData.id]
    if storeItem == nil then
      storeItem = (self.StoreRoomItemPool):GetOne()
    end
    storeItem:InitStoreItem(storeData, self.__onStoreItemClick, self.__onChipItemClick)
    ;
    (storeItem.gameObject):SetActive(true)
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (self.currItemDic)[storeData.idx] = storeItem
  end
end

UIStoreRoom.OnStoreItemClick = function(self, storeItem)
  -- function num : 0_2
  (self.ctrl):SendStorePurchase(storeItem)
end

UIStoreRoom.OnChipItemClick = function(self, chipItem)
  -- function num : 0_3
  (self.ctrl):ShowChipItemDetail(chipItem)
end

UIStoreRoom.UpdateMoney = function(self, currencyId, money)
  -- function num : 0_4 , upvalues : _ENV
  local currencyItem = (ConfigData.item)[currencyId]
  if currencyItem == nil then
    ((self.ui).tex_Money):SetIndex(0, tostring(currencyId), tostring(money))
    error("UIStoreRoom:UpdateMoney error: currencyItem is nil")
  else
    ;
    ((self.ui).tex_Money):SetIndex(0, (LanguageUtil.GetLocaleText)(currencyItem.name), tostring(money))
  end
end

UIStoreRoom.OnCloseClick = function(self)
  -- function num : 0_5
  (self.ctrl):SendStoreQuit()
end

UIStoreRoom.CloseWindow = function(self)
  -- function num : 0_6
  if self.detailWindow ~= nil then
    (self.detailWindow):Hide()
  end
  self:Delete()
end

UIStoreRoom.OnDelete = function(self)
  -- function num : 0_7 , upvalues : _ENV, base
  if self.currItemDic ~= nil then
    for _,v in pairs(self.currItemDic) do
      v:OnDelete()
    end
    self.currItemDic = nil
  end
  ;
  (base.OnDelete)(self)
end

return UIStoreRoom

