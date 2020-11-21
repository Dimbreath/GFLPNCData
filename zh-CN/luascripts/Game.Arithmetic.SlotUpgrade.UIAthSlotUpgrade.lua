-- params : ...
-- function num : 0 , upvalues : _ENV
local UIAthSlotUpgrade = class("UIAthSlotUpgrade", UIBaseWindow)
local base = UIBaseWindow
local SlotUpgradeTog =
    require("Game.Arithmetic.SlotUpgrade.UIAthSlotUpgradeTog")
local UIAthMultSortList = require("Game.Arithmetic.SortList.UIAthMultSortList")
local UIAthDecomposeFliter = require(
                                 "Game.Arithmetic.SlotUpgrade.UIAthDecomposeFliter")
local eFliterKindType, eFliterKindTypeName, eFliterKindTypeOptionName,
      eFliterKindColorName = (table.unpack)(
                                 require(
                                     "Game.Arithmetic.SlotUpgrade.UIAthFliterHelper"))
UIAthSlotUpgrade.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, SlotUpgradeTog, UIAthMultSortList, UIAthDecomposeFliter
    self.athNetwork = NetworkManager:GetNetwork(NetworkTypeID.Arithmetic)
    self.athFrgId = (ConfigData.game_config).athSlotFrgid
    self.SlotUpgradeTogPool = (UIItemPool.New)(SlotUpgradeTog,
                                               (self.ui).tog_AreaSelectObj);
    ((self.ui).tog_AreaSelectObj):SetActive(false);
    (((self.ui).tex_IsSatisfy).gameObject):SetActive(false)
    self.togList = {}
    for key, _ in pairs((PlayerDataCenter.allAthData).slotAthDic) do
        local tog = (self.SlotUpgradeTogPool):GetOne(true) -- DECOMPILER ERROR at PC41: Confused about usage of register: R7 in 'UnsetPending'
        ;
        (self.togList)[key] = tog
    end
    if self.sortListNode == nil then
        self.sortListNode = (UIAthMultSortList.New)();
        (self.sortListNode):Init((self.ui).athSortListNode)
    end
    if self.decomposeFliterNode == nil then
        self.decomposeFliterNode = (UIAthDecomposeFliter.New)();
        (self.decomposeFliterNode):Init(((self.sortListNode).ui).fliterNode);
        (self.decomposeFliterNode):Hide();
        (self.decomposeFliterNode):InitFliter(self:GenFliteroptions())
    end
    self.solveList = {}
    self.DecoDic = {} -- DECOMPILER ERROR at PC81: Confused about usage of register: R1 in 'UnsetPending'
    ;
    (self.DecoDic).area = {} -- DECOMPILER ERROR at PC84: Confused about usage of register: R1 in 'UnsetPending'
    ;
    (self.DecoDic).quality = {} -- DECOMPILER ERROR at PC87: Confused about usage of register: R1 in 'UnsetPending'
    ;
    (self.DecoDic).mainAttr = {}
    self:__AthAutoDecomposeInitConfig();
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddButtonListener)((self.ui).btn_LevelUp, self, self.OnClickUpgrade);
    (UIUtil.AddButtonListener)((self.ui).btn_Close, self, self.OnClickClose);
    (UIUtil.AddButtonListener)(((self.sortListNode).ui).btn_Decompose, self,
                               self.AthDecompose);
    (UIUtil.AddButtonListener)(((self.sortListNode).ui).btn_AutoDecompose, self,
                               self.AthAutoDecompose);
    (UIUtil.AddValueChangedListener)(((self.sortListNode).ui).tog_AutoDecompose,
                                     self, self.AthAutoDecomposeTog);
    (UIUtil.AddButtonListener)(((self.sortListNode).ui).btn_OneKeyDecompose,
                               self, self.AthOneKeyDecompose)
end

