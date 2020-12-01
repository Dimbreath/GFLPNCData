-- params : ...
-- function num : 0 , upvalues : _ENV
local UIFactory = class("UIFactory", UIBaseWindow)
local base = UIBaseWindow
local FactoryEnum = require("Game.Factory.FactoryEnum")
local UINResourceGroup = require("Game.CommonUI.ResourceGroup.UINResourceGroup")
local UINFactoryRoomLock = require("Game.Factory.UI.UINFactoryRoomLock")
local UINFactoryOrderListNode = require("Game.Factory.UI.UINFactoryOrderListNode")
local UINFactoryOrderNode = require("Game.Factory.UI.UINFactoryOrderNode")
local UINFactoryEnterHeroItem = require("Game.Factory.UI.UINFactoryEnterHeroItem")
local cs_ResLoader = CS.ResLoader
local OFFSET = (Vector3.New)(0, 2, 0)
UIFactory.OnInit = function(self)
  -- function num : 0_0 , upvalues : cs_ResLoader, _ENV, UINResourceGroup, UINFactoryOrderListNode, UINFactoryOrderNode, UINFactoryEnterHeroItem
  self.resloader = (cs_ResLoader.Create)()
  self.factoryController = ControllerManager:GetController(ControllerTypeId.Factory, false)
  self.lockDic = {}
  self.isShowingRoomFuncUI = false
  self.lastSelectRoomIndex = nil
  ;
  (UIUtil.CreateTopBtnGroup)((self.ui).obj_topButtonGroup, self, self.CloseFactory)
  self.resourceGroup = (UINResourceGroup.New)()
  ;
  (self.resourceGroup):Init((self.ui).obj_gameResourceGroup)
  ;
  (self.resourceGroup):SetResourceIds({1002, 1003, 1004})
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
  self.heroHeadItemPool = (UIItemPool.New)(UINFactoryEnterHeroItem, (self.ui).obj_enterItem)
  ;
  ((self.ui).obj_enterItem):SetActive(false)
  self.m_OnClickRoom = BindCallback(self, self.OnClickRoom)
  self.m_CloseOrderNodes = BindCallback(self, self.CloseOrderNodes)
  self.m_ShowOrderDetail = BindCallback(self, self.ShowOrderDetail)
  self.m_OnRoomMove = BindCallback(self, self.OnRoomMove)
  self.m_OnClickSelectHero = BindCallback(self, self.OnClickSelectHero)
  self.m_OnClick3DBG = BindCallback(self, self.OnClick3DBG)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_SelectHero, self, self.OnClickSelectHero)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Production, self, self.OnClickProduction)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_backGround, self, self.OnClickBackgroundBtn)
  ;
  (((self.ui).btn_backGround).gameObject):SetActive(false)
  ;
  (((self.ui).tween_OrderList).onRewind):AddListener(BindCallback(self, self.OrderNodesPlayBackwardsOver))
  ;
  (((self.ui).tween_OrderList).onComplete):AddListener(BindCallback(self, self.OrderNodesPlayOver))
  ;
  (((self.ui).tween_OrderList).onUpdate):AddListener(BindCallback(self, self.OrderNodesPlayUpdate))
  self.selRoomTween = {}
  ;
  (UIUtil.LuaUIBindingTable)(((self.ui).obj_factoryRoomFunc).transform, self.selRoomTween)
end

UIFactory.OnClickRoom = function(self, roomEntity)
  -- function num : 0_1 , upvalues : FactoryEnum
  if roomEntity.type ~= (FactoryEnum.eRoomType).locked then
    if self.isShowingRoomFuncUI then
      if self.lastSelectRoomIndex == roomEntity.index then
        ((self.ui).obj_factoryRoomFunc):SetActive(false)
        self.isShowingRoomFuncUI = false
        self.lastSelectRoomIndex = nil
      else
        self:ChangeRoomFuncUI(roomEntity)
      end
    else
      ;
      ((self.ui).obj_factoryRoomFunc):SetActive(true)
      self.isShowingRoomFuncUI = true
      self:ChangeRoomFuncUI(roomEntity)
      self:RestartSelRoomTween()
    end
  else
    ;
    ((self.ui).obj_factoryRoomFunc):SetActive(false)
    self.isShowingRoomFuncUI = false
    self.lastSelectRoomIndex = nil
  end
end

