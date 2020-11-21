-- params : ...
-- function num : 0 , upvalues : _ENV
local UIAthSortList = class("UIAthSortList", UIBaseNode)
local base = UIBaseNode
local UIAthIconItem = require("Game.Arithmetic.SortList.UIAthIconItem")
local eSortKindType, SortKindFunc, FliterKindFunc =
    (table.unpack)(require("Game.Arithmetic.SortList.AthSortKindHelper"))
UIAthSortList.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
    self.athItemDic = {} -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'
    ;
    ((self.ui).scrollView).onInstantiateItem =
        BindCallback(self, self.__OnNewItem) -- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'
    ;
    ((self.ui).scrollView).onChangeItem =
        BindCallback(self, self.__OnChangeItem)
    self.__selectAthFunc = BindCallback(self, self.OnAthItemClicked)
    self.__onAthDataUpdate = BindCallback(self, self.OnAthDataUpdate);
    (UIUtil.AddButtonListener)((self.ui).btn_AthSortKind, self,
                               self.OnClickSortAndFliter)
    self:__InitSortAndFliterKind()
    self.defaultSort = function(a, b)
        -- function num : 0_0_0 , upvalues : self
        local aBind = a.bindInfo ~= nil
        local bBind = b.bindInfo ~= nil
        local aSpaceOk = a.size <= self.space
        local bSpaceOk = b.size <= self.space
        if aSpaceOk == bSpaceOk then
            if a.quality == b.quality then
                if b:GetAthDensity() >= a:GetAthDensity() then
                    do return aBind ~= bBind end
                    do return b.quality < a.quality end
                    do return aSpaceOk end
                    do return bBind end
                    -- DECOMPILER ERROR: 10 unprocessed JMP targets
                end
            end
        end
    end

    self.inheritSort = function(a, b)
        -- function num : 0_0_1
        local aBind = a.bindInfo ~= nil
        local bBind = b.bindInfo ~= nil
        if aBind == bBind then
            if a.quality == b.quality then
                if b:GetAthDensity() >= a:GetAthDensity() then
                    do return a.lockUnlock ~= b.lockUnlock end
                    do return b.quality < a.quality end
                    do return bBind end
                    do return b.lockUnlock end
                    -- DECOMPILER ERROR: 8 unprocessed JMP targets
                end
            end
        end
    end

end

UIAthSortList.OnShow = function(self)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.OnShow)(self)
    MsgCenter:AddListener(eMsgEventId.OnAthDataUpdate, self.__onAthDataUpdate)
end

UIAthSortList.OnHide = function(self)
    -- function num : 0_2 , upvalues : _ENV
    MsgCenter:RemoveListener(eMsgEventId.OnAthDataUpdate, self.__onAthDataUpdate)
end

UIAthSortList.InitAthSortList = function(self, slotId, space, curSlotAthDataDic)
    -- function num : 0_3
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R4 in 'UnsetPending'

    if ((self.ui).scrollView).horizontal then
        ((self.ui).scrollView).horizontalNormalizedPosition = 1
    end
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R4 in 'UnsetPending'

    if ((self.ui).scrollView).vertical then
        ((self.ui).scrollView).verticalNormalizedPosition = 1
    end
    self.slotId = slotId
    self.space = space
    self:__InitOriginList(slotId)
    self:RefreshAthList(nil, self.defaultSort)
    self.CurAthListBeforeFliter = self.curAthList
    self.selectedSort = nil
    self.selectedFliter = nil
end

UIAthSortList.__InitOriginList = function(self, slotId)
    -- function num : 0_4 , upvalues : _ENV
    self.originAthList = (PlayerDataCenter.allAthData):GetAllAthSlotList(slotId)
    self.selectAth = nil
end

