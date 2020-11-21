-- params : ...
-- function num : 0 , upvalues : _ENV
local UIHeroLevelUp = class("UIHeroLevelUp", UIBaseWindow)
local base = UIBaseWindow
local UINResourceGroup = require("Game.CommonUI.ResourceGroup.UINResourceGroup")
local UINHeroLevelUpItem = require(
                               "Game.Hero.NewUI.UpgradeLevel.UINHeroLevelUpItem")
local UINStarUpAttrItem = require(
                              "Game.Hero.NewUI.UpgradeStar.UINStarUpAttrItem")
local cs_ResLoader = CS.ResLoader
UIHeroLevelUp.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, UINResourceGroup, UINHeroLevelUpItem, UINStarUpAttrItem
    self.isClosing = false
    self.growupItemNums = {}
    self.growupItemList = {}
    self.networkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Hero);
    (UIUtil.CreateTopBtnGroup)((self.ui).obj_topButtonGroup, self,
                               self.OnClickBack, true)
    self.resourceGroup = (UINResourceGroup.New)();
    (self.resourceGroup):Init((self.ui).obj_gameResourceGroup)
    self.growupItemPool = (UIItemPool.New)(UINHeroLevelUpItem,
                                           (self.ui).upgradeItem);
    ((self.ui).upgradeItem):SetActive(false)
    self.attrItemPool = (UIItemPool.New)(UINStarUpAttrItem, (self.ui).attriItem);
    ((self.ui).attriItem):SetActive(false);
    (UIUtil.AddButtonListener)((self.ui).btn_StarUp, self, self.OnClickLevelUp);
    (UIUtil.AddButtonListener)((self.ui).btn_ClearSelect, self,
                               self.OnClickClean);
    (UIUtil.AddButtonListener)((self.ui).btn_LeftArrow, self,
                               self.__OnClickLeftArrow);
    (UIUtil.AddButtonListener)((self.ui).btn_RightArrow, self,
                               self.__OnClickRightArrow)
    self.__refreshItem = BindCallback(self, self.RefreshItem)
    MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__refreshItem)
    self.__refresh = BindCallback(self, self.Refresh)
    MsgCenter:AddListener(eMsgEventId.UpdateHero, self.__refresh)
    self:InitAllTween()
end

UIHeroLevelUp.InitAllTween = function(self)
    -- function num : 0_1 , upvalues : _ENV
    self.allTweens = (self.transform):GetComponentsInChildren(
                         typeof(((CS.DG).Tweening).DOTweenAnimation))
    for i = 0, (self.allTweens).Length - 1 do
        local tween = (self.allTweens)[i]
    end
end

UIHeroLevelUp.InitHeroLevelUp = function(self, heroData, resloader,
                                         hideCallBack, switchHeroFunc)
    -- function num : 0_2 , upvalues : _ENV
    (UIUtil.Push2BackStack)(self, self.OnClickBack)
    self:PlayAllDOTween()
    self.heroData = heroData
    self.resloader = resloader
    self.hideCallBack = hideCallBack
    self.switchHeroFunc = switchHeroFunc
    self.heroId = heroData.dataId
    self.level = heroData.level
    self.curExp = heroData.curExp
    self.isClosing = false
    self:RefreshHeroStaticInfo()
    self:RefreshCurrency()
    self:RefreshLevelUpItems()
    self:CalAndShowExpBar()
end

UIHeroLevelUp.SwitchHero = function(self, heroData, reUseBigImgResloader)
    -- function num : 0_3
    self:PlayAllDOTween()
    self.heroData = heroData
    self.heroId = heroData.dataId
    self.level = heroData.level
    self.curExp = heroData.curExp
    self.isClosing = false
    self:RefreshHeroStaticInfo(reUseBigImgResloader)
    self:RefreshCurrency()
    self:CalAndShowExpBar()
end

UIHeroLevelUp.RefreshItem = function(self)
    -- function num : 0_4
    self:RefreshLevelUpItems()
    self:CalAndShowExpBar()