UIFactory.OnClick3DBG = function(self, roomEntity)
  -- function num : 0_2
  ((self.ui).obj_factoryRoomFunc):SetActive(false)
  self.isShowingRoomFuncUI = false
  self.lastSelectRoomIndex = nil
end

UIFactory.ChangeRoomFuncUI = function(self, roomEntity)
  -- function num : 0_3 , upvalues : _ENV, OFFSET
  self.lastSelectRoomIndex = roomEntity.index
  self.lastSelectRoomEntity = roomEntity
  local UIPos = UIManager:World2UIPosition((roomEntity.transform).position + OFFSET)
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (((self.ui).obj_factoryRoomFunc).transform).localPosition = (Vector2.New)(UIPos.x, UIPos.y)
  self:RestartSelRoomTween()
end

UIFactory.UpdateEnterUIPos = function(self)
  -- function num : 0_4 , upvalues : _ENV, OFFSET
  local UIPos = UIManager:World2UIPosition(((self.lastSelectRoomEntity).transform).position + OFFSET)
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((self.ui).obj_enterhNode).transform).localPosition = (Vector2.New)(UIPos.x, UIPos.y)
end

UIFactory.UpdateEnterUIInfo = function(self)
  -- function num : 0_5
  local enteredHero = (self.factoryController):GetRoomHeroList()
  local heroList = enteredHero[self.lastSelectRoomIndex]
  ;
  (self.heroHeadItemPool):HideAll()
  for i = 1, 3 do
    local heroId = nil
    if heroList ~= nil then
      heroId = heroList[i]
    end
    local item = (self.heroHeadItemPool):GetOne()
    item:InitHeroItem(heroId, self.resloader, self.m_OnClickSelectHero)
  end
end

UIFactory.ChangeUILock = function(self, roomEntity, bool)
  -- function num : 0_6 , upvalues : UINFactoryRoomLock, _ENV
  if bool then
    local lock = (UINFactoryRoomLock.New)()
    if (table.count)(self.lockDic) == 0 then
      ((self.ui).obj_factoryLockItem):SetActive(true)
      lock:Init((self.ui).obj_factoryLockItem)
    else
      local go = ((self.ui).obj_factoryLockItem):Instantiate()
      go:SetActive(true)
      lock:Init(go)
    end
    do
      do
        -- DECOMPILER ERROR at PC31: Confused about usage of register: R4 in 'UnsetPending'

        ;
        (self.lockDic)[roomEntity] = lock
        lock:InitLock(roomEntity)
        local lock = (self.lockDic)[roomEntity]
        if lock ~= nil then
          lock:Delete()
          -- DECOMPILER ERROR at PC43: Confused about usage of register: R4 in 'UnsetPending'

          ;
          (self.lockDic)[roomEntity] = nil
        end
      end
    end
  end
end

UIFactory.OnClickSelectHero = function(self)
  -- function num : 0_7 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.FactoryHerolist, function(win)
    -- function num : 0_7_0 , upvalues : self
    if win == nil then
      return 
    end
    win:InitSelectHero(self.lastSelectRoomIndex, function()
      -- function num : 0_7_0_0 , upvalues : self
      self:UpdateEnterUIInfo()
    end
)
  end
)
end

UIFactory.OnClickProduction = function(self)
  -- function num : 0_8 , upvalues : _ENV
  ((self.ui).tween_OrderList):DOPlayForwardAllById("orderOpen")
  ;
  (self.factoryController):StartMoveRoomToLeftMin((self.ui).obj_posPointEnd, self.lastSelectRoomIndex, self.m_OnRoomMove)
  self.oringinDistance = ((((self.ui).obj_posPointEnd).transform).position).x - ((((self.ui).obj_posPointStart).transform).position).x
  self:UpdateEnterUIInfo()
  ;
  (self.orderNode):InitOrderNode(self.lastSelectRoomIndex)
  ;
  (self.orderNode):Show()
  ;
  (self.orderListNode):InitList(self.lastSelectRoomIndex, self.m_ShowOrderDetail)
  ;
  (self.orderListNode):Show()
  ;
  (UIUtil.Push2BackStack)(self.m_CloseOrderNodes)
  ;
  ((self.ui).obj_factoryRoomFunc):SetActive(false)
  ;
  ((self.ui).obj_enterhNode):SetActive(true)
  self.isShowingRoomFuncUI = false
  ;
  (((self.ui).btn_backGround).gameObject):SetActive(true)
  ;
  (UIManager:ShowWindow(UIWindowTypeID.ClickContinue)):InitContinue(nil, nil, nil, Color.clear, false)
