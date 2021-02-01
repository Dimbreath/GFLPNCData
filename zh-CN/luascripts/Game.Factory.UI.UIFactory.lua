-- params : ...
-- function num : 0 , upvalues : _ENV
local UIFactory = class("UIFactory", UIBaseWindow)
local base = UIBaseWindow
local FactoryEnum = require("Game.Factory.FactoryEnum")
local UINFactoryOrderListNode = require("Game.Factory.UI.UINFactoryOrderListNode")
local UINFactoryOrderNode = require("Game.Factory.UI.UINFactoryOrderNode")
local cs_ResLoader = CS.ResLoader
local cs_MessageCommon = CS.MessageCommon
local OFFSET = (Vector3.New)(0, 2, 0)
UIFactory.OnInit = function(self)
  -- function num : 0_0 , upvalues : cs_ResLoader, _ENV, UINFactoryOrderListNode, UINFactoryOrderNode
  self.resloader = (cs_ResLoader.Create)()
  self.factoryController = ControllerManager:GetController(ControllerTypeId.Factory, false)
  self.lockDic = {}
  self.lastSelectRoomIndex = nil
  self.isOpenOrder = false
  local energyId = (ConfigData.game_config).factoryEnergyItemId
  ;
  (UIUtil.SetTopStatus)(self, self.CloseFactory, {1002, energyId}, nil, {[energyId] = function()
    -- function num : 0_0_0 , upvalues : _ENV
    local ShopEnum = require("Game.Shop.ShopEnum")
    local quickBuyData = (ShopEnum.eQuickBuy).factoryEnergy
    local shopId = quickBuyData.shopId
    local shelfId = quickBuyData.shelfId
    local goodData = nil
    local ctrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
    ctrl:GetShopData(shopId, function(shopData)
      -- function num : 0_0_0_0 , upvalues : goodData, shelfId, _ENV, quickBuyData
      goodData = (shopData.shopGoodsDic)[shelfId]
      UIManager:ShowWindowAsync(UIWindowTypeID.QuickBuy, function(win)
        -- function num : 0_0_0_0_0 , upvalues : _ENV, goodData, quickBuyData
        if win == nil then
          error("can\'t open QuickBuy win")
          return 
        end
        win:SlideIn()
        win:InitBuyTarget(goodData, nil, true, quickBuyData.resourceIds)
        win:OnClickAdd()
      end
)
    end
)
  end
})
  self.orderListNode = (UINFactoryOrderListNode.New)()
  ;
  (self.orderListNode):Init((self.ui).obj_orderListNode)
  ;
  (self.orderListNode):Hide()
  self.orderNode = (UINFactoryOrderNode.New)()
  ;
  (self.orderNode):Init((self.ui).obj_orderNode)
  ;
  (self.orderNode):Hide()
  self.m_OnClickRoom = BindCallback(self, self.OnClickRoom)
  self.m_OnClick3DBGWithPop = BindCallback(self, self.OnClick3DBG, true)
  self.m_ShowOrderDetail = BindCallback(self, self.ShowOrderDetail)
  self.m_OnRoomMove = BindCallback(self, self.OnRoomMove)
  self.m_OnClick3DBG = BindCallback(self, self.OnClick3DBG)
  ;
  (((self.ui).tween_OrderList).onRewind):AddListener(BindCallback(self, self.OrderNodesPlayBackwardsOver))
  ;
  (((self.ui).tween_OrderList).onComplete):AddListener(BindCallback(self, self.OrderNodesPlayOver))
  ;
  (((self.ui).tween_OrderList).onUpdate):AddListener(BindCallback(self, self.OrderNodesPlayUpdate))
end

UIFactory.OnClickRoom = function(self, roomEntity)
  -- function num : 0_1 , upvalues : FactoryEnum, cs_MessageCommon, _ENV
  if roomEntity.type == (FactoryEnum.eRoomType).locked or roomEntity.type == (FactoryEnum.eRoomType).notOpen then
    if roomEntity.type == (FactoryEnum.eRoomType).locked then
      (cs_MessageCommon.ShowMessageTips)(roomEntity.unlcokDes)
    end
    return 
  else
    if self.lastSelectRoomEntity ~= nil then
      (self.lastSelectRoomEntity):SetSelected(false)
    end
    roomEntity:SetSelected(true)
    if self.lastSelectRoomIndex ~= roomEntity.index then
      if self.lastSelectRoomIndex == nil then
        self.lastSelectRoomIndex = roomEntity.index
        self.lastSelectRoomEntity = roomEntity
        self:OnClickProduction(roomEntity)
      else
        self.lastSelectRoomIndex = roomEntity.index
        self.lastSelectRoomEntity = roomEntity
        ;
        (self.orderNode):InitOrderNode(self.lastSelectRoomIndex)
        ;
        (self.orderListNode):InitList(self.lastSelectRoomIndex, self.m_ShowOrderDetail)
        if self.isOpenOrder then
          ((self.ui).tween_factoryOrderNode):DOPlayBackwardsAllById("orderOpen")
          self.isOpenOrder = false
          ;
          (self.orderListNode):DeSelect()
          ;
          (UIUtil.PopFromBackStack)()
          return 
        end
      end
    end
  end