end

UIHeroLevelUp.Refresh = function(self)
    -- function num : 0_5 , upvalues : _ENV
    local heroData = (PlayerDataCenter.heroDic)[self.heroId]
    self.level = heroData.level
    self.curExp = heroData.curExp
    self:OnClickClean()
    self:CalAndShowExpBar()
end

UIHeroLevelUp.RefreshHeroStaticInfo = function(self, reUseBigImgResloader)
    -- function num : 0_6 , upvalues : _ENV, cs_ResLoader
    local campIcon = (LanguageUtil.GetLocaleText)(
                         ((self.heroData):GetCampCfg()).icon);
    (self.resloader):LoadABAssetAsync(PathConsts:GetCampPicPath(campIcon),
                                      function(texture)
        -- function num : 0_6_0 , upvalues : _ENV, self
        if IsNull(self.transform) then return end -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'
        
        ((self.ui).img_Camp).texture = texture
    end)
    if reUseBigImgResloader ~= nil then
        (self.bigImgGameObject):SetActive(false)
        reUseBigImgResloader:LoadABAssetAsync(
            PathConsts:GetCharacterBigImgPrefabPath((self.heroData):GetResName()),
            function(prefab)
                -- function num : 0_6_1 , upvalues : _ENV, self
                DestroyUnityObject(self.bigImgGameObject)
                self.bigImgGameObject = prefab:Instantiate((self.ui).heroHolder)
                local commonPicCtrl = (self.bigImgGameObject):FindComponent(
                                          eUnityComponentID.CommonPicController)
                commonPicCtrl:SetPosType("HeroList")
            end)
    else
        if self.bigImgResloader ~= nil then
            (self.bigImgResloader):Put2Pool()
        end
        self.bigImgResloader = (cs_ResLoader.Create)();
        (self.bigImgResloader):LoadABAssetAsync(
            PathConsts:GetCharacterBigImgPrefabPath((self.heroData):GetResName()),
            function(prefab)
                -- function num : 0_6_2 , upvalues : _ENV, self
                DestroyUnityObject(self.bigImgGameObject)
                self.bigImgGameObject = prefab:Instantiate((self.ui).heroHolder)
                local commonPicCtrl = (self.bigImgGameObject):FindComponent(
                                          eUnityComponentID.CommonPicController)
                commonPicCtrl:SetPosType("HeroList")
            end)
    end
end

UIHeroLevelUp.RefreshCurrency = function(self, isFullLevel)
    -- function num : 0_7 , upvalues : _ENV
    if isFullLevel then
        (self.resourceGroup):Hide();
        ((self.ui).obj_CurrencyCost):SetActive(false)
        return
    else

        (self.resourceGroup):Show();
        ((self.ui).obj_CurrencyCost):SetActive(true)
    end
    if self.currencyId ~= nil then
        (self.resourceGroup):SetResourceIds({self.currencyId});
        ((self.ui).obj_CurrencyCost):SetActive(true)
        local itemCfg = (ConfigData.item)[self.currencyId]
        if itemCfg == nil then
            error("itemCfg read error id=" .. self.currencyId)
        else
            -- DECOMPILER ERROR at PC52: Confused about usage of register: R3 in 'UnsetPending'


            ((self.ui).img_CurrencyItem).sprite = CRH:GetSprite(itemCfg.icon)
        end
        ((self.ui).tex_CurrencyCost):SetIndex(0, tostring(self.needCurrencyNum))
    else
        do

            (self.resourceGroup):Hide();
            ((self.ui).obj_CurrencyCost):SetActive(false)
        end
    end
end