UIAthSortList.RefreshAthList = function(self, funcSift, funcSort, otherAthList)
    -- function num : 0_5 , upvalues : _ENV
    self.curAthList = {}
    local curSelectAth, list = nil, nil
    if otherAthList ~= nil then
        list = otherAthList
    else
        list = self.originAthList
    end
    for k, athData in ipairs(list) do
        if funcSift == nil then
            (table.insert)(self.curAthList, athData)
        else
            if funcSift(athData) then
                (table.insert)(self.curAthList, athData)
            end
        end
        if athData == self.selectAth then curSelectAth = athData end
    end
    if funcSort ~= nil then (table.sort)(self.curAthList, funcSort) end -- DECOMPILER ERROR at PC47: Confused about usage of register: R6 in 'UnsetPending'
    
    ((self.ui).scrollView).totalCount = #self.curAthList;
    ((self.ui).scrollView):RefillCells()
    self:__RefreshSelectAth(curSelectAth)
    self:___RefreshAthUIState(self.curAthList)
    self:RefreshAthCountNum()
end

local eAthUIState = {Default = 1, EquiptoHero = 2, AthCantEqui = 3}
UIAthSortList.___RefreshAthUIState = function(self, curAthList)
    -- function num : 0_6 , upvalues : _ENV, eAthUIState
    local athItem, heroData = nil, nil
    for k, athData in ipairs(curAthList) do
        athItem = self:__GetAthItemByData(athData)
        athData.AthUIState = eAthUIState.Default
        if athData.bindInfo ~= nil then
            athData.AthUIState = eAthUIState.EquiptoHero
        else
            if self.space ~= nil and self.space < athData.size then
                athData.AthUIState = eAthUIState.AthCantEqui
            end
        end
        if athItem ~= nil then
            athItem:AthDefaultState()
            if athData.bindInfo ~= nil then
                heroData = (PlayerDataCenter.heroDic)[(athData.bindInfo).id]
                athItem:AthEquipToHero((heroData.heroCfg).name)
            else
                if self.space ~= nil and self.space < athData.size then
                    athItem:AthCantEquip()
                end
            end
        end
    end
end

UIAthSortList.__RefreshSelectAth = function(self, athData)
    -- function num : 0_7
    do
        if self.selectAth ~= nil then
            local lastAthItem = self:__GetAthItemByData(athData)
            if lastAthItem ~= nil then lastAthItem:SelectAth(false) end
            self.selectAth = nil
        end
        if athData ~= nil then
            local athItem = self:__GetAthItemByData(athData)
            if athItem ~= nil then athItem:SelectAth(true) end
            self.selectAth = athData
        end
    end
end

UIAthSortList.SetClickSortAthEvent = function(self, event)
    -- function num : 0_8
    self.clickAthEvent = event
end

UIAthSortList.OnAthItemClicked = function(self, athData)
    -- function num : 0_9
    if self.clickAthEvent ~= nil then (self.clickAthEvent)(athData) end
    self.selectAth = athData
end

UIAthSortList.OnAthDataUpdate = function(self)
    -- function num : 0_10 , upvalues : _ENV
    self.originAthList = (PlayerDataCenter.allAthData):GetAllAthSlotList(
                             self.slotId)
    self:RefreshAthList(nil, self.defaultSort)
    if self.selectedSort ~= nil then
        self.CurAthListBeforeFliter = self.curAthList
        self:RefreshAthList(self.selectedFliter, self.selectedSort,
                            self.CurAthListBeforeFliter)
    end
end

UIAthSortList.__OnNewItem = function(self, go)
    -- function num : 0_11 , upvalues : UIAthIconItem
    local athItem = (UIAthIconItem.New)()
    athItem:Init(go) -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'
    ;
    (self.athItemDic)[go] = athItem
end

