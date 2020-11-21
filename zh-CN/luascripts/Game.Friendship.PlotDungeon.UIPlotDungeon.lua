-- params : ...
-- function num : 0 , upvalues : _ENV
local UIPlotDungeon = class("UIPlotDungeon", UIBaseWindow)
local base = UIBaseWindow
local HeroDungeonItemList = require(
                                "Game.CommonUI.DungeonPanelWidgets.UIDungeonItemList")
local UIHeroDungeonData = require(
                              "Game.CommonUI.DungeonPanelWidgets.UIDungeonData.UIDungeonData")
local UIHeroDungeonItem = require(
                              "Game.Friendship.PlotDungeon.UIHeroDungeonItem")
local UIHeroDungeonChapterList = require(
                                     "Game.CommonUI.DungeonPanelWidgets.UIDungeonChapterList")
local UIHeroChapterItem = require(
                              "Game.Friendship.PlotDungeon.UIHeroChapterItem")
local RewardItem = require("Game.CommonUI.Item.UINBaseItem")
local eFmtFromModule = require("Game.Formation.Enum.eFmtFromModule")
local filterItem = require("Game.Friendship.PlotDungeon.UIFilterItem")
local UIDungeonUtil = require(
                          "Game.CommonUI.DungeonPanelWidgets.UIDungeonData.UIDungeonUtil")
local HeroStoryItem = require("Game.Friendship.PlotDungeon.UIDungeonStoryItem")
local UINResourceGroup = require("Game.CommonUI.ResourceGroup.UINResourceGroup")
local cs_MessageCommon = CS.MessageCommon
local cs_ResLoader = CS.ResLoader
local CS_GSceneManager_Ins = (CS.GSceneManager).Instance
UIPlotDungeon.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, filterItem, UINResourceGroup
    self.moduelId = proto_csmsg_SystemFunctionID.SystemFunctionID_friendship;
    (UIUtil.CreateTopBtnGroup)((self.ui).topButtonGroup, self, self.__onBack)
    self.originItemDataList = {}
    self.heroItemDataList = {}
    self.heroItemDataIdDict = {}
    self.heroItemInsDict = {}
    self.onBattleStart = BindCallback(self, self.OnBattleStart)
    self.battleDungeonNetworkCtrl = NetworkManager:GetNetwork(
                                        NetworkTypeID.BattleDungeon)
    self.filterEvent = BindCallback(self, self.FilterItemAndUpdateList)
    self.filterParam = 0 -- DECOMPILER ERROR at PC37: Confused about usage of register: R1 in 'UnsetPending'
    ;
    ((self.ui).tex_CampName).text = "全部"
    self.filterParamDict = {};
    (UIUtil.AddButtonListener)((self.ui).btn_CampDrop, self, self.__dropCamList)
    self.campFilterItemPool = (UIItemPool.New)(filterItem,
                                               (self.ui).btn_CampItem)
    self.onfilterItemClick = BindCallback(self, self.OnClickFilterItem)
    self.resourceGroup = (UINResourceGroup.New)();
    (self.resourceGroup):Init((self.ui).gameResourceGroup);
    (self.resourceGroup):SetResourceIds({ItemIdOfKey})
    self.__onDailyLimitUpdate = BindCallback(self, self.__dailyLimitUpdate)
    MsgCenter:AddListener(eMsgEventId.OnBattleDungeonLimitChange,
                          self.__onDailyLimitUpdate)
end

UIPlotDungeon.InitPlotDungeon = function(self, heroId, sector3DWindow,
                                         onBackCallback)
    -- function num : 0_1 , upvalues : _ENV, cs_ResLoader
    if heroId == nil then
        heroId = (ConfigData.game_config).FriendshipDungeonDefaultHeroIndex
    end
    self.resLoader = (cs_ResLoader.Create)()
    self.selectHeroId = heroId
    if sector3DWindow ~= nil then self.sector3DWindow = sector3DWindow end
    if onBackCallback ~= nil then self.onBackCallback = onBackCallback end
    self:__updateDailyChanceAndStrength()
    self:__prepareHeroItemData()
    self:__loadHeroDungeonList(self.selectItemIndex)