UIHeroLevelUp.UpdateAttr = function(self, newLevel)
    -- function num : 0_8 , upvalues : _ENV
    (self.attrItemPool):HideAll()
    local changeList = (self.heroData):GetDifferAttrWhenRankUp(nil, newLevel)
    if #changeList >= 10 then
        for index, data in ipairs(changeList) do
            if index <= 10 then
                do
                    local item = (self.attrItemPool):GetOne()
                    item:InitAttrItem(data.oldAttr, data.newAttr, data.attrId)
                    -- DECOMPILER ERROR at PC25: LeaveBlock: unexpected jumping out IF_THEN_STMT

                    -- DECOMPILER ERROR at PC25: LeaveBlock: unexpected jumping out IF_STMT

                end
            end
        end
    else
        if #changeList < 10 then
            local showedIds = {}
            local num = #changeList
            for index, data in ipairs(changeList) do
                (table.insert)(showedIds, data.attrId)
            end
            for _, attrId in ipairs((ConfigData.attribute).baseAttrIds) do
                -- DECOMPILER ERROR at PC65: Unhandled construct in 'MakeBoolean' P1

                if ((ConfigData.attribute)[attrId]).merge_attribute == 0 and num <
                    10 then
                    do
                        if not (table.contain)(showedIds, attrId) then
                            num = num + 1;
                            (table.insert)(changeList, {
                                attrId = attrId,
                                property = ((ConfigData.attribute)[attrId]).attribute_priority,
                                oldAttr = (self.heroData):GetAttr(attrId, nil,
                                                                  true),
                                newAttr = nil
                            })
                        end
                        -- DECOMPILER ERROR at PC85: LeaveBlock: unexpected jumping out IF_THEN_STMT

                        -- DECOMPILER ERROR at PC85: LeaveBlock: unexpected jumping out IF_STMT

                    end
                end
            end
            (table.sort)(changeList, function(a, b)
                -- function num : 0_8_0
                if a.attrId >= b.attrId then
                    do return a.property ~= b.property end
                    do return a.property < b.property end
                    -- DECOMPILER ERROR: 4 unprocessed JMP targets
                end
            end)
            for index, data in ipairs(changeList) do
                local item = (self.attrItemPool):GetOne()
                item:InitAttrItem(data.oldAttr, data.newAttr, data.attrId)
            end
        end
    end
end

UIHeroLevelUp.RefreshLevelUpItems = function(self)
    -- function num : 0_9 , upvalues : _ENV
    (self.growupItemPool):HideAll()
    for _, id in ipairs(((ConfigData.item).growUpIds)[eItemActionType.HeroExp]) do
        if (PlayerDataCenter.itemDic)[id] ~= nil then
            local itemData = (PlayerDataCenter.itemDic)[id]
            do
                local item = (self.growupItemPool):GetOne(true) -- DECOMPILER ERROR at PC28: Confused about usage of register: R8 in 'UnsetPending'
                ;
                (item.gameObject).name = tostring(id)
                item:InitExpItem(itemData, function(num)
                    -- function num : 0_9_0 , upvalues : self, itemData
                    -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

                    (self.growupItemNums)[itemData] = num
                    self:CalAndShowExpBar()
                end);
                (table.insert)(self.growupItemList, item)
            end
        else
            do
                do
                    local item = (self.growupItemPool):GetOne(true)
                    item:InitEmptyExpItem(id)
                    -- DECOMPILER ERROR at PC47: LeaveBlock: unexpected jumping out DO_STMT

                    -- DECOMPILER ERROR at PC47: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                    -- DECOMPILER ERROR at PC47: LeaveBlock: unexpected jumping out IF_STMT

                end
            end
        end
    end
end

UIHeroLevelUp.UpdateLevel = function(self, level)
    -- function num : 0_10 , upvalues : _ENV
    self:UpdateAttr(level)
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

    if self.level <= 9 then
        ((self.ui).tex_curLv).text = "0" .. tostring(self.level)
    else
        -- DECOMPILER ERROR at PC20: Confused about usage of register: R2 in 'UnsetPending'


        ((self.ui).tex_curLv).text = tostring(self.level)
    end
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R2 in 'UnsetPending'

    if level <= 9 then
        ((self.ui).tex_NextLv).text = "0" .. tostring(level)
    else
        -- DECOMPILER ERROR at PC37: Confused about usage of register: R2 in 'UnsetPending'


        ((self.ui).tex_NextLv).text = tostring(level)
    end
