-- params : ...
-- function num : 0 , upvalues : _ENV
local UIAthMultSortList = class("UIAthMultSortList", UIBaseNode)
local base = UIBaseNode
local UIAthIconItem = require("Game.Arithmetic.SortList.UIAthIconItem")
local eSortKindType, SortKindFunc, FliterKindFunc =
    (table.unpack)(require("Game.Arithmetic.SortList.AthSortKindHelper"))
UIAthMultSortList.OnInit = function(self)
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

UIAthMultSortList.OnShow = function(self)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.OnShow)(self)
    MsgCenter:AddListener(eMsgEventId.OnAthDataUpdate, self.__onAthDataUpdate)
end

UIAthMultSortList.OnHide = function(self)
    -- function num : 0_2 , upvalues : _ENV
    MsgCenter:RemoveListener(eMsgEventId.OnAthDataUpdate, self.__onAthDataUpdate)
end

UIAthMultSortList.InitAthSortList = function(self, slotId, space,
                                             curSlotAthDataDic)
    -- function num : 0_3
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R4 in 'UnsetPending'

    if ((self.ui).scrollView).horizontal then
        ((self.ui).scrollView).horizontalNormalizedPosition = 1
    end
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R4 in 'UnsetPending'

    if ((self.ui).scrollView).vertical then
        ((self.ui).scrollView).verticalNormalizedPosition = 1
    end
    if slotId == nil and space == nil then
        self:__InitOriginList()
        self:RefreshAthList(function(athData)
            -- function num : 0_3_0
            if athData.lockUnlock or athData.bindInfo ~= nil then
                return false
            end
            return true
        end, function(a, b)
            -- function num : 0_3_1
            do return b.quality < a.quality end
            -- DECOMPILER ERROR: 1 unprocessed JMP targets
        end);
        ((self.ui).fliterNode):SetActive(false);
        ((self.ui).decompose):SetActive(true)
    else
        self.slotId = slotId
        self.space = space
        self:__InitOriginList(slotId)
        local funcSift = function(athData)
            -- function num : 0_3_2 , upvalues : curSlotAthDataDic
            if curSlotAthDataDic == nil then return true end
            do return curSlotAthDataDic[athData.uid] == nil end
            -- DECOMPILER ERROR: 1 unprocessed JMP targets
        end

        self:RefreshAthList(funcSift, self.defaultSort)
    end
    do
        self.CurAthListBeforeFliter = self.curAthList
        self.selectedSort = nil
        self.selectedFliter = nil
    end
end

UIAthMultSortList.__InitOriginList = function(self, slotId)
    -- function num : 0_4 , upvalues : _ENV
    if slotId == nil then
        self.originAthList = (PlayerDataCenter.allAthData):GetAllAthList()
    else
        self.originAthList = (PlayerDataCenter.allAthData):GetAllAthSlotList(
                                 slotId)
    end
    self.multSelectAth = {}
end

UIAthMultSortList.RefreshAthList = function(self, funcSift, funcSort,
                                            otherAthList)
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
    end
    if funcSort ~= nil then (table.sort)(self.curAthList, funcSort) end -- DECOMPILER ERROR at PC43: Confused about usage of register: R6 in 'UnsetPending'
    
    ((self.ui).scrollView).totalCount = #self.curAthList;
    ((self.ui).scrollView):RefillCells()
    self:RefreshAthCountNum()
end

UIAthMultSortList.RefreshSelectAth = function(self)
    -- function num : 0_6 , upvalues : _ENV
    for index, athData in ipairs(self.curAthList) do
        local athItem = nil
        if index <= (((self.ui).scrollView).content).childCount then
            athItem = self:__GetAthItemGoByIndex(index - 1)
        else
            return
        end
        -- DECOMPILER ERROR at PC28: Unhandled construct in 'MakeBoolean' P1

        if (table.contain)(self.multSelectAth, athData.uid) and athItem ~= nil then
            athItem:SelectAth(true)
        end
        if athItem ~= nil then athItem:SelectAth(false) end
    end
end

UIAthMultSortList.SetClickSortAthEvent =
    function(self, event)
        -- function num : 0_7
        self.clickAthEvent = event
    end

UIAthMultSortList.OnAthItemClicked = function(self, athData)
    -- function num : 0_8
    if self.clickAthEvent ~= nil then (self.clickAthEvent)(athData) end
end

UIAthMultSortList.isSelected = function(self, athData)
    -- function num : 0_9 , upvalues : _ENV
    return (table.contain)(self.multSelectAth, athData.uid)
end

UIAthMultSortList.setSelected = function(self, athData, bool)
    -- function num : 0_10 , upvalues : _ENV
    if bool and not (table.contain)(self.multSelectAth, athData.uid) then
        (table.insert)(self.multSelectAth, athData.uid)
    end
    if (table.contain)(self.multSelectAth, athData.uid) then
        (table.removebyvalue)(self.multSelectAth, athData.uid)
    end
end

