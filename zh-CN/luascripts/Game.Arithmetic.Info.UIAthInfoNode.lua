-- params : ...
-- function num : 0 , upvalues : _ENV
local UIAthInfoNode = class("UIAthInfoNode", UIBaseNode)
local base = UIBaseNode
local UIAthSlotItemBar = require("Game.Arithmetic.Info.UIAthSlotItemBar")
local UIAthSlotItemSwitch = require("Game.Arithmetic.Info.UIAthSlotItemSwitch")
local UIAthInfoAttrItem = require("Game.Arithmetic.Info.UIAthInfoAttrItem")
local UIAthItemDetail = require("Game.Arithmetic.Info.UIAthItemDetail")
local UIAthSortList = require("Game.Arithmetic.SortList.UIAthSortList")
local cs_MessageCommon = CS.MessageCommon
UIAthInfoNode.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, UIAthSlotItemBar, UIAthSlotItemSwitch, UIAthItemDetail, UIAthInfoAttrItem
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddButtonListener)((self.ui).btn_Close, self, self.OnClickClose);
    (UIUtil.AddButtonListener)((self.ui).btn_BarStrengthen, self,
                               self.OnClickSlotUpgrade);
    ((self.ui).uI_ATHBarItem):SetActive(false);
    ((self.ui).uI_ATHBarItem_Switch):SetActive(false);
    ((self.ui).athItemDetail):SetActive(false);
    ((self.ui).attriDetail_Item):SetActive(false)
    self.slotPool = (UIItemPool.New)(UIAthSlotItemBar, (self.ui).uI_ATHBarItem)
    self.slotSwitchPool = (UIItemPool.New)(UIAthSlotItemSwitch,
                                           (self.ui).uI_ATHBarItem_Switch)
    self.athDetailPool = (UIItemPool.New)(UIAthItemDetail,
                                          (self.ui).athItemDetail)
    self.athAttrPool = (UIItemPool.New)(UIAthInfoAttrItem,
                                        (self.ui).attriDetail_Item)
    self.__onClickSlot = BindCallback(self, self.OnClickSlot)
    self.__onClickAth = BindCallback(self, self.OnClickAth)
    self.__onClickSortListAth = BindCallback(self, self.OnClickSortListAth)
    self.__uninstallAthEvent = BindCallback(self, self.UninstallAth)
    self.__onAthInstallEvent = BindCallback(self, self.OnAthInstall)
    self.__onAthDetailMainCloseEvent = BindCallback(self,
                                                    self.OnAthDetailMainClose)
    self.__onAthDetailSubCloseEvent = BindCallback(self,
                                                   self.OnAthDetailSubClose)
    self.athNetwork = NetworkManager:GetNetwork(NetworkTypeID.Arithmetic)
end

UIAthInfoNode.InitAthInfo = function(self, heroData, uiHeroList)
    -- function num : 0_1 , upvalues : _ENV, UIAthSortList
    self.uiHeroList = uiHeroList
    self.heroData = heroData
    uiHeroList:SetReturnEvent(BindCallback(self, self.OnClickClose))
    if self.sortListNode == nil then
        self.sortListNode = (UIAthSortList.New)();
        (self.sortListNode):Init((self.ui).athSortListNode)
    end
    self:__HideSortList()
    if self.athDetailWindow ~= nil then
        (self.athDetailWindow):ResetAthDetail()
    end
    self:ShowAllSlot()
end

UIAthInfoNode.ShowAllSlot = function(self)
    -- function num : 0_2 , upvalues : _ENV
    ((self.ui).athBarContent):SetActive(true);
    ((self.ui).athBarInfoNode):SetActive(false);
    ((self.ui).athBarNode):SetActive(false);
    (self.slotPool):HideAll()
    local athSlotList = (self.heroData):GetAthSlotList()
    for k, space in ipairs(athSlotList) do
        local slotItem = (self.slotPool):GetOne()
        slotItem:InitAthSlotItem(k, space, (self.heroData).dataId)
        slotItem:SetClickEvent(self.__onClickSlot)
    end
    self:RefreshAthAttr(athSlotList)
