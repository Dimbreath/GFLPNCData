-- params : ...
-- function num : 0 , upvalues : _ENV
local WeeklyChallengeData = class("WeeklyChallengeData")
WeeklyChallengeData.ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.id = nil
  self.cfg = nil
  self.buffList = {}
  self.heroIdList = {}
  self.chipList = {}
  self.exploreBuffId = nil
  self.baseRecommandPower = 0
  self.weeklyRecommandPowerEffectRate = (ConfigData.game_config).weeklyRecommandPowerEffectRate or 0
  self.lastDebuffRecorder = nil
end

WeeklyChallengeData.UpdateByMsg = function(self, id, weeklyChallengeElem)
  -- function num : 0_1 , upvalues : _ENV
  self.id = id
  self.buffDic = (weeklyChallengeElem.cfg).initBuffId
  if not ((ConfigData.game_config).weeklyRecommandPower)[id] then
    self.baseRecommandPower = (ConfigData.game_config).weeklyRecommandPower == nil or 0
    local heroGroup = (weeklyChallengeElem.cfg).heroGroup
    self.heroIdList = {}
    for k,v in pairs(heroGroup) do
      (table.insert)(self.heroIdList, k)
    end
    self.baseRate = (weeklyChallengeElem.cfg).baseRate
    self.exploreBuffId = (weeklyChallengeElem.cfg).exploreBuffId
    self.cfg = (ConfigData.weekly_challenge)[self.id]
    local clgId = (self.cfg).challenge_id
    local endTime = (weeklyChallengeElem.cfg).endTime
    if (ConfigData.weekly_challenge_config)[clgId] == nil or ((ConfigData.weekly_challenge_config)[clgId])[endTime] == nil then
      error((string.format)("Cant get weekly_challenge_config, id:%s, endTime:%s", clgId, endTime))
      return 
    end
    self.wc_cfg = ((ConfigData.weekly_challenge_config)[clgId])[endTime]
  end
end

WeeklyChallengeData.GetWeeklyChanllengeChipDic = function(self)
  -- function num : 0_2
  return (self.wc_cfg).const_shop_poolDic
end

WeeklyChallengeData.IsEffectBuff = function(self, buffId)
  -- function num : 0_3
  do return (self.buffDic ~= nil and (self.buffDic)[buffId] ~= nil) or (self.exploreBuffId ~= nil and (self.exploreBuffId)[buffId] ~= nil) end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

WeeklyChallengeData.GetBuffEffect = function(self, buffId)
  -- function num : 0_4
  if self.buffDic ~= nil and (self.buffDic)[buffId] ~= nil then
    return (self.buffDic)[buffId]
  end
  if self.exploreBuffId ~= nil and (self.exploreBuffId)[buffId] ~= nil then
    return (self.exploreBuffId)[buffId]
  end
end

WeeklyChallengeData.GetLastDebuff = function(self)
  -- function num : 0_5
  return self.lastDebuffRecorder
end

WeeklyChallengeData.SetLastDebuff = function(self, buffIds)
  -- function num : 0_6
  self.lastDebuffRecorder = buffIds
end

WeeklyChallengeData.IsUnlockWeeklyChallenge = function(self)
  -- function num : 0_7 , upvalues : _ENV
  return (CheckCondition.CheckLua)((self.cfg).pre_condition, (self.cfg).pre_para1, (self.cfg).pre_para2)
end

return WeeklyChallengeData

