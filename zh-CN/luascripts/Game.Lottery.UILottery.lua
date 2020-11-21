-- params : ...
-- function num : 0 , upvalues : _ENV
local UILottery = class("UILottery", UIBaseWindow)
local base = UIBaseWindow
local cs_Resloader = CS.ResLoader
local cs_MessageCommon = CS.MessageCommon
local UILotteryResultItem = require("Game.Lottery.UILotteryResultItem")
local cs_coroutine = require("XLua.Common.cs_coroutine")
local LotteryEnum = require("Game.Lottery.LotteryEnum")
UILottery.OnInit = function(self)
    -- function num : 0_0 , upvalues : cs_Resloader, _ENV, UILotteryResultItem
    self.resloader = (cs_Resloader.Create)()
    self.networkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Lottery);
    ((self.ui).resultPanel):SetActive(false);
    ((self.ui).resultItemPrefab):SetActive(false)
    self.resultItemPool = (UIItemPool.New)(UILotteryResultItem,
                                           (self.ui).resultItemPrefab)
    self.lotteryItemPool = {}
    self.lotteryItems = {};
    (UIUtil.AddButtonListener)((self.ui).btn_drawOnce, self,
                               self.OnClickDrawOnce);
    (UIUtil.AddButtonListener)((self.ui).btn_drawTen, self, self.OnClickDrawTen);
    (UIUtil.AddButtonListener)((self.ui).Btn_nextTen, self, self.OnClickDrawTen);
    (UIUtil.AddButtonListener)((self.ui).Btn_nextOne, self, self.OnClickDrawOnce);
    (UIUtil.AddButtonListener)((self.ui).btn_close, self,
                               self.OnClickCloseButton);
    (UIUtil.AddButtonListener)((self.ui).btn_closeReselt, self,
                               self.OnClickCloseResultPanel);
    (UIUtil.AddValueChangedListener)((self.ui).typeFirst, self,
                                     self.OnClickTypeFirst);
    (UIUtil.AddValueChangedListener)((self.ui).typeSecond, self,
                                     self.OnClickTypeSecond)
    self.__onUpdateItemEvent = BindCallback(self, self.OnItemUpdateEvent)
    self.__AutoFlipCards = BindCallback(self, self.AutoFlipCards)
    MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__onUpdateItemEvent)
    MsgCenter:AddListener(eMsgEventId.UIGetHeroClose, self.__AutoFlipCards)
    UILotteryResultItem:SetFlipFun(function()
        -- function num : 0_0_0 , upvalues : self
        self.flipNum = self.flipNum - 1
    end)
    UILotteryResultItem:SetStopAutoFlipCards(self, self.StopAutoFlipCards)
    self.dailyLotteryLimtNum = (ConfigData.game_config).DailyLotteryLimtNum
    self.__onExpiredUpdate = BindCallback(self, self.OnExpiredUpdate)
end

UILottery.OnShow = function(self)
    -- function num : 0_1 , upvalues : base, LotteryEnum
    (base.OnShow)(self)
    self.lotteryId = (LotteryEnum.eLotteryPoolType).Main
    if self:CheckExpiredAndUpdate(false) then (self.__onExpiredUpdate)() end
end

UILottery.OnExpiredUpdate = function(self)
    -- function num : 0_2
    (self.networkCtrl):SendGetLotteryDetail()
end

UILottery.OnLotteryDataReUpdate = function(self)
    -- function num : 0_3
    if self.lotteryId ~= nil then self:EnterLotteryPool(self.lotteryId, true) end
end