end

UIAthInfoNode.ShowSlotDetail = function(self, slotId)
    -- function num : 0_3 , upvalues : _ENV
    ((self.ui).athBarContent):SetActive(false);
    ((self.ui).athBarInfoNode):SetActive(true);
    ((self.ui).athBarNode):SetActive(true)
    self.curSlotId = slotId
    if self.athDetailWindow ~= nil then
        (self.athDetailWindow):ResetAthDetail()
    end
    self.selectAthItem = nil;
    ((self.ui).tex_CurArea):SetIndex(0, tostring(slotId))
    local athSlotList = (self.heroData):GetAthSlotList()
    local athSlotFullSpaceList = (self.heroData):GetAthSlotList(true)
    local slotLevel = (PlayerDataCenter.allAthData):GetHeroAthSlotLevel(
                          (self.heroData).dataId, slotId)
    local efficiency = (PlayerDataCenter.allAthData):GetAthEfficiency(slotLevel)
    self.curSlotEfficiency = efficiency;
    ((self.ui).tex_ATHBarRatio):SetIndex(0, tostring(FormatNum(efficiency / 10)));
    ((self.ui).tex_ATHBarLevel):SetIndex(0, tostring(slotLevel))
    local athDataList, athDic = (PlayerDataCenter.allAthData):GetHeroAthList(
                                    (self.heroData).dataId, slotId)
    self.curSlotAthDataList = athDataList
    self.curSlotAthDataDic = athDic
    local curSpace = athSlotList[slotId]
    local fullSpace = athSlotFullSpaceList[slotId]
    local lockSpace = fullSpace - curSpace
    local usedSpace = 0
    for k, athData in ipairs(athDataList) do
        usedSpace = usedSpace + athData.size
    end
    local emptySpace = curSpace - (usedSpace)
    self.curSlotEmptySpace = emptySpace
    if emptySpace <= 0 or not #athDataList + 1 then
        local imgCount = #athDataList
    end
    if lockSpace <= 0 or not imgCount + 1 then
        local verLayout = (self.ui).athContent
        local totalHeight = ((verLayout.transform).rect).height -
                                (verLayout.padding).vertical - verLayout.spacing *
                                (imgCount - 1)
        local curSlotDensity = self:GetSlotDensity(slotId, curSpace);
        ((self.ui).tex_ATHDensity):SetIndex(0, GetPreciseDecimalStr(
                                                curSlotDensity, 2));
        (self.athDetailPool):HideAll()
        if lockSpace > 0 then
            local athItem = (self.athDetailPool):GetOne()
            local height = lockSpace / fullSpace * totalHeight
            athItem:InitAthItem((self.ui).lockColor, height, lockSpace, nil,
                                false)
        end
        do
            if emptySpace > 0 then
                local athItem = (self.athDetailPool):GetOne()
                local height = emptySpace / fullSpace * totalHeight
                athItem:InitAthItem((self.ui).emptyColor, height, emptySpace,
                                    nil, true)
                athItem:SetClickAthEvent(self.__onClickAth)
            end
            do
                for k, athData in ipairs(athDataList) do
                    local athItem = (self.athDetailPool):GetOne()
                    local height = athData.size / fullSpace * totalHeight
                    athItem:InitAthItem(athData:GetColor(), height,
                                        athData.size, athData)
                    athItem:SetClickAthEvent(self.__onClickAth)
                end
                (self.slotSwitchPool):HideAll()
                for k, space in ipairs(athSlotList) do
                    if k ~= slotId then
                        local slotItem = (self.slotSwitchPool):GetOne()
                        slotItem:InitAthSlotItem(k, space,
                                                 (self.heroData).dataId)
                        slotItem:SetClickEvent(self.__onClickSlot)
                    end
                end
                self:RefreshAthAttr(athSlotList, slotId)
                self:ShowAthSortList(nil)
            end
        end
    end
