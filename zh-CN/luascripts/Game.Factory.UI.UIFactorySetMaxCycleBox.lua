-- params : ...
-- function num : 0 , upvalues : _ENV
local UIFactorySetMaxCycleBox = class("UIFactorySetMaxCycleBox", UIBaseNode)
local UINFactoryLineItem = require("Game.Factory.UI.UINFactoryLineItem")
UIFactorySetMaxCycleBox.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddButtonListener)((self.ui).btn_Confirm, self,
                               self.OnBtnConfirmClick);
    (UIUtil.AddButtonListener)((self.ui).btn_Cancel, self, self.OnBtnCancelClick);
    (UIUtil.AddValueChangedListener)((self.ui).slider, self,
                                     self.OnSliderValueChange)
end

local OneCycleTime = 60
UIFactorySetMaxCycleBox.InitSetMaxCycleBox =
    function(self, uiParent)
        -- function num : 0_1
        self.uiParent = uiParent
        self.produceItem = nil
        self.consumeItems = {};
        ((self.ui).resItem):SetActive(false)
        self:Hide()
    end

UIFactorySetMaxCycleBox.ShowSetMaxCycleBox =
    function(self, lineItem)
        -- function num : 0_2 , upvalues : _ENV
        self.lineItem = lineItem
        self.cycle = ((self.lineItem).factoryCfg).cycle -- DECOMPILER ERROR at PC12: Confused about usage of register: R2 in 'UnsetPending'
        ;
        ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(
                                        (lineItem.factoryCfg).name)
        self:InitProduce(lineItem.factoryCfg)
        self:InitConsume(lineItem.factoryCfg) -- DECOMPILER ERROR at PC21: Confused about usage of register: R2 in 'UnsetPending'
        ;
        ((self.ui).slider).value = 1
        self:OnSliderValueChange(1)
        self:Show()
    end

UIFactorySetMaxCycleBox.InitProduce = function(self, factoryCfg)
    -- function num : 0_3 , upvalues : _ENV, UINFactoryLineItem
    local productId = factoryCfg.productId
    local productNum = factoryCfg.productNum
    local itemCfg = (ConfigData.item)[productId]
    if itemCfg == nil then
        error("factory line Item Cfg is null,ItemId:" .. tostring(productId))
        return
    end
    self.produceItem = (UINFactoryLineItem.New)();
    (self.produceItem):Init((self.ui).finalItem);
    (self.produceItem):InitLineItem(itemCfg, productNum, true)
end

UIFactorySetMaxCycleBox.InitConsume = function(self, factoryCfg)
    -- function num : 0_4 , upvalues : _ENV, UINFactoryLineItem
    local consumeItemList = {}
    local lastItem = nil
    for k, v in ipairs(self.consumeItems) do
        (v.gameObject):SetActive(false)
        v:SetSignActive(true)
    end
    for k, consumeId in ipairs(factoryCfg.consumeIds) do
        local consumeNum = (factoryCfg.consumeNums)[k] * factoryCfg.cycle
        local itemCfg = (ConfigData.item)[consumeId]
        if itemCfg == nil then
            error("factory line Item Cfg is null,ItemId:" .. tostring(consumeId))
        else
            local consumeItem = (table.remove)(self.consumeItems,
                                               #self.consumeItems)
            do
                do
                    if consumeItem == nil then
                        local go = ((self.ui).resItem):Instantiate()
                        consumeItem = (UINFactoryLineItem.New)()
                        consumeItem:Init(go)
                    end
                    (consumeItem.gameObject):SetActive(true)
                    consumeItem:InitLineItem(itemCfg, consumeNum, false);
                    (table.insert)(consumeItemList, consumeItem)
                    lastItem = consumeItem
                    -- DECOMPILER ERROR at PC69: LeaveBlock: unexpected jumping out DO_STMT

                    -- DECOMPILER ERROR at PC69: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                    -- DECOMPILER ERROR at PC69: LeaveBlock: unexpected jumping out IF_STMT

                end
            end
        end
    end
    if lastItem ~= nil then lastItem:SetSignActive(false) end
    if #consumeItemList > 0 then
        for i = 1, #consumeItemList do
            local item = (table.remove)(consumeItemList, #consumeItemList);
            (table.insert)(self.consumeItems, item)
        end
    end
end

local cycleData = {}
UIFactorySetMaxCycleBox.OnSliderValueChange =
    function(self, value)
        -- function num : 0_5 , upvalues : _ENV, cycleData, OneCycleTime
        if value <= (ConfigData.game_config).factoryLineMaxCycle then
            cycleData.setCycle = value
            cycleData.setCycleTime = OneCycleTime * self.cycle * value
        else
            cycleData.setCycle = 0
        end
        self:ShowInfomation(cycleData)
    end

UIFactorySetMaxCycleBox.ShowInfomation =
    function(self, cycleData)
        -- function num : 0_6 , upvalues : _ENV
        if cycleData.setCycle ~= 0 and cycleData.setCycleTime ~= nil then
            local time = TimestampToTime((math.floor)(cycleData.setCycleTime));
            ((self.ui).tex_Info):SetIndex(0, tostring(
                                              (math.floor)(cycleData.setCycle)),
                                          time)
        else
            do

                ((self.ui).tex_Info):SetIndex(1)
            end
        end
    end

UIFactorySetMaxCycleBox.OnBtnConfirmClick =
    function(self)
        -- function num : 0_7 , upvalues : cycleData
        if cycleData.setCycle ~= nil then
            (self.uiParent):RequestAddOneFactoryLine(self.lineItem,
                                                     cycleData.setCycle)
            self:Hide()
        end
    end

UIFactorySetMaxCycleBox.OnBtnCancelClick =
    function(self)
        -- function num : 0_8
        self:Hide()
    end

return UIFactorySetMaxCycleBox

