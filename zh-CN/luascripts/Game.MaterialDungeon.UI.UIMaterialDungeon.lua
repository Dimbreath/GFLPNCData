-- params : ...
-- function num : 0 , upvalues : _ENV
local UIMaterialDungeon = class("UIMaterialDungeon", UIBaseWindow)
local base = UIBaseWindow
local UINResourceGroup = require("Game.CommonUI.ResourceGroup.UINResourceGroup")
local UIMatDungeonData = require(
                             "Game.CommonUI.DungeonPanelWidgets.UIDungeonData.UIDungeonData")
local UIMatDungeonItem = require("Game.MaterialDungeon.UI.UIMatDungeonItem")
local UIMatDungeonChapterList = require(
                                    "Game.CommonUI.DungeonPanelWidgets.UIDungeonChapterList")
local UIMatChapterItem = require("Game.MaterialDungeon.UI.UIMatChapterItem")
local RewardItem = require("Game.CommonUI.Item.UINBaseItem")
local eFmtFromModule = require("Game.Formation.Enum.eFmtFromModule")
local cs_MessageCommon = CS.MessageCommon
local cs_ResLoader = CS.ResLoader
local CS_GSceneManager_Ins = (CS.GSceneManager).Instance
UIMaterialDungeon.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, UIMatDungeonItem, UINResourceGroup
    self.moduelId =
        proto_csmsg_SystemFunctionID.SystemFunctionID_MaterialDungeon;
    (UIUtil.CreateTopBtnGroup)((self.ui).topButtonGroup, self, self.__onBack)
    self.matItemDataList = {}
    self.matItemDict = {}
    self.onBattleStart = BindCallback(self, self.OnBattleStart)
    self.dungeonItemPool = (UIItemPool.New)(UIMatDungeonItem,
                                            (self.ui).tog_DungeonItem);
    ((self.ui).tog_DungeonItem):SetActive(false)
    self.onItemClick = BindCallback(self, self.__onClickItem)
    self.battleDungeonNetworkCtrl = NetworkManager:GetNetwork(
                                        NetworkTypeID.BattleDungeon)
    self.resourceGroup = (UINResourceGroup.New)();
    (self.resourceGroup):Init((self.ui).gameResourceGroup);
    (self.resourceGroup):SetResourceIds({ItemIdOfKey})
    self.__onDailyLimitUpdate = BindCallback(self, self.__dailyLimitUpdate)
    MsgCenter:AddListener(eMsgEventId.OnBattleDungeonLimitChange,
                          self.__onDailyLimitUpdate)
end

UIMaterialDungeon.InitMatDungeon = function(self, selectItemId, sector3DWindow,
                                            onBackCallback)
    -- function num : 0_1 , upvalues : cs_ResLoader, _ENV
    self.resLoader = (cs_ResLoader.Create)()
    self.selectMaterialId = nil
    if sector3DWindow ~= nil then self.sector3DWindow = sector3DWindow end
    if onBackCallback ~= nil then self.onBackCallback = onBackCallback end
    self:__prepareMatItemData()
    self:__loadMatDungeonList()
    if selectItemId == nil then
        self.selectItemId = ((self.matItemDataList)[1]).itemId
        for k, v in ipairs(self.matItemDataList) do
            if v.moduelUnlock then
                self.selectItemId = v.itemId
                break
            end
        end
    else
        do
            self.selectItemId = selectItemId
            self.selectItem = (self.matItemDict)[self.selectItemId]
            self:__updateSelectMatItemDisplay(self.selectItem)
        end
    end
end

UIMaterialDungeon.__dailyLimitUpdate = function(self)
    -- function num : 0_2 , upvalues : _ENV
    for k, v in pairs(self.matItemDict) do
        if v ~= nil then
            (v.data):ForceUpdate()
            v:UpdateDailyLimit()
        end
    end
    self:__updateSelectMatItemDisplay(self.selectItem)
end

UIMaterialDungeon.__loadMatDungeonList =
    function(self)
        -- function num : 0_3 , upvalues : _ENV
        if self.dungeonItemPool == nil then return end
        for k, v in ipairs(self.matItemDataList) do
            if v ~= nil then
                local item = (self.dungeonItemPool):GetOne()
                item:InitWithData(v, self.resLoader)
                item.clickEvent = self.onItemClick -- DECOMPILER ERROR at PC21: Confused about usage of register: R7 in 'UnsetPending'
                ;
                (self.matItemDict)[v.itemId] = item
            end
        end
    end

UIMaterialDungeon.__onClickItem = function(self, item)
    -- function num : 0_4
    self:OnSelectItemEvent(item)
end