end

UIAthInfoNode.GetSlotDensity = function(self, slotId, size)
    -- function num : 0_4 , upvalues : _ENV
    local attrDic = setmetatable({}, {
        __index = function(tab, key)
            -- function num : 0_4_0
            return 0
        end
    })
    local athList = (PlayerDataCenter.allAthData):GetHeroAthList(
                        (self.heroData).dataId, slotId)
    for k, athData in ipairs(athList) do
        for k2, elem in ipairs(athData.attrList) do
            local attrId = elem.id
            local slotLevel = (PlayerDataCenter.allAthData):GetHeroAthSlotLevel(
                                  (self.heroData).dataId, slotId)
            local efficiency = (PlayerDataCenter.allAthData):GetAthEfficiency(
                                   slotLevel)
            local attrValue = (math.floor)(elem.value * efficiency / 1000)
            attrDic[attrId] = attrValue + attrDic[attrId]
        end
        for k2, elem in ipairs(athData.affixList) do
            local cfg = (ConfigData.ath_affix_pool)[elem.id]
            if cfg == nil then
                error("Cant\'t find ath_affix_pool, id = " .. tostring(elem.id))
            else
                local attrId = cfg.affix_para
                local attrValue = elem.value
                attrDic[attrId] = attrValue + attrDic[attrId]
            end
        end
    end
    return (PlayerDataCenter.allAthData):GetAthDensity(attrDic, size)
end