UILottery.EnterLotteryPool = function(self, lotteryPoolId, isClick)
    -- function num : 0_4 , upvalues : LotteryEnum, _ENV
    self.lotteryId = lotteryPoolId
    if lotteryPoolId == (LotteryEnum.eLotteryPoolType).Main then
        (((self.ui).text_LotteryLimt).gameObject):SetActive(true)
        local curNum = (PlayerDataCenter.todayLotteryNums)[lotteryPoolId] or 0;
        ((self.ui).text_LotteryLimt):SetIndex(0, tostring(curNum), tostring(
                                                  self.dailyLotteryLimtNum))
    else
        do

            (((self.ui).text_LotteryLimt).gameObject):SetActive(false)
            do
                if not isClick and
                    (lotteryPoolId ~= (LotteryEnum.eLotteryPoolType).Main or
                        not (self.ui).typeFirst) then
                    local activeToggle = (self.ui).typeSecond
                end
                activeToggle.isOn = true
                self.lotteryData = (ConfigData.gashapon_para)[self.lotteryId]
                self.cost1Name = (LanguageUtil.GetLocaleText)(
                                     ((ConfigData.item)[(self.lotteryData).costId1]).name)
                self.cost2Name = (LanguageUtil.GetLocaleText)(
                                     ((ConfigData.item)[(self.lotteryData).costId2]).name)
                local num1 = PlayerDataCenter:GetItemCount(
                                 (self.lotteryData).costId1)
                local num2 = PlayerDataCenter:GetItemCount(
                                 (self.lotteryData).costId2)
                if num1 < (self.lotteryData).costNum1 then
                    ((self.ui).drawOnceCost):SetIndex(1, self.cost1Name,
                                                      (self.lotteryData).costNum1)
                else

                    ((self.ui).drawOnceCost):SetIndex(0, self.cost1Name,
                                                      (self.lotteryData).costNum1)
                end
                if num2 < (self.lotteryData).costNum2 then
                    ((self.ui).drawTenCost):SetIndex(1, self.cost2Name,
                                                     (self.lotteryData).costNum2)
                else

                    ((self.ui).drawTenCost):SetIndex(0, self.cost2Name,
                                                     (self.lotteryData).costNum2)
                end -- DECOMPILER ERROR at PC136: Confused about usage of register: R5 in 'UnsetPending'
                
                ((self.ui).drawOnceCostItemIcon).sprite =
                    CRH:GetSprite(
                        ((ConfigData.item)[(self.lotteryData).costId1]).icon) -- DECOMPILER ERROR at PC148: Confused about usage of register: R5 in 'UnsetPending'
                ;
                ((self.ui).drawTenCostItemIcon).sprite =
                    CRH:GetSprite(
                        ((ConfigData.item)[(self.lotteryData).costId2]).icon) -- DECOMPILER ERROR at PC160: Confused about usage of register: R5 in 'UnsetPending'
                ;
                ((self.ui).img_nextTenCostIcon).sprite =
                    CRH:GetSprite(
                        ((ConfigData.item)[(self.lotteryData).costId2]).icon) -- DECOMPILER ERROR at PC172: Confused about usage of register: R5 in 'UnsetPending'
                ;
                ((self.ui).img_nextOneCosticon).sprite =
                    CRH:GetSprite(
                        ((ConfigData.item)[(self.lotteryData).costId1]).icon)
                self.enableExcuteFree = (self.lotteryData).cd ~= 0
                self:InitCfg()
                self:InitRedDotEvent(lotteryPoolId)
                -- DECOMPILER ERROR: 1 unprocessed JMP targets
            end
        end
    end
end

UILottery.InitCfg = function(self)
    -- function num : 0_5 , upvalues : _ENV
    self.lotteryCfg = (PlayerDataCenter.LotteryCfg)[self.lotteryId]
    self:UpdateExcuteFreeUI()
    if self.enableExcuteFree then
        if self.updateFreeUITimer ~= nil then
            (self.updateFreeUITimer):Stop()
        end
        self.updateFreeUITimer = (TimerManager:GetTimer(1, BindCallback(self,
                                                                        self.UpdateExcuteFreeUI))):Start()
    end
end

