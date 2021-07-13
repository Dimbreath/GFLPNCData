-- params : ...
-- function num : 0 , upvalues : _ENV
eMsgEventId = {OnSceneLoadingProgress = 10, UpdateItem = 100, UpdateHero = 101, SyncUserData = 102, UpdateARGItem = 103, UnlockFunc = 104, PreCondition = 105, UserNameChanged = 110, OnOpenHomeUI = 120123, OnCommanderSkillChande = 150, OnHeroSkinChange = 151, UIHeroListClosed = 200, UIOasisShow = 201, UIGetHeroClose = 202, OnHeroRankChange = 210, UpdateWarehouse = 301, UpdateBuildingProcess = 302, UpdateAutoRecoverItemSpeed = 303, UpdateTrainingProgress = 400, TaskUpdate = 500, TaskDelete = 501, TaskCommitComplete = 503, TaskReceived = 506, TaskSyncFinish = 507, PeroidCommitComplete = 508, SectorChipSet = 601, SectorPickReward = 602, PickFirstReward = 603, SectorStateUpdate = 604, BuildingUpgradeComplete = 700, BuildingSendUpgradeComplete = 701, BuildingCancelComplete = 702, BuildingProduceUpdate = 703, StaminaUpdate = 800, OnMailDiff = 850, OnMailDelete = 851, GetAchivLevelRewardComplete = 900, UpdatePlayerLevel = 901, UpdatePickedRewardLevel = 902, UpdatePickedAchivTask = 903, ChallengeOutOfData = 960, ExplorationEnterComplete = 1000, ExplorationExit = 1001, OnHasUncompletedEp = 1002, GiveUncompleteExploration = 1005, OnEpSceneLoadRole = 1050, OnShowRoleHeadBar = 1051, OnShowExplorationUI = 1052, OnChangeEpRoomSelectAudio = 1053, OnEpSceneStateChanged = 1060, OnRoomSelected = 1101, OnEpOperatorDiff = 1102, OnEpGridDetailDiff = 1103, OnEpBackpackDiff = 1105, EpMoneyChange = 1106, OnEpFormationDetailDiff = 1107, OnEpBuffDiff = 1108, OnEpPlayerHeroDataChange = 1109, OnEpChipListChange = 1110, OnEpBuffListChange = 1111, OnShowBattleResultComplete = 1112, OnExitRoomComplete = 1113, OnEpResidentDiff = 1114, OnChipDataDiff = 1115, OnEpPlayerFightPowerChang = 1116, OnEpOpStateChanged = 1117, OnEpBuffListDisplay = 1118, OnBeforeBattleRandomDataChange = 1120, OnEpPlayerMoveStart = 1121, OnEpPlayerMoveComplete = 1122, OnEpOpStore = 1123, OnEpRewardBagDiff = 1124, OnEpChipSuitUpdate = 1125, OnEpCommonDataDiff = 1126, OnEpServerGridDiff = 1150, OnEpOverclockDiff = 1160, UpdateEpOverclock = 1161, UpdateEpMonsterLevel = 1170, OnTreasureRoomUpdate = 1201, OnStoreRoomUpdate = 1202, OnEventAndRecoveryRoomUpdate = 1203, OnResetRoomUpdate = 1204, EpFocusPointChange = 1205, DungeonHeroListActiveSet = 1206, OnEnterBattle = 1300, OnExitBattle = 1301, OnBattleReady = 1302, OnBattleUpdateUltSkill = 1310, OnTimelineNoticeCreateResultUI = 1351, OnPlayChipEffect = 1400, OnDeployCoordChanged = 1401, OnChipLimitChange = 1405, OnChipDiscardChanged = 1406, EpSaveMoneyChange = 1407, OnAthDataUpdate = 1500, OnAthDataUpdate1 = 1501, OnAthItemDetailShow = 1502, OnHeroEnterDataUpdate = 1505, OnHeroFriendshipDataChange = 1510, OnCommanderSkillOverLoad = 1515, OnCommanderSkillTreeDataDiffer = 1516, OnCommanderSkillMasterLevelDiffer = 1517, OnCommanderSkillLevelDiffer = 1518, OnDungeonDetailWinChange = 1600, OnSettleMentTimeLinePlayToEnd = 1601, OnShowingMapRoomClick = 1602, OnSectorStageStateChange = 1700, OnBattleDungeonLimitChange = 1800, OnMainAvgStateChange = 1900, OnMainLevelStateChange = 1901, ActivityShowChange = 2002, AVGCtrlPlayEnd = 2101, BattlePassChange = 2201, BattlePassBuy = 2202, MonthCardRefresh = 2110, PayGiftChange = 2120, ShopRechargeComplete = 2121, ChangeBattleScoreActive = 5001, ChangeBattleScoreValue = 5002}
eLogicType = {ResourceLimit = 3, ResourceOutput = 4, CampBuff = 5, CareerBuff = 6, FactoryPipelie = 7, GlobalExpCeiling = 8, StaminaCeiling = 9, StaminaOutput = 10, ResOutputEfficiency = 11, BuildQueue = 12, BuildSpeed = 13, GlobalExpRatio = 14, AllHeroBuff = 15, OverClock = 16, OverClockFreeNum = 17, FocusPointCeiling = 18, BattleExpBonus = 19, DynSkillUpgrade = 20, DynChipCountMax = 21, DynPlayerAttrBuff = 22, DungeonRewardRate = 23, HeroLevelCeiling = 24, AutoRecoverItem = 25, DungeonCountAdd = 26, FactoryEfficiency = 27, ResOutputCeiling = 28}
_ENV.eCustomWaitType = {TcpConnect = 1, WaitGateInfo = 2, WaitCheckVersion = 3, WaitAthDetailBatch = 4, WaitPayFinish = 5}
_ENV.eBuildingId = {OasisMainBuilding = 1001, OasisConstructionBureau = 1002, OasisEnergeyStation = 1003, OasisSearchTerminal = 1004, DimensionBuildingId = 1004, OasisLibrary = 1007, OasisTrainingBuilding = 1008, OasisFactory = 1011, SkyBuilding = 1013}
_ENV.eBuildQueueType = {Oasis = 1, Sector = 2}
_ENV.eBattleState = {Init = 0, Deploy = 1, Running = 2, End = 3, Delete = 4}
_ENV.eGuideCondition = {None = 0, InHome = 1, InExploration = 2, InExplorationScene = 3, InBattleDeploy = 4, InSelectChip = 5, InBattleScene = 6, InEpTreasureRoom = 7, InEpEventRoom = 8, InSectorLevel = 9, InOassisBuildingDetail = 10, InFormation = 11, InSectorSceneNormal = 12, InMainScene = 13, InHeroStateUI = 14, InNewMonsterDetail = 15, InEpBattleResult = 16, InLottery = 17, InATHRefactor = 18, AfterEpCrossRoom = 19, InEpRewardBagSettle = 20, InHeroPotential = 21, InEpResultFail = 22, InEpStoreRoom = 23, InFormationSpecial = 24, FInHome = 101, FInSectorLevel = 109, FInSectorScene = 112}
_ENV.eAudioSourceType = {BgmSource = 1, SfxSource = 2, LoopSource = 3, VoiceSource = 4}
_ENV.eAudioVolumeType = {Bgm = 1, Sfx = 2, Voice = 3}
_ENV.eAuSelct = {
Home = {name = "Selector_Mus_Home", base = "SelectorLabel_Base", oasisNight = "SelectorLabel_Oasis", oasisDay = "SelectorLabel_OasisDay", sector = "SelectorLabel_Sector"}
, 
Sector = {name = "Selector_Mus_Sector", roomSelect = "SelectorLabel_LevelSelect", normalCombat = "SelectorLabel_NormalCombat", bossCombat = "SelectorLabel_BossCombat"}
, 
Atk_Mat = {name = "Imp_Atk_Material", 
lables = {"Light", "Mid", "Heavy"}
}
, 
Hit_Mat = {name = "Imp_Imp_Ameterial", 
lables = {"Body", "Heavy", "Shield"}
}
}
_ENV.eAuCueSheet = {Ambience = "Ambience", CommonSkill = "Common_Skill", Music = "Music", UI = "UI", AVG_gf = "AVG_gf", Prefix_Character = "Chara_", Prefix_Monster = "Mon_"}
_ENV.eVoiceType = {MORNING = 1, AFTERNOON = 2, EVENING = 3, MIDNIGHT = 4, GAIN = 101, LEVELUP = 102, RANKUP = 103, TITLE = 118}
_ENV.eAvgTriggerType = {MainAvg = 1, MainAvgEp = 2, AvgDungeon = 3, AvgTask = 4, SubAvg = 5}
_ENV.eSectorStageDifficult = {Normal = 1, Hard = 2, Endless = 3}
_ENV.eMessageSideType = {normal = 1, efficiency = 2}
_ENV.eFormulaType = {Hero = 101, Ath = 102, BattleHero = 103, Commander = 104, ChipPara = 105, BattleHeroEnemy = 108}
_ENV.eBaseWinFromWhere = {home = 1, homeCorver = 4, jumpCorver = 8}

