-- params : ...
-- function num : 0 , upvalues : _ENV
local cs_playerData = (CS.PlayerDataCenter).Instance
local PlayerDataCenter = setmetatable({}, {__index = cs_playerData})
local LotteryConfig = require("Game.PlayerData.LotteryConfig")
local FormationData = require("Game.PlayerData.FormationData")
local AllBuildingData = require("Game.PlayerData.AllBuildingData")
local AllTaskData = require("Game.PlayerData.AllTaskData")
local StaminaData = require("Game.PlayerData.StaminaData")
local SectorStageData = require("Game.PlayerData.SectorStageData")
local HeroData = require("Game.PlayerData.Hero.HeroData")
local PlayerSkillData = require("Game.PlayerData.Skill.PlayerSkillData")
local ItemData = require("Game.PlayerData.Item.ItemData")
local PlayerLevelData = require("Game.PlayerData.PlayerLevelData")
local AchivLevelData = require("Game.PlayerData.AchivLevel.AchivLevelData")
local AllAthData = require("Game.PlayerData.Arithmetic.AllAthData")
local TrainingSlotData = require("Game.Training.Data.TrainingSlotData")
local AllEffectorData = require("Game.Effector.Data.AllEffectorData")
local FriendshipData = require("Game.Friendship.FriendshipData")
local AttributeBonus = require("Game.PlayerData.AttributeBonus")
local HeroAttrChecker = require("Game.Debug.HeroAttrChecker")
local PlayerBonus = require("Game.PlayerData.PlayerBonus.PlayerBonus")
local ShopEnum = require("Game.Shop.ShopEnum")
local PstConfig = require(
                      "Game.PersistentManager.PersistentData.PersistentConfig")
PlayerDataCenter.ctor = function(self)
    -- function num : 0_0
    self:InitData()
end

PlayerDataCenter.InitData = function(self)
    -- function num : 0_1 , upvalues : _ENV, PlayerLevelData, AllBuildingData, SectorStageData, StaminaData, AllTaskData, TrainingSlotData, AchivLevelData, AllAthData, AllEffectorData, FriendshipData, AttributeBonus, PlayerBonus, HeroAttrChecker
    self.heroDic = {}
    self.heroCount = 0
    self.campHeroCount = {}
    self.itemDic = {}
    self.itemTypeList = {}
    for i = 1, ItemTypeMax do
        -- DECOMPILER ERROR at PC15: Confused about usage of register: R5 in 'UnsetPending'

        (self.itemTypeList)[i] = {}
    end
    self.playerSkillCount = 0
    self.playerLevel = (PlayerLevelData.New)()
    self.AllBuildingData = (AllBuildingData.New)()
    self.LotteryCfg = {}
    self.sectorStage = (SectorStageData.New)()
    self.formationDic = {}
    self.stamina = (StaminaData.New)()
    self.allTaskData = (AllTaskData.New)()
    self.trainingSlotDatas = (TrainingSlotData.InitAllTrainingSlotData)()
    self.sectorDatas = nil
    self.achivLevelData = (AchivLevelData.New)()
    self.allAthData = (AllAthData.New)()
    self.allEnterData = {}
    self.allEffectorData = (AllEffectorData.New)()
    self.todayLotteryNums = {}
    self.lotteryRefreshTimes = {}
    self.allFriendshipData = (FriendshipData.New)()
    self.attributeBonus = (AttributeBonus.New)()
    self.dungeonDailyBattleTimes = {}
    self.dungeonTotalBattleTimes = {}
    self.CommanderSkillModualData = nil
    self.playerBonus = (PlayerBonus.New)()
    self.allVisitedMonsters = {}
    self.showGirlId = nil
    self.lastSectorMentionedId = nil
    self.infinityData = {
        completed = {},
        processingUpdate = {},
        freshData = {},
        oldData = nil
    }
    self.lastAthDiff = nil
    if isGameDev then self.heroAttrChecker = (HeroAttrChecker.New)() end
end