end

UIHeroLevelUp.CalAndShowExpBar = function(self, level, curExp, addExp)
    -- function num : 0_11 , upvalues : _ENV
    self:RefreshConfirmBtn()
    level = level or self.level or 1
    curExp = curExp or self.curExp or 0
    addExp = addExp or self:_CalAddExp() or 0
    local requireExp = ((ConfigData.hero_level)[level]).exp
    local maxAddExp = -(curExp)
    for i = level, (ConfigData.game_config).heroMaxLevel - 1 do
        maxAddExp = maxAddExp + ((ConfigData.hero_level)[i]).exp
    end
    self:SetAddExpLimt(maxAddExp, addExp);
    ((self.ui).tex_Exp):SetIndex(0, tostring(curExp), tostring(requireExp));
    ((self.ui).tex_AddExp):SetIndex(0, tostring(addExp))
    -- DECOMPILER ERROR at PC69: Confused about usage of register: R6 in 'UnsetPending'

    if (curExp) + (addExp) < requireExp then
        ((self.ui).img_Exp).fillAmount = ((curExp) + (addExp)) / requireExp;
        ((self.ui).tex_Exp):SetIndex(0, tostring((curExp) + (addExp)),
                                     tostring(requireExp))
        self:UpdateLevel(level)
    else
        local remainEXP = (curExp) + (addExp) - requireExp
        if (ConfigData.game_config).heroMaxLevel >= (level) + 1 then
            level = (level) + 1
            requireExp = ((ConfigData.hero_level)[level]).exp
            while 1 do
                if requireExp <= remainEXP then
                    remainEXP = remainEXP - requireExp
                    if (ConfigData.game_config).heroMaxLevel >= level + 1 then
                        level = level + 1
                        requireExp = ((ConfigData.hero_level)[level]).exp
                        -- DECOMPILER ERROR at PC112: LeaveBlock: unexpected jumping out IF_THEN_STMT

                        -- DECOMPILER ERROR at PC112: LeaveBlock: unexpected jumping out IF_STMT

                        -- DECOMPILER ERROR at PC112: LeaveBlock: unexpected jumping out IF_THEN_STMT

                        -- DECOMPILER ERROR at PC112: LeaveBlock: unexpected jumping out IF_STMT

                    end
                end
            end
        end -- DECOMPILER ERROR at PC116: Confused about usage of register: R7 in 'UnsetPending'
        
        ((self.ui).img_Exp).fillAmount = (remainEXP) / requireExp;
        ((self.ui).tex_Exp):SetIndex(0, tostring(remainEXP),
                                     tostring(requireExp))
        self:UpdateLevel(level)
    end
end

UIHeroLevelUp._CalAddExp = function(self)
    -- function num : 0_12 , upvalues : _ENV
    local totalExp = 0
    for itemData, num in pairs(self.growupItemNums) do
        totalExp = totalExp + itemData:GetActionArg(1) * num
    end
    return totalExp
end

UIHeroLevelUp.SetAddExpLimt = function(self, maxAddExp, addExp)
    -- function num : 0_13 , upvalues : _ENV
    for _, item in ipairs(self.growupItemList) do
        item:SetAddExpLimt(maxAddExp, addExp)
    end
end