UIAthMultSortList.OnAthDataUpdate = function(self)
    -- function num : 0_11 , upvalues : _ENV
    self.originAthList = (PlayerDataCenter.allAthData):GetAllAthSlotList(
                             self.slotId)
    self:RefreshAthList(function(athData)
        -- function num : 0_11_0
        if athData.lockUnlock or athData.bindInfo ~= nil then
            return false
        end
    end, function(a, b)
        -- function num : 0_11_1
        do return b.quality < a.quality end
        -- DECOMPILER ERROR: 1 unprocessed JMP targets
    end)
    if self.selectedSort ~= nil then
        self.CurAthListBeforeFliter = self.curAthList
        self:RefreshAthList(self.selectedFliter, self.selectedSort,
                            self.CurAthListBeforeFliter)
    end
    return
end

UIAthMultSortList.__OnNewItem = function(self, go)
    -- function num : 0_12 , upvalues : UIAthIconItem
    local athItem = (UIAthIconItem.New)()
    athItem:Init(go) -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'
    ;
    (self.athItemDic)[go] = athItem
end

UIAthMultSortList.__OnChangeItem = function(self, go, index)
    -- function num : 0_13 , upvalues : _ENV
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
    if (table.contain)(self.multSelectAth, athData.uid) then
        athItem:SelectAth(true)
    else
        athItem:SelectAth(false)
    end
end

UIAthMultSortList.__GetAthItemByData = function(self, athData)
    -- function num : 0_14 , upvalues : _ENV
    for k, v in ipairs(self.curAthList) do
        if v == athData then
            local index = k - 1
            return self:__GetAthItemGoByIndex(index)
        end
    end
end

UIAthMultSortList.__GetAthItemGoByIndex =
    function(self, index)
        -- function num : 0_15
        local go = ((self.ui).scrollView):GetCellByIndex(index)
        do
            if go ~= nil then
                local athItem = (self.athItemDic)[go]
                return athItem
            end
            return nil
        end
    end

UIAthMultSortList.RefreshAthCountNum = function(self)
    -- function num : 0_16 , upvalues : _ENV
    ((self.ui).tex_AthCount):SetIndex(0, tostring(
                                          #(PlayerDataCenter.allAthData):GetAllAthList()),
                                      (ConfigData.game_config).athMaxNum)
end

UIAthMultSortList.OnClickSortAndFliter =
    function(self)
        -- function num : 0_17
        local isActive = ((self.ui).obj_mannerNode).activeSelf
        if isActive then
            ((self.ui).obj_mannerNode):SetActive(false)
        else

            ((self.ui).obj_mannerNode):SetActive(true)
        end
    end

UIAthMultSortList.__InitSortAndFliterKind =
    function(self)
        -- function num : 0_18 , upvalues : _ENV, eSortKindType, SortKindFunc, FliterKindFunc
        ((self.ui).obj_manner_Item):SetActive(false)
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
                                            -- function num : 0_18_0 , upvalues : self, SortKindFunc, index, value, FliterKindFunc, texName
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
                            (((self.ui).obj_manner_Item):Instantiate()):SetActive(
                                go)
                            -- DECOMPILER ERROR at PC65: Overwrote pending register: R8 in 'AssignReg'

                            local texNameInfo = nil
                            -- DECOMPILER ERROR at PC70: Overwrote pending register: R8 in 'AssignReg'

                            local texNameText = nil
                            -- DECOMPILER ERROR at PC75: Overwrote pending register: R8 in 'AssignReg'

                            -- DECOMPILER ERROR at PC76: Overwrote pending register: R9 in 'AssignReg'

                            -- DECOMPILER ERROR at PC76: Overwrote pending register: R8 in 'AssignReg'

                            local btn = nil
                            -- DECOMPILER ERROR at PC81: Overwrote pending register: R10 in 'AssignReg'

                            -- DECOMPILER ERROR at PC81: Overwrote pending register: R9 in 'AssignReg'

                            texNameInfo(texNameText, btn)
                            -- DECOMPILER ERROR at PC86: Overwrote pending register: R9 in 'AssignReg'

                            -- DECOMPILER ERROR at PC87: Overwrote pending register: R9 in 'AssignReg'

                            -- DECOMPILER ERROR at PC88: Overwrote pending register: R10 in 'AssignReg'

                            if index == 1 then
                                texNameInfo.text = texNameText
                            end
                            -- DECOMPILER ERROR at PC90: Overwrote pending register: R9 in 'AssignReg'

                            -- DECOMPILER ERROR at PC91: Overwrote pending register: R10 in 'AssignReg'

                            -- DECOMPILER ERROR at PC91: Overwrote pending register: R9 in 'AssignReg'

                            -- DECOMPILER ERROR at PC92: Overwrote pending register: R11 in 'AssignReg'

                            texNameInfo(texNameText, btn)
                        end
                    end
                    -- DECOMPILER ERROR at PC96: LeaveBlock: unexpected jumping out DO_STMT

                end
            end
        end
    end

UIAthMultSortList.OnDelete = function(self)
    -- function num : 0_19 , upvalues : base
    (base.OnDelete)(self)
end

return UIAthMultSortList

