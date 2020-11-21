-- params : ...
-- function num : 0 , upvalues : _ENV
local UIAthEfficiency = class("UIAthEfficiency", UIBaseWindow)
local base = UIBaseWindow
local UINAthSortList = require("Game.Arithmetic.AthSortList.UINAthSortList")
local UINAthEfficiencyOneKeyFiltrate = require(
                                           "Game.Arithmetic.AthEfficiency.UINAthEfficiencyOneKeyFiltrate")
local cs_MessageCommon = CS.MessageCommon
UIAthEfficiency.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, UINAthSortList
    (UIUtil.CreateTopBtnGroup)((self.ui).topButtonGroup, self,
                               self.__OnClickBack);
    (UIUtil.AddButtonListener)((self.ui).btn_LevelUp, self,
                               self.__OnClickUpgrade);
    (UIUtil.AddButtonListener)((self.ui).btn_Auto, self,
                               self.__OnClickAutoSelect)
    self.athNetwork = NetworkManager:GetNetwork(NetworkTypeID.Arithmetic)
    self.sortListNode = (UINAthSortList.New)();
    (self.sortListNode):Init((self.ui).aTHListNode)
    self.athMatUpNode = (self.sortListNode):GetAthMatUpNode();
    (self.athMatUpNode):SetRefreshAthSlotAddExpFunc(
        BindCallback(self, self.RefreshAthSlotAddExp))
    self.athSelectedDic = {}
    self.athExpAdd = 0
end

UIAthEfficiency.InitAthAthEfcc = function(self, heroData, heroResLoader)
    -- function num : 0_1 , upvalues : _ENV
    self.heroData = heroData
    heroResLoader:LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath(
                                       heroData:GetResName()), function(prefab)
        -- function num : 0_1_0 , upvalues : self, _ENV
        self.bigImgGameObject = prefab:Instantiate((self.ui).heroHolder)
        local commonPicCtrl = (self.bigImgGameObject):FindComponent(
                                  eUnityComponentID.CommonPicController)
        commonPicCtrl:SetPosType("HeroList")
    end);
    (self.sortListNode):InitAthSortListNode(heroData, true, BindCallback(self,
                                                                         self.__OnClickAthItem))
    self:RefreshCurAthEfficency()
end

UIAthEfficiency.RefreshCurAthEfficency =
    function(self)
        -- function num : 0_2 , upvalues : _ENV
        local curLevel, curExp =
            (PlayerDataCenter.allAthData):GetHeroAthSlotInfo(
                (self.heroData).dataId)
        self.curLevel = curLevel
        self.curExp = curExp
        self.athSelectedDic = {}
        self.athExpAdd = 0;
        (self.sortListNode):SetAthListMultSeletedUidDic(self.athSelectedDic);
        (self.athMatUpNode):CleanAllAthUpMat();
        (self.athMatUpNode):InitAthMatUp(curLevel, curExp,
                                         BindCallback(self, self.__OnMatExpAdd))
        local maxLevel = (ConfigData.ath_efficiency).maxLevel
        if maxLevel <= curLevel then
            ((self.ui).full):SetActive(true);
            ((self.ui).unfulfill):SetActive(false)
            local maxLvCfg = (ConfigData.ath_efficiency)[maxLevel]
            local efcc = maxLvCfg.attribute_promote / 1000
            self.curEfccStr = (string.format)("%.1f", efcc) -- DECOMPILER ERROR at PC56: Confused about usage of register: R6 in 'UnsetPending'
            ;
            ((self.ui).tex_FullValue).text = self.curEfccStr
        else
            do

                ((self.ui).full):SetActive(false);
                ((self.ui).unfulfill):SetActive(true)
                local lvCfg = (ConfigData.ath_efficiency)[curLevel]
                if lvCfg == nil then
                    error("Can\'t get ath_efficiency cfg, level = " ..
                              tostring(curLevel))
                    return
                end
                do
                    local curEfcc = lvCfg.attribute_promote / 1000
                    self.curEfccStr = (string.format)("%.1f", curEfcc) -- DECOMPILER ERROR at PC92: Confused about usage of register: R6 in 'UnsetPending'
                    ;
                    ((self.ui).tex_CurNum).text = self.curEfccStr
                    self:RefreshAthSlotAddExp()
                end
            end
        end
    end

