-- params : ...
-- function num : 0 , upvalues : _ENV
local ShopController = class("ShopController", ControllerBase)
local ShopEnum = require("Game.Shop.ShopEnum")
local ShopData = require("Game.Shop.ShopData")
ShopController.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    self.shopDataDic = {}
    self.redDotTimerDic = {}
    self.network = NetworkManager:GetNetwork(NetworkTypeID.Shop)
    local funcUnLockCrtl = ControllerManager:GetController(
                               ControllerTypeId.FunctionUnlock, true)
    self.isUnlocked = funcUnLockCrtl:ValidateUnlock(
                          proto_csmsg_SystemFunctionID.SystemFunctionID_Store)
end

ShopController.SetLock = function(self, bool)
    -- function num : 0_1
    self.isUnlocked = bool
end

ShopController.ReqShopDetail = function(self, shopId, callback)
    -- function num : 0_2 , upvalues : _ENV, ShopEnum
    local win = UIManager:GetWindow(UIWindowTypeID.QuickBuy)
    if win ~= nil then win:SlideOut() end
    local shopCfg = (ConfigData.shop)[shopId]
    if shopCfg == nil then
        error("can\'t read shopCfg id = " .. shopId)
    else
        if shopCfg.shop_type == (ShopEnum.eShopType).Charcter or
            shopCfg.shop_type == (ShopEnum.eShopType).Resource then
            (self.network):CS_STORE_Detail(shopId, function(args)
                -- function num : 0_2_0 , upvalues : self, shopId, callback
                do
                    if args ~= nil and args.Count > 0 then
                        local shopDataMsg = args[0]
                        self:InitShopData(shopDataMsg, shopId)
                    end
                    if callback ~= nil then callback() end
                end
            end)
        else

            (self.network):CS_STORE_Detail(shopId, function(args)
                -- function num : 0_2_1 , upvalues : self, callback
                do
                    if args ~= nil and args.Count > 0 then
                        local shopDataMsg = args[0]
                        self:InitShopData(shopDataMsg, nil)
                    end
                    if callback ~= nil then callback() end
                end
            end)
        end
    end
end

ShopController.InitShopData = function(self, shopDataMsg, shopId)
    -- function num : 0_3 , upvalues : ShopData
    local shopData = (ShopData.CreateShopData)(shopDataMsg, shopId) -- DECOMPILER ERROR at PC6: Confused about usage of register: R4 in 'UnsetPending'
    ;
    (self.shopDataDic)[shopData.shopId] = shopData
end

ShopController.ReqRefreshShopDetail = function(self, shopId, callback)
    -- function num : 0_4 , upvalues : _ENV
    local win = UIManager:GetWindow(UIWindowTypeID.QuickBuy)
    if win ~= nil then win:SlideOut() end
    (self.network):CS_STORE_Fresh(shopId, callback)
end

ShopController.RefreshShopData = function(self, shopDataMsg)
    -- function num : 0_5 , upvalues : ShopData
    local shopData = (ShopData.CreateShopData)(shopDataMsg) -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'
    ;
    (self.shopDataDic)[shopData.shopId] = shopData
end

ShopController.ReqBuyGoods = function(self, storeId, shelfId, cnt, callback)
    -- function num : 0_6
    if not cnt then cnt = 1 end
    (self.network):CS_STORE_Purchase(storeId, shelfId, cnt, callback)
end

ShopController.RefreshGoodsData = function(self, CommonStoreShelfData, shopId)
    -- function num : 0_7
    local goodsData =
        (((self.shopDataDic)[shopId]).shopGoodsDic)[CommonStoreShelfData.shelfId]
    goodsData:UpdateShopGoodData(CommonStoreShelfData)
end

