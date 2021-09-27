local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local HomeEnum = require("Game.Home.HomeEnum")
local ActivityFrameOpenFunc = {[(ActivityFrameEnum.eActivityType).StarUp] = function(activityId)
  -- function num : 0_0 , upvalues : _ENV
  local data = ((PlayerDataCenter.activityStarUpData).dataDic)[activityId]
  if data ~= nil then
    data:UpdateStarUpRedddot()
  end
end
, [(ActivityFrameEnum.eActivityType).BattlePass] = function(activityId)
  -- function num : 0_1 , upvalues : _ENV
  if ((PlayerDataCenter.battlepassData).passInfos)[activityId] ~= nil then
    return 
  end
  local defaultData = {
[activityId] = {lv = 1, exp = 0, unlockSenior = false, 
taken = {}
}
}
  ;
  (PlayerDataCenter.battlepassData):UpdateAllBattlePass(defaultData)
end
, [(ActivityFrameEnum.eActivityType).SevenDayLogin] = function(activityId)
  -- function num : 0_2 , upvalues : _ENV
  if ((PlayerDataCenter.eventNoviceSignData).dataDic)[activityId] ~= nil then
    return 
  end
  local defaultData = {id = activityId, times = 0, nextExpiredTm = 0}
  ;
  (PlayerDataCenter.eventNoviceSignData):UpdateNoviceSignData(defaultData)
  local HomeEnum = require("Game.Home.HomeEnum")
  local HomeController = ControllerManager:GetController(ControllerTypeId.HomeController)
  if HomeController ~= nil and HomeController.homeState == (HomeEnum.eHomeState).Normal then
    HomeController:AddAutoShowGuide((HomeEnum.eAutoShwoCommand).NoviceSign)
  end
end
}
return ActivityFrameOpenFunc

