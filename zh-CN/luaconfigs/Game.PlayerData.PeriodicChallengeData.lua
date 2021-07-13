-- params : ...
-- function num : 0 , upvalues : _ENV
local PeriodicChallengeData = class("PeriodicChallengeData")
local PeridicChallengeEnum = require("Game.PeriodicChallenge.PeridicChallengeEnum")
PeriodicChallengeData.ctor = function(self)
  -- function num : 0_0
  self.dataHasError = nil
  self.dailyChallengeId = nil
  self.dailyBuffList = nil
  self.dailyChipList = nil
  self.isDailyOutOfData = true
end

PeriodicChallengeData.UpdateFromDailyChallengeMsg = function(self, msg)
  -- function num : 0_1 , upvalues : _ENV
  self.isDailyOutOfData = false
  self.dataHasError = nil
  if msg.data == nil then
    print("daily challenge mag data is nil")
    self.dataHasError = true
    return 
  end
  self.dailyChallengeId = (msg.data).id
  self.dailyBuffList = ((msg.data).randomData).buffList
  self.dailyChipPoolList = ((msg.data).randomData).algPoolList
  self:__GenChipList()
  local _, periodicRedNote = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Sector, RedDotStaticTypeId.PeriodicChallenge)
  if not self:GetIsDailyChallengeFished() or not 0 then
    local num = periodicRedNote == nil or 1
  end
  periodicRedNote:SetRedDotCount(num)
end

PeriodicChallengeData.GetChallengeId = function(self, eChallengeType)
  -- function num : 0_2 , upvalues : PeridicChallengeEnum
  if eChallengeType == (PeridicChallengeEnum.eChallengeType).daliy then
    return self.dailyChallengeId
  end
end

PeriodicChallengeData.GetChallengeBuffList = function(self, eChallengeType)
  -- function num : 0_3 , upvalues : PeridicChallengeEnum
  if eChallengeType == (PeridicChallengeEnum.eChallengeType).daliy then
    return self.dailyBuffList
  end
  return 
end

PeriodicChallengeData.__GenChipList = function(self)
  -- function num : 0_4 , upvalues : _ENV
  self.dailyChipList = {}
  for _,chipPoolId in ipairs(self.dailyChipPoolList) do
    local chipPoolCfg = (ConfigData.ep_function_pool)[chipPoolId]
    for _,chipId in ipairs(chipPoolCfg.function_pool) do
      (table.insert)(self.dailyChipList, chipId)
    end
  end
end

PeriodicChallengeData.GetDailyChallengeChipList = function(self, eChallengeType)
  -- function num : 0_5 , upvalues : PeridicChallengeEnum
  if eChallengeType == (PeridicChallengeEnum.eChallengeType).daliy then
    return self.dailyChipList
  end
  return 
end

PeriodicChallengeData.GetChallengeCounterElem = function(self, eChallengeType)
  -- function num : 0_6 , upvalues : PeridicChallengeEnum, _ENV
  if eChallengeType == (PeridicChallengeEnum.eChallengeType).daliy then
    return (ControllerManager:GetController(ControllerTypeId.TimePass)):getCounterElemData(proto_object_CounterModule.CounterModuleDailyChallenge, 0)
  end
end

PeriodicChallengeData.GetIsDailyChallengeFished = function(self)
  -- function num : 0_7 , upvalues : PeridicChallengeEnum
  local counterElem = self:GetChallengeCounterElem((PeridicChallengeEnum.eChallengeType).daliy)
  do return counterElem ~= nil and counterElem.times == 2 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

PeriodicChallengeData.GetDailyChallengeStage = function(self)
  -- function num : 0_8 , upvalues : _ENV, PeridicChallengeEnum
  local maxReward = (ConfigData.game_config).dailyRewardMax
  if self:GetIsDailyChallengeFished() then
    return true, maxReward, maxReward
  end
  local counterElem = self:GetChallengeCounterElem((PeridicChallengeEnum.eChallengeType).daliy)
  if counterElem == nil then
    return 0
  end
  local mask = 1000
  local number = 0
  if mask < counterElem.times then
    number = counterElem.times - mask
  end
  return false, number, maxReward
end

PeriodicChallengeData.SetIsDailyOutOfData = function(self, bool)
  -- function num : 0_9
  self.isDailyOutOfData = bool
end

PeriodicChallengeData.GetIsDailyOutOfData = function(self)
  -- function num : 0_10
  return self.isDailyOutOfData
end

return PeriodicChallengeData

