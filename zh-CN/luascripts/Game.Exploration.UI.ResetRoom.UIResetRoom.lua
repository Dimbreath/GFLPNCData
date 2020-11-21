-- params : ...
-- function num : 0 , upvalues : _ENV
local UIResetRoom = class("UIResetRoom", UIBaseWindow)
local base = UIBaseWindow
local UIResetRoomButton = require(
                              "Game.Exploration.UI.ResetRoom.UIResetRoomButton")
local UIResetRoomChip = require("Game.Exploration.UI.ResetRoom.UIResetRoomChip")
local cs_MessageCommon = CS.MessageCommon
local cs_ExplorationManager = (CS.ExplorationManager).Instance
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
UIResetRoom.OnInit = function(self)
    -- function num : 0_0
    self:__InitData()
    self:__InitUi()
end

UIResetRoom.__InitData = function(self)
    -- function num : 0_1 , upvalues : _ENV, UIResetRoomButton, UIResetRoomChip
    self.rewardGlobalChip = {}
    self.poolButtonItem = (UIItemPool.New)(UIResetRoomButton,
                                           (self.ui).btn_Operation)
    self.poolChipItem = (UIItemPool.New)(UIResetRoomChip, (self.ui).chipItem)
    self.selectChipItemArr = {}
end

UIResetRoom.__InitUi = function(self)
    -- function num : 0_2 , upvalues : _ENV
    (((self.ui).btn_Operation).gameObject):SetActive(false);
    ((self.ui).chipItem):SetActive(false)
    self.currBtnItems = {};
    (UIUtil.AddButtonListener)((self.ui).btn_Return, self, self.OnReturnClick);
    (UIUtil.AddButtonListener)((self.ui).btn_GiveUp, self, self.OnGiveUpClick);
    (UIUtil.AddButtonListener)((self.ui).btn_Confirm, self, self.OnComfirmClick)
    self.__onOperationButtonClick = BindCallback(self,
                                                 self.OnOperationButtonClick)
end

UIResetRoom.InitResetRoom = function(self, ctrl, resetRoomDataList)
    -- function num : 0_3 , upvalues : _ENV
    self.ctrl = ctrl
    self.dynPlayer = ExplorationManager:GetDynPlayer();
    (self.poolButtonItem):HideAll()
    local buttonItem = nil
    for id, resetRoomData in ipairs(resetRoomDataList) do
        buttonItem = (self.currBtnItems)[id]
        if buttonItem == nil then
            buttonItem = (self.poolButtonItem):GetOne() -- DECOMPILER ERROR at PC22: Confused about usage of register: R9 in 'UnsetPending'
            ;
            (self.currBtnItems)[id] = buttonItem
        end
        buttonItem:InitOperationButton(id, resetRoomData,
                                       self.__onOperationButtonClick);
        (buttonItem.gameObject):SetActive(true)
    end
end

UIResetRoom.UpdateMoney = function(self, money)
    -- function num : 0_4 , upvalues : _ENV
    ((self.ui).tex_MoneyCount):SetIndex(0, tostring(money))
end

UIResetRoom.OnOperationButtonClick = function(self, buttonItem)
    -- function num : 0_5 , upvalues : cs_MessageCommon, _ENV, ExplorationEnum
    if buttonItem == nil then return end
    if (self.dynPlayer):GetMoneyCount() < buttonItem.price then
        (cs_MessageCommon.ShowMessageTips)(
            ConfigData:GetTipContent(
                TipContent.exploration_Reconstitution_MoneyInsufficient))
        return
    end
    self.btnInfo = {} -- DECOMPILER ERROR at PC21: Confused about usage of register: R2 in 'UnsetPending'
    ;
    (self.btnInfo).currBtnId = buttonItem.id
    -- DECOMPILER ERROR at PC31: Confused about usage of register: R2 in 'UnsetPending'

    if buttonItem.id == (ExplorationEnum.eResetRoomType).Mix then
        (self.btnInfo).selectCount =
            (ConfigData.game_config).ExplorationResetRoomMixValue
    else
        -- DECOMPILER ERROR at PC34: Confused about usage of register: R2 in 'UnsetPending'


        (self.btnInfo).selectCount = 1
    end -- DECOMPILER ERROR at PC36: Confused about usage of register: R2 in 'UnsetPending'
    
    (self.btnInfo).clickCount = 0
    self:LoadGlobalChip()
    self:__SetSubPageActive(true)
end

UIResetRoom.LoadGlobalChip = function(self)
    -- function num : 0_6 , upvalues : _ENV, UIResetRoomChip
    if #(self.ctrl).playerChipDatas <= 0 or (self.ctrl).playerChipDatas == nil then
        return
    end
    if self.currChipItemDic ~= nil then
        for key, item in pairs(self.currChipItemDic) do item:Delete() end
    end
    do
        self.currChipItemDic = {}
        local chipItem = nil
        for key, chipData in ipairs((self.ctrl).playerChipDatas) do
            chipItem = (self.currChipItemDic)[key]
            if chipItem == nil then
                chipItem = (UIResetRoomChip.New)()
                local go = ((self.ui).chipItem):Instantiate()
                go:SetActive(true)
                chipItem:Init(go) -- DECOMPILER ERROR at PC47: Confused about usage of register: R8 in 'UnsetPending'
                ;
                (self.currChipItemDic)[key] = chipItem
            end
            do
                do

                    (chipItem.gameObject):SetActive(true)
                    chipItem:InitChipItem(chipData, chipData:GetCount(),
                                          BindCallback(self,
                                                       self.OnChipItemClick))
                    -- DECOMPILER ERROR at PC61: LeaveBlock: unexpected jumping out DO_STMT

                end
            end
        end
        self:__SortChip(self.currChipItemDic)
    end