PlayerDataCenter.LocallyAddDungeonLimit =
    function(self, moduelId, dungeonStageId)
        -- function num : 0_2
        if self.dungeonDailyBattleTimes == nil then
            self.dungeonDailyBattleTimes = {}
        end
        -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

        if (self.dungeonDailyBattleTimes)[moduelId] == nil then
            (self.dungeonDailyBattleTimes)[moduelId] = {} -- DECOMPILER ERROR at PC15: Confused about usage of register: R3 in 'UnsetPending'
            ;
            ((self.dungeonDailyBattleTimes)[moduelId]).data = {}
        end
        local moduelData = ((self.dungeonDailyBattleTimes)[moduelId]).data
        if moduelData[dungeonStageId] == nil then
            moduelData[dungeonStageId] = 1
        else
            moduelData[dungeonStageId] = moduelData[dungeonStageId] + 1
        end
        if self.dungeonTotalBattleTimes == nil then
            self.dungeonTotalBattleTimes = {}
        end
        moduelData = (self.dungeonTotalBattleTimes)[dungeonStageId]
        if moduelData == nil then
            moduelData = 1
        else
            moduelData = moduelData + 1
        end -- DECOMPILER ERROR at PC40: Confused about usage of register: R4 in 'UnsetPending'
        
        (self.dungeonTotalBattleTimes)[dungeonStageId] = moduelData
    end

PlayerDataCenter.GetTotalBattleTimes = function(self, dungeonStageId)
    -- function num : 0_3
    if self.dungeonTotalBattleTimes == nil then return 0 end
    local moduelData = (self.dungeonTotalBattleTimes)[dungeonStageId]
    if moduelData == nil then
        return 0
    else
        return moduelData
    end
end

PlayerDataCenter.GetLastRemoteSectorMentionId =
    function(self)
        -- function num : 0_4
        return self.lastSectorMentionedId
    end

PlayerDataCenter.RecordLastRemoteSectorMentionId =
    function(self, completeId)
        -- function num : 0_5
        self.lastSectorMentionedId = completeId
    end

PlayerDataCenter.UpdateLotteryCfg = function(self, details)
    -- function num : 0_6 , upvalues : _ENV, LotteryConfig
    for k, v in pairs(details) do
        if k ~= nil then
            local cfg = (self.LotteryCfg)[k]
            if cfg == nil then
                cfg = (LotteryConfig.New)() -- DECOMPILER ERROR at PC14: Confused about usage of register: R8 in 'UnsetPending'
                ;
                (self.LotteryCfg)[k] = cfg
            end
            if v ~= nil then
                cfg.NextFreeTime = v.nextFree -- DECOMPILER ERROR at PC21: Confused about usage of register: R8 in 'UnsetPending'
                ;
                (self.todayLotteryNums)[k] = v.lotteryNum -- DECOMPILER ERROR at PC24: Confused about usage of register: R8 in 'UnsetPending'
                ;
                (self.lotteryRefreshTimes)[k] = v.lotteryFreshTm
            end
        end
    end
end

