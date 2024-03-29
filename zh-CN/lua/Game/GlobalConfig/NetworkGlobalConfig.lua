require("Framework.Network.NetworkProto")
NetworkTypeID = {Hero = 1, Lottery = 2, Building = 3, Shop = 5, Sector = 6, Object = 7, Task = 8, Factory = 9, Exploration = 10, AchivLevel = 11, ItemRoom = 12, StoreRoom = 14, EventRoom = 15, ResetRoom = 16, Mail = 17, Login = 18, Arithmetic = 19, Dorm = 20, HeroEnter = 21, Effector = 22, Friendship = 23, BattleDungeon = 24, Debug = 25, Avg = 26, CommanderSkill = 27, BattlePass = 28, DailySignIn = 29, ActivityFrame = 30, Pay = 31, CDKey = 32, EventNoviceSign = 33, PayGift = 34, Warehouse = 35, Friend = 36, TimingProduct = 37, GM = 999}
NetworkGlobalConfig = {
[NetworkTypeID.Hero] = {NetworkClass = require("Game.Hero.HeroNetworkCtrl")}
, 
[NetworkTypeID.Lottery] = {NetworkClass = require("Game.Lottery.LotteryNetworkCtrl")}
, 
[NetworkTypeID.Building] = {NetworkClass = require("Game.Oasis.BuildingNetworkCtrl")}
, 
[NetworkTypeID.Shop] = {NetworkClass = require("Game.Shop.ShopNetworkCtrl")}
, 
[NetworkTypeID.Sector] = {NetworkClass = require("Game.Sector.SectorNetworkCtrl")}
, 
[NetworkTypeID.Object] = {NetworkClass = require("Game.PlayerData.ObjectNetworkCtrl")}
, 
[NetworkTypeID.Task] = {NetworkClass = require("Game.Task.TaskNetworkCtrl")}
, 
[NetworkTypeID.Factory] = {NetworkClass = require("Game.Factory.FactoryNetworkCtrl")}
, 
[NetworkTypeID.Exploration] = {NetworkClass = require("Game.Exploration.ExplorationNetworkCtrl")}
, 
[NetworkTypeID.AchivLevel] = {NetworkClass = require("Game.Achievement.AchivLevelNetworkCtrl")}
, 
[NetworkTypeID.ItemRoom] = {NetworkClass = require("Game.Exploration.ItemRoomNetworkCtrl")}
, 
[NetworkTypeID.StoreRoom] = {NetworkClass = require("Game.Exploration.StoreRoomNetworkCtrl")}
, 
[NetworkTypeID.EventRoom] = {NetworkClass = require("Game.Exploration.EventRoomNetworkCtrl")}
, 
[NetworkTypeID.ResetRoom] = {NetworkClass = require("Game.Exploration.ResetRoomNetworkCtrl")}
, 
[NetworkTypeID.Mail] = {NetworkClass = require("Game.Mail.MailNetworkCtrl")}
, 
[NetworkTypeID.Login] = {NetworkClass = require("Game.Login.LoginNetWorkCtrl")}
, 
[NetworkTypeID.Arithmetic] = {NetworkClass = require("Game.Arithmetic.ArithmeticNetwork")}
, 
[NetworkTypeID.Dorm] = {NetworkClass = require("Game.Dorm.DormNetworkCtrl")}
, 
[NetworkTypeID.HeroEnter] = {NetworkClass = require("Game.HeroEnter.HeroEnterNetworkCtrl")}
, 
[NetworkTypeID.Effector] = {NetworkClass = require("Game.Effector.EffectorNetworkCtrl")}
, 
[NetworkTypeID.Friendship] = {NetworkClass = require("Game.Friendship.FriendshipNetworkCtrl")}
, 
[NetworkTypeID.BattleDungeon] = {NetworkClass = require("Game.BattleDungeon.BattleDungeonNetworkCtrl")}
, 
[NetworkTypeID.Debug] = {NetworkClass = require("Game.Debug.DebugNetworkCtrl")}
, 
[NetworkTypeID.Avg] = {NetworkClass = require("Game.Avg.AvgNetwork")}
, 
[NetworkTypeID.CommanderSkill] = {NetworkClass = require("Game.CommanderSkill.CommanderSkillNetworkCtrl")}
, 
[NetworkTypeID.BattlePass] = {NetworkClass = require("Game.BattlePass.BattlePassNetworkCtrl")}
, 
[NetworkTypeID.Pay] = {NetworkClass = require("Game.Pay.PayNetworkCtrl")}
, 
[NetworkTypeID.GM] = {NetworkClass = require("Game.GM.GMNetworkCtrl")}
, 
[NetworkTypeID.DailySignIn] = {NetworkClass = require("Game.DailySignIn.DailySignInNetworkCtrl")}
, 
[NetworkTypeID.ActivityFrame] = {NetworkClass = require("Game.ActivityFrame.ActivityFrameNetworkCtrl")}
, 
[NetworkTypeID.CDKey] = {NetworkClass = require("Game.Setting.CDKeyNetworkCtrl")}
, 
[NetworkTypeID.EventNoviceSign] = {NetworkClass = require("Game.EventNoviceSign.EventNoviceSignNetwork")}
, 
[NetworkTypeID.PayGift] = {NetworkClass = require("Game.PayGift.PayGiftNetworkController")}
, 
[NetworkTypeID.Warehouse] = {NetworkClass = require("Game.Warehouse.WarehouseNetwork")}
, 
[NetworkTypeID.Friend] = {NetworkClass = require("Game.Friend.FriendNetworkCtrl")}
, 
[NetworkTypeID.TimingProduct] = {NetworkClass = require("Game.PlayerData.TimingProduct.TimingProductNetwork")}
}