end

UIPlotDungeon.__dailyLimitUpdate = function(self)
    -- function num : 0_2 , upvalues : _ENV
    for k, v in ipairs(self.heroItemDataList) do
        if v ~= nil then v:ForceUpdate() end
    end
    (self.heroItemList):ExecuteFilter((self.filterParamDict)[self.filterParam])
    self:__updateDailyChanceAndStrength()
end

UIPlotDungeon.__updateDailyChanceAndStrength =
    function(self)
        -- function num : 0_3 , upvalues : UIDungeonUtil, _ENV
        if self.dungeonUtil == nil then
            self.dungeonUtil = (UIDungeonUtil.New)()
        end
        self.totalLimit =
            ((ConfigData.game_config).DailyDungeonLimt)[self.moduelId]
        self.usedLimit = (self.dungeonUtil):GetDailyTotalAndUsedLimit(
                             self.moduelId);
        ((self.ui).tex_LimitCount):SetIndex(0, tostring(
                                                self.totalLimit - self.usedLimit),
                                            tostring(self.totalLimit))
    end

UIPlotDungeon.__loadHeroDungeonList = function(self, selectItemIndex)
    -- function num : 0_4 , upvalues : HeroDungeonItemList, _ENV
    self.heroItemList = (HeroDungeonItemList.New)();
    (self.heroItemList):Init((self.ui).heroList);
    (self.heroItemList):InjectDataAndFilterEvent(self.heroItemDataList);
    (self.heroItemList):InjectItemInitEvent(BindCallback(self, self.__InitItem));
    (self.heroItemList):InjectItemUpdateEvent(
        BindCallback(self, self.__UpdateDungeonItem));
    (self.heroItemList):LoadItemList(selectItemIndex)
end

UIPlotDungeon.__InitItem = function(self, go)
    -- function num : 0_5 , upvalues : UIHeroDungeonItem, _ENV
    local item = (UIHeroDungeonItem.New)()
    item:Init(go)
    local onclick = BindCallback(self, self.__onClickItem, go)
    item:InjectResLoaderAndClickEvent(self.resLoader, onclick) -- DECOMPILER ERROR at PC15: Confused about usage of register: R4 in 'UnsetPending'
    ;
    (self.heroItemInsDict)[go] = item
end

UIPlotDungeon.__onClickItem = function(self, go)
    -- function num : 0_6
    self:OnSelectItemEvent(go)
end

UIPlotDungeon.__UpdateDungeonItem = function(self, go, index)
    -- function num : 0_7
    local item = (self.heroItemInsDict)[go]
    local data = (self.heroItemDataList)[index + 1]
    if item ~= nil and data ~= nil then
        item:OnUpdateWithData(data)
        go.name = data.itemId
        if self.selectHeroId == data.itemId then
            self.selectItem = item
            self:__updateSelectHeroDisplay(item, go)
        else
            if self.selectInsGo ~= nil and self.selectInsGo == go then
                ((self.ui).img_Select):SetActive(false)
            end
        end
    end
end

UIPlotDungeon.OnSelectItemEvent = function(self, go)
    -- function num : 0_8
    if self.heroItemInsDict == nil then return end
    local item = (self.heroItemInsDict)[go]
    if item == nil then return end
    self.selectHeroId = (item.data).itemId
    self.selectItem = item
    self:__updateSelectHeroDisplay(item, go)
end

