-- params : ...
-- function num : 0 , upvalues : _ENV
local PeriodicChallengeData = class("PeriodicChallengeData")
local PeridicChallengeEnum = require("Game.PeriodicChallenge.PeridicChallengeEnum")
local SpecificHeroDataRuler = require("Game.PlayerData.Hero.SpecificHeroDataRuler")
PeriodicChallengeData.ctor = function(self)
  -- function num : 0_0
  self.dataHasError = nil
  self.dailyChallengeId = nil
  self.dailyBuffList = nil
  self.dailyChipList = nil
  self.isDailyOutOfData = true
  self.specificHeroDataCacheDic = {}
  self.specificHeroDataRuler = nil
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

PeriodicChallengeData.SetIsDailyOutOfData = function(self, bool)
  -- function num : 0_8
  self.isDailyOutOfData = bool
end

PeriodicChallengeData.GetIsDailyOutOfData = function(self)
  -- function num : 0_9
  return self.isDailyOutOfData
end

PeriodicChallengeData.GetSpecificHeroData = function(self, heroId, specificHeroDataRuler)
  -- function num : 0_10 , upvalues : _ENV
  local isSameRuler = self:__CampareSpecificHeroDataRuler(specificHeroDataRuler)
  if isSameRuler then
    local heroData = (self.specificHeroDataCacheDic)[heroId]
    if heroData ~= nil then
      return heroData
    else
      heroData = PlayerDataCenter:GetSpecificHeroData(heroId, specificHeroDataRuler)
      -- DECOMPILER ERROR at PC18: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (self.specificHeroDataCacheDic)[heroId] = heroData
    end
    return heroData
  else
    do
      local heroData = PlayerDataCenter:GetSpecificHeroData(heroId, specificHeroDataRuler)
      self:__SetSpecificHeroDataRuler(specificHeroDataRuler)
      self.specificHeroDataCacheDic = {}
      -- DECOMPILER ERROR at PC32: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (self.specificHeroDataCacheDic)[heroId] = heroData
      do return heroData end
    end
  end
end

PeriodicChallengeData.__SetSpecificHeroDataRuler = function(self, specificHeroDataRuler)
  -- function num : 0_11
  self.specificHeroDataRuler = specificHeroDataRuler
end

PeriodicChallengeData.__CampareSpecificHeroDataRuler = function(self, specificHeroDataRuler)
  -- function num : 0_12 , upvalues : _ENV
  if self.specificHeroDataRuler == nil then
    return false
  end
  if specificHeroDataRuler == nil then
    error("specificHeroDataRuler is empty, pls check it")
    return false
  end
  return (self.specificHeroDataRuler):CampareTo(specificHeroDataRuler)
end

PeriodicChallengeData.CleanSpecificHeroData = function(self)
  -- function num : 0_13
  self.specificHeroDataCacheDic = nil
end

return PeriodicChallengeData

