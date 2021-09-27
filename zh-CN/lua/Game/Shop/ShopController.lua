local ShopController = class("ShopController", ControllerBase)
local ShopEnum = require("Game.Shop.ShopEnum")
local ShopData = require("Game.Shop.ShopData")
ShopController.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.shopDataDic = {}
  self.redDotTimerDic = {}
  self.network = NetworkManager:GetNetwork(NetworkTypeID.Shop)
  self.isUnlocked = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Store)
end

ShopController.SetIsUnLock = function(self, bool)
  -- function num : 0_1
  self.isUnlocked = bool
  self:StartShopAllRedDot()
end

ShopController.GetIsUnlock = function(self)
  -- function num : 0_2
  return self.isUnlocked
end

ShopController.ReqShopDetail = function(self, shopId, callback)
  -- function num : 0_3 , upvalues : _ENV, ShopEnum
  local shopCfg = (ConfigData.shop)[shopId]
  if shopCfg == nil then
    error("can\'t read shopCfg id = " .. shopId)
  else
    if shopCfg.shop_type == (ShopEnum.eShopType).Charcter or shopCfg.shop_type == (ShopEnum.eShopType).Recharge or shopCfg.shop_type == (ShopEnum.eShopType).Resource or shopCfg.shop_type == (ShopEnum.eShopType).ResourceRefresh then
      (self.network):CS_STORE_Detail(shopId, function(args)
    -- function num : 0_3_0 , upvalues : self, shopId, callback
    do
      if args ~= nil and args.Count > 0 then
        local shopDataMsg = args[0]
        self:InitShopData(shopDataMsg, shopId)
      end
      if callback ~= nil then
        callback()
      end
    end
  end
)
    else
      ;
      (self.network):CS_STORE_Detail(shopId, function(args)
    -- function num : 0_3_1 , upvalues : self, callback
    do
      if args ~= nil and args.Count > 0 then
        local shopDataMsg = args[0]
        self:InitShopData(shopDataMsg, nil)
      end
      if callback ~= nil then
        callback()
      end
    end
  end
)
    end
  end
end

ShopController.InitShopData = function(self, shopDataMsg, shopId)
  -- function num : 0_4 , upvalues : ShopData
  local shopData = (ShopData.CreateShopData)(shopDataMsg, shopId)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.shopDataDic)[shopData.shopId] = shopData
end

ShopController.ReqRefreshShopDetail = function(self, shopId, callback)
  -- function num : 0_5 , upvalues : _ENV
  local win = UIManager:GetWindow(UIWindowTypeID.QuickBuy)
  if win ~= nil then
    win:SlideOut()
  end
  ;
  (self.network):CS_STORE_Fresh(shopId, callback)
end

ShopController.RefreshShopData = function(self, shopDataMsg, shopId)
  -- function num : 0_6 , upvalues : ShopData
  local shopData = nil
  if shopDataMsg ~= nil then
    shopData = (ShopData.CreateShopData)(shopDataMsg)
  else
    shopData = (ShopData.CreateShopData)(shopDataMsg, shopId)
  end
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.shopDataDic)[shopData.shopId] = shopData
end

ShopController.ReqBuyGoods = function(self, storeId, shelfId, cnt, callback)
  -- function num : 0_7 , upvalues : _ENV
  if not cnt then
    cnt = 1
  end
  ;
  (self.network):CS_STORE_Purchase(storeId, shelfId, cnt, function()
    -- function num : 0_7_0 , upvalues : _ENV, storeId, shelfId, callback
    MsgCenter:Broadcast(eMsgEventId.ShopGoodsBuyed, storeId, shelfId)
    callback()
  end
)
end

ShopController.ReqExchangeGoods = function(self, toId, num, callback)
  -- function num : 0_8
  (self.network):CS_BACKPACK_Exchange(toId, num, callback)
end

ShopController.RefreshGoodsData = function(self, CommonStoreShelfData, shopId)
  -- function num : 0_9 , upvalues : _ENV
  local shopData = (self.shopDataDic)[shopId]
  if shopData == nil then
    error("can\'t get shopData by Id:" .. tostring(shopId))
    return 
  end
  local goodsData = (shopData.shopGoodsDic)[CommonStoreShelfData.shelfId]
  if goodsData == nil then
    error("can\'t get goodsData by shelfId:" .. tostring(CommonStoreShelfData.shelfId))
    return 
  end
  goodsData:UpdateShopGoodData(CommonStoreShelfData)