UIPlotDungeon.__updateSelectHeroDisplay =
    function(self, item, itemGo)
        -- function num : 0_9 , upvalues : _ENV, cs_ResLoader
        local heroUIData = item.data
        if self.selectHeroId == nil or heroUIData == nil then return end -- DECOMPILER ERROR at PC13: Confused about usage of register: R4 in 'UnsetPending'
        
        ((self.ui).tex_StoryName).text =
            (LanguageUtil.GetLocaleText)(heroUIData.desName) -- DECOMPILER ERROR at PC20: Confused about usage of register: R4 in 'UnsetPending'
        ;
        ((self.ui).tex_StoryDescr).text =
            (LanguageUtil.GetLocaleText)(heroUIData.desInfo);
        (((self.ui).img_Select).transform):SetParent(item.transform, false);
        ((self.ui).img_Select):SetActive(true)
        self.selectInsGo = itemGo
        if (self.ui).heroHolder == nil then return end
        self:__loadBgImg(item)
        if self.heroPrefabResloader ~= nil then
            (self.heroPrefabResloader):Put2Pool()
        end
        self.heroPrefabResloader = (cs_ResLoader.Create)()
        DestroyUnityObject(self.heroImgIns);
        (self.heroPrefabResloader):LoadABAssetAsync(
            PathConsts:GetCharacterBigImgPrefabPath(heroUIData.itemIcon),
            function(prefab)
                -- function num : 0_9_0 , upvalues : _ENV, self
                DestroyUnityObject(self.bigImgGameObject)
                self.bigImgGameObject = prefab:Instantiate((self.ui).heroHolder)
                local commonPicCtrl = (self.bigImgGameObject):FindComponent(
                                          eUnityComponentID.CommonPicController)
                commonPicCtrl:SetPosType("HeroDungeon")
            end)
        self:__loadChapterUI(heroUIData)
        self:__loadAvgUI(heroUIData)
    end

UIPlotDungeon.__loadAvgUI = function(self, heroUIData)
    -- function num : 0_10 , upvalues : _ENV, HeroStoryItem
    if heroUIData.storyList ~= nil and #heroUIData.storyList > 0 then
        if self.storyItemPool == nil then
            self.storyItemPool = (UIItemPool.New)(HeroStoryItem,
                                                  (self.ui).storyItem)
        end
        (self.storyItemPool):HideAll()
        for i = 1, #heroUIData.storyList do
            local storyItem = (self.storyItemPool):GetOne()
            storyItem:InitWithData((heroUIData.storyList)[i])
            if not storyItem.isUnlock then return end
        end
    end
end

UIPlotDungeon.__loadChapterUI = function(self, heroUIData)
    -- function num : 0_11 , upvalues : UIHeroDungeonChapterList, UIHeroChapterItem, RewardItem, _ENV
    if self.chaptersUI == nil then
        self.chaptersUI = (UIHeroDungeonChapterList.New)();
        (self.chaptersUI):Init((self.ui).levelRewardNode)
    end
    if self.chaptersItemPool == nil or self.fstRewardItemPool == nil or
        self.mbRewardItemPool == nil then
        self.chaptersItemPool = (self.chaptersUI):CreatePool(UIHeroChapterItem,
                                                             RewardItem,
                                                             RewardItem)
    end
    (self.chaptersItemPool):HideAll();
    (self.fstRewardItemPool):HideAll();
    (self.mbRewardItemPool):HideAll()
    heroUIData:CalcUnLockedAndProgress()
    local chapterItemList = {}
    for index = 1, #heroUIData.dungeonCfgList do
        local item = (self.chaptersItemPool):GetOne()
        local itemState, lockReason = heroUIData:GetChapterState(
                                          ((heroUIData.dungeonCfgList)[index]).id)
        item:InitWithData((heroUIData.dungeonCfgList)[index], itemState, index,
                          self.fstRewardItemPool, self.mbRewardItemPool,
                          self.moduelId, lockReason);
        (table.insert)(chapterItemList, item)
    end
    (self.chaptersUI):UpdateWithChapterList(chapterItemList,
                                            heroUIData.totalCompleteChapterCount,
                                            heroUIData.totalChapterCount,
                                            self.onBattleStart)
end