UILottery.InitRedDotEvent = function(self, lotteryPoolId)
    -- function num : 0_6 , upvalues : _ENV
    self:RemoveRedDotEvent()
    local ok, lotteryMainNode = RedDotController:GetRedDotNode(
                                    RedDotStaticTypeId.Main,
                                    RedDotStaticTypeId.Lottery, lotteryPoolId)
    if lotteryMainNode:GetRedDotCount() <= 0 then
        ((self.ui).redDotLotteryMain):SetActive(not ok)
        self.__onRedDotMainPoolChanged =
            function(node)
                -- function num : 0_6_0 , upvalues : self
                if node:GetRedDotCount() <= 0 then
                    ((self.ui).redDotLotteryMain):SetActive(
                        node.nodeId ~= self.lotteryId)
                    -- DECOMPILER ERROR: 2 unprocessed JMP targets
                end
            end

        RedDotController:AddListener(RedDotDynPath.LotteryPoolPath,
                                     self.__onRedDotMainPoolChanged)
        local ok, lotteryFreeNode = RedDotController:GetRedDotNode(
                                        RedDotStaticTypeId.Main,
                                        RedDotStaticTypeId.Lottery,
                                        lotteryPoolId,
                                        RedDotStaticTypeId.LotteryFree)
        if lotteryFreeNode:GetRedDotCount() <= 0 then
            ((self.ui).redDotLotteryOnce):SetActive(not ok);
            ((self.ui).redDotLotteryOnce):SetActive(false)
            self.__onRedDotLotteryFreeChanged =
                function(node)
                    -- function num : 0_6_1 , upvalues : self
                    if node:GetRedDotCount() <= 0 then
                        ((self.ui).redDotLotteryOnce):SetActive(
                            node:GetParentNodeId() ~= self.lotteryId)
                        -- DECOMPILER ERROR: 2 unprocessed JMP targets
                    end
                end

            RedDotController:AddListener(RedDotDynPath.LotteryFreePath,
                                         self.__onRedDotLotteryFreeChanged)
            local ok, lotteryTenNode = RedDotController:GetRedDotNode(
                                           RedDotStaticTypeId.Main,
                                           RedDotStaticTypeId.Lottery,
                                           lotteryPoolId,
                                           RedDotStaticTypeId.LotteryTen)
            if lotteryTenNode:GetRedDotCount() <= 0 then
                ((self.ui).redDotLotteryTen):SetActive(not ok);
                ((self.ui).redDotLotteryTen):SetActive(false)
                self.__onRedDotLotteryTenChanged =
                    function(node)
                        -- function num : 0_6_2 , upvalues : self
                        if node:GetRedDotCount() <= 0 then
                            ((self.ui).redDotLotteryTen):SetActive(
                                node:GetParentNodeId() ~= self.lotteryId)
                            -- DECOMPILER ERROR: 2 unprocessed JMP targets
                        end
                    end

                RedDotController:AddListener(RedDotDynPath.LotteryTenPath,
                                             self.__onRedDotLotteryTenChanged)
                -- DECOMPILER ERROR: 8 unprocessed JMP targets
            end
        end
    end
end

UILottery.RemoveRedDotEvent = function(self)
    -- function num : 0_7 , upvalues : _ENV
    RedDotController:RemoveListener(RedDotDynPath.LotteryPoolPath,
                                    self.__onRedDotMainPoolChanged)
    RedDotController:RemoveListener(RedDotDynPath.LotteryFreePath,
                                    self.__onRedDotLotteryFreeChanged)
    RedDotController:RemoveListener(RedDotDynPath.LotteryTenPath,
                                    self.__onRedDotLotteryTenChanged)
end

UILottery.OnClickTypeFirst = function(self, isOn)
    -- function num : 0_8 , upvalues : LotteryEnum
    self:EnterLotteryPool((LotteryEnum.eLotteryPoolType).Main, true)
end

UILottery.OnClickTypeSecond = function(self, isOn)
    -- function num : 0_9 , upvalues : LotteryEnum
    self:EnterLotteryPool((LotteryEnum.eLotteryPoolType).Second, true)
end