end

ShopController.GetShopData = function(self, shopId, callback)
  -- function num : 0_10
  local shopData = (self.shopDataDic)[shopId]
  if shopData == nil then
    self:ReqShopDetail(shopId, function()
    -- function num : 0_10_0 , upvalues : callback, self, shopId
    if callback ~= nil then
      callback((self.shopDataDic)[shopId])
    end
  end
)
  else
    local isNeedFresh = not shopData:GetIsRefreshShop() or shopData:GetRemainAutoRefreshTime() < 0
    local isGoodsNeddFresh = shopData:GetIsHaveRefreshItem()
    if isNeedFresh or isGoodsNeddFresh then
      self:ReqShopDetail(shopId, function()
    -- function num : 0_10_1 , upvalues : callback, self, shopId
    if callback ~= nil then
      callback((self.shopDataDic)[shopId])
    end
  end
)
    else
      callback(shopData)
    end
  end
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

ShopController.ShopShowBeforeUnlock = function(self, shopId)
  -- function num : 0_11 , upvalues : _ENV
  local flag = ((ConfigData.game_config).shopShowBeforeUnlockDic)[shopId]
  if flag == nil or flag == false then
    return false
  else
    return true
  end
end

ShopController.ShopIsUnlock = function(self, shopId)
  -- function num : 0_12 , upvalues : _ENV
  local cfg = (ConfigData.shop)[shopId]
  if cfg == nil then
    return false
  end
  return (CheckCondition.CheckLua)(cfg.pre_condition, cfg.pre_para1, cfg.pre_para2), (CheckCondition.GetUnlockInfoLua)(cfg.pre_condition, cfg.pre_para1, cfg.pre_para2)
end