UIPlotDungeon.OnBattleStart = function(self)
    -- function num : 0_12 , upvalues : cs_MessageCommon, _ENV, base, CS_GSceneManager_Ins, eFmtFromModule
    self.selectChapterItem = (self.chaptersUI).selectChapterItem
    if self.totalLimit <= self.usedLimit then
        (cs_MessageCommon.ShowMessageTips)(
            ConfigData:GetTipContent(TipContent.BattleDungeon_DailyLimit))
        return
    end
    if not (self.selectChapterItem):CheckDailyLimit() then
        (cs_MessageCommon.ShowMessageTips)(
            ConfigData:GetTipContent(TipContent.BattleDungeon_DailyLimit))
        return
    end
    if (PlayerDataCenter.stamina).value <
        (self.selectChapterItem).costStrengthNum then
        (cs_MessageCommon.ShowMessageTips)(
            ConfigData:GetTipContent(TipContent.Sector_LackOfStamina))
        return
    end
    for id, count in pairs((self.selectChapterItem).costItemData) do
        if count ~= nil and count > 0 then
            local itemNum = PlayerDataCenter:GetItemCount(id)
            if itemNum < count then
                (cs_MessageCommon.ShowMessageTips)("消耗道具数量不足")
                return
            end
        end
    end
    local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation,
                                                    true)
    local enterFormationFunc = function()
        -- function num : 0_12_0 , upvalues : self, base, _ENV
        if (self.sector3DWindow).ui ~= nil then
            (((self.sector3DWindow).ui).sectorDungeonRoot):SetActive(false)
        end
        (base.Hide)(self)
        UIManager:HideWindow(UIWindowTypeID.Sector)
    end

    local exitFormationFunc = function()
        -- function num : 0_12_1 , upvalues : self, base, _ENV
        if (self.sector3DWindow).ui ~= nil then
            (((self.sector3DWindow).ui).sectorDungeonRoot):SetActive(true)
        end
        (base.Show)(self)
        UIManager:ShowWindow(UIWindowTypeID.Sector)
    end

    local startBattleFunc = function(curSelectFormationId, callBack)
        -- function num : 0_12_2 , upvalues : _ENV, self, CS_GSceneManager_Ins
        local formationData =
            (PlayerDataCenter.formationDic)[curSelectFormationId]
        if formationData == nil then return end
        BattleDungeonManager:SaveFormation(formationData)
        local afterBattleWinEvent = BindCallback(self, self.AfterBattleWin,
                                                 self.selectChapterItem,
                                                 self.selectItem)
        BattleDungeonManager:InjectBattleWinEvent(afterBattleWinEvent)
        BattleDungeonManager:InjectBattleExitEvent(
            BindCallback(self, function(table, itemId)
                -- function num : 0_12_2_0 , upvalues : _ENV, self, CS_GSceneManager_Ins
                local loadFriendUIFunc =
                    BindCallback(self, function()
                        -- function num : 0_12_2_0_0 , upvalues : _ENV, itemId, self
                        UIManager:ShowWindowAsync(
                            UIWindowTypeID.FriendShipPlotDungeon,
                            function(window)
                                -- function num : 0_12_2_0_0_0 , upvalues : itemId, self, _ENV
                                if window == nil then
                                    return
                                end
                                window:InitPlotDungeon(itemId,
                                                       self.sector3DWindow,
                                                       function()
                                    -- function num : 0_12_2_0_0_0_0 , upvalues : _ENV
                                    local sectorCtrl =
                                        ControllerManager:GetController(
                                            ControllerTypeId.SectorController,
                                            true)
                                    sectorCtrl:ResetToNormalState()
                                end)
                                UIManager:HideWindow(
                                    UIWindowTypeID.ClickContinue)
                            end)
                    end)
                CS_GSceneManager_Ins:LoadSceneAsyncByAB(
                    (Consts.SceneName).Sector, function()
                        -- function num : 0_12_2_0_1 , upvalues : _ENV, loadFriendUIFunc
                        (UIManager:ShowWindow(UIWindowTypeID.ClickContinue)):InitContinue(
                            nil, nil, nil, Color.clear, false)
                        local sectorCtrl =
                            ControllerManager:GetController(
                                ControllerTypeId.SectorController, true)
                        sectorCtrl:SetFrom(AreaConst.DungeonBattle,
                                           loadFriendUIFunc)
                        sectorCtrl:OnEnterPlotOrMateralDungeon()
                    end)
            end, self.selectHeroId));
        (self.battleDungeonNetworkCtrl):CS_BATTLE_DungeonEnter(
            ((self.selectChapterItem).cfg).id, formationData, callBack)
        ControllerManager:DeleteController(ControllerTypeId.SectorController)
        UIManager:DeleteAllWindow()
    end

    fmtCtrl:InitFromationCtrl(eFmtFromModule.FriendshipDungeon,
                              ((self.selectChapterItem).cfg).id,
                              enterFormationFunc, exitFormationFunc,
                              startBattleFunc)