UIAthEfficiency.RefreshAthSlotAddExp = function(self)
    -- function num : 0_3 , upvalues : _ENV
    local addExp = self:__GetAddExp() -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'
    ;
    ((self.ui).btn_LevelUp).interactable = addExp > 0;
    ((self.ui).tex_AddExp):SetIndex(0, tostring(addExp))
    local testLevel, nextExp, nextTotalExp =
        (PlayerDataCenter.allAthData):TryAddAthAreaExp(addExp, self.curLevel,
                                                       self.curExp)
    local toMaxLevelExp = -self.curExp
    for i = self.curLevel, (ConfigData.ath_efficiency).maxLevel - 1 do
        local levelCfg = (PlayerDataCenter.allAthData):GetAthEfficiencyCfg(i)
        toMaxLevelExp = toMaxLevelExp + levelCfg.shard
    end
    self.ableAddExp = toMaxLevelExp - addExp;
    (self.athMatUpNode):SetAthAddExpLimt(toMaxLevelExp, addExp)
    local targetLvCfg = (PlayerDataCenter.allAthData):GetAthEfficiencyCfg(
                            testLevel)
    local targetEfcc = targetLvCfg.attribute_promote / 1000 -- DECOMPILER ERROR at PC62: Confused about usage of register: R8 in 'UnsetPending'
    ;
    ((self.ui).tex_NewNum).text = (string.format)("%.1f", targetEfcc);
    ((self.ui).tex_CurExp):SetIndex(0, tostring(nextExp), tostring(nextTotalExp)) -- DECOMPILER ERROR at PC77: Confused about usage of register: R8 in 'UnsetPending'
    ;
    ((self.ui).img_Bar).fillAmount = nextExp / nextTotalExp
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UIAthEfficiency.__OnMatExpAdd = function(self, addExp)
    -- function num : 0_4
    self.matExpAdd = addExp
    self:RefreshAthSlotAddExp()
end

UIAthEfficiency.__OnAthExpAdd = function(self, addExp)
    -- function num : 0_5 , upvalues : _ENV
    self.athExpAdd = (math.max)(self.athExpAdd + addExp, 0)
    self:RefreshAthSlotAddExp()
end

UIAthEfficiency.__GetAddExp = function(self)
    -- function num : 0_6
    return (self.matExpAdd or 0) + (self.athExpAdd or 0)
end

UIAthEfficiency.__OnClickAutoSelect = function(self)
    -- function num : 0_7 , upvalues : UINAthEfficiencyOneKeyFiltrate, _ENV
    if self.siftCondition == nil then
        self.siftCondition = (UINAthEfficiencyOneKeyFiltrate.New)();
        (self.siftCondition):Init((self.ui).screenConditionNode);
        (self.siftCondition):InitAthEfccOneKeyFilt(
            BindCallback(self, self.OnFilterConfirmAction))
    end
    (self.siftCondition):Show()
end

UIAthEfficiency.OnFilterConfirmAction = function(self, filtData)
    -- function num : 0_8
    self._onekeyFiltData = filtData
    self:__OnAutoSelect()
end

UIAthEfficiency.__OnAutoSelect = function(self)
    -- function num : 0_9 , upvalues : _ENV
    self:RefreshCurAthEfficency()
    local noSelectAny = true
    local selectMat = (self._onekeyFiltData)[4]
    for k, select in pairs(self._onekeyFiltData) do
        if select then noSelectAny = false end
    end
    do
        if noSelectAny or selectMat then
            local matList = {}
            local matItemList = (self.athMatUpNode):GetAthMatItemList()
            for k, v in pairs(matItemList) do
                local matItemId = v:GetHeroLvUpItemId()
                local itemData = (PlayerDataCenter.itemDic)[matItemId]
                if itemData ~= nil then
                    (table.insert)(matList, {
                        itemId = matItemId,
                        exp = itemData:GetActionArg(1),
                        count = itemData:GetCount(),
                        matItem = v
                    })
                end
            end
            (table.sort)(matList, function(a, b)
                -- function num : 0_9_0
                do return b.exp < a.exp end
                -- DECOMPILER ERROR: 1 unprocessed JMP targets
            end)
            for k, data in ipairs(matList) do
                for i = 1, data.count do
                    if self.ableAddExp > 0 then
                        (data.matItem):AddOne()
                    else
                        break
                    end
                end
            end
        end
        do
            if self.ableAddExp > 0 then
                local tempList = (PlayerDataCenter.allAthData):GetAllAthList(
                                     nil, true)
                local athList = {}
                for k, athData in ipairs(tempList) do
                    local qualityID = athData:GetAthQuality() - 2
                    if ((self._onekeyFiltData)[qualityID] or noSelectAny) and
                        not athData.lockUnlock then
                        (table.insert)(athList, athData)
                    end
                end
                (table.sort)(athList, function(a, b)
                    -- function num : 0_9_1
                    local qualityA = a:GetAthQuality()
                    local qualityB = b:GetAthQuality()
                    if a.uid >= b.uid then
                        do return qualityA ~= qualityB end
                        do return qualityA < qualityB end
                        -- DECOMPILER ERROR: 4 unprocessed JMP targets
                    end
                end)
                for k, athData in ipairs(athList) do
                    if self.ableAddExp > 0 then
                        local exp = (athData.athCfg).shard -- DECOMPILER ERROR at PC122: Confused about usage of register: R11 in 'UnsetPending'
                        ;
                        (self.athSelectedDic)[athData.uid] = true
                        self:__OnAthExpAdd(exp)
                    else
                        break
                    end
                end
            end
            do

                (self.sortListNode):SetAthListMultSeletedUidDic(
                    self.athSelectedDic);
                (self.sortListNode):RefillCurAthSortList()
            end
        end
    end