end

UIFactory.OrderNodesPlayUpdate = function(self)
  -- function num : 0_9
  local curDistance = ((((self.ui).obj_posPointEnd).transform).position).x - ((((self.ui).obj_posPointStart).transform).position).x
  ;
  (self.factoryController):OnMoveRoomToLeftMin(self.m_OnRoomMove, 1 - curDistance / self.oringinDistance)
end

UIFactory.OrderNodesPlayOver = function(self)
  -- function num : 0_10 , upvalues : _ENV
  (self.factoryController):ForceMoveToLeft(self.m_OnRoomMove)
  UIManager:HideWindow(UIWindowTypeID.ClickContinue)
end

UIFactory.CloseOrderNodes = function(self)
  -- function num : 0_11 , upvalues : _ENV
  ((self.ui).obj_enterhNode):SetActive(false)
  ;
  ((self.ui).tween_OrderList):DOPlayBackwardsAllById("orderOpen")
  ;
  (((self.ui).btn_backGround).gameObject):SetActive(false)
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.orderListNode).isSelectDefault = false
  ;
  (UIManager:ShowWindow(UIWindowTypeID.ClickContinue)):InitContinue(nil, nil, nil, Color.clear, false)
end

UIFactory.OrderNodesPlayBackwardsOver = function(self)
  -- function num : 0_12 , upvalues : _ENV
  (self.orderListNode):Hide()
  ;
  (self.orderNode):Hide()
  ;
  (self.factoryController):MoveRoomToMid(self.m_OnRoomMove)
  UIManager:HideWindow(UIWindowTypeID.ClickContinue)
end

UIFactory.OnClickBackgroundBtn = function(self)
  -- function num : 0_13 , upvalues : _ENV
  self:CloseOrderNodes()
  ;
  (UIUtil.PopFromBackStack)()
end

UIFactory.ShowOrderDetail = function(self, orderCfg)
  -- function num : 0_14
  (self.orderNode):ShowOrder(orderCfg)
end

UIFactory.UpdateEnergy = function(self)
  -- function num : 0_15
  if (self.orderNode).active then
    (self.orderNode):UpdateEnergy()
  end
end

UIFactory.OnRoomMove = function(self)
  -- function num : 0_16 , upvalues : _ENV
  for roomIndex,lockItem in pairs(self.lockDic) do
    lockItem:Set2RoomPos()
  end
  self:UpdateEnterUIPos()
end

UIFactory.CloseFactory = function(self)
  -- function num : 0_17 , upvalues : _ENV
  (UIManager:ShowWindow(UIWindowTypeID.ClickContinue)):InitContinue(nil, nil, nil, Color.clear, false)
  ;
  (self.factoryController):FadeFactory()
  ;
  ((self.ui).canvasGroup):DOFade(0, 0.5)
end

UIFactory.RestartSelRoomTween = function(self)
  -- function num : 0_18 , upvalues : _ENV
  local selRoomTweens = (self.selRoomTween).ani_Tweens
  if selRoomTweens ~= nil then
    for index,tweenAnima in ipairs(selRoomTweens) do
      tweenAnima:DORestart()
    end
  end
end

UIFactory.KillSelRoomTween = function(self)
  -- function num : 0_19 , upvalues : _ENV
  local selRoomTweens = (self.selRoomTween).ani_Tweens
  if selRoomTweens ~= nil then
    for index,tweenAnima in ipairs(selRoomTweens) do
      tweenAnima:DOKill()
    end
  end
end

UIFactory.OnDelete = function(self)
  -- function num : 0_20 , upvalues : base
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
  ;
  (self.resourceGroup):Delete()
  self:KillSelRoomTween()
  self.selRoomTween = nil
  ;
  (base.OnDelete)(self)
end

return UIFactory

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIFactory = class("UIFactory", UIBaseWindow)
local base = UIBaseWindow
local FactoryEnum = require("Game.Factory.FactoryEnum")
local UINResourceGroup = require("Game.CommonUI.ResourceGroup.UINResourceGroup")
local UINFactoryRoomLock = require("Game.Factory.UI.UINFactoryRoomLock")
local UINFactoryOrderListNode = require(
                                    "Game.Factory.UI.UINFactoryOrderListNode")