PlayerDataCenter.SyncUserData = function(self, userData)
    -- function num : 0_7 , upvalues : _ENV, HeroData, FormationData, ItemData, PstConfig
    if userData.heroGroup ~= nil then
        for k, v in pairs((userData.heroGroup).hero) do
            local heroData = (HeroData.New)(v) -- DECOMPILER ERROR at PC13: Confused about usage of register: R8 in 'UnsetPending'
            ;
            (self.heroDic)[heroData.dataId] = heroData -- DECOMPILER ERROR at PC23: Confused about usage of register: R8 in 'UnsetPending'
            ;
            (self.campHeroCount)[heroData.camp] =
                ((self.campHeroCount)[heroData.camp] or 0) + 1
            self.heroCount = self.heroCount + 1
        end
        local formationData = (userData.heroGroup).formation
        for k, v in pairs(formationData) do
            -- DECOMPILER ERROR at PC39: Confused about usage of register: R8 in 'UnsetPending'

            (self.formationDic)[k] = (FormationData.FromUserData)(v)
        end
    end
    do
        if userData.resource ~= nil then
            local resource = userData.resource
            if resource.backpack ~= nil then
                for itemId, v in pairs((resource.backpack).data) do
                    local itemData = (ItemData.New)(v.id, v.count) -- DECOMPILER ERROR at PC61: Confused about usage of register: R9 in 'UnsetPending'
                    ;
                    ((self.itemTypeList)[itemData.type])[itemId] = itemData -- DECOMPILER ERROR at PC63: Confused about usage of register: R9 in 'UnsetPending'
                    ;
                    (self.itemDic)[itemId] = itemData
                end
            end
        end
        do
            local func = userData["function"]
            local funcUnLockCrtl = ControllerManager:GetController(
                                       ControllerTypeId.FunctionUnlock, true)
            if func ~= nil then
                for k, v in pairs(func.data) do
                    local openCfg = (ConfigData.system_open)[k]
                    if openCfg ~= nil and openCfg.screening then
                        do
                            funcUnLockCrtl:AddUnlockFunction(k, true)
                            -- DECOMPILER ERROR at PC92: LeaveBlock: unexpected jumping out IF_THEN_STMT

                            -- DECOMPILER ERROR at PC92: LeaveBlock: unexpected jumping out IF_STMT

                        end
                    end
                end
            end
            if userData.questGroup ~= nil then
                (self.allTaskData):InitAllTaskData(userData.questGroup)
            end
            if userData.quest ~= nil then
                (self.allTaskData):InitCompletedMainTask(
                    (userData.quest).mainLineQuest)
            end
            if userData.userBase ~= nil then
                (self.playerLevel):UpdatePlayerLevelData(
                    (userData.userBase).level, (userData.userBase).exp)
                if (userData.userBase).stm ~= nil then
                    (self.stamina):UpdateStamina((userData.userBase).stm)
                end
                if (userData.userBase).showGirl ~= nil then
                    self.showGirlId = (userData.userBase).showGirl
                end
                if (userData.userBase).cliLastSecMent ~= nil then
                    self.lastSectorMentionedId =
                        (userData.userBase).cliLastSecMent
                end
                GuideManager:InitCompleteTriggerGuide(
                    (userData.userBase).triggerGuidance)
            else
                GuideManager:InitCompleteTriggerGuide({})
            end
            if userData.monsterAtlas ~= nil then
                self.allVisitedMonsters = (userData.monsterAtlas).data
            end
            (ControllerManager:GetController(ControllerTypeId.AvgPlay, true)):InitAllAvgPlayed(
                userData.avg)
            MsgCenter:Broadcast(eMsgEventId.SyncUserData);
            (NetworkManager:GetNetwork(NetworkTypeID.Sector)):CS_SECTOR_Detail();
            (NetworkManager:GetNetwork(NetworkTypeID.Sector)):CS_ENDLESS_Detail();
            (NetworkManager:GetNetwork(NetworkTypeID.Building)):SendBuildingDetail();
            (NetworkManager:GetNetwork(NetworkTypeID.Effector)):CS_EFFECTOR_ResourceGenerator();
            (NetworkManager:GetNetwork(NetworkTypeID.Exploration)):CS_EXPLORATION_Detail();
            (NetworkManager:GetNetwork(NetworkTypeID.Lottery)):SendGetLotteryDetail();
            (NetworkManager:GetNetwork(NetworkTypeID.Sector)):SendAchievement();
            (NetworkManager:GetNetwork(NetworkTypeID.Training)):SendTrainingDetail();
            (NetworkManager:GetNetwork(NetworkTypeID.AchivLevel)):Send_ACHIEVEMENT_Detail();
            (ControllerManager:GetController(ControllerTypeId.Mail, true)):GetInitData();
            (NetworkManager:GetNetwork(NetworkTypeID.Task)):SendQuestPeriodDetail();
            (NetworkManager:GetNetwork(NetworkTypeID.Arithmetic)):CS_ATH_Detail();
            (NetworkManager:GetNetwork(NetworkTypeID.HeroEnter)):CS_STATION_Detail(
                true);
            (NetworkManager:GetNetwork(NetworkTypeID.Friendship)):CS_INTIMACY_Detail(
                true);
            (NetworkManager:GetNetwork(NetworkTypeID.BattleDungeon)):CS_DUNGEON_STATIC_Detail()
            local isCSUnlock = funcUnLockCrtl:ValidateUnlock(
                                   proto_csmsg_SystemFunctionID.SystemFunctionID_commander_skill)
            if isCSUnlock then
                (NetworkManager:GetNetwork(NetworkTypeID.CommanderSkill)):CS_COMMANDSKILL_Detail(
                    function()
                        -- function num : 0_7_0 , upvalues : _ENV, self, FormationData
                        -- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

                        if (table.count)(self.formationDic) == 0 then
                            (self.formationDic)[1] =
                                (FormationData.CreateDefault)(1);
                            (NetworkManager:GetNetwork(NetworkTypeID.Hero)):SendFormationFresh(
                                1, ((self.formationDic)[1]).data)
                        else
                            for formId, formation in pairs(self.formationDic) do
                                (FormationData.IsIllegalCST)(formId, true)
                            end
                        end
                    end)
            else
                -- DECOMPILER ERROR at PC305: Confused about usage of register: R5 in 'UnsetPending'

                if (table.count)(self.formationDic) == 0 then
                    (self.formationDic)[1] = (FormationData.CreateDefault)(1);
                    (NetworkManager:GetNetwork(NetworkTypeID.Hero)):SendFormationFresh(
                        1, ((self.formationDic)[1]).data)
                end
            end
            -- DECOMPILER ERROR at PC319: Confused about usage of register: R5 in 'UnsetPending'

            PersistentManager.playerId = self.playerId
            PersistentManager:LoadAndDecodeData((PstConfig.ePackage).UserData)
        end
    end
