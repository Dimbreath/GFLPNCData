local UIWarehouse = class("UIWarehouse", UIBaseWindow)
local base = UIBaseWindow
local UINSortButtonItem = require("Game.Hero.NewUI.SortList.UINSortButtonItem")
local UINWarehouseItem = require("Game.Warehouse.UINWarehouseItem")
local UINWarehouseTab = require("Game.Warehouse.UINWarehouseTab")
local JumpManager = require("Game.Jump.JumpManager")
local cs_Canvas = (CS.UnityEngine).Canvas
local cs_ResLoader = CS.ResLoader
local eWareHouseType = require("Game.Warehouse.eWareHouseType")
local allShowTabId = (eWareHouseType.wharehouseType).all
UIWarehouse.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINSortButtonItem, UINWarehouseTab, cs_ResLoader
  (UIUtil.SetTopStatus)(self, self.OnClickClose)
  self.itemDic = {}
  self.dataList = {}
  self.dataDic = {}
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).itemScroll).onInstantiateItem = BindCallback(self, self.OnInstantiateItem)
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).itemScroll).onChangeItem = BindCallback(self, self.OnChangeItem)
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).itemScroll).onReturnItem = BindCallback(self, self.OnReturnItem)
  self.SortButtonItem = (UINSortButtonItem.New)()
  ;
  (self.SortButtonItem):Init((self.ui).sortBtnItem)
  ;
  (self.SortButtonItem):InitSortButtonItem(0, true, BindCallback(self, self.OnSortChangeCallback))
  self.tabPool = (UIItemPool.New)(UINWarehouseTab, (self.ui).btn_Page_pre)
  ;
  ((self.ui).btn_Page_pre):SetActive(false)
  self.resloader = (cs_ResLoader.Create)()
  self.__OnTabSelectCallback = BindCallback(self, self.OnTabSelectCallback)
  self.__OnItemUpdate = BindCallback(self, self.OnItemUpdateWarehouse)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__OnItemUpdate)
  self.__OnListenReddotWarehouse = BindCallback(self, self.OnListenReddotWarehouse)
  RedDotController:AddListener(RedDotDynPath.WarehousePath, self.__OnListenReddotWarehouse)
  self._onWarehouseItemClick = BindCallback(self, self._OnWarehouseItemClick)
end

UIWarehouse.InitWarehouse = function(self, itemId, openType)
  -- function num : 0_1 , upvalues : JumpManager, _ENV, cs_Canvas, allShowTabId
  self._lastCouldUseItemJump = JumpManager.couldUseItemJump
  JumpManager.couldUseItemJump = true
  self.tabId = 0
  self.isAscendState = 0
  ;
  (self.SortButtonItem):SetAllStateUI(false)
  local tabList = {}
  for _,cfg in pairs(ConfigData.warehouse) do
    (table.insert)(tabList, cfg)
  end
  ;
  (table.sort)(tabList, function(a, b)
    -- function num : 0_1_0
    do return a.id < b.id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (cs_Canvas.ForceUpdateCanvases)()
  local rectTr = ((self.ui).rect):GetComponent(typeof((CS.UnityEngine).RectTransform))
  local count = ((rectTr.rect).width - (((self.ui).rect).padding).left - (((self.ui).rect).padding).right + (((self.ui).rect).spacing).x) / ((((self.ui).rect).cellSize).x + (((self.ui).rect).spacing).x)
  -- DECOMPILER ERROR at PC71: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).rect).constraintCount = (math.floor)(count)
  ;
  (self.tabPool):HideAll()
  for _,cfg in ipairs(tabList) do
    local item = (self.tabPool):GetOne()
    item:InitWarehouseTab(cfg, self.__OnTabSelectCallback, self.resloader)
  end
  if openType == nil then
    self:OnTabSelectCallback(allShowTabId)
  else
    self:OnTabSelectCallback(openType)
  end
  if itemId ~= nil then
    for i,cfg in ipairs(self.dataList) do
      if cfg.id == itemId then
        ((self.ui).itemScroll):LocationItem(i - 1)
        break
      end
    end
  end
end

UIWarehouse.OnTabSelectCallback = function(self, id)
  -- function num : 0_2 , upvalues : _ENV
  if self.tabId == id then
    return 
  end
  for _,tab in ipairs((self.tabPool).listItem) do
    if (tab.warehouseTabCfg).id == self.tabId then
      tab:SetSelectState(false)
    end
    if (tab.warehouseTabCfg).id == id then
      tab:SetSelectState(true)
    end
  end
  self.tabId = id
  self:UpdateItemShow(false)
end

UIWarehouse.OnSortChangeCallback = function(self, sortType)
  -- function num : 0_3
  (self.SortButtonItem):ReversalAscend()
  self.isAscendState = (self.SortButtonItem).isAscend and 1 or -1
  self:UpdateItemShow(true)
end

