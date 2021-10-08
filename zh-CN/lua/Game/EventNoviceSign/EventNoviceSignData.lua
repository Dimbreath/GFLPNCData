local EventNoviceSignData = class("EventNoviceSignData")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local TaskEnum = require("Game.Task.TaskEnum")
local eSignType = {Novice = 1, Festival = 2}
EventNoviceSignData.InitNoviceSignData = function(self, data)
  -- function num : 0_0 , upvalues : _ENV
  self.id = data.id
  self.cfg = (ConfigData.sign_activity)[self.id]
  self.awardCfg = (ConfigData.sign_activity_award)[self.id]
  self:UpdateNoviceSignData(data)
end

EventNoviceSignData.UpdateNoviceSignData = function(self, data)
  -- function num : 0_1 , upvalues : _ENV, ActivityFrameEnum
  self.times = data.times
  self.nextExpiredTm = data.nextExpiredTm
  local activityFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
  activityFrameCtrl:SetReddot((ActivityFrameEnum.eActivityType).SevenDayLogin, self.id, self:IsAllowReceive() and 1 or 0)
  if (table.count)(self.awardCfg) <= self.times then
    activityFrameCtrl:HideActivityByExtraLogic((ActivityFrameEnum.eActivityType).SevenDayLogin, self.id)
  end
end

EventNoviceSignData.GetSignDataStartEndTimestamp = function(self)
  -- function num : 0_2 , upvalues : _ENV, ActivityFrameEnum
  local activityFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
  local activityId = activityFrameCtrl:GetIdByActTypeAndActId((ActivityFrameEnum.eActivityType).SevenDayLogin, self.id)
  local actData = activityFrameCtrl:GetActivityFrameData(activityId)
  if actData == nil then
    return -1, -1
  end
  return actData.startTime, actData.endTime
end

EventNoviceSignData.GetReceiveState = function(self, day)
  -- function num : 0_3 , upvalues : TaskEnum
  if day <= self.times then
    return (TaskEnum.eTaskState).Picked
  end
  if day == self.times + 1 and self:IsAllowReceive() then
    return (TaskEnum.eTaskState).Completed
  end
  return (TaskEnum.eTaskState).InProgress
end

EventNoviceSignData.IsAllowReceive = function(self)
  -- function num : 0_4 , upvalues : _ENV
  do return self.nextExpiredTm < PlayerDataCenter.timestamp and self.times < (table.count)(self.awardCfg) end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

EventNoviceSignData.SetPoped = function(self)
  -- function num : 0_5 , upvalues : _ENV
  self.popTime = PlayerDataCenter.timestamp
end

EventNoviceSignData.IsCanPop = function(self)
  -- function num : 0_6 , upvalues : _ENV, ActivityFrameEnum
  local activityFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
  if activityFrameCtrl ~= nil then
    local activityId = activityFrameCtrl:GetIdByActTypeAndActId((ActivityFrameEnum.eActivityType).SevenDayLogin, self.id)
    local actData = activityFrameCtrl:GetActivityFrameData(activityId)
    if actData ~= nil and not actData:GetCouldShowActivity() then
      return false
    end
  end
  do
    if not self:IsAllowReceive() then
      return false
    end
    local timePassCtrl = ControllerManager:GetController(ControllerTypeId.TimePass)
    do
      if self.popTime ~= nil then
        local isTody = timePassCtrl:GetIsLogicToday(self.popTime)
        if PlayerDataCenter.timestamp < self.popTime or isTody then
          return false
        end
      end
      return true
    end
  end
end

EventNoviceSignData.GetSignRewardList = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local list = {}
  for k,v in pairs(self.awardCfg) do
    (table.insert)(list, v)
  end
  ;
  (table.sort)(list, function(a, b)
    -- function num : 0_7_0
    do return a.day < b.day end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  return list
end

EventNoviceSignData.GetSignCfg = function(self)
  -- function num : 0_8
  return self.cfg
end

EventNoviceSignData.IsFestivalSign = function(self)
  -- function num : 0_9 , upvalues : eSignType
  do return (self.cfg).sign_type == eSignType.Festival end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return EventNoviceSignData

