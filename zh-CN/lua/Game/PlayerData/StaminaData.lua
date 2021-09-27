local StaminaData = class("StaminaData")
StaminaData.ctor = function(self)
  -- function num : 0_0
end

StaminaData.GetCurrentStamina = function(self)
  -- function num : 0_1 , upvalues : _ENV
  local ARGData = ((PlayerDataCenter.allEffectorData).AutoResourceGeneratorDic)[ConstGlobalItem.SKey]
  if ARGData ~= nil then
    return ARGData:GetCurrentNum()
  else
    return 0, 0
  end
end

StaminaData.GetStaminaCeiling = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local ARGData = ((PlayerDataCenter.allEffectorData).AutoResourceGeneratorDic)[ConstGlobalItem.SKey]
  if ARGData ~= nil then
    return ARGData:GetARGCeiling()
  else
    return 0
  end
end

StaminaData.StartTimer = function(self, time)
  -- function num : 0_3 , upvalues : _ENV
  if self.__TimerId ~= nil then
    TimerManager:StopTimer(self.__TimerId)
    self.__TimerId = nil
  end
  self.__TimerId = TimerManager:StartTimer(time, self.BroadcastStamina, self, true)
end

StaminaData.BroadcastStamina = function(self)
  -- function num : 0_4 , upvalues : _ENV
  self.__TimerId = nil
  MsgCenter:Broadcast(eMsgEventId.StaminaUpdate)
  local stamina, remainSecond = self:GetCurrentStamina()
  if remainSecond > 0 then
    self:StartTimer(remainSecond + 1)
  else
    if stamina < self:GetStaminaCeiling() then
      self:StartTimer(1)
    end
  end
end

return StaminaData