UIAthSlotUpgrade.InitSlotUpgrade = function(self, curSlotId, heroData)
    -- function num : 0_1 , upvalues : _ENV
    self.curSlotId = curSlotId
    self.heroData = heroData
    local heroName = (LanguageUtil.GetLocaleText)((heroData.heroCfg).name)
    for key, tog in pairs(self.togList) do
        do
            tog:SetTitle(heroName, key)
            tog:SetClikEvent(function()
                -- function num : 0_1_0 , upvalues : self, key
                self.curSlotId = key
                self:RefeshSlotInfo((self.heroData).dataId, self.curSlotId)
            end)
        end
    end
    self:RefeshSlotInfo((self.heroData).dataId, self.curSlotId)
    self:RefreshAthDepository()
end

UIAthSlotUpgrade.RefeshSlotInfo = function(self, dataId, curSlotId)
    -- function num : 0_2 , upvalues : _ENV
    if dataId == nil or curSlotId == nil then error("非法的槽位刷新") end
    local slotLevel = (PlayerDataCenter.allAthData):GetHeroAthSlotLevel(dataId,
                                                                        curSlotId);
    ((self.ui).tex_LevelUp):SetIndex(0, tostring(slotLevel))
    local playerFrgNum = PlayerDataCenter:GetItemCount(self.athFrgId)
    local needFrgNum = ((ConfigData.ath_efficiency)[slotLevel]).shard
    if slotLevel == #ConfigData.ath_efficiency then
        playerFrgNum = 0;
        (((self.ui).tex_IsSatisfy).gameObject):SetActive(true);
        ((self.ui).tex_IsSatisfy):SetIndex(1)
        self.maxLevel = true
        local efficiency = (PlayerDataCenter.allAthData):GetAthEfficiency(
                               slotLevel);
        ((self.ui).tex_AttriCount):SetIndex(0, tostring(
                                                FormatNum(efficiency / 10)))
    else
        do
            self.maxLevel = false
            if needFrgNum <= playerFrgNum then
                (((self.ui).tex_IsSatisfy).gameObject):SetActive(true);
                ((self.ui).tex_IsSatisfy):SetIndex(0)
                self.couldUpdate = true
                local efficiency =
                    (PlayerDataCenter.allAthData):GetAthEfficiency(slotLevel + 1);
                ((self.ui).tex_AttriCount):SetIndex(0, tostring(
                                                        FormatNum(
                                                            efficiency / 10)))
            else
                do

                    (((self.ui).tex_IsSatisfy).gameObject):SetActive(false)
                    self.couldUpdate = false
                    do
                        local efficiency =
                            (PlayerDataCenter.allAthData):GetAthEfficiency(
                                slotLevel);
                        ((self.ui).tex_AttriCount):SetIndex(0, tostring(
                                                                FormatNum(
                                                                    efficiency /
                                                                        10)));
                        ((self.ui).tex_Condition):SetIndex(0, tostring(
                                                               playerFrgNum),
                                                           tostring(needFrgNum)) -- DECOMPILER ERROR at PC130: Confused about usage of register: R6 in 'UnsetPending'
                        ;
                        ((self.ui).img_progressBar).fillAmount =
                            playerFrgNum / needFrgNum
                    end
                end
            end
        end
    end
end

UIAthSlotUpgrade.OnClickUpgrade = function(self)
    -- function num : 0_3 , upvalues : _ENV
    if self.maxLevel then
        ((CS.MessageCommon).ShowMessageTips)(
            ConfigData:GetTipContent(TipContent.arithmetic_slot_HasFullLevel))
        return
    end
    if self.couldUpdate then
        local oldSlotLevel = (PlayerDataCenter.allAthData):GetHeroAthSlotLevel(
                                 (self.heroData).dataId, self.curSlotId)
        do
            local oldEfficiency =
                (PlayerDataCenter.allAthData):GetAthEfficiency(oldSlotLevel);
            (self.athNetwork):CS_ATH_SlotUpgrade((self.heroData).dataId,
                                                 self.curSlotId, function()
                -- function num : 0_3_0 , upvalues : _ENV, self, oldEfficiency, oldSlotLevel
                local slotLevel =
                    (PlayerDataCenter.allAthData):GetHeroAthSlotLevel(
                        (self.heroData).dataId, self.curSlotId)
                local efficiency =
                    (PlayerDataCenter.allAthData):GetAthEfficiency(slotLevel)
                UIManager:ShowWindowAsync(UIWindowTypeID.AthSlotUpgradeInfo,
                                          function(win)
                    -- function num : 0_3_0_0 , upvalues : _ENV, oldEfficiency, efficiency, oldSlotLevel, slotLevel
                    local AttrCangeList = {}
                    local attr = {}
                    attr.name = "算法效率"
                    attr.oldNum = FormatNum(oldEfficiency / 10)
                    attr.newNum = FormatNum(efficiency / 10);
                    (table.insert)(AttrCangeList, attr)
                    win:InitInfo(oldSlotLevel, slotLevel, AttrCangeList)
                end)
                self:RefeshSlotInfo((self.heroData).dataId, self.curSlotId)
            end)
        end
    else
        do

            ((CS.MessageCommon).ShowMessageTips)(
                ConfigData:GetTipContent(TipContent.arithmetic_Slot_MaterialShot))
        end
    end