UIAthInfoNode.RefreshAthAttr = function(self, athSlotList, curSlotId)
    -- function num : 0_5 , upvalues : _ENV
    local allAttrDic, slotAttrTab, suitDic =
        (PlayerDataCenter.allAthData):GetHeroAthAttr((self.heroData).dataId);
    (self.athAttrPool):HideAll()
    local allAttrIdList = {}
    for k, v in pairs(allAttrDic) do (table.insert)(allAttrIdList, k) end
    (table.sort)(allAttrIdList)
    local valueList = {}
    for k, attrId in ipairs(allAttrIdList) do
        local attrConfig = (ConfigData.attribute)[attrId]
        if attrConfig.merge_attribute ~= 0 then
            local mergeID = attrConfig.merge_attribute
            if valueList[mergeID] == nil then valueList[mergeID] = {} end
            -- DECOMPILER ERROR at PC60: Confused about usage of register: R15 in 'UnsetPending'

            if not (valueList[mergeID]).v1 then
                do
                    (valueList[mergeID]).v1 =
                        (attrConfig.num_type ~= 2 or 0) + allAttrDic[attrId] *
                            (self.heroData):GetAttr(mergeID, true) // 1000 -- DECOMPILER ERROR at PC83: Confused about usage of register: R15 in 'UnsetPending'
                    ;
                    (valueList[mergeID]).v2 =
                        (slotAttrTab[curSlotId] == nil or 0) +
                            (not (valueList[mergeID]).v2 and
                                (slotAttrTab[curSlotId])[attrId] or 0) *
                            (self.heroData):GetAttr(mergeID, true) // 1000 -- DECOMPILER ERROR at PC93: Confused about usage of register: R15 in 'UnsetPending'
                    ;
                    (valueList[mergeID]).v1 =
                        ((valueList[mergeID]).v1 or 0) + allAttrDic[attrId] -- DECOMPILER ERROR at PC109: Confused about usage of register: R15 in 'UnsetPending'
                    ;
                    (valueList[mergeID]).v2 =
                        (slotAttrTab[curSlotId] == nil or 0) +
                            (not (valueList[mergeID]).v2 and
                                (slotAttrTab[curSlotId])[attrId] or 0)
                    if valueList[attrId] == nil then
                        valueList[attrId] = {}
                    end
                    -- DECOMPILER ERROR at PC123: Confused about usage of register: R14 in 'UnsetPending'

                    if attrConfig.num_type == 2 then
                        if attrId > 17 then
                            (valueList[attrId]).v1 = allAttrDic[attrId]
                            -- DECOMPILER ERROR at PC133: Confused about usage of register: R14 in 'UnsetPending'

                            if not (slotAttrTab[curSlotId])[attrId] then
                                do
                                    (valueList[attrId]).v2 =
                                        slotAttrTab[curSlotId] == nil or 0 -- DECOMPILER ERROR at PC150: Confused about usage of register: R14 in 'UnsetPending'
                                    ;
                                    (valueList[attrId]).v1 =
                                        ((valueList[attrId]).v1 or 0) +
                                            allAttrDic[attrId] *
                                            (self.heroData):GetAttr(attrId, true) //
                                            1000 -- DECOMPILER ERROR at PC173: Confused about usage of register: R14 in 'UnsetPending'
                                    ;
                                    (valueList[attrId]).v2 =
                                        (slotAttrTab[curSlotId] == nil or 0) +
                                            (not (valueList[attrId]).v2 and
                                                (slotAttrTab[curSlotId])[attrId] or
                                                0) *
                                            (self.heroData):GetAttr(attrId, true) //
                                            1000 -- DECOMPILER ERROR at PC183: Confused about usage of register: R14 in 'UnsetPending'
                                    ;
                                    (valueList[attrId]).v1 =
                                        ((valueList[attrId]).v1 or 0) +
                                            allAttrDic[attrId] -- DECOMPILER ERROR at PC199: Confused about usage of register: R14 in 'UnsetPending'
                                    ;
                                    (valueList[attrId]).v2 =
                                        (slotAttrTab[curSlotId] == nil or 0) +
                                            (not (valueList[attrId]).v2 and
                                                (slotAttrTab[curSlotId])[attrId] or
                                                0)
                                    -- DECOMPILER ERROR at PC200: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                    -- DECOMPILER ERROR at PC200: LeaveBlock: unexpected jumping out IF_STMT

                                    -- DECOMPILER ERROR at PC200: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                    -- DECOMPILER ERROR at PC200: LeaveBlock: unexpected jumping out IF_STMT

                                    -- DECOMPILER ERROR at PC200: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                    -- DECOMPILER ERROR at PC200: LeaveBlock: unexpected jumping out IF_STMT

                                    -- DECOMPILER ERROR at PC200: LeaveBlock: unexpected jumping out DO_STMT

                                    -- DECOMPILER ERROR at PC200: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                    -- DECOMPILER ERROR at PC200: LeaveBlock: unexpected jumping out IF_STMT

                                    -- DECOMPILER ERROR at PC200: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                    -- DECOMPILER ERROR at PC200: LeaveBlock: unexpected jumping out IF_STMT

                                end
                            end
                        end
                    end
                end
            end
        end
    end
    local maxKey = 1
    for key, value in pairs(valueList) do
        if maxKey < key then maxKey = key end
    end
    for key = 1, maxKey do
        local value = valueList[key]
        if value ~= nil then
            local attrItem = (self.athAttrPool):GetOne()
            attrItem:InitAthInfoAttrItem(key, value.v1, value.v2)
        end
    end
    local content = ""
    local suitIdList = {}
    for k, v in pairs(suitDic) do (table.insert)(suitIdList, k) end
    (table.sort)(suitIdList)
    for k, suitId in ipairs(suitIdList) do
        local suitCfg = suitDic[suitId]
        local suitName = (LanguageUtil.GetLocaleText)(suitCfg.name)
        local suitNum = tostring(suitCfg.num)
        local suitDetail = (LanguageUtil.GetLocaleText)(suitCfg.describe)
        content = content ..
                      ((self.ui).tex_EffectDetail):GetIndex(0, suitName,
                                                            suitNum, suitDetail)
    end
    ((self.ui).tex_EffectDetail):SetText(content)