UIHeroLevelUp.RefreshConfirmBtn = function(self)
    -- function num : 0_14 , upvalues : _ENV
    -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

    ((self.ui).img_StarUp).color = (self.ui).color_gray -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'
    ;
    ((self.ui).img_ClearSelect).color = (self.ui).color_gray -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'
    ;
    ((self.ui).btn_StarUp).interactable = false -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'
    ;
    ((self.ui).btn_ClearSelect).interactable = false
    if (table.count)(self.growupItemNums) ~= 0 then
        for itemId, num in pairs(self.growupItemNums) do
            -- DECOMPILER ERROR at PC32: Confused about usage of register: R6 in 'UnsetPending'

            if num > 0 then
                ((self.ui).img_StarUp).color = (self.ui).color_orange -- DECOMPILER ERROR at PC37: Confused about usage of register: R6 in 'UnsetPending'
                ;
                ((self.ui).img_ClearSelect).color = (self.ui).color_black -- DECOMPILER ERROR at PC40: Confused about usage of register: R6 in 'UnsetPending'
                ;
                ((self.ui).btn_StarUp).interactable = true -- DECOMPILER ERROR at PC43: Confused about usage of register: R6 in 'UnsetPending'
                ;
                ((self.ui).btn_ClearSelect).interactable = true
            end
        end
    end
end

UIHeroLevelUp.OnClickLevelUp = function(self)
    -- function num : 0_15 , upvalues : _ENV
    if (table.count)(self.growupItemNums) == 0 then return end
    local itemTab = {}
    for itemData, num in pairs(self.growupItemNums) do
        itemTab[itemData.dataId] = num
    end
    if self.networkCtrl ~= nil then
        (self.networkCtrl):SendHeroAddExp(self.heroId, itemTab)
    end
end

UIHeroLevelUp.OnClickClean = function(self)
    -- function num : 0_16 , upvalues : _ENV
    for _, item in ipairs(self.growupItemList) do item:CleanAll() end
    for itemData, _ in pairs(self.growupItemNums) do
        -- DECOMPILER ERROR at PC13: Confused about usage of register: R6 in 'UnsetPending'

        (self.growupItemNums)[itemData] = 0
    end
end

UIHeroLevelUp.OnClickBack = function(self)
    -- function num : 0_17 , upvalues : _ENV
    if not self.isClosing then
        self.isClosing = true
    else
        return
    end
    if self.hideCallBack ~= nil then (self.hideCallBack)() end
    UIManager:ShowWindow(UIWindowTypeID.HeroState)
    self:Hide()
end

UIHeroLevelUp.__OnClickLeftArrow = function(self)
    -- function num : 0_18
    if self.switchHeroFunc ~= nil then
        local newHeroData, reUseBigImgResloader = (self.switchHeroFunc)(-1)
        self:SwitchHero(newHeroData, reUseBigImgResloader)
    end
end

UIHeroLevelUp.__OnClickRightArrow = function(self)
    -- function num : 0_19
    if self.switchHeroFunc ~= nil then
        local newHeroData, reUseBigImgResloader = (self.switchHeroFunc)(1)
        self:SwitchHero(newHeroData, reUseBigImgResloader)
    end
end

UIHeroLevelUp.PlayAllDOTween = function(self)
    -- function num : 0_20
    for i = 0, (self.allTweens).Length - 1 do
        local tween = (self.allTweens)[i]
        tween:DORestart(false)
    end
end

UIHeroLevelUp.BackwardsAllDOTween = function(self, callback)
    -- function num : 0_21 , upvalues : _ENV
    local longestDuration = 0
    for i = 0, (self.allTweens).Length - 1 do
        local tween = (self.allTweens)[i]
        if longestDuration < tween.duration then
            longestDuration = tween.duration + tween.delay
        end
        tween:DOPlayBackwards()
    end
    if callback ~= nil then
        (TimerManager:GetTimer(longestDuration, callback, nil, true)):Start()
    end
end

UIHeroLevelUp.OnHide = function(self)
    -- function num : 0_22 , upvalues : base
    (base.OnHide)(self)
    if self.closeEvent ~= nil then
        (self.closeEvent)()
        self.closeEvent = nil
    end
end

UIHeroLevelUp.OnDelete = function(self)
    -- function num : 0_23 , upvalues : _ENV, base
    MsgCenter:RemoveListener(eMsgEventId.UpdateHero, self.__refresh)
    MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__refreshItem);
    (self.growupItemPool):DeleteAll();
    (self.resourceGroup):Delete();
    (base.OnDelete)(self)
end

return UIHeroLevelUp