UIMaterialDungeon.OnSelectItemEvent = function(self, item)
    -- function num : 0_5
    (self.selectItem):OnSelectDisplay(false)
    self.selectItemId = (item.data).itemId
    self.selectItem = (self.matItemDict)[self.selectItemId]
    self:__updateSelectMatItemDisplay(item)
end

UIMaterialDungeon.__updateSelectMatItemDisplay =
    function(self, item)
        -- function num : 0_6 , upvalues : _ENV
        if item == nil or item.data == nil then return end
        local matUIData = item.data -- DECOMPILER ERROR at PC13: Confused about usage of register: R3 in 'UnsetPending'
        ;
        ((self.ui).tex_StoryName).text =
            (LanguageUtil.GetLocaleText)(matUIData.desName) -- DECOMPILER ERROR at PC20: Confused about usage of register: R3 in 'UnsetPending'
        ;
        ((self.ui).tex_StoryDescr).text =
            (LanguageUtil.GetLocaleText)(matUIData.desInfo);
        ((self.ui).tex_LimitCount):SetIndex(0, tostring(
                                                matUIData.totalDailyLimit -
                                                    matUIData.usedDailyLimit),
                                            tostring(matUIData.totalDailyLimit))
        self:__loadBgImg(item)
        self:__loadChapterUI(matUIData)
        item:OnSelectDisplay(true)
    end

UIMaterialDungeon.__loadChapterUI = function(self, matUIData)
    -- function num : 0_7 , upvalues : UIMatDungeonChapterList, UIMatChapterItem, RewardItem, _ENV
    if self.chaptersUI == nil then
        self.chaptersUI = (UIMatDungeonChapterList.New)();
        (self.chaptersUI):Init((self.ui).levelRewardNode)
    end
    if self.chaptersItemPool == nil or self.fstRewardItemPool == nil or
        self.mbRewardItemPool == nil then
        self.chaptersItemPool = (self.chaptersUI):CreatePool(UIMatChapterItem,
                                                             RewardItem,
                                                             RewardItem)
    end
    (self.chaptersItemPool):HideAll();
    (self.fstRewardItemPool):HideAll();
    (self.mbRewardItemPool):HideAll()
    matUIData:CalcUnLockedAndProgress()
    local chapterItemList = {}
    for index = 1, #matUIData.dungeonCfgList do
        local item = (self.chaptersItemPool):GetOne()
        local itemState, lockReason = matUIData:GetChapterState(
                                          ((matUIData.dungeonCfgList)[index]).id)
        item:InitWithData((matUIData.dungeonCfgList)[index], itemState, index,
                          self.fstRewardItemPool, self.mbRewardItemPool,
                          matUIData.moduelId, lockReason);
        (table.insert)(chapterItemList, item)
    end
    (self.chaptersUI):UpdateWithChapterList(chapterItemList,
                                            matUIData.totalCompleteChapterCount,
                                            matUIData.totalChapterCount,
                                            self.onBattleStart)
end

UIMaterialDungeon.OnBattleStart = function(self)
    -- function num : 0_8 , upvalues : _ENV, cs_MessageCommon, base, CS_GSceneManager_Ins, eFmtFromModule
    self.selectChapterItem = (self.chaptersUI).selectChapterItem
    if ((self.selectItem).data).moduelId ==
        proto_csmsg_SystemFunctionID.SystemFunctionID_EquipDungeon and
        (ConfigData.game_config).athMaxNum <=
        #(PlayerDataCenter.allAthData):GetAllAthList() then
        (cs_MessageCommon.ShowMessageTips)(
            ConfigData:GetTipContent(TipContent.Ath_MaxCount))
        return
    end
    if ((self.selectItem).data).totalDailyLimit <=
        ((self.selectItem).data).usedDailyLimit then
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
        -- function num : 0_8_0 , upvalues : self, base, _ENV
        if (self.sector3DWindow).ui ~= nil then
            (((self.sector3DWindow).ui).sectorDungeonRoot):SetActive(false)
        end
        (base.Hide)(self)
        UIManager:HideWindow(UIWindowTypeID.Sector)
    end

    local exitFormationFunc = function()
        -- function num : 0_8_1 , upvalues : self, base, _ENV
        if (self.sector3DWindow).ui ~= nil then
            (((self.sector3DWindow).ui).sectorDungeonRoot):SetActive(true)
        end
        (base.Show)(self)
        UIManager:ShowWindow(UIWindowTypeID.Sector)
    end

    local startBattleFunc = function(curSelectFormationId, callBack)
        -- function num : 0_8_2 , upvalues : _ENV, self, CS_GSceneManager_Ins
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
                -- function num : 0_8_2_0 , upvalues : _ENV, self, CS_GSceneManager_Ins
                local loadMatUIFunc = BindCallback(self, function()
                    -- function num : 0_8_2_0_0 , upvalues : _ENV, itemId, self
                    UIManager:ShowWindowAsync(UIWindowTypeID.MaterialDungeon,
                                              function(window)
                        -- function num : 0_8_2_0_0_0 , upvalues : itemId, self, _ENV
                        if window == nil then return end
                        window:InitMatDungeon(itemId, self.sector3DWindow,
                                              function()
                            -- function num : 0_8_2_0_0_0_0 , upvalues : _ENV
                            local sectorCtrl =
                                ControllerManager:GetController(
                                    ControllerTypeId.SectorController, true)
                            sectorCtrl:ResetToNormalState()
                        end)
                        UIManager:HideWindow(UIWindowTypeID.ClickContinue)
                    end)
                end)
                CS_GSceneManager_Ins:LoadSceneAsyncByAB(
                    (Consts.SceneName).Sector, function()
                        -- function num : 0_8_2_0_1 , upvalues : _ENV, loadMatUIFunc
                        (UIManager:ShowWindow(UIWindowTypeID.ClickContinue)):InitContinue(
                            nil, nil, nil, Color.clear, false)
                        local sectorCtrl =
                            ControllerManager:GetController(
                                ControllerTypeId.SectorController, true)
                        sectorCtrl:SetFrom(AreaConst.DungeonBattle,
                                           loadMatUIFunc)
                        sectorCtrl:OnEnterPlotOrMateralDungeon()
                    end)
            end, self.selectItemId));
        (self.battleDungeonNetworkCtrl):CS_BATTLE_DungeonEnter(
            ((self.selectChapterItem).cfg).id, formationData, callBack)
        ControllerManager:DeleteController(ControllerTypeId.SectorController)
        UIManager:DeleteAllWindow()
    end

    fmtCtrl:InitFromationCtrl(eFmtFromModule.MaterialDungeon,
                              ((self.selectChapterItem).cfg).id,
                              enterFormationFunc, exitFormationFunc,
                              startBattleFunc)