end

UIAthInfoNode.OnClickSlot = function(self, slotId)
    -- function num : 0_6
    self:ShowSlotDetail(slotId)
end

UIAthInfoNode.OnClickAth = function(self, athItem)
    -- function num : 0_7 , upvalues : _ENV
    if self.selectAthItem ~= nil then (self.selectAthItem):SelectAth(false) end
    self.selectAthItem = athItem;
    (self.selectAthItem):SelectAth(true)
    local athData = athItem.athData
    self:ShowAthSortList(athData)
    if athData ~= nil then
        UIManager:ShowWindowAsync(UIWindowTypeID.AthDetail, function(window)
            -- function num : 0_7_0 , upvalues : athData, self
            if window == nil then return end
            window:ShowAthDetailMain(athData, self.curSlotEfficiency,
                                     (self.heroData).dataId,
                                     self.__onAthInstallEvent,
                                     self.__uninstallAthEvent,
                                     self.__onAthDetailMainCloseEvent)
            self.athDetailWindow = window
        end)
    end
end

UIAthInfoNode.OnAthDetailMainClose = function(self)
    -- function num : 0_8
    if self.selectAthItem ~= nil then
        (self.selectAthItem):SelectAth(false)
        self.selectAthItem = nil
    end
    self:ShowAthSortList(nil)
end

UIAthInfoNode.OnAthDetailSubClose = function(self)
    -- function num : 0_9
    self.selectSortListAthData = nil
end

UIAthInfoNode.ShowAthSortList = function(self, athData)
    -- function num : 0_10
    local usableSpace = self.curSlotEmptySpace
    if athData ~= nil then usableSpace = usableSpace + athData.size end
    self.curSlotUsableSpace = usableSpace;
    (self.uiHeroList):EnableHorizontalScroll(false);
    (self.sortListNode):Show();
    (self.sortListNode):InitAthSortList(self.curSlotId, usableSpace,
                                        self.curSlotAthDataDic);
    (self.sortListNode):SetClickSortAthEvent(self.__onClickSortListAth)
end

UIAthInfoNode.OnClickSortListAth = function(self, athData)
    -- function num : 0_11 , upvalues : _ENV
    self.selectSortListAthData = athData
    UIManager:ShowWindowAsync(UIWindowTypeID.AthDetail, function(window)
        -- function num : 0_11_0 , upvalues : athData, self
        if window == nil then return end
        window:ShowAthDetailSub(athData, self.curSlotEfficiency,
                                (self.heroData).dataId,
                                self.__onAthInstallEvent,
                                self.__onAthDetailSubCloseEvent)
        self.athDetailWindow = window
    end)
end

UIAthInfoNode.OnAthInstall = function(self)
    -- function num : 0_12 , upvalues : cs_MessageCommon, _ENV
    local athData = self.selectSortListAthData
    if athData == nil then return end
    if (self.curSlotAthDataDic)[athData.uid] ~= nil then
        (cs_MessageCommon.ShowMessageTips)(
            ConfigData:GetTipContent(TipContent.arithmetic_HasInstalledInfo))
        return
    end
    if self.curSlotUsableSpace < athData.size then
        (cs_MessageCommon.ShowMessageTips)(
            ConfigData:GetTipContent(
                TipContent.arithmetic_UsableSpaceInsufficient))
        return
    end
    if self.selectAthItem == nil then
        self:InstallAth(athData)
    else
        if (self.selectAthItem).athData == nil then
            self:InstallAth(athData)
        else
            self:ReplaceAth(athData)
        end
    end
end