end

UIPlotDungeon.AfterBattleWin = function(self, selectChapterItem, selectItem)
    -- function num : 0_13 , upvalues : _ENV
    PlayerDataCenter:LocallyAddDungeonLimit((selectItem.data).moduelId,
                                            selectChapterItem.chapterId);
    (selectItem.data):CalcUnLockedAndProgress()
    selectChapterItem:UpdateLimit()
end

UIPlotDungeon.__loadBgImg = function(self, item)
    -- function num : 0_14
    -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

    ((self.ui).img_StoryBg).texture = item.img_StoryBg
end

UIPlotDungeon.__prepareHeroItemData = function(self)
    -- function num : 0_15 , upvalues : _ENV, UIHeroDungeonData
    for k, v in pairs(PlayerDataCenter.heroDic) do
        if v ~= nil then
            local heroItemData = (UIHeroDungeonData.New)()
            heroItemData.moduelId = self.moduelId
            heroItemData.itemId = v.dataId
            heroItemData.itemName = (v.heroCfg).name
            heroItemData.itemNameEn = (v.heroCfg).name_en
            heroItemData.itemIcon = (v.resCfg).res_Name
            heroItemData.itemBgImg =
                ((ConfigData.friendship_hero)[v.dataId]).dungeon_img
            heroItemData.sortParam = v.camp
            heroItemData.desName =
                ((ConfigData.friendship_hero)[v.dataId]).des_name
            heroItemData.desInfo =
                ((ConfigData.friendship_hero)[v.dataId]).des_info
            if ((ConfigData.friendship_hero)[v.dataId]).story_id ~= nil then
                local storyids =
                    ((ConfigData.friendship_hero)[v.dataId]).story_id
                if #storyids <= 0 then
                    heroItemData.storyList = nil
                else
                    for _, stId in ipairs(storyids) do
                        local storyCfg = (ConfigData.story_avg)[stId]
                        if storyCfg ~= nil then
                            (table.insert)(heroItemData.storyList, storyCfg)
                        end
                    end
                end
            end
            do
                -- DECOMPILER ERROR at PC82: Confused about usage of register: R7 in 'UnsetPending'

                if (self.filterParamDict)[heroItemData.sortParam] == nil then
                    (self.filterParamDict)[heroItemData.sortParam] = 1
                    self:InitDropFilterItem(heroItemData.sortParam)
                else
                    -- DECOMPILER ERROR at PC93: Confused about usage of register: R7 in 'UnsetPending'


                    (self.filterParamDict)[heroItemData.sortParam] =
                        (self.filterParamDict)[heroItemData.sortParam] + 1
                end
                local heroDungeonCfg =
                    ((ConfigData.friendship_hero)[v.dataId]).plot_stage
                do
                    local dungeonCfgList = {}
                    for k, v in ipairs(heroDungeonCfg) do
                        local cfg = (ConfigData.battle_dungeon)[v]
                        if cfg == nil then
                            error("read battle_dungeon error stageId:" .. v)
                        else

                            (table.insert)(dungeonCfgList, cfg)
                        end
                    end
                    heroItemData.dungeonCfgList = dungeonCfgList
                    heroItemData:CalcUnLockedAndProgress();
                    (table.insert)(self.originItemDataList, heroItemData);
                    (table.insert)(self.heroItemDataList, heroItemData) -- DECOMPILER ERROR at PC137: Confused about usage of register: R9 in 'UnsetPending'
                    ;
                    (self.heroItemDataIdDict)[v.dataId] = heroItemData
                    -- DECOMPILER ERROR at PC138: LeaveBlock: unexpected jumping out DO_STMT

                    -- DECOMPILER ERROR at PC138: LeaveBlock: unexpected jumping out IF_THEN_STMT

                    -- DECOMPILER ERROR at PC138: LeaveBlock: unexpected jumping out IF_STMT

                end
            end
        end
    end
    (table.sort)(self.heroItemDataList, function(a, b)
        -- function num : 0_15_0
        do return a.itemId < b.itemId end
        -- DECOMPILER ERROR: 1 unprocessed JMP targets
    end)
    for index, v in ipairs(self.heroItemDataList) do
        if self.selectHeroId == v.itemId then
            self.selectItemIndex = index
        end
    end -- DECOMPILER ERROR at PC159: Confused about usage of register: R1 in 'UnsetPending'
    
    (self.filterParamDict)[0] = #self.heroItemDataList
    self:InitDropFilterItem(0)
