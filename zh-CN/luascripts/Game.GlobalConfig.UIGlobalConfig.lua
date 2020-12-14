-- params : ...
-- function num : 0 , upvalues : _ENV
EUILayoutLevel = {"Bottom", "Normal", "Middle", "High", "OverHigh", "LowTop", "Top", "Msg", "Max"}
EUILayoutLevel = CreatEnumTable(EUILayoutLevel, -1)
UIWindowTypeID = {LuaTest = 1000, Home = 1, TopStatus = 2, Oasis = 3, BattleResult = 4, BossResult = 5, ExplorationResult = 6, ExplorationResultSettlement = 7, OasisEditWindow = 9, HomeSide = 10, Login = 12, LotteryWindow = 13, Loading = 14, SectorBuilding = 18, Training = 20, TrainingState = 21, TrainingHeroList = 22, Shop = 23, BuildingQueue = 24, Task = 25, Factory = 26, CommonReward = 27, AchievementSystem = 28, AddChipToHero = 33, GetHero = 34, Mail = 35, Guide = 36, QuickBuy = 37, FloatText = 38, ClickContinue = 39, GlobalItemDetail = 40, Setting = 45, HeroEnter = 46, HeroEnterOverView = 47, Dorm = 50, DormEdit = 51, DormOverview = 52, DormOperate = 53, DormRoomEdit = 54, DormWarehouse = 55, DormShop = 56, DormRoomDetail = 57, DormFntDetail = 58, DormHeroEnter = 59, FriendShip = 70, FriendShipHeroFoster = 71, FriendShipPlotDungeon = 72, Avg = 73, SectorLevel = 74, SectorLevelDetail = 75, Sector = 76, Formation = 80, FmtHeroDetail = 81, FormationQuick = 82, CampBond = 83, MessageSide = 90, ViewChips = 95, ViewItems = 96, MaterialDungeon = 97, SelectBoardHero = 98, CommonCollectRes = 99, UserInfo = 100, Exploration = 101, SelectChip = 102, GlobalChipDetail = 103, EpChipList = 104, ThreeDSelectChip = 105, EpBuff = 106, SectorTask = 107, EpStoreRoom = 109, EpBuffShow = 110, EpAutoMode = 111, OverClock = 120, FloatingFrame = 121, GuidePicture = 122, CommanderSkill = 123, ResetRoom = 129, EpTreasureRoom = 130, EpEventRoom = 131, EpUpgradeRoom = 132, EpChipDiscard = 133, ATHDungeon = 134, DungeonDropInfo = 135, BattleDeploy = 201, BattleRandomBeforeBattle = 202, BattleSkillModule = 203, Battle = 204, BattlePause = 205, BattleEnemyDetail = 206, BattleDPS = 207, BattleCrazyMode = 208, DungeonStateInfo = 210, DungeonInfoDetail = 211, BattleEffectGirdInfo = 212, ResultSkada = 220, DungeonResult = 250, DungeonFailureResult = 251, DungeonWaveTip = 252, HeroList = 300, HeroState = 301, HeroLevelUp = 302, HeroLevelUpSuccess = 303, HeroStarUp = 304, HeroSkillUp = 305, HeroSkillUpgrade = 306, HeroPowerUpSuccess = 308, UserNameCreate = 401, UICJResult = 700, Ath = 1000, AthEfficiency = 1001, AthEfficiencyUpSuccess = 1002, AthItemDetail = 1003, AthReplaceHero = 1004, AthStrengthen = 1005, LotteryResult = 1100, LotteryShow = 1101, MessageCommon = 1200, Factory = 1300, FactoryHerolist = 1301}
EUIAnimaType = {Fade = 0, FadeScaleUp = 1, ScaleUp = 2}
UIWindowGlobalConfig = {
[UIWindowTypeID.LuaTest] = {PrefabName = "UI_LuaTest", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Test.UILuaTest")}
, 
[UIWindowTypeID.Home] = {PrefabName = "UI_Home", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Home.UI.UIHome")}
, 
[UIWindowTypeID.HomeSide] = {PrefabName = "UI_HomeSide", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Home.UI.Side.UIHomeSide")}
, 
[UIWindowTypeID.TopStatus] = {PrefabName = "UI_TopStatus_Legacy", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.TopStatus.UITopStatus")}
, 
[UIWindowTypeID.Oasis] = {PrefabName = "UI_Oasis", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Oasis.UI.UIOasis")}
, 
[UIWindowTypeID.OasisEditWindow] = {PrefabName = "UI_OasisEditWindow", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Oasis.UI.UIOasisEditWindow")}
, 
[UIWindowTypeID.BuildingQueue] = {PrefabName = "UI_BuildingQueue", LayoutLevel = EUILayoutLevel.Bottom, WindowClass = (_ENV.require)("Game.Oasis.UI.UIBuildingQueue")}
, 
[UIWindowTypeID.BattleResult] = {PrefabName = "UI_EpBattleResult", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.BattleResult.UIBattleResult")}
, 
[UIWindowTypeID.BossResult] = {PrefabName = "UI_BossResult", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.BattleResult.UIBossResult"), AnimaType = EUIAnimaType.FadeScaleUp}
, 
[UIWindowTypeID.ExplorationResult] = {PrefabName = "UI_ExplorationResult", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.BattleResult.UIExplorationResult")}
, 
[UIWindowTypeID.ExplorationResultSettlement] = {PrefabName = "UI_ResultSettlement", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.BattleResult.UIResultSettlement")}
, 
[UIWindowTypeID.SectorBuilding] = {PrefabName = "UI_STBuilding", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Sector.Building.UISectorBuilding"), AnimaType = EUIAnimaType.FadeScaleUp}
, 
[UIWindowTypeID.HeroList] = {PrefabName = "UI_HeroList", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Hero.NewUI.NewUIHeroList"), AnimaType = EUIAnimaType.FadeScaleUp}
, 
[UIWindowTypeID.HeroState] = {PrefabName = "UI_HeroState", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Hero.NewUI.State.UIHeroState"), AnimaType = EUIAnimaType.ScaleUp}
, 
[UIWindowTypeID.HeroLevelUp] = {PrefabName = "UI_HeroLevelUp", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Hero.NewUI.UpgradeLevel.UIHeroLevelUp")}
, 
[UIWindowTypeID.Login] = {PrefabName = "UI_Login", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Login.UILogin")}
, 
[UIWindowTypeID.LotteryWindow] = {PrefabName = "UI_Lottery", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Lottery.UI.UILottery"), AnimaType = EUIAnimaType.FadeScaleUp}
, 
[UIWindowTypeID.LotteryResult] = {PrefabName = "UI_LotteryResult", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Lottery.UI.Result.UILotteryResult")}
, 
[UIWindowTypeID.HeroLevelUpSuccess] = {PrefabName = "UI_HeroLevelUpSuccess", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.Hero.NewUI.UpgradeLevel.UIHeroLevelUpSuccess")}
, 
[UIWindowTypeID.HeroStarUp] = {PrefabName = "UI_HeroStarUp", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Hero.NewUI.UpgradeStar.UIHeroStarUp")}
, 
[UIWindowTypeID.GetHero] = {PrefabName = "UI_GetHero", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.CommonUI.Hero.New.UIGetHero")}
, 
[UIWindowTypeID.HeroSkillUpgrade] = {PrefabName = "UI_HeroSkillUpgrade", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.Hero.NewUI.UpgradeSkill.UIHeroSkillUpgrade")}
, 
[UIWindowTypeID.Training] = {PrefabName = "UI_HeroTraining_Obsolete", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Training.UITraining")}
, 
[UIWindowTypeID.TrainingState] = {PrefabName = "UI_HeroTrainingStateBox_Obsolete", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.Training.TrainingState.UITrainingState")}
, 
[UIWindowTypeID.TrainingHeroList] = {PrefabName = "UI_HeroTrainingList_Obsolete", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.Training.SelectHero.UITrainingHeroList")}
, 
[UIWindowTypeID.Shop] = {PrefabName = "UI_Shop", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Shop.UIShop"), AnimaType = EUIAnimaType.FadeScaleUp}
, 
[UIWindowTypeID.Task] = {PrefabName = "UI_Task", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Task.NewUI.UITask"), AnimaType = EUIAnimaType.FadeScaleUp}
, 
[UIWindowTypeID.CommonReward] = {PrefabName = "UI_CommonReward", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.CommonUI.UICommonReward")}
, 
[UIWindowTypeID.AchievementSystem] = {PrefabName = "UI_AchievementSystem", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Achievement.UI.UIAchievementSystem")}
, 
[UIWindowTypeID.ResetRoom] = {PrefabName = "UI_ResetRoom", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Exploration.UI.ResetRoom.UIResetRoom")}
, 
[UIWindowTypeID.EpTreasureRoom] = {PrefabName = "UI_EpTreasureRoom", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Exploration.UI.TreasureRoom.UITreasureRoom"), AnimaType = EUIAnimaType.FadeScaleUp}
, 
[UIWindowTypeID.SelectChip] = {PrefabName = "UI_SelectChip", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Exploration.UI.SelectChip.UISelectChip")}
, 
[UIWindowTypeID.ThreeDSelectChip] = {PrefabName = "UI_3DSelectChip", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Exploration.UI.SelectChip.UISelectChip")}
, 
[UIWindowTypeID.Exploration] = {PrefabName = "UI_Exploration", LayoutLevel = EUILayoutLevel.Bottom, WindowClass = (_ENV.require)("Game.Exploration.UI.UIExploration")}
, 
[UIWindowTypeID.EpEventRoom] = {PrefabName = "UI_EpEventRoom", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Exploration.UI.EventRoom.UIEpEventRoom"), AnimaType = EUIAnimaType.FadeScaleUp}
, 
[UIWindowTypeID.EpUpgradeRoom] = {PrefabName = "UI_EpChipLevelUp", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Exploration.UI.UpgradeRoom.UIEpUpgradeRoom"), AnimaType = EUIAnimaType.FadeScaleUp}
, 
[UIWindowTypeID.EpChipDiscard] = {PrefabName = "UI_EpChipDiscard", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Exploration.UI.ChipDiscard.UIEpChipDiscard"), AnimaType = EUIAnimaType.FadeScaleUp}
, 
[UIWindowTypeID.GlobalChipDetail] = {PrefabName = "UI_GlobalPropItemDetail_Obsolete", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.Exploration.UI.UIGlobalChipDetail")}
, 
[UIWindowTypeID.AddChipToHero] = {PrefabName = "UI_AddChipToHero_Obsolete", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Exploration.UI.ResetRoom.UIAddChipToHero")}
, 
[UIWindowTypeID.BattleDeploy] = {PrefabName = "UI_BattleDeploy", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Battle.UI.UIBattleDeploy")}
, 
[UIWindowTypeID.BattleRandomBeforeBattle] = {PrefabName = "UI_BattleRandomBeforeBattle", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Battle.UI.UINRandomBeforeBattle")}
, 
[UIWindowTypeID.BattleSkillModule] = {PrefabName = "UI_BattleSkillModule", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Battle.UI.SkillModule.UIBattleSkillModule")}
, 
[UIWindowTypeID.Battle] = {PrefabName = "UI_Battle", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Battle.UI.UIBattle")}
, 
[UIWindowTypeID.BattlePause] = {PrefabName = "UI_BattlePause", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.Battle.UI.UIBattlePause")}
, 
[UIWindowTypeID.BattleEnemyDetail] = {PrefabName = "UI_BattleEnemyDetail", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Battle.UI.UIBattleEnemyDetail"), AnimaType = EUIAnimaType.FadeScaleUp}
, 
[UIWindowTypeID.Mail] = {PrefabName = "UI_Mail", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Mail.UI.New_UIMail"), AnimaType = EUIAnimaType.FadeScaleUp}
, 
[UIWindowTypeID.Guide] = {PrefabName = "UI_Guide", LayoutLevel = EUILayoutLevel.Top, WindowClass = (_ENV.require)("Game.Guide.UIGuide")}
, 
[UIWindowTypeID.QuickBuy] = {PrefabName = "UI_QuickPurchaseBox", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.QuickPurchaseBox.New_UIQuickPurchaseBox")}
, 
[UIWindowTypeID.FloatText] = {PrefabName = "UI_FloatText", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.CommonUI.FloatText.UIFloatText")}
, 
[UIWindowTypeID.ClickContinue] = {PrefabName = "UI_ClickContinue", LayoutLevel = EUILayoutLevel.Top, WindowClass = (_ENV.require)("Game.CommonUI.ClickContinue.UIClickContinue")}
, 
[UIWindowTypeID.GlobalItemDetail] = {PrefabName = "UI_CommonItemDetail", LayoutLevel = EUILayoutLevel.LowTop, WindowClass = (_ENV.require)("Game.CommonUI.ItemDetail.UICommonItemDetailWin"), AnimaType = EUIAnimaType.Fade}
, 
[UIWindowTypeID.Ath] = {PrefabName = "UI_ATH", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Arithmetic.UIATH")}
, 
[UIWindowTypeID.AthEfficiency] = {PrefabName = "UI_ATHEfficiency", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Arithmetic.AthEfficiency.UIAthEfficiency")}
, 
[UIWindowTypeID.AthEfficiencyUpSuccess] = {PrefabName = "UI_ATHEfficiencyUpgradeSuccess", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Arithmetic.AthEfficiency.UIAthEfficiencyUpSuccess")}
, 
[UIWindowTypeID.AthItemDetail] = {PrefabName = "UI_ATHDetail", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Arithmetic.AthDetail.UIAthItemDetail")}
, 
[UIWindowTypeID.AthReplaceHero] = {PrefabName = "UI_ATHReplaceHero", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Arithmetic.AthReplaceHero.UIAthReplaceHero")}
, 
[UIWindowTypeID.AthStrengthen] = {PrefabName = "UI_ATHStrengthen", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.Arithmetic.Strengthen.UIAthStrengthen"), AnimaType = EUIAnimaType.Fade}
, 
[UIWindowTypeID.Setting] = {PrefabName = "UI_Setting", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Setting.UISetting")}
, 
[UIWindowTypeID.HeroEnter] = {PrefabName = "UI_StationedDetail_Obsolete", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.HeroEnter.UIHeroEnterSelect")}
, 
[UIWindowTypeID.HeroEnterOverView] = {PrefabName = "UI_StationedOverviewBox_Obsolete", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.HeroEnter.UIHeroEnterOverView")}
, 
[UIWindowTypeID.Dorm] = {PrefabName = "UI_Dorm", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Dorm.UI.UIDorm")}
, 
[UIWindowTypeID.DormEdit] = {PrefabName = "UI_DormEdit", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Dorm.UI.UIDormEdit")}
, 
[UIWindowTypeID.DormRoomEdit] = {PrefabName = "UI_DormRoomEdit", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Dorm.UI.Room.UIDormRoomEdit")}
, 
[UIWindowTypeID.DormOverview] = {PrefabName = "UI_DormOverview", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Dorm.UI.UIDormOverview")}
, 
[UIWindowTypeID.DormOperate] = {PrefabName = "UI_DormOperate", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Dorm.UI.UIDormOperate")}
, 
[UIWindowTypeID.DormWarehouse] = {PrefabName = "UI_DormWarehouse", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Dorm.UI.SortList.UIDormWarehouse")}
, 
[UIWindowTypeID.DormShop] = {PrefabName = "UI_DormShop", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Dorm.UI.UIDormShop")}
, 
[UIWindowTypeID.DormRoomDetail] = {PrefabName = "UI_DormRoomDetail", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.Dorm.UI.UIDormRoomDetail")}
, 
[UIWindowTypeID.DormFntDetail] = {PrefabName = "UI_DormFntDetail", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.Dorm.UI.UIDormFntDetail")}
, 
[UIWindowTypeID.DormHeroEnter] = {PrefabName = "UI_DormHeroEnter", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Dorm.UI.UIDormHeroEnter")}
, 
[UIWindowTypeID.FriendShip] = {PrefabName = "UI_FriendshipSkillUpgrade", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Friendship.NewFriendshipUI.UIFriendshipSkillUpgrade")}
, 
[UIWindowTypeID.Avg] = {PrefabName = "UI_AVGSystem", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.Avg.UI.UIAVGSystem")}
, 
[UIWindowTypeID.FriendShipHeroFoster] = {PrefabName = "UI_HeroFoster_Legacy", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Friendship.Foster.UIFoster")}
, 
[UIWindowTypeID.FriendShipPlotDungeon] = {PrefabName = "UI_HeroFriendshipDungeon", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Friendship.PlotDungeon.UIPlotDungeon")}
, 
[UIWindowTypeID.SectorLevel] = {PrefabName = "UI_SectorLevel", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Sector.SectorLevel.UISectorLevel"), AnimaType = EUIAnimaType.FadeScaleUp}
, 
[UIWindowTypeID.SectorLevelDetail] = {PrefabName = "UI_SectorLevelDetail", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Sector.SectorLevelDetail.UISectorLevelDetail")}
, 
[UIWindowTypeID.Sector] = {PrefabName = "UI_Sector", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Sector.UISector.UISector"), AnimaType = EUIAnimaType.Fade}
, 
[UIWindowTypeID.SectorTask] = {PrefabName = "UI_SectorTask", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Sector.SectorTask.New.UISectorTask"), AnimaType = EUIAnimaType.FadeScaleUp}
, 
[UIWindowTypeID.OverClock] = {PrefabName = "UI_Overclock", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Sector.Overclock.UIOverclock")}
, 
[UIWindowTypeID.CommanderSkill] = {PrefabName = "UI_CommanderSkill", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.CommanderSkill.UI.UICommanderSkill"), AnimaType = EUIAnimaType.FadeScaleUp}
, 
[UIWindowTypeID.DungeonResult] = {PrefabName = "UI_BattleResult", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.BattleDungeon.UI.UIDungeonResult")}
, 
[UIWindowTypeID.DungeonFailureResult] = {PrefabName = "UI_TempBattleFailureResult", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.BattleDungeon.UI.UIDungeonFailureResult_Temp")}
, 
[UIWindowTypeID.DungeonWaveTip] = {PrefabName = "UI_DungeonWaveTip", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.BattleDungeon.UI.UIDungeonWaveTip")}
, 
[UIWindowTypeID.Formation] = {PrefabName = "UI_Formation", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Formation.UI.UIFormation"), AnimaType = EUIAnimaType.Fade}
, 
[UIWindowTypeID.FmtHeroDetail] = {PrefabName = "UI_FormationHeroDetail", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Formation.UI.HeroDetail.UIFmtHeroDetail")}
, 
[UIWindowTypeID.FormationQuick] = {PrefabName = "UI_FormationQuick", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Formation.UI.QuickFmt.UIFormationQuick"), AnimaType = EUIAnimaType.FadeScaleUp}
, 
[UIWindowTypeID.CampBond] = {PrefabName = "UI_CampBond", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.Formation.UI.CampBond.UICampBond")}
, 
[UIWindowTypeID.UICJResult] = {PrefabName = "UI_EpCJResult_Obsolete", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.Exploration.UI.CJResult.UICJResult")}
, 
[UIWindowTypeID.DungeonStateInfo] = {PrefabName = "UI_DungeonStateInfo", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.CommonUI.DungeonState.UIDungeonStateInfo")}
, 
[UIWindowTypeID.DungeonInfoDetail] = {PrefabName = "UI_DungeonInfoDetail", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.CommonUI.DungeonState.Info.UIDungeonInfoDetail")}
, 
[UIWindowTypeID.EpStoreRoom] = {PrefabName = "UI_EpStoreRoom", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Exploration.UI.StoreRoom.UIEpStoreRoom"), AnimaType = EUIAnimaType.FadeScaleUp}
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
[UIWindowTypeID.MessageSide] = {PrefabName = "UI_MessageSide", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.Message.Side.UIMessageSide")}
, 
[UIWindowTypeID.ViewChips] = {PrefabName = "UI_ViewChips", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.ViewChips.UIViewChips"), AnimaType = EUIAnimaType.FadeScaleUp}
, 
[UIWindowTypeID.ViewItems] = {PrefabName = "UI_ViewItems", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.ViewItems.UIViewItems")}
, 
[UIWindowTypeID.MaterialDungeon] = {PrefabName = "UI_MaterialDungeon", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.MaterialDungeon.UI.UIMaterialDungeon")}
, 
[UIWindowTypeID.BattleEffectGirdInfo] = {PrefabName = "UI_BattleEffectGirdInfo", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.Battle.UI.Grid.UIBattleEffectGirdInfo")}
, 
[UIWindowTypeID.CommonCollectRes] = {PrefabName = "UI_CommonCollectRes", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.CommonUI.CollectRes.UICommonCollectRes")}
, 
[UIWindowTypeID.SelectBoardHero] = {PrefabName = "UI_HeroList", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Home.UI.UISelectBoardHero"), AnimaType = EUIAnimaType.FadeScaleUp}
, 
[UIWindowTypeID.UserNameCreate] = {PrefabName = "UI_UserNameCreate", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.User.UIUserNameCreate")}
, 
[UIWindowTypeID.ResultSkada] = {PrefabName = "UI_ResultSkada", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.BattleResult.SkadaSystem.UIResultSkada")}
, 
[UIWindowTypeID.UserInfo] = {PrefabName = "UI_UserInfo", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.User.UIUserInfo")}
, 
[UIWindowTypeID.EpAutoMode] = {PrefabName = "UI_EpAutoMode", LayoutLevel = EUILayoutLevel.Top, WindowClass = (_ENV.require)("Game.Exploration.UI.AutoMode.UIEpAutoMode")}
, 
[UIWindowTypeID.MessageCommon] = {PrefabName = "UI_MessageItemBox", LayoutLevel = EUILayoutLevel.LowTop, WindowClass = (_ENV.require)("Game.CommonUI.MessageCommon.UIMessageCommon")}
, 
[UIWindowTypeID.ATHDungeon] = {PrefabName = "UI_ATHDungeon", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.ATHDungeon.UI.UIATHDungeon")}
, 
[UIWindowTypeID.Factory] = {PrefabName = "UI_Factory", LayoutLevel = EUILayoutLevel.Normal, WindowClass = (_ENV.require)("Game.Factory.UI.UIFactory"), AnimaType = EUIAnimaType.FadeScaleUp}
, 
[UIWindowTypeID.FactoryHerolist] = {PrefabName = "UI_FactorytHeroList", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Factory.UI.FactoryHeroList.UIFactoryHeroListCover")}
, 
[UIWindowTypeID.LotteryShow] = {PrefabName = "UI_LotteryShow", LayoutLevel = EUILayoutLevel.Middle, WindowClass = (_ENV.require)("Game.Lottery.UI.UILotteryShow")}
, 
[UIWindowTypeID.BattleCrazyMode] = {PrefabName = "UI_BattleCrazyMode", LayoutLevel = EUILayoutLevel.OverHigh, WindowClass = (_ENV.require)("Game.BattleCrazyMode.UI.UIBattleCrazyMode")}
, 
[UIWindowTypeID.DungeonDropInfo] = {PrefabName = "UI_DungeonDropInfo", LayoutLevel = EUILayoutLevel.OverHigh, WindowClass = (_ENV.require)("Game.DungeonUI.DungeonDropInfo.UIDungeonDropInfo")}
, 
[UIWindowTypeID.HeroPowerUpSuccess] = {PrefabName = "UI_HeroPowerUpSuccess", LayoutLevel = EUILayoutLevel.High, WindowClass = (_ENV.require)("Game.Hero.NewUI.UIHeroPowerUpSuccess")}
}