UIAthSortList.__OnChangeItem = function(self, go, index)
    -- function num : 0_12 , upvalues : _ENV, eAthUIState
    local athItem = (self.athItemDic)[go]
    if athItem == nil then
        error("Can\'t find athItem by gameObject")
        return
    end
    local athData = (self.curAthList)[index + 1]
    if athData == nil then
        error("Can\'t find athData by index, index = " .. tonumber(index))
    end
    athItem:InitAthIconItem(athData, self.__selectAthFunc)
    if athData.AthUIState ~= nil then
        athItem:AthDefaultState()
        -- DECOMPILER ERROR at PC41: Unhandled construct in 'MakeBoolean' P1

        if athData.AthUIState == eAthUIState.EquiptoHero and athData.bindInfo ~=
            nil then
            local heroData = (PlayerDataCenter.heroDic)[(athData.bindInfo).id]
            athItem:AthEquipToHero((heroData.heroCfg).name)
        end
    end
    do
        if athData.AthUIState == eAthUIState.AthCantEqui then
            athItem:AthCantEquip()
        end
        local isSelect = self.selectAth == athData
        athItem:SelectAth(isSelect)
        -- DECOMPILER ERROR: 1 unprocessed JMP targets
    end
end

UIAthSortList.__GetAthItemByData = function(self, athData)
    -- function num : 0_13 , upvalues : _ENV
    for k, v in ipairs(self.curAthList) do
        if v == athData then
            local index = k - 1
            return self:__GetAthItemGoByIndex(index)
        end
    end
end

UIAthSortList.__GetAthItemGoByIndex = function(self, index)
    -- function num : 0_14
    if (((self.ui).scrollView).content).childCount <= index then return nil end
    local go = ((self.ui).scrollView):GetCellByIndex(index)
    do
        if go ~= nil then
            local athItem = (self.athItemDic)[go]
            return athItem
        end
        return nil
    end
end