end

UIMaterialDungeon.AfterBattleWin = function(self, selectChapterItem, selectItem)
    -- function num : 0_9 , upvalues : _ENV
    PlayerDataCenter:LocallyAddDungeonLimit((selectItem.data).moduelId,
                                            selectChapterItem.chapterId);
    (selectItem.data):CalcUnLockedAndProgress()
    selectChapterItem:UpdateLimit()
end

UIMaterialDungeon.__loadBgImg = function(self, item)
    -- function num : 0_10
    -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

    ((self.ui).img_Bg).texture = item.bannerTexture -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'
    ;
    ((self.ui).img_Icon).texture = item.iconTexture -- DECOMPILER ERROR at PC16: Confused about usage of register: R2 in 'UnsetPending'
    ;
    ((self.ui).img_IconWidget).color =
        ((self.ui).bannerColor)[(item.data).itemBgImg + 1]
end

UIMaterialDungeon.__prepareMatItemData =
    function(self)
        -- function num : 0_11 , upvalues : _ENV, UIMatDungeonData
        for k, v in pairs(ConfigData.material_dungeon) do
            if v ~= nil then
                local matItemData = (UIMatDungeonData.New)()
                matItemData.moduelId = v.id
                matItemData.itemId = k
                matItemData.itemName = v.name
                matItemData.itemNameEn = v.name_en
                matItemData.itemIcon = v.item_icon
                matItemData.itemBgImg = v.dungeon_img
                matItemData.totalDailyLimit = v.frequency_day
                matItemData.desInfo = v.des_info
                matItemData.desName = v.name
                local heroDungeonCfg = v.stage_id
                local dungeonCfgList = {}
                for k, v in ipairs(heroDungeonCfg) do
                    local cfg = (ConfigData.battle_dungeon)[v]
                    if cfg == nil then
                        error("read battle_dungeon error stageId:" .. v)
                    else

                        (table.insert)(dungeonCfgList, cfg)
                    end
                end
                matItemData.dungeonCfgList = dungeonCfgList
                matItemData:CalcUnLockedAndProgress()
                matItemData:CalcSelfUnlock();
                (table.insert)(self.matItemDataList, matItemData)
            end
        end
    end

UIMaterialDungeon.__onBack = function(self)
    -- function num : 0_12 , upvalues : base
    if self.onBackCallback ~= nil then (self.onBackCallback)() end
    (base.Delete)(self)
end

UIMaterialDungeon.OnDelete = function(self)
    -- function num : 0_13 , upvalues : _ENV, base
    MsgCenter:RemoveListener(eMsgEventId.OnBattleDungeonLimitChange,
                             self.__onDailyLimitUpdate);
    (self.resourceGroup):Delete()
    if self.resLoader ~= nil then (self.resLoader):Put2Pool() end
    (base.OnDelete)(self)
end

return UIMaterialDungeon