UILottery.OnClickDrawOnce = function(self)
    -- function num : 0_10 , upvalues : _ENV, LotteryEnum, cs_MessageCommon
    if self:CheckExpiredAndUpdate() then return end
    local curNum = (PlayerDataCenter.todayLotteryNums)[self.lotteryId] or 0
    if self.lotteryId == (LotteryEnum.eLotteryPoolType).Main and
        self.dailyLotteryLimtNum - curNum < 1 then
        (cs_MessageCommon.ShowMessageTips)(
            ConfigData:GetTipContent(TipContent.lottery_DailyLimtFull))
        return
    end
    local itemCount = PlayerDataCenter:GetItemCount((self.lotteryData).costId1)
    if self.enableExcuteFree and (self.lotteryCfg).NextFreeTime <=
        PlayerDataCenter.timestamp then
        (self.networkCtrl):SendExecuteOnce(self.lotteryId, true, function()
            -- function num : 0_10_0 , upvalues : self, LotteryEnum, _ENV
            -- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

            if self.lotteryId == (LotteryEnum.eLotteryPoolType).Main then
                (PlayerDataCenter.todayLotteryNums)[self.lotteryId] =
                    (PlayerDataCenter.todayLotteryNums)[self.lotteryId] + 1;
                ((self.ui).text_LotteryLimt):SetIndex(0, tostring(
                                                          (PlayerDataCenter.todayLotteryNums)[self.lotteryId]),
                                                      tostring(
                                                          self.dailyLotteryLimtNum))
            end
        end)
    else
        if (self.lotteryData).costNum1 <= itemCount then
            (self.networkCtrl):SendExecuteOnce(self.lotteryId, false, function()
                -- function num : 0_10_1 , upvalues : self, LotteryEnum, _ENV
                -- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

                if self.lotteryId == (LotteryEnum.eLotteryPoolType).Main then
                    (PlayerDataCenter.todayLotteryNums)[self.lotteryId] =
                        (PlayerDataCenter.todayLotteryNums)[self.lotteryId] + 1;
                    ((self.ui).text_LotteryLimt):SetIndex(0, tostring(
                                                              (PlayerDataCenter.todayLotteryNums)[self.lotteryId]),
                                                          tostring(
                                                              self.dailyLotteryLimtNum))
                end
            end)
        else

            (cs_MessageCommon.ShowMessageTips)(
                self.cost1Name ..
                    ConfigData:GetTipContent(TipContent.lottery_ItemInsufficient))
            self:ShowQuickPurchaseBox((self.lotteryData).costId1)
        end
    end
    if itemCount - (self.lotteryData).costNum1 < (self.lotteryData).costNum1 then
        ((self.ui).text_CostNextOne):SetIndex(1, self.cost1Name,
                                              (self.lotteryData).costNum1);
        ((self.ui).drawOnceCost):SetIndex(1, self.cost1Name,
                                          (self.lotteryData).costNum1)
    else

        ((self.ui).text_CostNextOne):SetIndex(0, self.cost1Name,
                                              (self.lotteryData).costNum1);
        ((self.ui).drawOnceCost):SetIndex(0, self.cost1Name,
                                          (self.lotteryData).costNum1)
    end
    ((self.ui).nextOne):SetActive(true);
    ((self.ui).nextTen):SetActive(false)
end

UILottery.OnClickDrawTen = function(self)
    -- function num : 0_11 , upvalues : _ENV, LotteryEnum, cs_MessageCommon
    if self:CheckExpiredAndUpdate() then return end
    local curNum = (PlayerDataCenter.todayLotteryNums)[self.lotteryId] or 0
    if self.lotteryId == (LotteryEnum.eLotteryPoolType).Main and
        (ConfigData.game_config).DailyLotteryLimtNum - curNum < 10 then
        (cs_MessageCommon.ShowMessageTips)(
            ConfigData:GetTipContent(TipContent.lottery_DailyLimtFull))
        return
    end
    local itemCount = PlayerDataCenter:GetItemCount((self.lotteryData).costId2)
    if (self.lotteryData).costNum2 <= itemCount then
        (self.networkCtrl):SendExecuteTen(self.lotteryId, function()
            -- function num : 0_11_0 , upvalues : self, LotteryEnum, _ENV
            -- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

            if self.lotteryId == (LotteryEnum.eLotteryPoolType).Main then
                (PlayerDataCenter.todayLotteryNums)[self.lotteryId] =
                    (PlayerDataCenter.todayLotteryNums)[self.lotteryId] + 10;
                ((self.ui).text_LotteryLimt):SetIndex(0, tostring(
                                                          (PlayerDataCenter.todayLotteryNums)[self.lotteryId]),
                                                      tostring(
                                                          self.dailyLotteryLimtNum))
            end
        end)
    else

        (cs_MessageCommon.ShowMessageTips)(
            self.cost2Name ..
                ConfigData:GetTipContent(TipContent.lottery_ItemInsufficient))
        self:ShowQuickPurchaseBox((self.lotteryData).costId2)
    end
    if itemCount - (self.lotteryData).costNum2 < (self.lotteryData).costNum2 then
        ((self.ui).text_CostNextTen):SetIndex(1, self.cost2Name,
                                              (self.lotteryData).costNum2);
        ((self.ui).drawTenCost):SetIndex(1, self.cost2Name,
                                         (self.lotteryData).costNum2)
    else

        ((self.ui).text_CostNextTen):SetIndex(0, self.cost2Name,
                                              (self.lotteryData).costNum2);
        ((self.ui).drawTenCost):SetIndex(0, self.cost2Name,
                                         (self.lotteryData).costNum2)
    end
    ((self.ui).nextOne):SetActive(false);
    ((self.ui).nextTen):SetActive(true)