end

UIAthEfficiency.__OnClickAthItem = function(self, athItem)
    -- function num : 0_10 , upvalues : cs_MessageCommon, _ENV
    local athData = athItem:GetAthItemData()
    if athData.lockUnlock then
        (cs_MessageCommon.ShowMessageTips)(
            ConfigData:GetTipContent(TipContent.Ath_CantSelectLockAth))
        return
    end
    local exp = (athData.athCfg).shard
    if (self.athSelectedDic)[athData.uid] == nil then
        if self.ableAddExp <= 0 then
            (cs_MessageCommon.ShowMessageTips)(
                ConfigData:GetTipContent(TipContent.Ath_AreaUpExpIsFull))
            return
        end -- DECOMPILER ERROR at PC33: Confused about usage of register: R4 in 'UnsetPending'
        
        (self.athSelectedDic)[athData.uid] = true
        self:__OnAthExpAdd(exp)
        athItem:SetAthItemSelect(true, true)
    else
        -- DECOMPILER ERROR at PC44: Confused about usage of register: R4 in 'UnsetPending'


        (self.athSelectedDic)[athData.uid] = nil
        self:__OnAthExpAdd(-exp)
        athItem:SetAthItemSelect(false)
    end
    (self.sortListNode):SetAthListMultSeletedUidDic(self.athSelectedDic)
end

UIAthEfficiency.__OnClickUpgrade = function(self)
    -- function num : 0_11 , upvalues : _ENV, cs_MessageCommon
    if self:__GetAddExp() <= 0 then return end
    local itemDic = (self.athMatUpNode):GetAthMatExpAddItemDic()
    local athDic = self.athSelectedDic
    if self.__onUpComplete == nil then
        self.__onUpComplete = BindCallback(self, self.OnAthAreaUpgradeComplete)
    end
    self.oldEfccStr = ((self.ui).tex_CurNum).text
    local hasOrangeAth = false
    for uid, v in pairs(athDic) do
        local athData = ((PlayerDataCenter.allAthData).athDic)[uid]
        if athData:GetAthQuality() == eItemQualityType.Orange then
            hasOrangeAth = true
        end
    end
    local requestFunc = function()
        -- function num : 0_11_0 , upvalues : self, itemDic, athDic
        (self.athNetwork):CS_ATH_SlotUpgrade((self.heroData).dataId, itemDic,
                                             athDic, self.__onUpComplete)
    end

    if hasOrangeAth then
        (cs_MessageCommon.ShowMessageBox)(
            ConfigData:GetTipContent(TipContent.Ath_EfficiencyUpContainOrangeAth),
            requestFunc, nil)
    else
        requestFunc()
    end
end

UIAthEfficiency.OnAthAreaUpgradeComplete =
    function(self)
        -- function num : 0_12 , upvalues : _ENV
        self:RefreshCurAthEfficency()
        if self.oldEfccStr ~= self.curEfccStr then
            UIManager:ShowWindowAsync(UIWindowTypeID.AthEfficiencyUpSuccess,
                                      function(window)
                -- function num : 0_12_0 , upvalues : self
                if window == nil then return end
                window:InitAthEffiUpSuccess(self.oldEfccStr, self.curEfccStr)
            end)
        end
    end

UIAthEfficiency.__OnClickBack = function(self)
    -- function num : 0_13
    self:Delete()
end

UIAthEfficiency.OnDelete = function(self)
    -- function num : 0_14 , upvalues : base
    (self.sortListNode):Delete()
    if self.siftCondition ~= nil then (self.siftCondition):Delete() end
    (base.OnDelete)(self)
end

return UIAthEfficiency

