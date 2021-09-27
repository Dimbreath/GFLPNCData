EUILayoutLevel = {"Bottom", "Normal", "Middle", "High", "OverHigh", "LowTop", "Top", "Msg", "Max"}
EUILayoutLevel = CreatEnumTable(EUILayoutLevel, -1)
UIWindowTypeID = {LuaTest = 1000, Home = 1, TopStatus = 2, NavigationBar = 3, BattleResult = 4, ExplorationResult = 6, ExplorationResultSettlement = 7, ChatSystem = 8, OasisEditWindow = 9, HomeSide = 10, NoticeMessagePush = 11, Login = 12, LotteryWindow = 13, Loading = 14, USkySystem = 15, CommonRename = 16, UserFreined = 17, GameNotice = 18, Task = 25, Factory = 26, CommonReward = 27, AchievementSystem = 28, QuickBuy = 30, QuickBuyKey = 31, GetHero = 34, Mail = 35, Guide = 36, FloatText = 38, ClickContinue = 39, GlobalItemDetail = 40, Setting = 45, SettingGraph = 46, SettingDescribe = 47, DormInput = 60, DormInteract = 61, DormMain = 62, DormRoom = 63, DormCheckIn = 64, DormReplaceHero = 65, DormComfort = 66, DormTransAnima = 67, FriendShip = 70, FriendShipHeroFoster = 71, FriendShipPlotDungeon = 72, Avg = 73, SectorLevel = 74, SectorLevelDetail = 75, Sector = 76, SectorUnlockMovie = 77, AvgNounDes = 78, AvgSkip = 79, Formation = 80, FormationQuick = 82, CampBond = 83, MessageSide = 90, ViewChips = 95, ViewItems = 96, MaterialDungeon = 97, SelectBoardHero = 98, Exploration = 101, SelectChip = 102, EpChipList = 104, ThreeDSelectChip = 105, EpBuff = 106, SectorTask = 107, EpStoreRoom = 109, EpBuffShow = 110, EpAutoMode = 111, OverClock = 120, FloatingFrame = 121, GuidePicture = 122, CSTMain = 123, RichIntro = 124, ChipDisplace = 128, EpTreasureRoom = 130, EpEventRoom = 131, EpUpgradeRoom = 132, EpChipDiscard = 133, ATHDungeon = 134, EpSupportRoom = 135, EpResidentStore = 136, EpBuffDesc = 137, EpRewardBag = 141, EpRewardPreview = 142, CurrentChip = 143, EpChipSuit = 144, EpMonsterLevelUp = 145, EpSelectDebuff = 146, LotteryExchange = 147, LotteryPoolDetail = 148, BattleSkillModule = 203, Battle = 204, BattlePause = 205, BattleEnemyDetail = 206, BattleDPS = 207, BattleCrazyMode = 208, BattleFail = 209, DungeonStateInfo = 210, DungeonInfoDetail = 211, BattleEffectGirdInfo = 212, SelectChipSuit = 213, ResultSkada = 220, UltimateSkillShow = 225, DungeonResult = 250, DungeonFailureResult = 251, DungeonWaveTip = 252, BattleResultExtra = 260, BattleAutoMode = 261, HeroList = 300, HeroState = 301, HeroLevelUp = 302, HeroLevelUpSuccess = 303, HeroStarUp = 304, HeroSkillUp = 305, HeroSkillUpgrade = 306, HeroStarUpSuccess = 307, HeroPowerUpSuccess = 308, HeroPotential = 309, HeroPotentialSuccess = 310, HeroSkin = 311, HeroSkinPreView = 312, HeroTask = 313, HeroInfomation = 314, UserNameCreate = 401, UserInfo = 500, UserInfoDialog = 501, UserInfoSelectSupport = 502, SelectSupportList = 503, SupportHeroState = 504, CommonUserInfo = 505, MessageSideAddFriend = 506, HeroInfoState = 520, Ath = 1000, AthEfficiency = 1001, AthEfficiencyUpSuccess = 1002, AthItemDetail = 1003, AthReplaceHero = 1004, AthDecompose = 1006, AthRefactor = 1007, AthRefactorSuccess = 1008, AthItemDetailFloat = 1009, LotteryResult = 1100, LotteryShow = 1101, LotterySelectHero = 1102, MessageCommon = 1200, Factory = 1300, FactoryQuickProduce = 1302, FactoryProduceLine = 1303, RecommeFormation = 1305, StrategyOverview = 1400, OasisMain = 1500, ActivityStarUp = 1600, ActivityStarUpRewardPreview = 1601, EventSignin = 1605, EventWeChat = 1606, EventWeChatInformation = 1607, EventWeChatViewQRCode = 1608, EventBattlePass = 1701, EventBattlePassPurchase = 1702, EventGrowBag = 1703, ShopMain = 1800, CommonInfo = 1900, PeriodicDebuffSelect = 1910, DailyChallenge = 1950, WeeklyChallengeRank = 1961, WCDebuffResult = 1962, WeeklyChallengeTask = 1963, ActivityFrameMain = 2000, EventNoviceSign = 2001, Warehouse = 2002, CommonUseGift = 2003, EpTask = 2004, GiftPageDetail = 2005, TDBattle = 2101, TDCharactorInfo = 2102, DailyDungeonMain = 2200, DailyDungeonLevel = 2201, DailyDungeonComplete = 2202, FightScene = 2301, FightStart = 2302, FightResult = 2303, FightDebug = 2304, SceneChangesMask = 2350, MovieBlack = 2401, ShowCharacter = 2501, CADPAWarring = 9999}
_ENV.EUIAnimaType = {Fade = 0, FadeScaleUp = 1, ScaleUp = 2, FadeScaleDown = 3}
_ENV.UIWindowGlobalConfig = {
[UIWindowTypeID.LuaTest] = {PrefabName = "UI_LuaTest", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Test.UILuaTest")}
, 
[UIWindowTypeID.Home] = {PrefabName = "UI_HomeMain", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Home.UI.UIHomeMain")}
, 
[UIWindowTypeID.HomeSide] = {PrefabName = "UI_HomeSide", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Home.UI.Side.UIHomeSide")}
, 
[UIWindowTypeID.ChatSystem] = {PrefabName = "UI_ChatSystem", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Chat.UI.UIChatSystem")}
, 
[UIWindowTypeID.NoticeMessagePush] = {PrefabName = "UI_NoticeMessagePush", LayoutLevel = EUILayoutLevel.LowTop, WindowClass = (_ENV.require)("Game.Notice.UI.UINoticeMessagePush")}
, 
[UIWindowTypeID.TopStatus] = {PrefabName = "UI_TopStatus", LayoutLevel = EUILayoutLevel.OverHigh, WindowClass = (_ENV.require)("Game.TopStatus.UITopStatus"), AnimaType = (_ENV.EUIAnimaType).Fade}
, 
[UIWindowTypeID.NavigationBar] = {PrefabName = "UI_NavigationBar", LayoutLevel = EUILayoutLevel.OverHigh, WindowClass = (_ENV.require)("Game.TopStatus.Navigation.UINavigationBar")}
, 
[UIWindowTypeID.OasisMain] = {PrefabName = "UI_OasisMain", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Oasis.UI.Main.UIOasisMain")}
, 
[UIWindowTypeID.OasisEditWindow] = {PrefabName = "UI_OasisEditor", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Oasis.UI.Editor.UIOasisEditor")}
, 
[UIWindowTypeID.USkySystem] = {PrefabName = "UI_USkySystem", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Oasis.UI.Sky.UIUSkySystem")}
, 
[UIWindowTypeID.BattleResult] = {PrefabName = "UI_EpBattleResult", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.BattleResult.UIBattleResult")}
, 
[UIWindowTypeID.ExplorationResult] = {PrefabName = "UI_ExplorationResult", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.BattleResult.UIExplorationResult")}
, 
[UIWindowTypeID.ExplorationResultSettlement] = {PrefabName = "UI_ResultSettlement", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.BattleResult.UIResultSettlement"), AnimaType = (_ENV.EUIAnimaType).FadeScaleUp}
, 
[UIWindowTypeID.HeroList] = {PrefabName = "UI_HeroList", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Hero.NewUI.NewUIHeroList"), AnimaType = (_ENV.EUIAnimaType).FadeScaleUp, ShowWinAuId = 1088, HideWinAuId = 1089}
, 
[UIWindowTypeID.HeroState] = {PrefabName = "UI_HeroState", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Hero.NewUI.State.UIHeroState"), AnimaType = (_ENV.EUIAnimaType).FadeScaleUp}
, 
[UIWindowTypeID.HeroLevelUp] = {PrefabName = "UI_HeroLevelUp", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Hero.NewUI.UpgradeLevel.UIHeroLevelUp"), AnimaType = (_ENV.EUIAnimaType).Fade}
, 
[UIWindowTypeID.Login] = {PrefabName = "UI_Login", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Login.UILogin")}
, 
[UIWindowTypeID.LotteryWindow] = {PrefabName = "UI_Lottery", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Lottery.UI.UILottery"), AnimaType = (_ENV.EUIAnimaType).FadeScaleUp}
, 
[UIWindowTypeID.LotteryExchange] = {PrefabName = "UI_LotteryExchange", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Lottery.UI.UILotteryExchange")}
, 
[UIWindowTypeID.LotteryPoolDetail] = {PrefabName = "UI_LotteryGachaRate", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Lottery.UI.PoolDetail.UILotteryPoolDetail")}
, 
[UIWindowTypeID.LotteryResult] = {PrefabName = "UI_LotteryResult", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Lottery.UI.Result.UILotteryResult")}
, 
[UIWindowTypeID.HeroLevelUpSuccess] = {PrefabName = "UI_HeroLevelUpSuccess", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.Hero.NewUI.UpgradeLevel.UIHeroLevelUpSuccess")}
, 
[UIWindowTypeID.HeroStarUp] = {PrefabName = "UI_HeroStarUp", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Hero.NewUI.UpgradeStar.UIHeroStarUp"), AnimaType = (_ENV.EUIAnimaType).Fade}
, 
[UIWindowTypeID.GetHero] = {PrefabName = "UI_GetHero", LayoutLevel = EUILayoutLevel.OverHigh, WindowClass = (_ENV.require)("Game.CommonUI.Hero.New.UIGetHero")}
, 
[UIWindowTypeID.HeroSkillUpgrade] = {PrefabName = "UI_HeroSkillUpgrade", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Hero.NewUI.UpgradeSkill.UIHeroSkillUpgrade"), AnimaType = (_ENV.EUIAnimaType).Fade}
, 
[UIWindowTypeID.Task] = {PrefabName = "UI_Task", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Task.NewUI.UITask"), AnimaType = (_ENV.EUIAnimaType).FadeScaleUp}
, 
[UIWindowTypeID.CommonReward] = {PrefabName = "UI_CommonReward", LayoutLevel = EUILayoutLevel.OverHigh, WindowClass = (_ENV.require)("Game.CommonUI.UICommonReward")}
, 
[UIWindowTypeID.AchievementSystem] = {PrefabName = "UI_AchievementSystem", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Achievement.UI.UIAchievementSystem"), AnimaType = (_ENV.EUIAnimaType).FadeScaleUp, ShowWinAuId = 1088}
, 
[UIWindowTypeID.EpTreasureRoom] = {PrefabName = "UI_EpTreasureRoom", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Exploration.UI.TreasureRoom.UITreasureRoom"), AnimaType = (_ENV.EUIAnimaType).Fade}
, 
[UIWindowTypeID.SelectChip] = {PrefabName = "UI_SelectChip", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.Exploration.UI.SelectChip.UISelectChip"), AnimaType = (_ENV.EUIAnimaType).FadeScaleUp}
, 
[UIWindowTypeID.SelectChipSuit] = {PrefabName = "UI_SelectChipSuit", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.DailyDungeon.UI.SelectChipSuit.UISelectChipSuit"), AnimaType = (_ENV.EUIAnimaType).FadeScaleUp}
, 
[UIWindowTypeID.ThreeDSelectChip] = {PrefabName = "UI_3DSelectChip", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Exploration.UI.SelectChip.UISelectChip")}
, 
[UIWindowTypeID.Exploration] = {PrefabName = "UI_Exploration", LayoutLevel = EUILayoutLevel.Bottom, WindowClass = (_ENV.require)("Game.Exploration.UI.UIExploration")}
, 
[UIWindowTypeID.EpEventRoom] = {PrefabName = "UI_EpEventRoom", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Exploration.UI.EventRoom.UIEpEventRoom"), AnimaType = (_ENV.EUIAnimaType).Fade}
, 
[UIWindowTypeID.EpUpgradeRoom] = {PrefabName = "UI_EpChipLevelUp", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Exploration.UI.UpgradeRoom.UIEpUpgradeRoom"), AnimaType = (_ENV.EUIAnimaType).Fade}
, 
[UIWindowTypeID.EpChipDiscard] = {PrefabName = "UI_EpChipDiscard", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Exploration.UI.ChipDiscard.UIEpChipDiscard"), AnimaType = (_ENV.EUIAnimaType).Fade}
, 
[UIWindowTypeID.EpSelectDebuff] = {PrefabName = "UI_EpDebuffSelect", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Exploration.UI.SelectDebuff.UIEpSelectDebuff"), AnimaType = (_ENV.EUIAnimaType).Fade}
, 
[UIWindowTypeID.EpResidentStore] = {PrefabName = "UI_EpResidentStore", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Exploration.UI.ResidentStore.UIEpResidentStore"), AnimaType = (_ENV.EUIAnimaType).FadeScaleDown}
, 
[UIWindowTypeID.BattleSkillModule] = {PrefabName = "UI_BattleSkillModule", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Battle.UI.SkillModule.UIBattleSkillModule")}
, 
[UIWindowTypeID.UltimateSkillShow] = {PrefabName = "UI_UltimateSkillShow", LayoutLevel = EUILayoutLevel.Top, WindowClass = (_ENV.require)("Game.Battle.UI.SkillModule.UIUltrSkillHeroShow")}
, 
[UIWindowTypeID.Battle] = {PrefabName = "UI_Battle", LayoutLevel = EUILayoutLevel.Bottom, WindowClass = (_ENV.require)("Game.Battle.UI.UIBattle"), AnimaType = (_ENV.EUIAnimaType).Fade}
, 
[UIWindowTypeID.BattlePause] = {PrefabName = "UI_BattlePause", LayoutLevel = EUILayoutLevel.OverHigh, WindowClass = (_ENV.require)("Game.Battle.UI.UIBattlePause"), AnimaType = (_ENV.EUIAnimaType).Fade}
, 
[UIWindowTypeID.BattleEnemyDetail] = {PrefabName = "UI_BattleEnemyDetail", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Battle.UI.UIBattleEnemyDetail"), AnimaType = (_ENV.EUIAnimaType).FadeScaleUp}
, 
[UIWindowTypeID.Mail] = {PrefabName = "UI_Mail", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Mail.UI.New_UIMail"), AnimaType = (_ENV.EUIAnimaType).FadeScaleUp}
, 
[UIWindowTypeID.Guide] = {PrefabName = "UI_Guide", LayoutLevel = EUILayoutLevel.Top, WindowClass = (_ENV.require)("Game.Guide.UIGuide")}
, 
[UIWindowTypeID.QuickBuy] = {PrefabName = "UI_QuickPurchaseBox", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.QuickPurchaseBox.New_UIQuickPurchaseBox")}
, 
[UIWindowTypeID.QuickBuyKey] = {PrefabName = "UI_QuickPurchaseKey", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.QuickPurchaseBox.PurchaseKey.UIQuickPurchaseKey")}
, 
[UIWindowTypeID.FloatText] = {PrefabName = "UI_FloatText", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.CommonUI.FloatText.UIFloatText")}
, 
[UIWindowTypeID.ClickContinue] = {PrefabName = "UI_ClickContinue", LayoutLevel = EUILayoutLevel.Top, WindowClass = (_ENV.require)("Game.CommonUI.ClickContinue.UIClickContinue")}
, 
[UIWindowTypeID.GlobalItemDetail] = {PrefabName = "UI_CommonItemDetail", LayoutLevel = EUILayoutLevel.OverHigh, WindowClass = (_ENV.require)("Game.CommonUI.ItemDetail.UICommonItemDetailWin"), AnimaType = (_ENV.EUIAnimaType).Fade}
, 
[UIWindowTypeID.Ath] = {PrefabName = "UI_ATHMain", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Arithmetic.UIATHMain"), AnimaType = (_ENV.EUIAnimaType).Fade}
, 
[UIWindowTypeID.AthEfficiency] = {PrefabName = "UI_ATHEfficiency", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Arithmetic.AthEfficiency.UIAthEfficiency")}
, 
[UIWindowTypeID.AthEfficiencyUpSuccess] = {PrefabName = "UI_ATHEfficiencyUpgradeSuccess", LayoutLevel = EUILayoutLevel.OverHigh, WindowClass = (_ENV.require)("Game.Arithmetic.AthEfficiency.UIAthEfficiencyUpSuccess")}
, 
[UIWindowTypeID.AthItemDetail] = {PrefabName = "UI_ATHDetail", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.Arithmetic.AthDetail.UIAthItemDetail")}
, 
[UIWindowTypeID.AthReplaceHero] = {PrefabName = "UI_ATHReplaceHero", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.Arithmetic.AthReplaceHero.UIAthReplaceHero"), AnimaType = (_ENV.EUIAnimaType).FadeScaleUp}
, 
[UIWindowTypeID.AthDecompose] = {PrefabName = "UI_ATHDecompose", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Arithmetic.Decompose.UIAthDecompose")}
, 
[UIWindowTypeID.AthRefactor] = {PrefabName = "UI_ATHRefactor", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.Arithmetic.Refactor.UIAthRefactor")}
, 
[UIWindowTypeID.AthRefactorSuccess] = {PrefabName = "UI_ATHRefactorSuccess", LayoutLevel = EUILayoutLevel.OverHigh, WindowClass = (_ENV.require)("Game.Arithmetic.Refactor.UIAthRefactorSuccess")}
, 
[UIWindowTypeID.AthItemDetailFloat] = {PrefabName = "UI_ATHDetailFloat", LayoutLevel = EUILayoutLevel.OverHigh, WindowClass = (_ENV.require)("Game.Arithmetic.AthDetail.UIAthDetailFloat")}
, 
[UIWindowTypeID.Setting] = {PrefabName = "UI_Setting", LayoutLevel = EUILayoutLevel.OverHigh, WindowClass = (_ENV.require)("Game.Setting.UISetting"), AnimaType = (_ENV.EUIAnimaType).Fade, ShowWinAuId = 1088, HideWinAuId = 1089}
, 
[UIWindowTypeID.SettingGraph] = {PrefabName = "UI_SettingGraph", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Setting.UISettingGraph")}
, 
[UIWindowTypeID.SettingDescribe] = {PrefabName = "UI_SettingDescribe", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Setting.UISettingDescribe")}
, 
[UIWindowTypeID.CommonRename] = {PrefabName = "UI_CommonRename", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.CommonUI.Rename.UICommonRename")}
, 
[UIWindowTypeID.UserFreined] = {PrefabName = "UI_UserFriends", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Friend.UI.UIUserFriend"), ShowWinAuId = 1088, HideWinAuId = 1089, AnimaType = (_ENV.EUIAnimaType).FadeScaleUp}
, 
[UIWindowTypeID.DormInput] = {PrefabName = "UI_DormInput", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Dorm.UI.UIDormInput")}
, 
[UIWindowTypeID.DormInteract] = {PrefabName = "UI_DormInteract", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Dorm.UI.Interact.UIDormInteract")}
, 
[UIWindowTypeID.DormMain] = {PrefabName = "UI_DormMain", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Dorm.DUI.UIDormMain")}
, 
[UIWindowTypeID.DormRoom] = {PrefabName = "UI_DormRoom", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Dorm.DUI.Room.UIDormRoom")}
, 
[UIWindowTypeID.DormCheckIn] = {PrefabName = "UI_DormCheckIn", LayoutLevel = EUILayoutLevel.OverHigh, WindowClass = (_ENV.require)("Game.Dorm.DUI.DormCheckIn.UIDormCheckIn"), AnimaType = (_ENV.EUIAnimaType).FadeScaleUp, ShowWinAuId = 1066}
, 
[UIWindowTypeID.DormReplaceHero] = {PrefabName = "UI_DormReplaceHero", LayoutLevel = EUILayoutLevel.OverHigh, WindowClass = (_ENV.require)("Game.Dorm.DUI.DormCheckIn.UIDormReplaceHero")}
, 
[UIWindowTypeID.DormComfort] = {PrefabName = "UI_DormComfort", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Dorm.DUI.Comfort.UIDormComfort"), AnimaType = (_ENV.EUIAnimaType).FadeScaleUp, ShowWinAuId = 1066}
, 
[UIWindowTypeID.FriendShip] = {PrefabName = "UI_FriendshipSkillUpgrade", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Friendship.NewFriendshipUI.UIFriendshipSkillUpgrade"), AnimaType = (_ENV.EUIAnimaType).Fade, ShowWinAuId = 1066}
, 
[UIWindowTypeID.Avg] = {PrefabName = "UI_AVGSystem", LayoutLevel = EUILayoutLevel.OverHigh, WindowClass = (_ENV.require)("Game.Avg.UI.UIAVGSystem")}
, 
[UIWindowTypeID.AvgSkip] = {PrefabName = "UI_AvgSkip", LayoutLevel = EUILayoutLevel.OverHigh, WindowClass = (_ENV.require)("Game.Avg.UI.AvgSkip.UIAvgSkip")}
, 
[UIWindowTypeID.AvgNounDes] = {PrefabName = "UI_AvgNounDes", LayoutLevel = EUILayoutLevel.OverHigh, WindowClass = (_ENV.require)("Game.Avg.UI.NounDes.UIAvgNounDes")}
, 
[UIWindowTypeID.FriendShipHeroFoster] = {PrefabName = "UI_HeroFoster_Legacy", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Friendship.Foster.UIFoster")}
, 
[UIWindowTypeID.FriendShipPlotDungeon] = {PrefabName = "UI_HeroFriendshipDungeon", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Friendship.PlotDungeon.UIPlotDungeon"), ShowWinAuId = 1088}
, 
[UIWindowTypeID.SectorLevel] = {PrefabName = "UI_SectorLevel", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Sector.SectorLevel.UISectorLevel"), AnimaType = (_ENV.EUIAnimaType).FadeScaleUp}
, 
[UIWindowTypeID.SectorUnlockMovie] = {PrefabName = "UI_SectorPlayMovie", LayoutLevel = EUILayoutLevel.OverHigh, WindowClass = (_ENV.require)("Game.Sector.UISector.UISectorUnlockMovie")}
, 
[UIWindowTypeID.SectorLevelDetail] = {PrefabName = "UI_SectorLevelDetail", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Sector.SectorLevelDetail.UISectorLevelDetail")}
, 
[UIWindowTypeID.Sector] = {PrefabName = "UI_Sector", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Sector.UISector.UISector"), AnimaType = (_ENV.EUIAnimaType).Fade}
, 
[UIWindowTypeID.SectorTask] = {PrefabName = "UI_SectorTask", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Sector.SectorTask.UISectorTask"), AnimaType = (_ENV.EUIAnimaType).FadeScaleUp, ShowWinAuId = 1088, HideWinAuId = 1089}
, 
[UIWindowTypeID.OverClock] = {PrefabName = "UI_Overclock", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.Exploration.UI.Overclock.UIEpOverclock"), AnimaType = (_ENV.EUIAnimaType).Fade, ShowWinAuId = 1088, HideWinAuId = 1089}
, 
[UIWindowTypeID.CSTMain] = {PrefabName = "UI_CSTMain", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.CommanderSkill.UI.UICSTMain"), AnimaType = (_ENV.EUIAnimaType).Fade, ShowWinAuId = 1088}
, 
[UIWindowTypeID.DungeonResult] = {PrefabName = "UI_BattleResult", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.BattleDungeon.UI.UIDungeonResult")}
, 
[UIWindowTypeID.DungeonFailureResult] = {PrefabName = "UI_TempBattleFailureResult", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.BattleDungeon.UI.UIDungeonFailureResult_Temp")}
, 
[UIWindowTypeID.DungeonWaveTip] = {PrefabName = "UI_DungeonWaveTip", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.BattleDungeon.UI.UIDungeonWaveTip")}
, 
[UIWindowTypeID.BattleResultExtra] = {PrefabName = "UI_BattleResultExtra", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.BattleDungeon.UI.UIBattleResultExtra")}
, 
[UIWindowTypeID.Formation] = {PrefabName = "UI_Formation", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Formation.UI.UIFormation"), AnimaType = (_ENV.EUIAnimaType).Fade, ShowWinAuId = 1088}
, 
[UIWindowTypeID.FormationQuick] = {PrefabName = "UI_FormationQuick", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Formation.UI.QuickFmt.UIFormationQuick"), AnimaType = (_ENV.EUIAnimaType).Fade}
, 
[UIWindowTypeID.CampBond] = {PrefabName = "UI_CampBond", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Formation.UI.CampBond.UICampFetter")}
, 
[UIWindowTypeID.DungeonStateInfo] = {PrefabName = "UI_DungeonStateInfo", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.CommonUI.DungeonState.UIDungeonStateInfo")}
, 
[UIWindowTypeID.DungeonInfoDetail] = {PrefabName = "UI_DungeonInfoDetail", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.CommonUI.DungeonState.Info.UIDungeonInfoDetail"), AnimaType = (_ENV.EUIAnimaType).Fade}
, 
[UIWindowTypeID.EpStoreRoom] = {PrefabName = "UI_EpStoreRoom", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Exploration.UI.StoreRoom.UIEpStoreRoom"), AnimaType = (_ENV.EUIAnimaType).Fade}
, 
[UIWindowTypeID.FloatingFrame] = {PrefabName = "UI_FloatingFrame", LayoutLevel = EUILayoutLevel.OverHigh, WindowClass = (_ENV.require)("Game.CommonUI.FloatWin.UIFloatFrame")}
, 
[UIWindowTypeID.Loading] = {PrefabName = "UI_Loading", LayoutLevel = EUILayoutLevel.Top, WindowClass = (_ENV.require)("Game.Loading.UILoading")}
, 
[UIWindowTypeID.BattleDPS] = {PrefabName = "UI_BattleDPS", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.Battle.UI.UIBattleDPS")}
, 
[UIWindowTypeID.EpBuffShow] = {PrefabName = "UI_EpBuffShow", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.Exploration.UI.EpBuffShow.UIEpBuffShow")}
, 
[UIWindowTypeID.GuidePicture] = {PrefabName = "UI_GuidePicture", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.Guide.GuidePicture.UIGuidePicture")}
, 
[UIWindowTypeID.MessageSide] = {PrefabName = "UI_MessageSide", LayoutLevel = EUILayoutLevel.LowTop, WindowClass = (_ENV.require)("Game.Message.Side.UIMessageSide")}
, 
[UIWindowTypeID.MessageSideAddFriend] = {PrefabName = "UI_MessageSideAddFriend", LayoutLevel = EUILayoutLevel.LowTop, WindowClass = (_ENV.require)("Game.Friend.SideAddFriend.UISideAddFriend")}
, 
[UIWindowTypeID.ViewChips] = {PrefabName = "UI_ViewChips", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.ViewChips.UIViewChips"), AnimaType = (_ENV.EUIAnimaType).FadeScaleUp, ShowWinAuId = 1088}
, 
[UIWindowTypeID.ViewItems] = {PrefabName = "UI_ViewItems", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.ViewItems.UIViewItems")}
, 
[UIWindowTypeID.MaterialDungeon] = {PrefabName = "UI_MaterialDungeon", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.MaterialDungeon.UI.UIMaterialDungeon")}
, 
[UIWindowTypeID.BattleEffectGirdInfo] = {PrefabName = "UI_BattleEffectGirdInfo", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.Battle.UI.Grid.UIBattleEffectGirdInfo")}
, 
[UIWindowTypeID.SelectBoardHero] = {PrefabName = "UI_HeroList", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Home.UI.UISelectBoardHero"), AnimaType = (_ENV.EUIAnimaType).FadeScaleUp}
, 
[UIWindowTypeID.UserNameCreate] = {PrefabName = "UI_UserNameCreate", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.User.UIUserNameCreate"), AnimaType = (_ENV.EUIAnimaType).FadeScaleUp}
, 
[UIWindowTypeID.ResultSkada] = {PrefabName = "UI_ResultSkada", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.BattleResult.SkadaSystem.UIResultSkada"), AnimaType = (_ENV.EUIAnimaType).Fade, ShowWinAuId = 1066}
, 
[UIWindowTypeID.UserInfo] = {PrefabName = "UI_UserInfo", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.User.UIUserInfo"), AnimaType = (_ENV.EUIAnimaType).FadeScaleUp}
, 
[UIWindowTypeID.CommonUserInfo] = {PrefabName = "UI_UserInfoView", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.User.CommonUser.UIUserInfoView"), AnimaType = (_ENV.EUIAnimaType).FadeScaleUp}
, 
[UIWindowTypeID.UserInfoSelectSupport] = {PrefabName = "UI_UserInfoSupport", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.User.SelectSupport.UISelectSupportHero"), ShowWinAuId = 1066}
, 
[UIWindowTypeID.SelectSupportList] = {PrefabName = "UI_SupportHeroList", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Formation.UI.SupportHeroList.UISupportHeroList"), ShowWinAuId = 1088, AnimaType = (_ENV.EUIAnimaType).FadeScaleUp}
, 
[UIWindowTypeID.UserInfoDialog] = {PrefabName = "UI_UserInfoDialog", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.User.UIUserInfoDialog")}
, 
[UIWindowTypeID.EpAutoMode] = {PrefabName = "UI_EpAutoMode", LayoutLevel = EUILayoutLevel.Top, WindowClass = (_ENV.require)("Game.Exploration.UI.AutoMode.UIEpAutoMode")}
, 
[UIWindowTypeID.MessageCommon] = {PrefabName = "UI_MessageItemBox", LayoutLevel = EUILayoutLevel.LowTop, WindowClass = (_ENV.require)("Game.CommonUI.MessageCommon.UIMessageCommon")}
, 
[UIWindowTypeID.ATHDungeon] = {PrefabName = "UI_ATHDungeon", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.ATHDungeon.UI.UIATHDungeon")}
, 
[UIWindowTypeID.Factory] = {PrefabName = "UI_Factory", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Factory.UI.UIFactory"), AnimaType = (_ENV.EUIAnimaType).FadeScaleUp}
, 
[UIWindowTypeID.FactoryQuickProduce] = {PrefabName = "UI_FactoryQuickProduce", LayoutLevel = EUILayoutLevel.OverHigh, WindowClass = (_ENV.require)("Game.Factory.UI.QuickProduce.UIFactoryQuickProduce")}
, 
[UIWindowTypeID.FactoryProduceLine] = {PrefabName = "UI_FactoryProductionLine", LayoutLevel = EUILayoutLevel.OverHigh, WindowClass = (_ENV.require)("Game.Factory.UI.ProduceLine.UIFactoryProduceLine")}
, 
[UIWindowTypeID.LotteryShow] = {PrefabName = "UI_LotteryShow", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.Lottery.UI.UILotteryShow")}
, 
[UIWindowTypeID.LotterySelectHero] = {PrefabName = "UI_LotterySelectHero", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Lottery.UI.SelectHero.UILotterySelectHero")}
, 
[UIWindowTypeID.BattleCrazyMode] = {PrefabName = "UI_BattleCrazyMode", LayoutLevel = EUILayoutLevel.OverHigh, WindowClass = (_ENV.require)("Game.BattleCrazyMode.UI.UIBattleCrazyMode")}
, 
[UIWindowTypeID.CommonInfo] = {PrefabName = "UI_CommonInfo", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.CommonUI.CommonInfo.UICommonInfo"), AnimaType = (_ENV.EUIAnimaType).FadeScaleUp, ShowWinAuId = 1066}
, 
[UIWindowTypeID.EpSupportRoom] = {PrefabName = "UI_EpSupportRoom", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Exploration.UI.SupportRoom.UIEpSurpportRoom"), AnimaType = (_ENV.EUIAnimaType).FadeScaleUp}
, 
[UIWindowTypeID.DailyChallenge] = {PrefabName = "UI_PeriodicChallenge", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.PeriodicChallenge.UI.UIPeriodicChallenge"), AnimaType = (_ENV.EUIAnimaType).FadeScaleUp}
, 
[UIWindowTypeID.EpRewardBag] = {PrefabName = "UI_EpRewardBag", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.Exploration.UI.EpRewardBag.UIEpRewardBag"), AnimaType = (_ENV.EUIAnimaType).FadeScaleUp}
, 
[UIWindowTypeID.HeroPowerUpSuccess] = {PrefabName = "UI_HeroPowerUpSuccess", LayoutLevel = EUILayoutLevel.OverHigh, WindowClass = (_ENV.require)("Game.Hero.NewUI.UIHeroPowerUpSuccess")}
, 
[UIWindowTypeID.HeroStarUpSuccess] = {PrefabName = "UI_HeroStarUpSuccess", LayoutLevel = EUILayoutLevel.OverHigh, WindowClass = (_ENV.require)("Game.Hero.NewUI.UpgradeStar.UIStarUpSuccess"), AnimaType = (_ENV.EUIAnimaType).Fade}
, 
[UIWindowTypeID.RecommeFormation] = {PrefabName = "UI_RecommeFormation", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.Formation.UI.RecommeFormation.UIRecommeFormation"), ShowWinAuId = 1133}
, 
[UIWindowTypeID.HeroPotential] = {PrefabName = "UI_HeroPotential", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.Hero.NewUI.UpgradePotential.UIHeroPotential"), AnimaType = (_ENV.EUIAnimaType).FadeScaleUp, ShowWinAuId = 1088}
, 
[UIWindowTypeID.StrategyOverview] = {PrefabName = "UI_StrategyOverview", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.StrategyOverview.UI.UIStrategyOverview"), AnimaType = (_ENV.EUIAnimaType).FadeScaleUp}
, 
[UIWindowTypeID.RichIntro] = {PrefabName = "UI_RichIntro", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.CommonUI.RichIntro.UIRichIntro")}
, 
[UIWindowTypeID.ActivityStarUp] = {PrefabName = "UI_ActivityStarUp", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.ActivityStarUp.UI.UIActivityStarUp"), AnimaType = (_ENV.EUIAnimaType).FadeScaleUp}
, 
[UIWindowTypeID.ChipDisplace] = {PrefabName = "UI_EpChipDisplace", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.Exploration.UI.ChipDisplace.UIChipDisplace")}
, 
[UIWindowTypeID.HeroPotentialSuccess] = {PrefabName = "UI_HeroPotentialSuccess", LayoutLevel = EUILayoutLevel.OverHigh, WindowClass = (_ENV.require)("Game.Hero.NewUI.UpgradePotential.UIHeroPotentialSuccess")}
, 
[UIWindowTypeID.EventBattlePass] = {PrefabName = "UI_EventBattlePass", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.BattlePass.UI.UIEventBattlePass")}
, 
[UIWindowTypeID.EventBattlePassPurchase] = {PrefabName = "UI_EventBattlePassPurchase", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.BattlePass.UI.UIEventBattlePassPurChase")}
, 
[UIWindowTypeID.EventGrowBag] = {PrefabName = "UI_EventGrowBag", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.EventGrowBag.UI.UIEventGrowBag"), AnimaType = (_ENV.EUIAnimaType).FadeScaleUp}
, 
[UIWindowTypeID.EventSignin] = {PrefabName = "UI_EventSignin", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.DailySignIn.UI.UIEventSignin")}
, 
[UIWindowTypeID.EventWeChat] = {PrefabName = "UI_EventWeChat", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.EventNoviceSign.UI.UIEventWeChat")}
, 
[UIWindowTypeID.HeroSkin] = {PrefabName = "UI_HeroSkin", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Skin.UI.UIHeroSkin"), AnimaType = (_ENV.EUIAnimaType).Fade}
, 
[UIWindowTypeID.HeroSkinPreView] = {PrefabName = "UI_HeroStarUpSkinPreview", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Skin.UI.Preview.UIPreviewSkin"), AnimaType = (_ENV.EUIAnimaType).FadeScaleUp}
, 
[UIWindowTypeID.HeroTask] = {PrefabName = "UI_HeroTask", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Hero.NewUI.HeroTask.UIHeroTask"), AnimaType = (_ENV.EUIAnimaType).Fade}
, 
[UIWindowTypeID.HeroInfomation] = {PrefabName = "UI_HeroInformation", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Hero.NewUI.HeroInfo.UIHeroInformation"), AnimaType = (_ENV.EUIAnimaType).Fade}
, 
[UIWindowTypeID.ShopMain] = {PrefabName = "UI_ShopMain", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.ShopMain.UIShopMain"), AnimaType = (_ENV.EUIAnimaType).FadeScaleUp, ShowWinAuId = 1088}
, 
[UIWindowTypeID.PeriodicDebuffSelect] = {PrefabName = "UI_PeriodicDebuffSelect", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.PeriodicChallenge.UI.UIPeriodicDebuffSelect"), AnimaType = (_ENV.EUIAnimaType).Fade}
, 
[UIWindowTypeID.WeeklyChallengeRank] = {PrefabName = "UI_WeeklyChallengeRank", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.PeriodicChallenge.UI.WeeklyChallengeRank.UIWeeklyChallengeRank")}
, 
[UIWindowTypeID.WCDebuffResult] = {PrefabName = "UI_PeriodicDebuffSelectResult", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.PeriodicChallenge.UI.WeeklyChallengeDebuffResult.UIWCDebuffResult")}
, 
[UIWindowTypeID.EpRewardPreview] = {PrefabName = "UI_EpRewardPreview", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.Exploration.UI.EpRewardPreview.UIEpRewardPreview"), AnimaType = (_ENV.EUIAnimaType).Fade, ShowWinAuId = 1066}
, 
[UIWindowTypeID.CurrentChip] = {PrefabName = "UI_CurrentChip", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.Exploration.UI.CurrentChip.UICurrentChip"), AnimaType = (_ENV.EUIAnimaType).Fade, ShowWinAuId = 1088}
, 
[UIWindowTypeID.EpChipSuit] = {PrefabName = "UI_EpChipSuit", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.Exploration.UI.ChipSuit.UIEpChipSuit")}
, 
[UIWindowTypeID.EpMonsterLevelUp] = {PrefabName = "UI_EpMonsterLevelUp", LayoutLevel = EUILayoutLevel.OverHigh, WindowClass = (_ENV.require)("Game.Exploration.UI.MonsterLevel.UIEpMonsterLevelUp"), ShowWinAuId = 1130}
, 
[UIWindowTypeID.ActivityFrameMain] = {PrefabName = "UI_EventMain", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.ActivityFrame.UI.UIActivityFrameMain")}
, 
[UIWindowTypeID.EventNoviceSign] = {PrefabName = "UI_EventNoviceSign", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.EventNoviceSign.UI.UIEventNoviceSign")}
, 
[UIWindowTypeID.BattleFail] = {PrefabName = "UI_BattleFail", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Exploration.UI.BattleFail.UIBattleFail")}
, 
[UIWindowTypeID.Warehouse] = {PrefabName = "UI_Warehouse", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Warehouse.UIWarehouse"), AnimaType = (_ENV.EUIAnimaType).FadeScaleUp, ShowWinAuId = 1088}
, 
[UIWindowTypeID.CommonUseGift] = {PrefabName = "UI_CommonUseGift", LayoutLevel = EUILayoutLevel.OverHigh, WindowClass = (_ENV.require)("Game.CommonUI.UseGift.UICommonUseGift")}
, 
[UIWindowTypeID.CADPAWarring] = {PrefabName = "UI_CADPAWarring", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.CADPA.UICADPAWarringWin")}
, 
[UIWindowTypeID.EpTask] = {PrefabName = "UI_EpTask", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Exploration.UI.EpTask.UIEpTask")}
, 
[UIWindowTypeID.ActivityStarUpRewardPreview] = {PrefabName = "UI_ActivityStarUpRewardPreview", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.ActivityStarUp.UI.UIActivityStarUpPre")}
, 
[UIWindowTypeID.GameNotice] = {PrefabName = "UI_GameNotice", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.GameNotice.UI.UIGameNotice"), AnimaType = (_ENV.EUIAnimaType).Fade}
, 
[UIWindowTypeID.WeeklyChallengeTask] = {PrefabName = "UI_WeeklyChallengeTask", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.WeeklyChallenge.UIWeeklyChallengeTask"), AnimaType = (_ENV.EUIAnimaType).FadeScaleUp}
, 
[UIWindowTypeID.TDBattle] = {PrefabName = "UI_TDBattle", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.BattleTowerDefence.UI.UITDBattle")}
, 
[UIWindowTypeID.TDCharactorInfo] = {PrefabName = "UI_TDCharacterInfo", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.BattleTowerDefence.UI.UITDCharactorInfo")}
, 
[UIWindowTypeID.SupportHeroState] = {PrefabName = "UI_SupportHeroState", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Formation.UI.SupportHeroList.UISupportHeroState"), ShowWinAuId = 1063}
, 
[UIWindowTypeID.HeroInfoState] = {PrefabName = "UI_SupportHeroState", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Lottery.UI.HeroInfo.UIHeroInfoState"), ShowWinAuId = 1063}
, 
[UIWindowTypeID.DailyDungeonMain] = {PrefabName = "UI_DailyDungeonMain", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.DailyDungeon.UI.LevelSelect.UIDailyDungeonMain"), ShowWinAuId = 1088, AnimaType = (_ENV.EUIAnimaType).FadeScaleUp}
, 
[UIWindowTypeID.DailyDungeonLevel] = {PrefabName = "UI_DailyDungeonLevel", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.DailyDungeon.UI.LevelSelect.Level.UIDailyDungeonLevel"), ShowWinAuId = 1066}
, 
[UIWindowTypeID.DailyDungeonComplete] = {PrefabName = "UI_DailyDungeonComplete", LayoutLevel = EUILayoutLevel.OverHigh, WindowClass = (_ENV.require)("Game.DailyDungeon.UI.LevelSelect.CompleteDungeon.UIDailyDungeonComplete")}
, 
[UIWindowTypeID.FightScene] = {PrefabName = "UI_FightMain", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Fight.Ui.UIFightMain")}
, 
[UIWindowTypeID.FightStart] = {PrefabName = "UI_FightStart", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Fight.Ui.UIFightStart")}
, 
[UIWindowTypeID.FightResult] = {PrefabName = "UI_FightResult", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Fight.Ui.UIFightResult")}
, 
[UIWindowTypeID.FightDebug] = {PrefabName = "UI_FightDebug", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Fight.Ui.UIFightDebug")}
, 
[UIWindowTypeID.MovieBlack] = {PrefabName = "UI_MovieBlack", LayoutLevel = EUILayoutLevel.Top, WindowClass = (_ENV.require)("Game.Common.UIMovieBlack")}
, 
[UIWindowTypeID.EpBuffDesc] = {PrefabName = "UI_EpBuffDesc", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Exploration.UI.EpBuffDesc.UIEpBuffDesc"), AnimaType = (_ENV.EUIAnimaType).Fade}
, 
[UIWindowTypeID.ShowCharacter] = {PrefabName = "UI_ShowCharacter", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.ShowCharacter.UI.UIShowCharacter")}
, 
[UIWindowTypeID.BattleAutoMode] = {PrefabName = "UI_BattleAutoMode", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.BattleDungeon.UI.BattleDungeonAutoMode.UIBattleDungeonAutoMode")}
, 
[UIWindowTypeID.SceneChangesMask] = {PrefabName = "UI_SceneChangesMask", LayoutLevel = EUILayoutLevel.OverHigh, WindowClass = (_ENV.require)("Game.CommonUI.SceneChanges.UISceneChangesMask")}
, 
[UIWindowTypeID.DormTransAnima] = {PrefabName = "UI_DormTransAnima", LayoutLevel = EUILayoutLevel.OverHigh, WindowClass = (_ENV.require)("Game.Dorm.UI.UIDormTransAnima"), AnimaType = (_ENV.EUIAnimaType).FadeScaleUp}
, 
[UIWindowTypeID.EventWeChatInformation] = {PrefabName = "UI_EventWeChatInformation", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.EventNoviceSign.UI.UIEventWeChatInformation")}
, 
[UIWindowTypeID.EventWeChatViewQRCode] = {PrefabName = "UI_EventWeChatViewQRCode", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.EventNoviceSign.UI.UIEventWeChatViewQRCode")}
, 
[UIWindowTypeID.GiftPageDetail] = {PrefabName = "UI_GiftPageDetail", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.QuickPurchaseBox.UIGiftPageDetail")}
}