ShopController.StartShopAllRedDot = function(self)
  -- function num : 0_13 , upvalues : _ENV, ShopEnum
  if not self.isUnlocked then
    return 
  end
  local showShopDic = (ConfigData.shop_classification).showShopDic
  for k,shopId in ipairs((ConfigData.shop).id_sort_list) do
    local shopCfg = (ConfigData.shop)[shopId]
    if shopCfg.shop_type == (ShopEnum.eShopType).PayGift and (CheckCondition.CheckLua)(shopCfg.pre_condition, shopCfg.pre_para1, shopCfg.pre_para2) then
      local saveUserData = (PersistentManager:GetDataModel((PersistentConfig.ePackage).UserData))
      do
        local monthCardPageId = nil
        for _,pageId in ipairs(shopCfg.shop_para) do
          local pageCfg = (ConfigData.shop_page)[pageId]
          if pageCfg.mark == (ShopEnum.ePageMarkType).MonthCard then
            monthCardPageId = pageId
            break
          end
        end
        do
          if monthCardPageId ~= nil then
            local isBoughtMonthCardRDClosed = saveUserData:GetIsSReddotClose(RedDotStaticTypeId.Main .. "." .. RedDotStaticTypeId.ShopWindow .. "." .. tostring(shopId) .. "." .. tostring(monthCardPageId))
            if not isBoughtMonthCardRDClosed then
              do
                local shopNode = RedDotController:AddRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ShopWindow, shopId, monthCardPageId)
                shopNode:SetRedDotCount(1)
                -- DECOMPILER ERROR at PC84: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC84: LeaveBlock: unexpected jumping out IF_STMT

                -- DECOMPILER ERROR at PC84: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC84: LeaveBlock: unexpected jumping out IF_STMT

              end
            end
          end
        end
        if showShopDic[shopId] and shopCfg.isRefreshShop and (CheckCondition.CheckLua)(shopCfg.pre_condition, shopCfg.pre_para1, shopCfg.pre_para2) then
          TimerManager:StopTimer((self.redDotTimerDic)[shopId])
          -- DECOMPILER ERROR at PC104: Confused about usage of register: R8 in 'UnsetPending'

          ;
          (self.redDotTimerDic)[shopId] = nil
          local counterElem = (ControllerManager:GetController(ControllerTypeId.TimePass)):getCounterElemData(proto_object_CounterModule.CounterModuleStoreSystemReset, shopId)
          if counterElem == nil then
            local shopNode = RedDotController:AddRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ShopWindow, shopId)
            shopNode:SetRedDotCount(1)
          else
            do
              local saveUserData = PersistentManager:GetDataModel((PersistentConfig.ePackage).UserData)
              local isBoughtMonthCardRDClosed = saveUserData:GetIsSReddotClose(RedDotStaticTypeId.Main .. "." .. RedDotStaticTypeId.ShopWindow .. "." .. tostring(shopId))
              do
                do
                  if isBoughtMonthCardRDClosed ~= nil and not isBoughtMonthCardRDClosed then
                    local shopNode = RedDotController:AddRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ShopWindow, shopId)
                    shopNode:SetRedDotCount(1)
                  end
                  if PlayerDataCenter.timestamp < counterElem.nextExpiredTm then
                    self:_StartShopRedDotTimer(shopId, counterElem.nextExpiredTm)
                  end
                  if shopId == (ShopEnum.ShopId).supportShop then
                    local maxPoint = (ConfigData.game_config).supportPointMaxNum
                    local shopNode = RedDotController:AddRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ShopWindow, shopId)
                    local SFSPNode = shopNode:AddChildWithPath(RedDotStaticTypeId.ShopFriendSupportBtn, RedDotDynPath.ShopFriendSupportBtnPath)
                    local curPoint = (PlayerDataCenter.inforData):GetCurSupportPoint()
                    if maxPoint <= curPoint then
                      SFSPNode:SetRedDotCount(1)
                    else
                      SFSPNode:SetRedDotCount(0)
                    end
                    self.__FriendShipPointReddotTimerId = TimerManager:StartTimer(60, function()
    -- function num : 0_13_0 , upvalues : _ENV, maxPoint, SFSPNode
    local curPoint = (PlayerDataCenter.inforData):GetCurSupportPoint()
    if maxPoint <= curPoint then
      SFSPNode:SetRedDotCount(1)
    else
      SFSPNode:SetRedDotCount(0)
    end
  end
, self, false, false, true)
                  end
                  do
                    -- DECOMPILER ERROR at PC216: LeaveBlock: unexpected jumping out DO_STMT

                    -- DECOMPILER ERROR at PC216: LeaveBlock: unexpected jumping out DO_STMT

                    -- DECOMPILER ERROR at PC216: LeaveBlock: unexpected jumping out DO_STMT

                    -- DECOMPILER ERROR at PC216: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                    -- DECOMPILER ERROR at PC216: LeaveBlock: unexpected jumping out IF_STMT

                    -- DECOMPILER ERROR at PC216: LeaveBlock: unexpected jumping out IF_THEN_STMT

                    -- DECOMPILER ERROR at PC216: LeaveBlock: unexpected jumping out IF_STMT

                    -- DECOMPILER ERROR at PC216: LeaveBlock: unexpected jumping out DO_STMT

                    -- DECOMPILER ERROR at PC216: LeaveBlock: unexpected jumping out IF_THEN_STMT

                    -- DECOMPILER ERROR at PC216: LeaveBlock: unexpected jumping out IF_STMT

                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

ShopController.StartOneShopRedDot = function(self, shopData)
  -- function num : 0_14
  if not shopData:GetIsRefreshShop() then
    return 
  end
  local nextTime = shopData.freeFreshTm
  self:_StartShopRedDotTimer(shopData.shopId, nextTime)
end

ShopController._StartShopRedDotTimer = function(self, shopId, nextTime)
  -- function num : 0_15 , upvalues : _ENV
  TimerManager:StopTimer((self.redDotTimerDic)[shopId])
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.redDotTimerDic)[shopId] = TimerManager:StartTimer(1, function()
    -- function num : 0_15_0 , upvalues : nextTime, _ENV, self, shopId
    if nextTime < PlayerDataCenter.timestamp then
      TimerManager:StopTimer((self.redDotTimerDic)[shopId])
      -- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

      ;
      (self.redDotTimerDic)[shopId] = nil
      local shopNode = RedDotController:AddRedDotNodeWithPath(RedDotDynPath.ShopPath, RedDotStaticTypeId.Main, RedDotStaticTypeId.ShopWindow, shopId)
      shopNode:SetRedDotCount(1)
      local saveUserData = PersistentManager:GetDataModel((PersistentConfig.ePackage).UserData)
      saveUserData:SetSReddotClose(RedDotStaticTypeId.Main .. "." .. RedDotStaticTypeId.ShopWindow .. "." .. tostring(shopId), false)
    end
  end
, self, false, false, true)
end

