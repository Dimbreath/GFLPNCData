-- params : ...
-- function num : 0 , upvalues : _ENV
ControllerTypeId = {SectorController = 1, OasisController = 2, Shop = 4, Factory = 5, Task = 6, Mail = 7, Setting = 8, Dorm = 9, Avg = 10, Overclock = 11, Formation = 12, AvgPlay = 13, TimePass = 14, HomeController = 15, Login = 16, Lottery = 17, Cv = 18, StrategyOverview = 19, Activity = 20, BuildingQueue = 21}
ControllerGlobalConfig = {
[ControllerTypeId.HomeController] = {ControllerClass = require("Game.Home.HomeController")}
, 
[ControllerTypeId.SectorController] = {ControllerClass = require("Game.Sector.SectorController")}
, 
[ControllerTypeId.OasisController] = {ControllerClass = require("Game.Oasis.OasisController")}
, 
[ControllerTypeId.Shop] = {ControllerClass = require("Game.Shop.ShopController")}
, 
[ControllerTypeId.Factory] = {ControllerClass = require("Game.Factory.FactoryController")}
, 
[ControllerTypeId.Task] = {ControllerClass = require("Game.Task.TaskController")}
, 
[ControllerTypeId.Mail] = {ControllerClass = require("Game.Mail.New_MailController")}
, 
[ControllerTypeId.Setting] = {ControllerClass = require("Game.Setting.SettingController")}
, 
[ControllerTypeId.Dorm] = {ControllerClass = require("Game.Dorm.DormController")}
, 
[ControllerTypeId.Avg] = {ControllerClass = require("Game.Avg.AvgController")}
, 
[ControllerTypeId.AvgPlay] = {ControllerClass = require("Game.Avg.AvgPlayController")}
, 
[ControllerTypeId.Overclock] = {ControllerClass = require("Game.Sector.Overclock.OverclockController")}
, 
[ControllerTypeId.Formation] = {ControllerClass = require("Game.Formation.FormationController")}
, 
[ControllerTypeId.TimePass] = {ControllerClass = require("Game.TimePass.TimePassController")}
, 
[ControllerTypeId.Login] = {ControllerClass = require("Game.Login.LoginController")}
, 
[ControllerTypeId.Lottery] = {ControllerClass = require("Game.Lottery.LotteryController")}
, 
[ControllerTypeId.Cv] = {ControllerClass = require("Game.CharacterVoice.CharacterVoiceController")}
, 
[ControllerTypeId.StrategyOverview] = {ControllerClass = require("Game.StrategyOverview.StrategyOverviewController")}
, 
[ControllerTypeId.Activity] = {ControllerClass = require("Game.Activity.ActivityController")}
, 
[ControllerTypeId.BuildingQueue] = {ControllerClass = require("Game.Oasis.BuildingQueueCtrl")}
}