local UINFactoryOrderNode = require("Game.Factory.UI.UINFactoryOrderNode")
local UINFactoryEnterHeroItem = require(
                                    "Game.Factory.UI.UINFactoryEnterHeroItem")
local cs_ResLoader = CS.ResLoader
local OFFSET = (Vector3.New)(0, 2, 0)
UIFactory.OnInit = function(self)
    -- function num : 0_0 , upvalues : cs_ResLoader, _ENV, UINResourceGroup, UINFactoryOrderListNode, UINFactoryOrderNode, UINFactoryEnterHeroItem
    self.resloader = (cs_ResLoader.Create)()
    self.factoryController = ControllerManager:GetController(
                                 ControllerTypeId.Factory, false)
    self.lockDic = {}
    self.isShowingRoomFuncUI = false
    self.lastSelectRoomIndex = nil;
    (UIUtil.CreateTopBtnGroup)((self.ui).obj_topButtonGroup, self,
                               self.CloseFactory)
    self.resourceGroup = (UINResourceGroup.New)();
    (self.resourceGroup):Init((self.ui).obj_gameResourceGroup);
    (self.resourceGroup):SetResourceIds({1002, 1003, 1004})
    self.orderListNode = (UINFactoryOrderListNode.New)();
    (self.orderListNode):Init((self.ui).obj_orderListNode);
    (self.orderListNode):Hide()
    self.orderNode = (UINFactoryOrderNode.New)();
    (self.orderNode):Init((self.ui).obj_orderNode);
    (self.orderNode):Hide()
    self.heroHeadItemPool = (UIItemPool.New)(UINFactoryEnterHeroItem,
                                             (self.ui).obj_enterItem);
    ((self.ui).obj_enterItem):SetActive(false)
    self.m_OnClickRoom = BindCallback(self, self.OnClickRoom)
    self.m_CloseOrderNodes = BindCallback(self, self.CloseOrderNodes)
    self.m_ShowOrderDetail = BindCallback(self, self.ShowOrderDetail)
    self.m_OnRoomMove = BindCallback(self, self.OnRoomMove)
    self.m_OnClickSelectHero = BindCallback(self, self.OnClickSelectHero)
    self.m_OnClick3DBG = BindCallback(self, self.OnClick3DBG);
    (UIUtil.AddButtonListener)((self.ui).btn_SelectHero, self,
                               self.OnClickSelectHero);
    (UIUtil.AddButtonListener)((self.ui).btn_Production, self,
                               self.OnClickProduction);
    (UIUtil.AddButtonListener)((self.ui).btn_backGround, self,
                               self.OnClickBackgroundBtn);
    (((self.ui).btn_backGround).gameObject):SetActive(false);
    (((self.ui).tween_OrderList).onRewind):AddListener(
        BindCallback(self, self.OrderNodesPlayBackwardsOver));
    (((self.ui).tween_OrderList).onComplete):AddListener(
        BindCallback(self, self.OrderNodesPlayOver));
    (((self.ui).tween_OrderList).onUpdate):AddListener(
        BindCallback(self, self.OrderNodesPlayUpdate))
    self.selRoomTween = {};
    (UIUtil.LuaUIBindingTable)(((self.ui).obj_factoryRoomFunc).transform,
                               self.selRoomTween)
end

UIFactory.OnClickRoom = function(self, roomEntity)
    -- function num : 0_1 , upvalues : FactoryEnum
    if roomEntity.type ~= (FactoryEnum.eRoomType).locked then
        if self.isShowingRoomFuncUI then
            if self.lastSelectRoomIndex == roomEntity.index then
                ((self.ui).obj_factoryRoomFunc):SetActive(false)
                self.isShowingRoomFuncUI = false
                self.lastSelectRoomIndex = nil
            else
                self:ChangeRoomFuncUI(roomEntity)
            end
        else

            ((self.ui).obj_factoryRoomFunc):SetActive(true)
            self.isShowingRoomFuncUI = true
            self:ChangeRoomFuncUI(roomEntity)
            self:RestartSelRoomTween()
        end
    else

        ((self.ui).obj_factoryRoomFunc):SetActive(false)
        self.isShowingRoomFuncUI = false
        self.lastSelectRoomIndex = nil
    end