ShopController.StopShopRedDot = function(self)
  -- function num : 0_16 , upvalues : _ENV
  for _,oldTimer in pairs(self.redDotTimerDic) do
    TimerManager:StopTimer(oldTimer)
    oldTimer = nil
  end
  if self.__FriendShipPointReddotTimerId ~= nil then
    TimerManager:StopTimer(self.__FriendShipPointReddotTimerId)
    self.__FriendShipPointReddotTimerId = nil
  end
end

ShopController.IsShopBlueReddot = function(self, shopId)
  -- function num : 0_17 , upvalues : ShopEnum, _ENV
  if shopId == (ShopEnum.ShopId).supportShop then
    return false
  end
  local shopCfg = (ConfigData.shop)[shopId]
  do return (shopCfg ~= nil and shopCfg.isRefreshShop) end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

ShopController.SetShopMinRed = function(self, shopId)
  -- function num : 0_18 , upvalues : ShopEnum, _ENV
  do
    if shopId ~= (ShopEnum.ShopId).supportShop then
      local ok, shopNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ShopWindow, shopId)
      if ok then
        shopNode:SetRedDotCount(0)
      end
    end
    local shopCfg = (ConfigData.shop)[shopId]
    if shopCfg.isRefreshShop and (CheckCondition.CheckLua)(shopCfg.pre_condition, shopCfg.pre_para1, shopCfg.pre_para2) then
      local saveUserData = PersistentManager:GetDataModel((PersistentConfig.ePackage).UserData)
      saveUserData:SetSReddotClose(RedDotStaticTypeId.Main .. "." .. RedDotStaticTypeId.ShopWindow .. "." .. tostring(shopId), true)
    end
  end
end

ShopController.ReqShopRecharge = function(self, pay_id)
  -- function num : 0_19 , upvalues : _ENV
  self._rechargePayId = pay_id
  if not self._OnShopRechargeFunc then
    self._OnShopRechargeFunc = BindCallback(self, self._OnShopRecharge)
    ;
    (self.network):CS_STORE_Recharge(pay_id, self._OnShopRechargeFunc)
  end
end

ShopController._OnShopRecharge = function(self)
  -- function num : 0_20 , upvalues : _ENV
  (ControllerManager:GetController(ControllerTypeId.Pay, true)):ReqPay(self._rechargePayId, 1)
end

ShopController.AfterShopRechargeComplete = function(self, CommonStore)
  -- function num : 0_21 , upvalues : _ENV
  if (self.shopDataDic)[CommonStore.storeId] ~= nil then
    for k,CommonStoreShelf in pairs(CommonStore.data) do
      self:RefreshGoodsData(CommonStoreShelf, CommonStore.storeId)
    end
  end
  do
    MsgCenter:Broadcast(eMsgEventId.ShopRechargeComplete, CommonStore.storeId)
  end
end

ShopController.GetShelfIsSouldOut = function(self, shopId, shelfId)
  -- function num : 0_22 , upvalues : _ENV, ShopEnum
  local shopCfg = (ConfigData.shop)[shopId]
  if shopCfg == nil then
    return true
  end
  if shopCfg.shop_type == (ShopEnum.eShopType).PayGift then
    local payGiftCtrl = ControllerManager:GetController(ControllerTypeId.PayGift, true)
    return payGiftCtrl:GetIsGiftSouldOut(shelfId)
  else
    do
      self:GetShopData(shopId, function(shopData)
    -- function num : 0_22_0 , upvalues : shelfId
    if shopData == nil then
      return true
    end
    local goodData = (shopData.shopGoodsDic)[shelfId]
    do return goodData ~= nil and goodData.isSoldOut end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
)
    end
  end
end

ShopController.OnDelete = function(self)
  -- function num : 0_23
  self:StopShopRedDot()
  self.shopDataDic = nil
end

return ShopController