end

PlayerDataCenter.SyncItemUpdateDiff = function(self, resourceData)
    -- function num : 0_8 , upvalues : _ENV, ItemData
    local itemUpdate = {}
    if resourceData.backpack ~= nil then
        for itemId, v in pairs((resourceData.backpack).deletes) do
            local deleteItem = (self.itemDic)[itemId]
            -- DECOMPILER ERROR at PC16: Confused about usage of register: R9 in 'UnsetPending'

            if deleteItem ~= nil then
                ((self.itemTypeList)[deleteItem.type])[itemId] = nil
            end -- DECOMPILER ERROR at PC18: Confused about usage of register: R9 in 'UnsetPending'
            
            (self.itemDic)[itemId] = nil
            itemUpdate[itemId] = true
        end
        for itemId, v in pairs((resourceData.backpack).updates) do
            local itemData = (self.itemDic)[itemId]
            if itemData ~= nil then
                itemData:UpdateData(v)
            else
                itemData = (ItemData.New)(v.id, v.count) -- DECOMPILER ERROR at PC43: Confused about usage of register: R9 in 'UnsetPending'
                ;
                ((self.itemTypeList)[itemData.type])[itemId] = itemData -- DECOMPILER ERROR at PC45: Confused about usage of register: R9 in 'UnsetPending'
                ;
                (self.itemDic)[itemId] = itemData
            end
            itemUpdate[itemId] = false
        end
    end
    do MsgCenter:Broadcast(eMsgEventId.UpdateItem, itemUpdate, resourceData) end
end

PlayerDataCenter.SyncHeroUpdateDiff = function(self, heroUpdateData)
    -- function num : 0_9 , upvalues : _ENV, HeroData
    if heroUpdateData.update ~= nil then
        local heroUpdate = {}
        for heroId, hero in pairs(heroUpdateData.update) do
            local heroData = (self.heroDic)[heroId]
            if heroData ~= nil then
                heroData:UpdateHeroData(hero)
                heroUpdate[heroId] = false
            else
                heroData = (HeroData.New)(hero) -- DECOMPILER ERROR at PC23: Confused about usage of register: R9 in 'UnsetPending'
                ;
                (self.heroDic)[heroData.dataId] = heroData -- DECOMPILER ERROR at PC33: Confused about usage of register: R9 in 'UnsetPending'
                ;
                (self.campHeroCount)[heroData.camp] =
                    ((self.campHeroCount)[heroData.camp] or 0) + 1
                heroUpdate[heroId] = true
                self.heroCount = self.heroCount + 1
            end
        end
        MsgCenter:Broadcast(eMsgEventId.UpdateHero, heroUpdate)
    end
end

PlayerDataCenter.OnPreDataRecvComplete =
    function(self)
        -- function num : 0_10 , upvalues : _ENV
        print("接受前置数据完毕");
        (ControllerManager:GetController(ControllerTypeId.Shop, true)):StartShopAllRedDot()
    end