end

UIFactory.OnClick3DBG = function(self, roomEntity)
    -- function num : 0_2
    ((self.ui).obj_factoryRoomFunc):SetActive(false)
    self.isShowingRoomFuncUI = false
    self.lastSelectRoomIndex = nil
end

UIFactory.ChangeRoomFuncUI = function(self, roomEntity)
    -- function num : 0_3 , upvalues : _ENV, OFFSET
    self.lastSelectRoomIndex = roomEntity.index
    self.lastSelectRoomEntity = roomEntity
    local UIPos = UIManager:World2UIPosition(
                      (roomEntity.transform).position + OFFSET) -- DECOMPILER ERROR at PC18: Confused about usage of register: R3 in 'UnsetPending'
    ;
    (((self.ui).obj_factoryRoomFunc).transform).localPosition =
        (Vector2.New)(UIPos.x, UIPos.y)
    self:RestartSelRoomTween()
end

UIFactory.UpdateEnterUIPos = function(self)
    -- function num : 0_4 , upvalues : _ENV, OFFSET
    local UIPos = UIManager:World2UIPosition(
                      ((self.lastSelectRoomEntity).transform).position + OFFSET) -- DECOMPILER ERROR at PC16: Confused about usage of register: R2 in 'UnsetPending'
    ;
    (((self.ui).obj_enterhNode).transform).localPosition =
        (Vector2.New)(UIPos.x, UIPos.y)
end

UIFactory.UpdateEnterUIInfo = function(self)
    -- function num : 0_5
    local enteredHero = (self.factoryController):GetRoomHeroList()
    local heroList = enteredHero[self.lastSelectRoomIndex];
    (self.heroHeadItemPool):HideAll()
    for i = 1, 3 do
        local heroId = nil
        if heroList ~= nil then heroId = heroList[i] end
        local item = (self.heroHeadItemPool):GetOne()
        item:InitHeroItem(heroId, self.resloader, self.m_OnClickSelectHero)
    end
end

UIFactory.ChangeUILock = function(self, roomEntity, bool)
    -- function num : 0_6 , upvalues : UINFactoryRoomLock, _ENV
    if bool then
        local lock = (UINFactoryRoomLock.New)()
        if (table.count)(self.lockDic) == 0 then
            ((self.ui).obj_factoryLockItem):SetActive(true)
            lock:Init((self.ui).obj_factoryLockItem)
        else
            local go = ((self.ui).obj_factoryLockItem):Instantiate()
            go:SetActive(true)
            lock:Init(go)
        end
        do
            do
                -- DECOMPILER ERROR at PC31: Confused about usage of register: R4 in 'UnsetPending'


                (self.lockDic)[roomEntity] = lock
                lock:InitLock(roomEntity)
                local lock = (self.lockDic)[roomEntity]
                if lock ~= nil then
                    lock:Delete() -- DECOMPILER ERROR at PC43: Confused about usage of register: R4 in 'UnsetPending'
                    ;
                    (self.lockDic)[roomEntity] = nil
                end
            end
        end
    end
end

UIFactory.OnClickSelectHero = function(self)
    -- function num : 0_7 , upvalues : _ENV
    UIManager:ShowWindowAsync(UIWindowTypeID.FactoryHerolist, function(win)
        -- function num : 0_7_0 , upvalues : self
        if win == nil then return end
        win:InitSelectHero(self.lastSelectRoomIndex, function()
            -- function num : 0_7_0_0 , upvalues : self
            self:UpdateEnterUIInfo()
        end)
    end)
end

UIFactory.OnClickProduction = function(self)
    -- function num : 0_8 , upvalues : _ENV
    ((self.ui).tween_OrderList):DOPlayForwardAllById("orderOpen");
    (self.factoryController):StartMoveRoomToLeftMin((self.ui).obj_posPointEnd,
                                                    self.lastSelectRoomIndex,
                                                    self.m_OnRoomMove)
    self.oringinDistance =
        ((((self.ui).obj_posPointEnd).transform).position).x -
            ((((self.ui).obj_posPointStart).transform).position).x
    self:UpdateEnterUIInfo();
    (self.orderNode):InitOrderNode(self.lastSelectRoomIndex);
    (self.orderNode):Show();
    (self.orderListNode):InitList(self.lastSelectRoomIndex,
                                  self.m_ShowOrderDetail);
    (self.orderListNode):Show();
    (UIUtil.Push2BackStack)(self.m_CloseOrderNodes);
    ((self.ui).obj_factoryRoomFunc):SetActive(false);
    ((self.ui).obj_enterhNode):SetActive(true)
    self.isShowingRoomFuncUI = false;
    (((self.ui).btn_backGround).gameObject):SetActive(true);
    (UIManager:ShowWindow(UIWindowTypeID.ClickContinue)):InitContinue(nil, nil,
                                                                      nil,
                                                                      Color.clear,
                                                                      false)
