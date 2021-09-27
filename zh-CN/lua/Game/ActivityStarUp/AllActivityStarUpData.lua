local AllActivityStarUpData = class("AllActivityStarUpData")
local ActivityStarUpEnum = require("Game.ActivityStarUp.ActivityStarUpEnum")
local ActivityStarUpData = require("Game.ActivityStarUp.ActivityStarUpData")
AllActivityStarUpData.InitActivityStarUp = function(self)
  -- function num : 0_0 , upvalues : _ENV, ActivityStarUpData
  self.__isInited = true
  self.dataDic = {}
  for k,v in pairs(ConfigData.rookie_star) do
    local data = (ActivityStarUpData.New)()
    data:InitStarUp(v)
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self.dataDic)[k] = data
  end
end

AllActivityStarUpData.UpdateStage = function(self, taskId)
  -- function num : 0_1 , upvalues : _ENV
  for k,v in pairs(self.dataDic) do
    if v.curStageId ~= nil then
      if (((v.cfg).phase)[v.curStageId]).task == taskId then
        v:RefreshStage()
      else
        if v:ContainsTask(taskId) then
          v:UpdateStarUpRedddot()
        end
      end
    end
  end
end

AllActivityStarUpData.UpdateTask = function(self, taskData)
  -- function num : 0_2 , upvalues : _ENV
  if not taskData:CheckComplete() then
    return 
  end
  if not self.__isInited then
    return 
  end
  for k,v in pairs(self.dataDic) do
    if v.curStageId ~= nil and v:ContainsTask(taskData.id) then
      v:UpdateStarUpRedddot()
    end
  end
end

AllActivityStarUpData.GetInfo = function(self, activityId)
  -- function num : 0_3
  return (self.dataDic)[activityId]
end

return AllActivityStarUpData