end

UIResetRoom.OnChipItemClick = function(self, chipItem)
    -- function num : 0_7 , upvalues : cs_MessageCommon, _ENV, ExplorationEnum
    if (self.btnInfo).selectCount <= (self.btnInfo).clickCount then
        (cs_MessageCommon.ShowMessageTips)(
            ConfigData:GetTipContent(
                TipContent.exploration_Reconstitution_SelectCountReachMax) ..
                (self.btnInfo).selectCount)
        return
    end
    if chipItem:CanSelect() then
        self:__SelectChip(chipItem)
        if (self.btnInfo).currBtnId == (ExplorationEnum.eResetRoomType).Mix then
            self:__UpdateChipItemDic((chipItem.chipData):GetQuality())
        else
            self:__UpdateChipItemDic(nil)
        end
        chipItem:UpdateCountUI((self.btnInfo).clickCount)
    end
    if (self.btnInfo).clickCount == (self.btnInfo).selectCount then
        (((self.ui).btn_Confirm).gameObject):SetActive(true)
    else

        (((self.ui).btn_Confirm).gameObject):SetActive(false)
    end
end

UIResetRoom.__SelectChip = function(self, chipItem, selectCount)
    -- function num : 0_8 , upvalues : UIResetRoomChip, _ENV
    -- DECOMPILER ERROR at PC4: Confused about usage of register: R3 in 'UnsetPending'

    (self.btnInfo).clickCount = (self.btnInfo).clickCount + 1
    local selectItem = nil
    selectItem = (UIResetRoomChip.New)()
    local go = ((self.ui).chipItem):Instantiate()
    go:SetActive(true)
    selectItem:Init(go);
    (selectItem.transform):SetParent((self.ui).selectContent)
    selectItem:InitChipItem(chipItem.chipData, 1, nil);
    (table.insert)(self.selectChipItemArr, selectItem)
end

UIResetRoom.__UpdateChipItemDic = function(self, quality)
    -- function num : 0_9 , upvalues : _ENV
    for dataId, item in pairs(self.currChipItemDic) do
        if quality == nil or (item.chipData):GetQuality() ~= quality then
            item:OnSelectUI(true) -- DECOMPILER ERROR at PC16: Confused about usage of register: R7 in 'UnsetPending'
            ;
            ((item.ui).btn_Item).enabled = false
        end
    end
end

UIResetRoom.OnComfirmClick = function(self)
    -- function num : 0_10 , upvalues : cs_MessageCommon, _ENV
    if self.btnInfo == nil then return end
    self.selectChipItemList = {}
    local selectCount = #self.selectChipItemArr
    if selectCount < (self.btnInfo).selectCount then
        (cs_MessageCommon.ShowMessageTips)(
            ConfigData:GetTipContent(
                TipContent.exploration_Reconstitution_NotSelectEnourhChip) ..
                selectCount)
        return
    end
    (self.ctrl):SendInfomationOperation(self.btnInfo, self.selectChipItemArr)
    self:OnReturnClick()
end

UIResetRoom.OnReturnClick = function(self)
    -- function num : 0_11
    (((self.ui).btn_Confirm).gameObject):SetActive(false)
    self:__SetSubPageActive(false)
    self:__ClearSelectChipData()
end

UIResetRoom.__ClearSelectChipData = function(self)
    -- function num : 0_12 , upvalues : _ENV
    if self.selectChipItemArr ~= nil then
        for _, v in ipairs(self.selectChipItemArr) do v:Delete() end
        self.selectChipItemArr = {}
    end
end

UIResetRoom.OnGiveUpClick = function(self)
    -- function num : 0_13
    (self.ctrl):SendResetRoomQuit()
end

UIResetRoom.CloseResetRoom = function(self)
    -- function num : 0_14
    self:Delete()
end

UIResetRoom.__SetSubPageActive = function(self, active)
    -- function num : 0_15
    (((self.ui).btn_GiveUp).gameObject):SetActive(not active);
    ((self.ui).ControlNode):SetActive(not active);
    ((self.ui).UserChipNode):SetActive(active);
    ((self.ui).SelectChipNode):SetActive(active);
    (((self.ui).btn_Return).gameObject):SetActive(active)
end

UIResetRoom.__SortChip = function(self, datas)
    -- function num : 0_16 , upvalues : _ENV
    local tab = {}
    for key, value in pairs(datas) do (table.insert)(tab, value) end
    (table.sort)(tab, function(chip1, chip2)
        -- function num : 0_16_0
        local quality1 = (chip1.chipData):GetQuality()
        local quality2 = (chip2.chipData):GetQuality()
        local id1 = (chip1.chipData).dataId
        local id2 = (chip2.chipData).dataId
        if id1 >= id2 then
            do return quality1 ~= quality2 end
            do return quality2 < quality1 end
            -- DECOMPILER ERROR: 4 unprocessed JMP targets
        end
    end)
    for _, value in ipairs(tab) do (value.transform):SetAsLastSibling() end
end

UIResetRoom.OnDelete = function(self)
    -- function num : 0_17 , upvalues : _ENV, base
    self.currBtuttons = nil
    if self.currChipItemDic ~= nil then
        for _, v in pairs(self.currChipItemDic) do v:OnDelete() end
        self.currChipItemDic = nil
    end
    (base.OnDelete)(self)
end

return UIResetRoom