end

UIPlotDungeon.__dropCamList = function(self, isShow)
    -- function num : 0_16 , upvalues : _ENV
    if isShow ~= nil and isShow == false then
        ((self.ui).campList):SetActive(isShow) -- DECOMPILER ERROR at PC14: Confused about usage of register: R2 in 'UnsetPending'
        ;
        (((self.ui).img_Arrow).transform).localScale = Vector3.one
        return
    end
    local curActive = ((self.ui).campList).activeSelf;
    ((self.ui).campList):SetActive(not curActive)
    -- DECOMPILER ERROR at PC31: Confused about usage of register: R3 in 'UnsetPending'

    if curActive then
        (((self.ui).img_Arrow).transform).localScale = Vector3.one
    else
        -- DECOMPILER ERROR at PC42: Confused about usage of register: R3 in 'UnsetPending'


        (((self.ui).img_Arrow).transform).localScale = (Vector3.New)(1, -1, 1)
    end
end

UIPlotDungeon.InitDropFilterItem = function(self, campId)
    -- function num : 0_17
    local filterItem = (self.campFilterItemPool):GetOne()
    filterItem:InitWithData(campId)
    filterItem.clickEvent = self.onfilterItemClick
end

UIPlotDungeon.OnClickFilterItem = function(self, campId, campText)
    -- function num : 0_18 , upvalues : _ENV
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R3 in 'UnsetPending'

    ((self.ui).tex_CampName).text = campText
    self:__dropCamList(false)
    self.filterParam = campId
    if self.filterEvent ~= nil then
        self.heroItemDataList = {}
        for k, v in ipairs(self.originItemDataList) do
            if (self.filterEvent)(v.sortParam) then
                (table.insert)(self.heroItemDataList, v)
            end
        end
    end
    do

        (table.sort)(self.heroItemDataList, function(a, b)
            -- function num : 0_18_0
            do return a.itemId < b.itemId end
            -- DECOMPILER ERROR: 1 unprocessed JMP targets
        end)
        self.selectHeroId = ((self.heroItemDataList)[1]).itemId;
        (self.heroItemList):ExecuteFilter(
            (self.filterParamDict)[self.filterParam])
    end
end

UIPlotDungeon.FilterItemAndUpdateList = function(self, itemSortParam)
    -- function num : 0_19
    if self.filterParam == 0 then
        return true
    else
        return itemSortParam == self.filterParam
    end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UIPlotDungeon.__onBack = function(self)
    -- function num : 0_20 , upvalues : base
    if self.onBackCallback ~= nil then (self.onBackCallback)() end
    (base.Delete)(self)
end

UIPlotDungeon.OnDelete = function(self)
    -- function num : 0_21 , upvalues : _ENV, base
    (self.resourceGroup):Delete()
    if self.heroPrefabResloader ~= nil then
        (self.heroPrefabResloader):Put2Pool()
    end
    if self.resLoader ~= nil then (self.resLoader):Put2Pool() end
    MsgCenter:RemoveListener(eMsgEventId.OnBattleDungeonLimitChange,
                             self.__onDailyLimitUpdate);
    (base.OnDelete)(self)
end

return UIPlotDungeon

