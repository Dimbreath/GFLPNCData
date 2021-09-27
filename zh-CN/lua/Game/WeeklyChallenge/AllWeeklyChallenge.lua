local AllWeeklyChallengeData = class("AllWeeklyChallengeData")
local WeeklyChallengeData = require("Game.WeeklyChallenge.WeeklyChallengeData")
AllWeeklyChallengeData.ctor = function(self)
  -- function num : 0_0
  self.dataDic = {}
  self.isOutOfData = true
  self.currentScore = 0
  self.rankTm = 0
  self.rewardDic = {}
  self.doublePickTm = nil
end

AllWeeklyChallengeData.UpdateByMsg = function(self, msg)
  -- function num : 0_1 , upvalues : _ENV, WeeklyChallengeData
  self.dataDic = {}
  for id,weeklyChallengeElem in pairs(msg.elem) do
    local data = (WeeklyChallengeData.New)()
    data:UpdateByMsg(id, weeklyChallengeElem)
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (self.dataDic)[id] = data
  end
  do
    if not ((msg.wc).current).score then
      self.currentScore = msg.wc == nil or 0
      self.rankTm = ((msg.wc).current).rankTm or 0
      if not (msg.wc).reward then
        self.rewardDic = {}
        self.doublePickTm = ((msg.wc).current).doublePickTm
        self.isOutOfData = false
      end
    end
  end
end

AllWeeklyChallengeData.UpdateScoreInfo = function(self, dungeonId, score, rewardDic)
  -- function num : 0_2 , upvalues : _ENV
  local isHaveNot = true
  for k,v in pairs(self.dataDic) do
    if k == dungeonId then
      isHaveNot = false
      break
    end
  end
  do
    if isHaveNot then
      return 
    end
    if rewardDic ~= nil and (table.count)(rewardDic) > 0 then
      for k,v in pairs(rewardDic) do
        -- DECOMPILER ERROR at PC31: Confused about usage of register: R10 in 'UnsetPending'

        if (self.rewardDic)[k] == nil then
          (self.rewardDic)[k] = v
        else
          -- DECOMPILER ERROR at PC37: Confused about usage of register: R10 in 'UnsetPending'

          ;
          (self.rewardDic)[k] = (self.rewardDic)[k] + v
        end
      end
    end
    do
      if score ~= nil and self.currentScore < score and PlayerDataCenter.timestamp < self.rankTm and (((self.dataDic)[dungeonId]).cfg).have_rank then
        self.currentScore = score
      end
    end
  end
end

AllWeeklyChallengeData.GetWeeklyChallengeDataByDungeonId = function(self, dungeonId)
  -- function num : 0_3
  return (self.dataDic)[dungeonId]
end

AllWeeklyChallengeData.GetWeeklyChallengeReward = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local rewardMax = (ConfigData.game_config).weeklyRewardMax
  local counterElem = self:GetCounterElem()
  local isFinish = counterElem == nil or counterElem.nextExpiredTm < PlayerDataCenter.timestamp
  do return isFinish, (self.rewardDic)[1] or 0, rewardMax[1] or 0, (self.rewardDic)[2] or 0, rewardMax[2] or 0 end
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

AllWeeklyChallengeData.GetCounterElem = function(self)
  -- function num : 0_5 , upvalues : _ENV
  return (ControllerManager:GetController(ControllerTypeId.TimePass)):getCounterElemData(proto_object_CounterModule.CounterModuleWeeklyChallengeFresh, 0)
end

AllWeeklyChallengeData.IsUnlockExtraReward = function(self)
  -- function num : 0_6 , upvalues : _ENV
  for _,data in pairs(self.dataDic) do
    if #(data.cfg).base_reward > 1 and data:IsUnlockWeeklyChallenge() then
      return true
    end
  end
  return false
end

AllWeeklyChallengeData.SetOutOfData = function(self)
  -- function num : 0_7
  self.isOutOfData = true
end

AllWeeklyChallengeData.IsOutOfData = function(self)
  -- function num : 0_8
  return self.isOutOfData
end

AllWeeklyChallengeData.IsExistChallenge = function(self)
  -- function num : 0_9 , upvalues : _ENV
  do return (table.count)(self.dataDic) > 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

AllWeeklyChallengeData.ConvetTypeReward2RewadDic = function(weeklyReward)
  -- function num : 0_10 , upvalues : _ENV
  local num = 0
  for type,rewardNum in pairs(weeklyReward) do
    num = rewardNum + num
  end
  if num > 0 then
    return {[(ConfigData.game_config).weeklyRewardItemId] = num}
  else
    return nil
  end
end

AllWeeklyChallengeData.IsTokenReach2Capacity = function(self)
  -- function num : 0_11
  local isFinish, baseNum, baseMax, extrNum, extrMax = self:GetWeeklyChallengeReward()
  if isFinish or baseMax <= baseNum and extrMax <= extrNum then
    return true
  end
  return false
end

AllWeeklyChallengeData.GetIsUnderDoubleReward = function(self)
  -- function num : 0_12 , upvalues : _ENV
  if self.doublePickTm == nil then
    return true
  end
  do return self.doublePickTm <= PlayerDataCenter.timestamp end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return AllWeeklyChallengeData