end

UIFactory.OrderNodesPlayUpdate = function(self)
    -- function num : 0_9
    local curDistance = ((((self.ui).obj_posPointEnd).transform).position).x -
                            ((((self.ui).obj_posPointStart).transform).position).x;
    (self.factoryController):OnMoveRoomToLeftMin(self.m_OnRoomMove, 1 -
                                                     curDistance /
                                                     self.oringinDistance)
end

UIFactory.OrderNodesPlayOver = function(self)
    -- function num : 0_10 , upvalues : _ENV
    (self.factoryController):ForceMoveToLeft(self.m_OnRoomMove)
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
end

UIFactory.CloseOrderNodes = function(self)
    -- function num : 0_11 , upvalues : _ENV
    ((self.ui).obj_enterhNode):SetActive(false);
    ((self.ui).tween_OrderList):DOPlayBackwardsAllById("orderOpen");
    (((self.ui).btn_backGround).gameObject):SetActive(false) -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'
    ;
    (self.orderListNode).isSelectDefault = false;
    (UIManager:ShowWindow(UIWindowTypeID.ClickContinue)):InitContinue(nil, nil,
                                                                      nil,
                                                                      Color.clear,
                                                                      false)
end

UIFactory.OrderNodesPlayBackwardsOver = function(self)
    -- function num : 0_12 , upvalues : _ENV
    (self.orderListNode):Hide();
    (self.orderNode):Hide();
    (self.factoryController):MoveRoomToMid(self.m_OnRoomMove)
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
end

UIFactory.OnClickBackgroundBtn = function(self)
    -- function num : 0_13 , upvalues : _ENV
    self:CloseOrderNodes();
    (UIUtil.PopFromBackStack)()
end

UIFactory.ShowOrderDetail = function(self, orderCfg)
    -- function num : 0_14
    (self.orderNode):ShowOrder(orderCfg)
end

UIFactory.UpdateEnergy = function(self)
    -- function num : 0_15
    if (self.orderNode).active then (self.orderNode):UpdateEnergy() end
end

UIFactory.OnRoomMove = function(self)
    -- function num : 0_16 , upvalues : _ENV
    for roomIndex, lockItem in pairs(self.lockDic) do lockItem:Set2RoomPos() end
    self:UpdateEnterUIPos()
end

UIFactory.CloseFactory = function(self)
    -- function num : 0_17 , upvalues : _ENV
    (UIManager:ShowWindow(UIWindowTypeID.ClickContinue)):InitContinue(nil, nil,
                                                                      nil,
                                                                      Color.clear,
                                                                      false);
    (self.factoryController):FadeFactory();
    ((self.ui).canvasGroup):DOFade(0, 0.5)
end

UIFactory.RestartSelRoomTween = function(self)
    -- function num : 0_18 , upvalues : _ENV
    local selRoomTweens = (self.selRoomTween).ani_Tweens
    if selRoomTweens ~= nil then
        for index, tweenAnima in ipairs(selRoomTweens) do
            tweenAnima:DORestart()
        end
    end
end

UIFactory.KillSelRoomTween = function(self)
    -- function num : 0_19 , upvalues : _ENV
    local selRoomTweens = (self.selRoomTween).ani_Tweens
    if selRoomTweens ~= nil then
        for index, tweenAnima in ipairs(selRoomTweens) do
            tweenAnima:DOKill()
        end
    end
end

UIFactory.OnDelete = function(self)
    -- function num : 0_20 , upvalues : base
    if self.resloader ~= nil then
        (self.resloader):Put2Pool()
        self.resloader = nil
    end
    (self.resourceGroup):Delete()
    self:KillSelRoomTween()
    self.selRoomTween = nil;
    (base.OnDelete)(self)
end

return UIFactory

