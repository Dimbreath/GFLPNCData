-- params : ...
-- function num : 0 , upvalues : _ENV
ControllerTypeId = {SectorController = 1, OasisController = 2, FunctionUnlock = 3, Shop = 4, Factory = 5, Task = 6, Mail = 7, Setting = 8, Dorm = 9, Avg = 10, Overclock = 11, Formation = 12, AvgPlay = 13, TimePass = 14, HomeController = 15, Login = 16, Lottery = 17}
ControllerGlobalConfig = {
[ControllerTypeId.HomeController] = {ControllerClass = require("Game.Home.HomeController")}
, 
[ControllerTypeId.SectorController] = {ControllerClass = require("Game.Sector.SectorController")}
, 
[ControllerTypeId.OasisController] = {ControllerClass = require("Game.Oasis.OasisController")}
, 
[ControllerTypeId.FunctionUnlock] = {ControllerClass = require("Game.FunctionUnlock.FunctionUnlockController")}
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
}

-- params : ...
-- function num : 0 , upvalues : _ENV
ControllerTypeId = {
    SectorController = 1,
    OasisController = 2,
    FunctionUnlock = 3,
    Shop = 4,
    Factory = 5,
    Task = 6,
    Mail = 7,
    Setting = 8,
    Dorm = 9,
    Avg = 10,
    Overclock = 11,
    Formation = 12,
    AvgPlay = 13,
    TimePass = 14,
    HomeController = 15,
    Login = 16,
    Lottery = 17
}
ControllerGlobalConfig = {
    [ControllerTypeId.HomeController] = {
        ControllerClass = require("Game.Home.HomeController")
    },
    [ControllerTypeId.SectorController] = {
        ControllerClass = require("Game.Sector.SectorController")
    },
    [ControllerTypeId.OasisController] = {
        ControllerClass = require("Game.Oasis.OasisController")
    },
    [ControllerTypeId.FunctionUnlock] = {
        ControllerClass = require("Game.FunctionUnlock.FunctionUnlockController")
    },
    [ControllerTypeId.Shop] = {
        ControllerClass = require("Game.Shop.ShopController")
    },
    [ControllerTypeId.Factory] = {
        ControllerClass = require("Game.Factory.FactoryController")
    },
    [ControllerTypeId.Task] = {
        ControllerClass = require("Game.Task.TaskController")
    },
    [ControllerTypeId.Mail] = {
        ControllerClass = require("Game.Mail.New_MailController")
    },
    [ControllerTypeId.Setting] = {
        ControllerClass = require("Game.Setting.SettingController")
    },
    [ControllerTypeId.Dorm] = {
        ControllerClass = require("Game.Dorm.DormController")
    },
    [ControllerTypeId.Avg] = {
        ControllerClass = require("Game.Avg.AvgController")
    },
    [ControllerTypeId.AvgPlay] = {
        ControllerClass = require("Game.Avg.AvgPlayController")
    },
    [ControllerTypeId.Overclock] = {
        ControllerClass = require("Game.Sector.Overclock.OverclockController")
    },
    [ControllerTypeId.Formation] = {
        ControllerClass = require("Game.Formation.FormationController")
    },
    [ControllerTypeId.TimePass] = {
        ControllerClass = require("Game.TimePass.TimePassController")
    },
    [ControllerTypeId.Login] = {
        ControllerClass = require("Game.Login.LoginController")
    },
    [ControllerTypeId.Lottery] = {
        ControllerClass = require("Game.Lottery.LotteryController")
    }
}