end

UIAthSlotUpgrade.RefreshAthDepository = function(self)
    -- function num : 0_4 , upvalues : _ENV
    (self.sortListNode):Show();
    (self.sortListNode):InitAthSortList();
    (self.sortListNode):SetClickSortAthEvent(
        function(athData)
            -- function num : 0_4_0 , upvalues : self, _ENV
            if not (self.sortListNode):isSelected(athData) then
                (table.insert)(self.solveList, athData.uid);
                (self.sortListNode):setSelected(athData, true);
                ((self.sortListNode):__GetAthItemByData(athData)):SelectAth(true)
            else

                (table.removebyvalue)(self.solveList, athData.uid);
                (self.sortListNode):setSelected(athData, false);
                ((self.sortListNode):__GetAthItemByData(athData)):SelectAth(
                    false)
            end
        end)
end

UIAthSlotUpgrade.AthDecompose = function(self)
    -- function num : 0_5 , upvalues : _ENV, eFliterKindColorName
    if #self.solveList == 0 then return end
    local nums = {}
    local frgNums = {}
    for _, uid in ipairs(self.solveList) do
        local id = uid >> 32
        local qID = ((ConfigData.item)[id]).quality
        if nums[qID] == nil then
            nums[qID] = 0
            frgNums[qID] = 0
        end
        nums[qID] = nums[qID] + 1
        frgNums[qID] = frgNums[qID] + ((ConfigData.arithmetic)[id]).shard
    end
    local info = "\n"
    for qID, nums in pairs(nums) do
        info = info .. tostring(nums) ..
                   (string.format)(ConfigData:GetTipContent(
                                       TipContent.arithmetic_DecomposeInfo),
                                   eFliterKindColorName[qID],
                                   tostring(frgNums[qID]))
    end
    ((CS.MessageCommon).ShowMessageBox)(ConfigData:GetTipContent(
                                            TipContent.arithmetic_Slot_ConfirmDecompose) ..
                                            info, function()
        -- function num : 0_5_0 , upvalues : self
        (self.athNetwork):CS_ATH_OneKeyDeco(self.solveList, function()
            -- function num : 0_5_0_0 , upvalues : self
            self:RefreshAthDepository()
            self:RefeshSlotInfo((self.heroData).dataId, self.curSlotId)
            self.solveList = {}
        end)
    end, function()
        -- function num : 0_5_1
    end)
end

UIAthSlotUpgrade.AthAutoDecompose = function(self)
    -- function num : 0_6
    (self.decomposeFliterNode):Show();
    (self.decomposeFliterNode):OrangeAddOrRemoveSwitch(true);
    (self.decomposeFliterNode):CleanSelect();
    (self.decomposeFliterNode):AutoDecoSelect(self.autoDecoDic);
    (self.decomposeFliterNode):SetResetCallback(nil);
    (self.decomposeFliterNode):SetConfirmCallback(
        function()
            -- function num : 0_6_0 , upvalues : self
            self.autoDecoDic = self:DecoDic2AutoDecoDic(self.DecoDic, true) -- DECOMPILER ERROR at PC9: Confused about usage of register: R0 in 'UnsetPending'
            ;
            (((self.sortListNode).ui).tog_AutoDecompose).isOn = true
            self:AthAutoDecomposeTog(true);
            (self.decomposeFliterNode):Hide()
        end)