end

UILottery.SetCloseCallback = function(self, callback)
    -- function num : 0_12
    self.closeCallback = callback
end

UILottery.OnClickCloseButton = function(self)
    -- function num : 0_13
    self:Delete()
    if self.closeCallback ~= nil then
        (self.closeCallback)()
        self.closeCallback = nil
    end
end

local ShopEnum = require("Game.Shop.ShopEnum")
UILottery.ShowQuickPurchaseBox = function(self, costId)
    -- function num : 0_14 , upvalues : ShopEnum, _ENV
    local quickBuyData = (ShopEnum.eQuickBuy).lottery
    local shopId = quickBuyData.shopId
    local shelfId = quickBuyData.shelfId
    local goodData = nil
    local ctrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
    if not ctrl.isUnlocked then return end
    ctrl:GetShopData(shopId, function(shopData)
        -- function num : 0_14_0 , upvalues : goodData, shelfId, _ENV
        goodData = (shopData.shopGoodsDic)[shelfId]
        UIManager:ShowWindowAsync(UIWindowTypeID.QuickBuy, function(win)
            -- function num : 0_14_0_0 , upvalues : _ENV, goodData
            if win == nil then
                error("can\'t open QuickBuy win")
                return
            end
            win:SlideIn()
            win:InitBuyTarget(goodData, nil)
        end)
    end)
end

UILottery.ShowResult = function(self, elements)
    -- function num : 0_15 , upvalues : UILotteryResultItem, _ENV
    self.flipNum = 0;
    ((self.ui).GameObject_nextDraw):SetActive(false);
    ((self.ui).resultPanel):SetActive(true);
    (self.resultItemPool):HideAll()
    self.isFliping = false
    self.rwList = {}
    local repeatNewHeroTable = {}
    UILotteryResultItem:SetRepeatTable(repeatNewHeroTable)
    for k, v in pairs(elements) do
        self.flipNum = self.flipNum + 1
        local rwsultItem = nil
        rwsultItem = (self.resultItemPool):GetOne()
        rwsultItem:InitLotteryResultItem(v.item, v.num, self.resloader);
        (table.insert)(self.rwList, rwsultItem)
    end
end

UILottery.OnClickCloseResultPanel = function(self)
    -- function num : 0_16
    if self.flipNum > 0 and not self.isFliping then
        self:AutoFlipCards()
        return
    end
    if self.flipNum == 0 then
        self:StopAutoFlipCards()
        self.rwList = nil;
        ((self.ui).resultPanel):SetActive(false)
    end
end