end

UIFactory.OnClick3DBG = function(self, isNeedPop)
  -- function num : 0_2 , upvalues : _ENV
  if self.lastSelectRoomIndex ~= nil then
    if self.isOpenOrder then
      ((self.ui).tween_factoryOrderNode):DOPlayBackwardsAllById("orderOpen")
      self.isOpenOrder = false
      ;
      (self.orderListNode):DeSelect()
      if isNeedPop == true then
        (UIUtil.PopFromBackStack)()
      end
      return 
    end
    self.lastSelectRoomIndex = nil
    self:CloseOrderNodes()
    if isNeedPop == true then
      (UIUtil.PopFromBackStack)()
    end
  end
end

UIFactory.OnClickProduction = function(self, roomEntity)
  -- function num : 0_3 , upvalues : _ENV
  ((self.ui).tween_OrderList):DOPlayForwardAllById("orderListOpen")
  ;
  (self.factoryController):StartMoveRoomToLeftMin((self.ui).obj_posPointEnd, self.lastSelectRoomIndex)
  ;
  (self.orderNode):Show()
  ;
  (self.orderNode):InitOrderNode(self.lastSelectRoomIndex)
  ;
  (self.orderListNode):Show()
  ;
  (self.orderListNode):InitList(self.lastSelectRoomIndex, self.m_ShowOrderDetail)
  ;
  (UIUtil.Push2BackStack)(self, self.m_OnClick3DBG)
  ;
  (UIManager:ShowWindow(UIWindowTypeID.ClickContinue)):InitContinue(nil, nil, nil, Color.clear, false)
end

UIFactory.OrderNodesPlayUpdate = function(self)
  -- function num : 0_4
  local rate = ((self.ui).orderListNode).alpha
  ;
  (self.factoryController):OnMoveRoomToLeftMin(self.m_OnRoomMove, rate)
end

UIFactory.OrderNodesPlayOver = function(self)
  -- function num : 0_5 , upvalues : _ENV
  (self.factoryController):ForceMoveToLeft(self.m_OnRoomMove)
  UIManager:HideWindow(UIWindowTypeID.ClickContinue)
end

UIFactory.CloseOrderNodes = function(self)
  -- function num : 0_6 , upvalues : _ENV
  self.lastSelectRoomIndex = nil
  if self.lastSelectRoomEntity ~= nil then
    (self.lastSelectRoomEntity):SetSelected(false)
  end
  ;
  ((self.ui).obj_enterhNode):SetActive(false)
  ;
  ((self.ui).tween_OrderList):DOPlayBackwardsAllById("orderListOpen")
  ;
  (UIManager:ShowWindow(UIWindowTypeID.ClickContinue)):InitContinue(nil, nil, nil, Color.clear, false)
end

UIFactory.OrderNodesPlayBackwardsOver = function(self)
  -- function num : 0_7 , upvalues : _ENV
  (self.orderListNode):Hide()
  ;
  (self.orderNode):Hide()
  ;
  (self.factoryController):MoveRoomToMid(self.m_OnRoomMove)
  UIManager:HideWindow(UIWindowTypeID.ClickContinue)
end

UIFactory.ShowOrderDetail = function(self, orderCfg)
  -- function num : 0_8 , upvalues : _ENV
  (self.orderNode):ShowOrder(orderCfg)
  if not self.isOpenOrder then
    ((self.ui).tween_factoryOrderNode):DOPlayForwardAllById("orderOpen")
    self.isOpenOrder = true
    ;
    (UIUtil.Push2BackStack)(self, self.m_OnClick3DBG)
  end
end

UIFactory.UpdateEnergy = function(self)
  -- function num : 0_9
  if (self.orderListNode).active then
    (self.orderListNode):UpdateEnergy()
  end
  if (self.orderNode).active then
    (self.orderNode):UpdateEnergy()
  end
end

UIFactory.OnRoomMove = function(self)
  -- function num : 0_10
end

UIFactory.CloseFactory = function(self)
  -- function num : 0_11 , upvalues : _ENV
  (UIManager:ShowWindow(UIWindowTypeID.ClickContinue)):InitContinue(nil, nil, nil, Color.clear, false)
  ;
  (self.factoryController):FadeFactory()
  ;
  ((self.ui).canvasGroup):DOFade(0, 0.5)
end

UIFactory.OnDelete = function(self)
  -- function num : 0_12 , upvalues : _ENV, base
  if self.updateFunc ~= nil then
    UpdateManager:RemoveUpdate(self.updateFunc)
  end
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
  ;
  (self.orderListNode):Delete()
  self.selRoomTween = nil
  ;
  (base.OnDelete)(self)
end

return UIFactory