UIAthSortList.RefreshAthCountNum = function(self)
    -- function num : 0_15 , upvalues : _ENV
    ((self.ui).tex_AthCount):SetIndex(0, tostring(
                                          #(PlayerDataCenter.allAthData):GetAllAthList()),
                                      (ConfigData.game_config).athMaxNum)
end

UIAthSortList.OnClickSortAndFliter = function(self)
    -- function num : 0_16
    local isActive = ((self.ui).obj_mannerNode).activeSelf
    if isActive then
        ((self.ui).obj_mannerNode):SetActive(false)
    else

        ((self.ui).obj_mannerNode):SetActive(true)
    end
end

UIAthSortList.__InitSortAndFliterKind = function(self)
    -- function num : 0_17 , upvalues : _ENV, eSortKindType, SortKindFunc, FliterKindFunc
    ((self.ui).obj_manner_Item):SetActive(false)
    self.CurAthListBeforeFliter = self.curAthList
    for index = 1, (table.count)(eSortKindType) do
        do
            do
                if index == eSortKindType.mainAttr then
                    for key, value in pairs(ConfigData.attribute) do
                        do
                            if value.algor_main_attribute == 1 then
                                local go =
                                    ((self.ui).obj_manner_Item):Instantiate()
                                go:SetActive(true)
                                local btn =
                                    (go.transform):FindComponent("",
                                                                 eUnityComponentID.Button)
                                local texName =
                                    (go.transform):FindComponent("Tex_Name",
                                                                 eUnityComponentID.Text)
                                texName.text =
                                    (LanguageUtil.GetLocaleText)(value.name);
                                (btn.onClick):AddListener(
                                    function()
                                        -- function num : 0_17_0 , upvalues : self, SortKindFunc, index, value, FliterKindFunc, texName
                                        if SortKindFunc[index] then
                                            self.selectedSort =
                                                (SortKindFunc[index])(self,
                                                                      value.id)
                                            if FliterKindFunc[index] then
                                                self.selectedFliter =
                                                    (FliterKindFunc[index])(
                                                        value.id)
                                                self:RefreshAthList(
                                                    self.selectedFliter,
                                                    self.selectedSort,
                                                    self.CurAthListBeforeFliter) -- DECOMPILER ERROR at PC28: Confused about usage of register: R0 in 'UnsetPending'
                                                ;
                                                ((self.ui).tex_manner_info).text =
                                                    texName.text
                                                self:OnClickSortAndFliter()
                                            end
                                        end
                                    end)
                            end
                        end
                    end
                else
                    do
                        local go = nil;
                        (((self.ui).obj_manner_Item):Instantiate()):SetActive(go)
                        -- DECOMPILER ERROR at PC67: Overwrote pending register: R8 in 'AssignReg'

                        local texNameInfo = nil
                        -- DECOMPILER ERROR at PC72: Overwrote pending register: R8 in 'AssignReg'

                        local texNameText = nil
                        -- DECOMPILER ERROR at PC77: Overwrote pending register: R8 in 'AssignReg'

                        -- DECOMPILER ERROR at PC78: Overwrote pending register: R9 in 'AssignReg'

                        -- DECOMPILER ERROR at PC78: Overwrote pending register: R8 in 'AssignReg'

                        local btn = nil
                        -- DECOMPILER ERROR at PC83: Overwrote pending register: R10 in 'AssignReg'

                        -- DECOMPILER ERROR at PC83: Overwrote pending register: R9 in 'AssignReg'

                        texNameInfo(texNameText, btn)
                        -- DECOMPILER ERROR at PC88: Overwrote pending register: R9 in 'AssignReg'

                        -- DECOMPILER ERROR at PC89: Overwrote pending register: R9 in 'AssignReg'

                        -- DECOMPILER ERROR at PC90: Overwrote pending register: R10 in 'AssignReg'

                        if index == 1 then
                            texNameInfo.text = texNameText
                        end
                        -- DECOMPILER ERROR at PC92: Overwrote pending register: R9 in 'AssignReg'

                        -- DECOMPILER ERROR at PC93: Overwrote pending register: R10 in 'AssignReg'

                        -- DECOMPILER ERROR at PC93: Overwrote pending register: R9 in 'AssignReg'

                        -- DECOMPILER ERROR at PC94: Overwrote pending register: R11 in 'AssignReg'

                        texNameInfo(texNameText, btn)
                    end
                end
                -- DECOMPILER ERROR at PC98: LeaveBlock: unexpected jumping out DO_STMT

            end
        end
    end
end

UIAthSortList.OnDelete = function(self)
    -- function num : 0_18 , upvalues : base
    (base.OnDelete)(self)
end

UIAthSortList.InitForInherit = function(self, selectData)
    -- function num : 0_19 , upvalues : _ENV
    MsgCenter:RemoveListener(eMsgEventId.OnAthDataUpdate, self.__onAthDataUpdate)
    self.__onAthDataUpdate = BindCallback(self, self.OnAthDataUpdateForInherit)
    MsgCenter:AddListener(eMsgEventId.OnAthDataUpdate, self.__onAthDataUpdate)
    -- DECOMPILER ERROR at PC24: Confused about usage of register: R2 in 'UnsetPending'

    if ((self.ui).scrollView).horizontal then
        ((self.ui).scrollView).horizontalNormalizedPosition = 1
    end
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R2 in 'UnsetPending'

    if ((self.ui).scrollView).vertical then
        ((self.ui).scrollView).verticalNormalizedPosition = 1
    end
    self.slotId = selectData.area_type
    self:__InitOriginList(self.slotId)
    self.selectAth = selectData
    self:RefreshAthList(function(athDta)
        -- function num : 0_19_0 , upvalues : self
        do
            return athDta.id == (self.selectAth).id and athDta ~= self.selectAth
        end
        -- DECOMPILER ERROR: 1 unprocessed JMP targets
    end, self.inheritSort)
    self:__InitSortAndFliterKind()
    self.selectedSort = nil
    self.selectedFliter = nil
end

UIAthSortList.OnAthDataUpdateForInherit =
    function(self)
        -- function num : 0_20 , upvalues : _ENV
        self.originAthList = (PlayerDataCenter.allAthData):GetAllAthSlotList(
                                 self.slotId)
        self:RefreshAthList(function(athDta)
            -- function num : 0_20_0 , upvalues : self
            do
                return athDta.id == (self.selectAth).id and athDta ~=
                           self.selectAth
            end
            -- DECOMPILER ERROR: 1 unprocessed JMP targets
        end, self.inheritSort)
    end

return UIAthSortList