UILottery.AutoFlipCards = function(self)
    -- function num : 0_17 , upvalues : cs_coroutine, _ENV
    if self.isFliping then return end
    self.isFliping = true
    self.Flipcoroutine = (cs_coroutine.start)(
                             function()
            -- function num : 0_17_0 , upvalues : self, _ENV
            while 1 do
                if self.flipNum ~= nil then
                    if self.flipNum > 0 then
                        ((self.rwList)[#self.rwList - self.flipNum + 1]):FlipSelf();
                        (coroutine.yield)(
                            ((CS.UnityEngine).WaitForSeconds)(0.35))
                        -- DECOMPILER ERROR at PC23: LeaveBlock: unexpected jumping out IF_THEN_STMT

                        -- DECOMPILER ERROR at PC23: LeaveBlock: unexpected jumping out IF_STMT

                        -- DECOMPILER ERROR at PC23: LeaveBlock: unexpected jumping out IF_THEN_STMT

                        -- DECOMPILER ERROR at PC23: LeaveBlock: unexpected jumping out IF_STMT

                    end
                end
            end
            if self.flipNum <= 0 then
                ((self.ui).GameObject_nextDraw):SetActive(true)
                for index, value in ipairs(self.rwList) do
                    if value.isFragment then
                        ((value.ui).Obj_ConvertToFragment):SetActive(true)
                    end
                end
            end
            do
                for index, value in ipairs(self.rwList) do
                    value:FlipSelf()
                end
            end
        end)
end

UILottery.StopAutoFlipCards = function(self)
    -- function num : 0_18 , upvalues : cs_coroutine
    (cs_coroutine.stop)(self.Flipcoroutine)
    self.isFliping = false
end

UILottery.UpdateExcuteFreeUI = function(self)
    -- function num : 0_19 , upvalues : _ENV
    if self.enableExcuteFree == false then
        ((self.ui).text_drawOnce):SetIndex(1)
        return
    end
    local currentTime = PlayerDataCenter.timestamp
    if (self.lotteryCfg).NextFreeTime <= currentTime then
        ((self.ui).text_drawOnce):SetIndex(1);
        ((self.ui).drawOnceCost):SetIndex(2)
    else
        if PlayerDataCenter:GetItemCount((self.lotteryData).costId1) <
            (self.lotteryData).costNum1 then
            ((self.ui).drawOnceCost):SetIndex(1, self.cost1Name,
                                              (self.lotteryData).costNum1)
        else

            ((self.ui).drawOnceCost):SetIndex(0, self.cost1Name,
                                              (self.lotteryData).costNum1)
        end
        local remainDuration = TimestampToTime(
                                   (self.lotteryCfg).NextFreeTime - currentTime);
        ((self.ui).text_drawOnce):SetIndex(0, remainDuration)
    end
end

UILottery.__GetTexResult = function(self)
    -- function num : 0_20
    ((self.ui).tex_Results):SetActive(false)
end

UILottery.OnItemUpdateEvent = function(self, itemDic)
    -- function num : 0_21
    self:EnterLotteryPool(self.lotteryId, true)
end

UILottery.CheckExpiredAndUpdate = function(self, isShowMention)
    -- function num : 0_22 , upvalues : _ENV, cs_MessageCommon
    if isShowMention == nil then isShowMention = true end
    do
        if PlayerDataCenter.lotteryRefreshTimes ~= nil then
            local curExpiredTime =
                (PlayerDataCenter.lotteryRefreshTimes)[self.lotteryId]
            if curExpiredTime ~= nil and curExpiredTime > 0 and curExpiredTime <
                PlayerDataCenter.timestamp then
                if isShowMention then
                    (cs_MessageCommon.ShowMessageTips)(
                        ConfigData:GetTipContent(TipContent.ExpiredMention))
                end
                (self.__onExpiredUpdate)()
                return true
            end
        end
        return false
    end
end

UILottery.OnHide = function(self)
    -- function num : 0_23 , upvalues : _ENV, base
    local homeWin = UIManager:GetWindow(UIWindowTypeID.Home)
    if homeWin ~= nil then homeWin:BackFromOtherWin() end
    (base.OnHide)(self)
end

UILottery.OnDelete = function(self)
    -- function num : 0_24 , upvalues : _ENV, base
    MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__onUpdateItemEvent)
    MsgCenter:RemoveListener(eMsgEventId.UIGetHeroClose, self.__AutoFlipCards)
    self:RemoveRedDotEvent()
    if self.resloader ~= nil then
        (self.resloader):Put2Pool()
        self.resloader = nil
    end
    if self.updateFreeUITimer ~= nil then
        (self.updateFreeUITimer):Stop()
        self.updateFreeUITimer = nil
    end
    (base.OnDelete)(self)
end

return UILottery

