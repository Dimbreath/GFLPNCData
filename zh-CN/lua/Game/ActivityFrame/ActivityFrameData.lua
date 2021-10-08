local ActivityFrameData = class("ActivityFrameData")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local CheckerTypeId, CheckerGlobalConfig = (table.unpack)(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
ActivityFrameData.CreateActivityFrameData = function(activityElemMsg)
  -- function num : 0_0 , upvalues : ActivityFrameData
  local data = (ActivityFrameData.New)()
  data:__SetData(activityElemMsg)
  data.isHideBySpecial = false
  return data
end

ActivityFrameData.CreateActivityFrameDataFromFakeData = function(fakeData)
  -- function num : 0_1 , upvalues : ActivityFrameData, _ENV
  local data = (ActivityFrameData.New)()
  data.isFake = true
  data.id = fakeData.id
  data.actCat = fakeData.actCat
  data.actId = fakeData.actId
  data.bornTime = -1
  data.startTime = -1
  data.rewardStartTime = -1
  data.rewardEndTime = -1
  data.endTime = -1
  data.destoryTime = -1
  data.enterType = fakeData.enterType
  data.order = fakeData.order
  local nameCfg = (ConfigData.activity_name)[fakeData.id]
  if nameCfg == nil or not (LanguageUtil.GetLocaleText)(nameCfg.name) then
    data.name = tostring((dataMsg.ct).nameId)
    data.icon = nameCfg ~= nil and nameCfg.icon or nil
    data.isHideBySpecial = false
    return data
  end
end

ActivityFrameData.GetActivityFrameId = function(self)
  -- function num : 0_2
  return self.id
end

ActivityFrameData.GetActivityFrameCat = function(self)
  -- function num : 0_3
  return self.actCat
end

ActivityFrameData.GetEnterType = function(self)
  -- function num : 0_4
  return self.enterType
end

ActivityFrameData.GetIsActivityUnlock = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if self.condition == nil or #self.condition == 0 then
    return true
  end
  return (CheckCondition.CheckLua)(self.condition, self.conditionPara1, self.conditionPara2)
end

ActivityFrameData.GetLockTip = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if self.condition == nil or #self.condition == 0 then
    return ""
  end
  return (CheckCondition.GetUnlockInfoLua)(self.condition, self.conditionPara1, self.conditionPara2)
end

ActivityFrameData.GetIsActivityOpened = function(self)
  -- function num : 0_7 , upvalues : _ENV
  if self.endTime ~= -1 and self.endTime < PlayerDataCenter.timestamp then
    return false
  end
  if self.startTime == -1 then
    return true
  end
  do return self.startTime <= PlayerDataCenter.timestamp end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

ActivityFrameData.GetIsActivityFinished = function(self)
  -- function num : 0_8 , upvalues : _ENV
  do return self.endTime <= PlayerDataCenter.timestamp and self.endTime ~= -1 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

ActivityFrameData.GetIsActivityDestroied = function(self)
  -- function num : 0_9 , upvalues : _ENV
  do return self.destoryTime <= PlayerDataCenter.timestamp and self.destoryTime ~= -1 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

ActivityFrameData.GetCouldRuningActivity = function(self)
  -- function num : 0_10
  if self:GetIsActivityOpened() then
    return self:GetIsActivityUnlock()
  end
end

ActivityFrameData.GetCouldShowActivity = function(self)
  -- function num : 0_11
  if self:GetCouldRuningActivity() then
    return not self.isHideBySpecial
  end
end

ActivityFrameData.GetActivityFrameState = function(self)
  -- function num : 0_12 , upvalues : ActivityFrameEnum
  if self == nil or self:GetIsActivityDestroied() then
    return (ActivityFrameEnum.eActivityState).Destroied
  end
  if not self:GetIsActivityUnlock() then
    return (ActivityFrameEnum.eActivityState).Locked
  end
  if not self:GetIsActivityOpened() then
    return (ActivityFrameEnum.eActivityState).Wait2Open
  end
  if not self:GetIsActivityFinished() then
    return (ActivityFrameEnum.eActivityState).Opening
  end
  if not self:GetIsActivityDestroied() then
    return (ActivityFrameEnum.eActivityState).Closed
  end
end

ActivityFrameData.IsHaveThisCondition = function(self, conditionId)
  -- function num : 0_13
  do return self.conditionKey ~= nil and (self.conditionKey)[conditionId] ~= nil end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

ActivityFrameData.UpdateActivityFrameData = function(self, newData)
  -- function num : 0_14 , upvalues : _ENV
  if self.id ~= newData.id then
    error("activity id is diff C:" .. tostring(self.activityId) .. " S:" .. tostring(newData.id))
    return 
  end
  self:__SetData(newData)
end

ActivityFrameData.__SetData = function(self, dataMsg)
  -- function num : 0_15 , upvalues : ActivityFrameEnum, _ENV, CheckerTypeId
  self.id = dataMsg.id
  self.actCat = dataMsg.actCat
  self.actId = dataMsg.actId
  self.lifeCat = dataMsg.lifeCat
  local diffTime = 0
  if self.lifeCat == (ActivityFrameEnum.eActivityLiftType).ServerTime then
    diffTime = PlayerDataCenter.serverTm
  else
    if self.lifeCat == (ActivityFrameEnum.eActivityLiftType).RoleTime then
      diffTime = PlayerDataCenter.createRelativeTm
    end
  end
  if (dataMsg.tm).bornTm == -1 or not (dataMsg.tm).bornTm + diffTime then
    self.bornTime = dataMsg.tm == nil or -1
    self.startTime = (dataMsg.tm).startTm ~= -1 and (dataMsg.tm).startTm + diffTime or -1
    self.rewardStartTime = (dataMsg.tm).rewardStartTm ~= -1 and (dataMsg.tm).rewardStartTm + diffTime or -1
    self.rewardEndTime = (dataMsg.tm).rewardEndTm ~= -1 and (dataMsg.tm).rewardEndTm + diffTime or -1
    self.endTime = (dataMsg.tm).endTm ~= -1 and (dataMsg.tm).endTm + diffTime or -1
    self.destoryTime = (dataMsg.tm).destoryTm ~= -1 and (dataMsg.tm).destoryTm + diffTime or -1
    self.bornTime = -1
    self.startTime = -1
    self.rewardStartTime = -1
    self.rewardEndTime = -1
    self.endTime = -1
    self.destoryTime = -1
    self.conditionKey = {}
    self.condition = {}
    self.conditionPara1 = {}
    self.conditionPara2 = {}
    if dataMsg.cond ~= nil and (dataMsg.cond).data ~= nil then
      for _,data in ipairs((dataMsg.cond).data) do
        (table.insert)(self.condition, (data.data)[1])
        ;
        (table.insert)(self.conditionPara1, (data.data)[2] or 0)
        ;
        (table.insert)(self.conditionPara2, (data.data)[3] or 0)
        -- DECOMPILER ERROR at PC147: Confused about usage of register: R8 in 'UnsetPending'

        ;
        (self.conditionKey)[(data.data)[1]] = true
      end
    end
    do
      if (self.conditionKey)[CheckerTypeId.TimeRange] == nil then
        (table.insert)(self.condition, CheckerTypeId.TimeRange)
        ;
        (table.insert)(self.conditionPara1, self.startTime)
        ;
        (table.insert)(self.conditionPara2, self.endTime)
        -- DECOMPILER ERROR at PC172: Confused about usage of register: R3 in 'UnsetPending'

        ;
        (self.conditionKey)[CheckerTypeId.TimeRange] = true
      end
      self.enterType = (dataMsg.ct).enterType
      self.order = (dataMsg.ct).order
      local nameCfg = (ConfigData.activity_name)[(dataMsg.ct).nameId]
      if nameCfg == nil or not (LanguageUtil.GetLocaleText)(nameCfg.name) then
        self.name = tostring((dataMsg.ct).nameId)
        self.icon = nameCfg ~= nil and nameCfg.icon or nil
      end
    end
  end
end

return ActivityFrameData