PlayerDataCenter.GetItemCount = function(self, itemId)
    -- function num : 0_11
    local itemData = (self.itemDic)[itemId]
    if itemData == nil then return 0 end
    return itemData:GetCount()
end

PlayerDataCenter.GetGlobalExpCount = function(self)
    -- function num : 0_12 , upvalues : _ENV
    return self:GetItemCount((ConfigData.game_config).globalExpItemId)
end

PlayerDataCenter.GetItemDicByType = function(self, itemType)
    -- function num : 0_13 , upvalues : _ENV
    if itemType > 0 and itemType <= ItemTypeMax then
        return (self.itemTypeList)[itemType]
    end
    return nil
end

PlayerDataCenter.UpdateFormation = function(self, msgData)
    -- function num : 0_14 , upvalues : FormationData
    local formation = (self.formationDic)[msgData.id]
    if formation ~= nil then
        formation:UpdateFormation(msgData)
    else
        -- DECOMPILER ERROR at PC14: Confused about usage of register: R3 in 'UnsetPending'


        (self.formationDic)[msgData.id] = (FormationData.FormMsgData)(msgData)
    end
end

PlayerDataCenter.TryGetFormation = function(self, formationId)
    -- function num : 0_15
    local formation = (self.formationDic)[formationId]
    if formation == nil then
        return false, nil, nil
    else
        return true, formation.data, formation.userSkill, formation.cst
    end
end

PlayerDataCenter.CreateFormation = function(self, formationId)
    -- function num : 0_16 , upvalues : FormationData
    local formation = (FormationData.Create)(formationId) -- DECOMPILER ERROR at PC4: Confused about usage of register: R3 in 'UnsetPending'
    ;
    (self.formationDic)[formationId] = formation
    return formation
end

PlayerDataCenter.GetResId = function(self, id)
    -- function num : 0_17
    return (((self.heroDic)[id]).heroCfg).src_id
end

PlayerDataCenter.UserLoginComplete = function(self, role)
    -- function num : 0_18 , upvalues : cs_playerData, _ENV
    cs_playerData.playerName = role.name
    cs_playerData.playerId = role.id
    self.timezone_offset = role.timezone_offset;
    (cs_playerData.serverTime):UpdateServerTime(role.timestamp);
    ((CS.MTPManager).Instance):UserLoginComplete(0, 0,
                                                 cs_playerData.strPlayerId, "")
end

PlayerDataCenter.UpdateUserNameData = function(self, name)
    -- function num : 0_19 , upvalues : cs_playerData, _ENV
    cs_playerData.playerName = name
    MsgCenter:Broadcast(eMsgEventId.UserNameChanged)
end

PlayerDataCenter.GetHeroData = function(self, heroId)
    -- function num : 0_20 , upvalues : _ENV
    local heroData = (self.heroDic)[heroId]
    if heroData == nil then
        error("Can\'t get heroData, id = " .. tostring(heroId))
    end
    return heroData
end

PlayerDataCenter.UnlockCommanderSkill = function(self)
    -- function num : 0_21 , upvalues : _ENV, FormationData
    for key, value in pairs(self.formationDic) do
        (FormationData.CreateDefultCST)(key)
    end
end

PlayerDataCenter.IsNewEnemy = function(self, ememyId)
    -- function num : 0_22 , upvalues : _ENV
    if (self.allVisitedMonsters)[ememyId] then
        if self.tempOldEnemy ~= nil and
            (table.contain)(self.tempOldEnemy, ememyId) then return true end
        return false
    else
        return true
    end
end

PlayerDataCenter.AddOldEnemy = function(self, ememyId)
    -- function num : 0_23 , upvalues : _ENV
    -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

    (self.allVisitedMonsters)[ememyId] = true
    if self.tempOldEnemy == nil then self.tempOldEnemy = {} end
    (table.insert)(self.tempOldEnemy, ememyId)
end

PlayerDataCenter.CleanTempOldEnemy = function(self)
    -- function num : 0_24
    self.tempOldEnemy = nil
end

PlayerDataCenter:ctor()
return PlayerDataCenter

