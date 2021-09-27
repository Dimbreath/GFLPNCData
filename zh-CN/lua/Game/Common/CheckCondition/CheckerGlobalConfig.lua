local CheckerTypeId = {PlayerLevel = 1, CompleteTask = 2, CompleteStage = 3, BuildingLevel = 4, FunctionUnlock = 5, FrienshipLevel = 6, CompleteDungeon = 7, CompleteAvg = 8, MinHeroStar = 9, MaxHeroStar = 10, InfinityDungeon = 11, TimeRange = 12, PlayerLevelUpLimit = 13, UserChannel = 14, StOCareerLevelLimit = 16}
local CheckerGlobalConfig = {
[CheckerTypeId.PlayerLevel] = {Checker = require("Game.Common.CheckCondition.Checker.CheckerPlayLevel")}
, 
[CheckerTypeId.CompleteTask] = {Checker = require("Game.Common.CheckCondition.Checker.CheckerTask")}
, 
[CheckerTypeId.CompleteStage] = {Checker = require("Game.Common.CheckCondition.Checker.CheckerSectorStage")}
, 
[CheckerTypeId.BuildingLevel] = {Checker = require("Game.Common.CheckCondition.Checker.CheckerBuilding")}
, 
[CheckerTypeId.FunctionUnlock] = {Checker = require("Game.Common.CheckCondition.Checker.CheckerFuncUnlock")}
, 
[CheckerTypeId.FrienshipLevel] = {Checker = require("Game.Common.CheckCondition.Checker.CherkerFriendshipLevel")}
, 
[CheckerTypeId.CompleteDungeon] = {Checker = require("Game.Common.CheckCondition.Checker.CherkerGeneralDungeon")}
, 
[CheckerTypeId.CompleteAvg] = {Checker = require("Game.Common.CheckCondition.Checker.CheckAvg")}
, 
[CheckerTypeId.MinHeroStar] = {Checker = require("Game.Common.CheckCondition.Checker.CheckMinHeroStar")}
, 
[CheckerTypeId.MaxHeroStar] = {Checker = require("Game.Common.CheckCondition.Checker.CheckMaxHeroStar")}
, 
[CheckerTypeId.InfinityDungeon] = {Checker = require("Game.Common.CheckCondition.Checker.CheckerInfinityDungeon")}
, 
[CheckerTypeId.TimeRange] = {Checker = require("Game.Common.CheckCondition.Checker.CheckerTimeRange")}
, 
[CheckerTypeId.PlayerLevelUpLimit] = {Checker = require("Game.Common.CheckCondition.Checker.CheckerPlayerLevelUpLimit")}
, 
[CheckerTypeId.UserChannel] = {Checker = require("Game.Common.CheckCondition.Checker.CheckerUserChannel")}
, 
[CheckerTypeId.StOCareerLevelLimit] = {Checker = require("Game.Common.CheckCondition.Checker.CheckerStOCareerLevel")}
}
local ChckerCfg = {CheckerTypeId, CheckerGlobalConfig}
return ChckerCfg

