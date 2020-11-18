-- params : ...
-- function num : 0 , upvalues : _ENV
local StaminaData = class("StaminaData")
StaminaData.ctor = function(self)
  -- function num : 0_0
  self.ceilingByLogic = 0
  self.ceilingByLevel = 0
  self.ceiling = 0
  self.value = 0
  self.output = 0
end

StaminaData.UpdateStamina = function(self, data)
  -- function num : 0_1
  local needUpdate = false
  if self.value ~= data or self.recoveTm ~= data.recoveTm or self.frag ~= data.frag then
    needUpdate = true
  end
  self.value = data.value
  self.recoveTm = data.recoveTm
  self.frag = data.frag
  if needUpdate then
    self:BroadcastStamina()
  end
end

StaminaData.UpdateStaminaLogic = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self.ceilingByLogic = (PlayerDataCenter.playerBonus):GetStaminaCeiling()
  self.output = (PlayerDataCenter.playerBonus):GetStaminaOutput()
  self:__UpdateStaaminaCeiling()
end

StaminaData.UpdateStaminaCfgByLevel = function(self, level)
  -- function num : 0_3 , upvalues : _ENV
  local cfg = (ConfigData.achievement_level)[level]
  if cfg == nil then
    error("can\'t find achievement_level by level, level = " .. tostring(level))
    return 
  end
  local ceiling = cfg.stamina
  if self.ceilingByLevel ~= ceiling then
    self.ceilingByLevel = ceiling
    self:__UpdateStaaminaCeiling()
    self:BroadcastStamina()
  end
end

StaminaData.__UpdateStaaminaCeiling = function(self)
  -- function num : 0_4
  self.ceiling = self.ceilingByLogic + self.ceilingByLevel
end

StaminaData.GetCurrentStamina = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if self.recoveTm == nil or self.output == nil then
    return 0, 0
  end
  local stamina = self.value
  local remainSecond = 0
  if self.ceiling <= stamina then
    return stamina, remainSecond
  end
  local timestamp = PlayerDataCenter.timestamp
  local interval = timestamp - self.recoveTm
  if interval < -1 then
    return stamina, remainSecond
  end
  local frag = self.frag + interval * self.output
  local stamina = stamina + (math.floor)(frag / 100000)
  if self.ceiling <= stamina then
    stamina = self.ceiling
  else
    if self.output == 0 then
      remainSecond = 0
    else
      local remainFrag = 100000 - frag % 100000
      remainSecond = (math.ceil)(remainFrag / self.output)
    end
  end
  do
    return stamina, remainSecond
  end
end

StaminaData.StartTimer = function(self, time)
  -- function num : 0_6 , upvalues : _ENV
  if self.__Timer ~= nil then
    (self.__Timer):Stop()
    self.__Timer = nil
  end
  self.__Timer = (TimerManager:GetTimer(time, self.BroadcastStamina, self, true)):Start()
end

StaminaData.BroadcastStamina = function(self)
  -- function num : 0_7 , upvalues : _ENV
  self.__Timer = nil
  MsgCenter:Broadcast(eMsgEventId.StaminaUpdate)
  local stamina, remainSecond = self:GetCurrentStamina()
  if remainSecond > 0 then
    self:StartTimer(remainSecond + 1)
  else
    if stamina < self.ceiling then
      self:StartTimer(1)
    end
  end
end

return StaminaData

