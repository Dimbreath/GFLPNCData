local NoticeData = require("Game.Notice.NoticeData")
local eDungeonEnum = require("Game.Dungeon.eDungeonEnum")
local JumpManager = require("Game.Jump.JumpManager")
local TimePassPostprocessFunc = {[proto_object_CounterModule.CounterModuleDailyChallenge] = function(isUpdate)
  -- function num : 0_0 , upvalues : _ENV
  local _, periodicRedNote = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Sector, RedDotStaticTypeId.PeriodicChallenge)
  if not (PlayerDataCenter.periodicChallengeData):GetIsDailyChallengeFished() or not 0 then
    local num = periodicRedNote == nil or 1
  end
  periodicRedNote:SetRedDotCount(num)
end
, [proto_object_CounterModule.CounterModuleGlobalDailyFlush] = function(isUpdate)
  -- function num : 0_1 , upvalues : _ENV
  if not isUpdate then
    return 
  end
  NoticeManager:RefreshDungeonRewardRateNotice(true, false)
end
}
return TimePassPostprocessFunc