UIAthInfoNode.InstallAth = function(self, athData)
    -- function num : 0_13 , upvalues : _ENV, cs_MessageCommon
    for k, v in ipairs(self.curSlotAthDataList) do
        if v.id == athData.id then
            (cs_MessageCommon.ShowMessageTips)(
                ConfigData:GetTipContent(TipContent.arithmetic_RepeatedATH))
            return
        end
    end
    if self.__onInstallComplete == nil then
        self.__onInstallComplete = BindCallback(self, self.OnInstallComplete)
    end
    (self.athNetwork):CS_ATH_AthInstall((self.heroData).dataId, self.curSlotId,
                                        athData.uid, self.__onInstallComplete)
end

UIAthInfoNode.OnInstallComplete = function(self)
    -- function num : 0_14 , upvalues : cs_MessageCommon, _ENV
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(
                                           TipContent.arithmetic_InstallSuccess))
    self:ShowSlotDetail(self.curSlotId)
end

UIAthInfoNode.UninstallAth = function(self, uid)
    -- function num : 0_15 , upvalues : _ENV
    if self.__onUninstallComplete == nil then
        self.__onUninstallComplete =
            BindCallback(self, self.OnUninstallComplete)
    end
    (self.athNetwork):CS_ATH_AthUninstall(uid, self.__onUninstallComplete)
end

UIAthInfoNode.OnUninstallComplete = function(self)
    -- function num : 0_16 , upvalues : cs_MessageCommon, _ENV
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(
                                           TipContent.arithmetic_UninstallSuccess))
    self:ShowSlotDetail(self.curSlotId)
end

UIAthInfoNode.ReplaceAth = function(self, newAthData)
    -- function num : 0_17 , upvalues : _ENV
    if self.selectAthItem == nil or (self.selectAthItem).athData == nil then
        return
    end
    if self.__onReplaceComplete == nil then
        self.__onReplaceComplete = BindCallback(self, self.OnReplaceComplete)
    end
    (self.athNetwork):CS_ATH_AthReplace(((self.selectAthItem).athData).uid,
                                        newAthData.uid, self.__onReplaceComplete)
end

UIAthInfoNode.OnReplaceComplete = function(self)
    -- function num : 0_18 , upvalues : cs_MessageCommon, _ENV
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(
                                           TipContent.arithmetic_ReplaceSuccess))
    self:ShowSlotDetail(self.curSlotId)
end

UIAthInfoNode.OnClickSlotUpgrade = function(self)
    -- function num : 0_19 , upvalues : _ENV
    UIManager:ShowWindowAsync(UIWindowTypeID.AthSlotUpgrade, function(window)
        -- function num : 0_19_0 , upvalues : self
        window:InitSlotUpgrade(self.curSlotId, self.heroData)
    end)
end

UIAthInfoNode.OnClickClose = function(self)
    -- function num : 0_20 , upvalues : _ENV
    if self.uiHeroList ~= nil then
        self:Hide();
        (self.uiHeroList):EnableHorizontalScroll(true);
        (self.uiHeroList):OpenStatePanel()
        UIManager:DeleteWindow(UIWindowTypeID.AthDetail)
        UIManager:DeleteWindow(UIWindowTypeID.AthSlotUpgrade)
        self.athDetailWindow = nil
    end
end

UIAthInfoNode.__HideSortList = function(self)
    -- function num : 0_21
    (self.uiHeroList):EnableHorizontalScroll(true);
    (self.sortListNode):Hide()
end

UIAthInfoNode.OnDelete = function(self)
    -- function num : 0_22 , upvalues : _ENV, base
    (self.slotPool):DeleteAll();
    (self.slotSwitchPool):DeleteAll();
    (self.athDetailPool):DeleteAll();
    (self.athAttrPool):DeleteAll();
    (self.sortListNode):Delete()
    UIManager:DeleteWindow(UIWindowTypeID.AthDetail)
    UIManager:DeleteWindow(UIWindowTypeID.AthSlotUpgrade)
    UIManager:DeleteWindow(UIWindowTypeID.AthSlotUpgradeInfo);
    (base.OnDelete)(self)
end

return UIAthInfoNode