end

UIAthSlotUpgrade.AthAutoDecomposeTog = function(self, bool)
    -- function num : 0_7 , upvalues : _ENV
    -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

    (self.autoDecoDic).trigger = bool
    if bool and #(self.autoDecoDic).data == 0 then
        self:AthAutoDecompose()
        return
    end
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R2 in 'UnsetPending'

    if not bool then (self.autoDecoDic).data = {} end -- DECOMPILER ERROR at PC20: Confused about usage of register: R2 in 'UnsetPending'
    
    (PlayerDataCenter.allAthData).autoDeco = self.autoDecoDic;
    (self.athNetwork):CS_Ath_AutoDecoSetting(self.autoDecoDic)
end

UIAthSlotUpgrade.__AthAutoDecomposeInitConfig =
    function(self)
        -- function num : 0_8 , upvalues : _ENV
        self.autoDecoDic = (PlayerDataCenter.allAthData).autoDeco
        if self.autoDecoDic == nil then self.autoDecoDic = {} end
        -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

        if (self.autoDecoDic).trigger then
            (((self.sortListNode).ui).tog_AutoDecompose).isOn = true
        else
            -- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'


            (((self.sortListNode).ui).tog_AutoDecompose).isOn = false
        end
    end

UIAthSlotUpgrade.DecoDic2AutoDecoDic = function(self, DecoDic, trigger)
    -- function num : 0_9 , upvalues : _ENV
    local autoDecoDic = {}
    autoDecoDic.trigger = trigger
    autoDecoDic.data = {}
    if trigger then
        local elem = {}
        elem.orange = {}
        elem.white = false
        elem.blue = false
        elem.purple = false
        local attrMap = nil
        for _, value in ipairs(DecoDic.quality) do
            local elemName = (string.lower)(
                                 (table.keyof)(eItemQualityType, value))
            if elemName == "orange" then
                for _, attrID in ipairs(DecoDic.mainAttr) do
                    -- DECOMPILER ERROR at PC32: Confused about usage of register: R17 in 'UnsetPending'

                    (elem.orange)[attrID] = true
                end
            else
                do
                    do
                        if elem[elemName] ~= nil then
                            elem[elemName] = true
                        end
                        -- DECOMPILER ERROR at PC40: LeaveBlock: unexpected jumping out DO_STMT

                        -- DECOMPILER ERROR at PC40: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                        -- DECOMPILER ERROR at PC40: LeaveBlock: unexpected jumping out IF_STMT

                    end
                end
            end
        end
        for _, areaID in ipairs(DecoDic.area) do
            -- DECOMPILER ERROR at PC50: Confused about usage of register: R11 in 'UnsetPending'

            (autoDecoDic.data)[areaID] = DeepCopy(elem)
        end
    end
    do return autoDecoDic end
end

UIAthSlotUpgrade.AthOneKeyDecompose = function(self)
    -- function num : 0_10 , upvalues : _ENV
    (self.decomposeFliterNode):Show();
    (self.decomposeFliterNode):OrangeAddOrRemoveSwitch(false);
    (self.decomposeFliterNode):CleanSelect();
    (self.decomposeFliterNode):SetResetCallback(
        function()
            -- function num : 0_10_0 , upvalues : self
            self:RefreshAthDepository()
            self.solveList = {}
        end);
    (self.decomposeFliterNode):SetConfirmCallback(
        function()
            -- function num : 0_10_1 , upvalues : self, _ENV
            (self.sortListNode):RefreshAthList(
                function(athData)
                    -- function num : 0_10_1_0 , upvalues : self, _ENV
                    if athData.lockUnlock or athData.bindInfo ~= nil then
                        return false
                    end
                    if #(self.DecoDic).area ~= 0 then
                        local tempBool = false
                        for _, areaID in ipairs((self.DecoDic).area) do
                            if athData.area_type == areaID then
                                tempBool = true
                                break
                            end
                        end
                        do
                            do
                                if not tempBool then
                                    return false
                                end
                                if #(self.DecoDic).mainAttr ~= 0 then
                                    local tempBool = false
                                    for _, attrID in
                                        ipairs((self.DecoDic).mainAttr) do
                                        if athData:IsHaveThisAttr(attrID) then
                                            tempBool = true
                                            break
                                        end
                                    end
                                    do
                                        do
                                            if not tempBool then
                                                return false
                                            end
                                            if #(self.DecoDic).quality ~= 0 then
                                                local tempBool = false
                                                for _, qualityID in
                                                    ipairs(
                                                        (self.DecoDic).quality) do
                                                    if (athData.itemCfg).quality ==
                                                        qualityID then
                                                        tempBool = true
                                                        break
                                                    end
                                                end
                                                do
                                                    do
                                                        if not tempBool then
                                                            return false
                                                        end
                                                        return true
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end, function(a, b)
                    -- function num : 0_10_1_1
                    do return b.quality < a.quality end
                    -- DECOMPILER ERROR: 1 unprocessed JMP targets
                end)
            self.solveList = {}
            for k, athData in ipairs((self.sortListNode).curAthList) do
                (table.insert)(self.solveList, athData.uid);
                (self.sortListNode):setSelected(athData, true)
            end
            (self.decomposeFliterNode):Hide();
            (self.sortListNode):RefreshSelectAth()
        end)
