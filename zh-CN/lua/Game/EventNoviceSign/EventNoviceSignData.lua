local EventNoviceSignData = class("EventNoviceSignData")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local TaskEnum = require("Game.Task.TaskEnum")
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

EventNoviceSignData.GetReceiveState = function(self, day)
  -- function num : 0_2 , upvalues : TaskEnum
  if day <= self.times then
    return (TaskEnum.eTaskState).Picked
  end
  if day == self.times + 1 and self:IsAllowReceive() then
    return (TaskEnum.eTaskState).Completed
  end
  return (TaskEnum.eTaskState).InProgress
end

EventNoviceSignData.IsAllowReceive = function(self)
  -- function num : 0_3 , upvalues : _ENV
  do return self.nextExpiredTm < PlayerDataCenter.timestamp and self.times < (table.count)(self.awardCfg) end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

EventNoviceSignData.SetPoped = function(self)
  -- function num : 0_4 , upvalues : _ENV
  self.nextPopTime = (math.floor)(PlayerDataCenter.timestamp)
  local timeTable = TimestampToDate(self.nextPopTime)
  timeTable.hour = 0
  timeTable.min = 0
  timeTable.sec = 0
  self.nextPopTime = (os.time)(timeTable) + 86400
end

EventNoviceSignData.IsCanPop = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if not self:IsAllowReceive() then
    return false
  end
  if self.nextPopTime == nil then
    return true
  end
  do return self.nextPopTime <= PlayerDataCenter.timestamp end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return EventNoviceSignData