ShopController.GetShopData = function(self, shopId, callback)
    -- function num : 0_8
    local shopData = (self.shopDataDic)[shopId]
    if shopData == nil then
        self:ReqShopDetail(shopId, function()
            -- function num : 0_8_0 , upvalues : callback, self, shopId
            if callback ~= nil then
                callback((self.shopDataDic)[shopId])
            end
        end)
    else
        local isNeedFresh = not shopData:GetIsRefreshShop() or
                                shopData:GetRemainAutoRefreshTime() < 0
        local isGoodsNeddFresh = shopData:GetIsHaveRefreshItem()
        if isNeedFresh or isGoodsNeddFresh then
            self:ReqShopDetail(shopId, function()
                -- function num : 0_8_1 , upvalues : callback, self, shopId
                if callback ~= nil then
                    callback((self.shopDataDic)[shopId])
                end
            end)
        else
            callback(shopData)
        end
    end
    -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

ShopController.StartShopAllRedDot = function(self)
    -- function num : 0_9 , upvalues : _ENV, ShopEnum
    if not self.isUnlocked then return end
    for k, shopId in ipairs((ConfigData.shop).id_sort_list) do
        do
            local shopCfg = (ConfigData.shop)[shopId]
            if shopCfg.shop_type == (ShopEnum.eShopType).Random and
                (CheckCondition.CheckLua)(shopCfg.pre_condition,
                                          shopCfg.pre_para1, shopCfg.pre_para2) then
                self:GetShopData(shopId, function(shopData)
                    -- function num : 0_9_0 , upvalues : self, shopId, _ENV
                    local timeBeforeNextRe =
                        shopData:GetRemainAutoRefreshTime(true)
                    local oldTimer = (self.redDotTimerDic)[shopId]
                    if oldTimer ~= nil then
                        oldTimer:Stop()
                        oldTimer = nil
                    end
                    local tmpShopId = shopId -- DECOMPILER ERROR at PC24: Confused about usage of register: R4 in 'UnsetPending'
                    ;
                    (self.redDotTimerDic)[tmpShopId] =
                        (TimerManager:GetTimer(timeBeforeNextRe, function()
                            -- function num : 0_9_0_0 , upvalues : self, tmpShopId, _ENV, shopId
                            -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

                            (self.redDotTimerDic)[tmpShopId] = nil
                            local shopNode =
                                RedDotController:AddRedDotNodeWithPath(
                                    RedDotDynPath.ShopPath,
                                    RedDotStaticTypeId.Main,
                                    RedDotStaticTypeId.ShopWindow, shopId)
                            shopNode:SetRedDotCount(1)
                        end, self, true, false, true)):Start()
                end)
            end
        end
    end
end

ShopController.StartOneShopRedDot = function(self, shopData)
    -- function num : 0_10 , upvalues : ShopEnum, _ENV
    if (shopData.shopCfg).shop_type ~= (ShopEnum.eShopType).Random then
        return
    end
    local timeBeforeNextRe = shopData:GetRemainAutoRefreshTime(true)
    local oldTimer = (self.redDotTimerDic)[shopData.shopId]
    if oldTimer ~= nil then
        oldTimer:Stop()
        oldTimer = nil
    end
    local tmpShopId = shopData.shopId -- DECOMPILER ERROR at PC31: Confused about usage of register: R5 in 'UnsetPending'
    ;
    (self.redDotTimerDic)[tmpShopId] = (TimerManager:GetTimer(timeBeforeNextRe,
                                                              function()
        -- function num : 0_10_0 , upvalues : self, tmpShopId, _ENV, shopData
        -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

        (self.redDotTimerDic)[tmpShopId] = nil
        local shopNode = RedDotController:AddRedDotNodeWithPath(
                             RedDotDynPath.ShopPath, RedDotStaticTypeId.Main,
                             RedDotStaticTypeId.ShopWindow, shopData.shopId)
        shopNode:SetRedDotCount(1)
    end, self, true, false, true)):Start()
end

ShopController.StopShopRedDot = function(self)
    -- function num : 0_11 , upvalues : _ENV
    for _, oldTimer in pairs(self.redDotTimerDic) do
        if oldTimer ~= nil then
            oldTimer:Stop()
            oldTimer = nil
        end
    end
end

ShopController.OnDelete = function(self)
    -- function num : 0_12
    self:StopShopRedDot()
    self.shopDataDic = nil
end

return ShopController