end

UIAthSlotUpgrade.GenFliteroptions = function(self)
    -- function num : 0_11 , upvalues : eFliterKindTypeName, eFliterKindType, _ENV, eFliterKindTypeOptionName, eFliterKindColorName
    local fliterList = {}
    local tempTitle = {}
    tempTitle.name = eFliterKindTypeName[eFliterKindType.Area]
    for i = 1, (ConfigData.game_config).athSlotCount do
        do
            local tempOption = {}
            tempOption.optionName =
                eFliterKindTypeOptionName[eFliterKindType.Area] .. i
            tempOption.callback = function(bool)
                -- function num : 0_11_0 , upvalues : _ENV, self, i
                if bool then
                    (table.insert)((self.DecoDic).area, i)
                else

                    (table.removebyvalue)((self.DecoDic).area, i)
                end
            end;
            (table.insert)(tempTitle, tempOption)
        end
    end
    (table.insert)(fliterList, tempTitle)
    tempTitle = {}
    tempTitle.name = eFliterKindTypeName[eFliterKindType.Quality]
    for key, value in pairs((ConfigData.game_config).athQualityEnum) do
        local tempOption = {}
        tempOption.optionName = eFliterKindColorName[value] ..
                                    eFliterKindTypeOptionName[eFliterKindType.Quality]
        tempOption.callback = function(bool)
            -- function num : 0_11_1 , upvalues : _ENV, self, value
            if bool then
                (table.insert)((self.DecoDic).quality, value)
            else

                (table.removebyvalue)((self.DecoDic).quality, value)
            end
        end;
        (table.insert)(tempTitle, tempOption)
    end
    (table.insert)(fliterList, tempTitle)
    tempTitle = {}
    tempTitle.name = eFliterKindTypeName[eFliterKindType.MainAttr]
    for key, value in pairs(ConfigData.attribute) do
        if value.algor_main_attribute == 1 then
            local tempOption = {}
            tempOption.optionName =
                eFliterKindTypeOptionName[eFliterKindType.MainAttr] ..
                    (LanguageUtil.GetLocaleText)(value.name) .. key
            tempOption.callback = function(bool)
                -- function num : 0_11_2 , upvalues : _ENV, self, key
                if bool then
                    (table.insert)((self.DecoDic).mainAttr, key)
                else

                    (table.removebyvalue)((self.DecoDic).mainAttr, key)
                end
            end;
            (table.insert)(tempTitle, tempOption)
        end
    end
    (table.insert)(fliterList, tempTitle)
    return fliterList
end

UIAthSlotUpgrade.OnClickClose = function(self)
    -- function num : 0_12
    (self.decomposeFliterNode):Hide()
    self.solveList = {}
    self:Hide()
end

UIAthSlotUpgrade.OnDelete = function(self)
    -- function num : 0_13 , upvalues : _ENV, base
    UIManager:DeleteWindow(UIWindowTypeID.AthSlotUpgradeInfo);
    (base.OnDelete)(self)
end

return UIAthSlotUpgrade