UIWarehouse.UpdateItemShow = function(self, isJustSortChange)
  -- function num : 0_4 , upvalues : _ENV, allShowTabId, cs_Canvas
  if not isJustSortChange then
    self.dataList = {}
    for itemId,itemData in pairs(PlayerDataCenter.itemDic) do
      local page = (itemData.itemCfg).warehouse_page
      local isInPage = (self.tabId == allShowTabId and page > 0) or page == self.tabId
      if isInPage then
        (table.insert)(self.dataList, itemData.itemCfg)
      end
    end
    local hasItem = (table.count)(self.dataList) > 0
    ;
    (((self.ui).itemScroll).gameObject):SetActive(hasItem)
    ;
    ((self.ui).scrollbar):SetActive(hasItem)
    ;
    ((self.ui).objEmpty):SetActive(not hasItem)
    if hasItem then
      (self.SortButtonItem):Show()
    else
      (self.SortButtonItem):Hide()
      return 
    end
  end
  if self.isAscendState == 1 then
    (table.sort)(self.dataList, function(a, b)
    -- function num : 0_4_0
    if a.quality >= b.quality then
      do return a.quality == b.quality end
      if a.warehouse_order >= b.warehouse_order then
        do return a.warehouse_order == b.warehouse_order end
        do return a.id < b.id end
        -- DECOMPILER ERROR: 5 unprocessed JMP targets
      end
    end
  end
)
  elseif self.isAscendState == -1 then
    (table.sort)(self.dataList, function(a, b)
    -- function num : 0_4_1
    if b.quality >= a.quality then
      do return a.quality == b.quality end
      if a.warehouse_order >= b.warehouse_order then
        do return a.warehouse_order == b.warehouse_order end
        do return a.id < b.id end
        -- DECOMPILER ERROR: 5 unprocessed JMP targets
      end
    end
  end
)
  else
    (table.sort)(self.dataList, function(a, b)
    -- function num : 0_4_2
    if a.warehouse_order >= b.warehouse_order then
      do return a.warehouse_order == b.warehouse_order end
      do return a.id < b.id end
      -- DECOMPILER ERROR: 3 unprocessed JMP targets
    end
  end
)
  end
  ;
  (cs_Canvas.ForceUpdateCanvases)()
  -- DECOMPILER ERROR at PC94: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).itemScroll).totalCount = #self.dataList
  ;
  ((self.ui).itemScroll):RefillCells()
  -- DECOMPILER ERROR: 8 unprocessed JMP targets
end

UIWarehouse.OnInstantiateItem = function(self, go)
  -- function num : 0_5 , upvalues : UINWarehouseItem
  local item = (UINWarehouseItem.New)()
  item:Init(go)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.itemDic)[go] = item
end

UIWarehouse.OnChangeItem = function(self, go, index)
  -- function num : 0_6 , upvalues : _ENV
  local item = (self.itemDic)[go]
  local itemCfg = (self.dataList)[index + 1]
  local count = PlayerDataCenter:GetItemCount(itemCfg.id)
  item:InitWarehouseItem(itemCfg, count, self._onWarehouseItemClick)
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (self.dataDic)[itemCfg.id] = item
end

UIWarehouse.OnReturnItem = function(self, go)
  -- function num : 0_7
  local item = (self.itemDic)[go]
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.dataDic)[(item.itemCfg).id] = nil
end

UIWarehouse.OnItemUpdateWarehouse = function(self, itemUpdate)
  -- function num : 0_8 , upvalues : _ENV
  for itemId,isdelete in pairs(itemUpdate) do
    if self:IsItemInCurTab(itemId) then
      local item = (self.dataDic)[itemId]
      if isdelete or item == nil then
        self:UpdateItemShow(false)
        break
      else
        local count = PlayerDataCenter:GetItemCount(itemId)
        item:SetNum(count)
      end
    end
  end
end

UIWarehouse.IsItemInCurTab = function(self, itemId)
  -- function num : 0_9 , upvalues : _ENV, allShowTabId
  local itemCfg = (ConfigData.item)[itemId]
  do
    if itemCfg ~= nil then
      local page = itemCfg.warehouse_page
      return (self.tabId == allShowTabId and page > 0) or page == self.tabId
    end
    do return false end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

UIWarehouse.OnListenReddotWarehouse = function(self)
  -- function num : 0_10 , upvalues : _ENV
  for _,tabItem in ipairs((self.tabPool).listItem) do
    tabItem:RefreshRedDotState()
  end
  for _,warehouseItem in pairs(self.itemDic) do
    warehouseItem:RefreshRedDotState()
  end
end

UIWarehouse._OnWarehouseItemClick = function(self, itemCfg)
  -- function num : 0_11 , upvalues : _ENV
  if GuideManager.inGuide and not GuideManager:HasGuideFeature((GuideEnum.GuideFeature).ItemDetail) then
    return 
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(win)
    -- function num : 0_11_0 , upvalues : itemCfg
    if win ~= nil then
      win:InitCommonItemDetail(itemCfg)
      win:ShowUseGiftBtn(itemCfg)
    end
  end
)
end

UIWarehouse.OnClickClose = function(self)
  -- function num : 0_12 , upvalues : JumpManager
  JumpManager.couldUseItemJump = self._lastCouldUseItemJump
  self:OnCloseWin()
  self:Delete()
end

UIWarehouse.OnDelete = function(self)
  -- function num : 0_13 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__OnItemUpdate)
  RedDotController:RemoveListener(RedDotDynPath.WarehousePath, self.__OnListenReddotWarehouse)
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
  ;
  (base.OnDelete)(self)
end

return UIWarehouse

