local AutoResourceGeneratorData = class("AutoResourceGeneratorData")
AutoResourceGeneratorData.ctor = function(self)
  -- function num : 0_0
  self.itemId = nil
  self.startTm = nil
  self.frag = 0
  self.ceiling = 0
  self.genSpeed = 0
  self.originalValue = 0
  self.newGenValue = 0
end

AutoResourceGeneratorData.UpdateItem = function(self, ARGBase)
  -- function num : 0_1 , upvalues : _ENV
  self.itemId = ARGBase.itemId
  self.startTm = ARGBase.startTm
  self.frag = ARGBase.frag
  self.originalValue = PlayerDataCenter:GetItemCount(self.itemId, true)
  self.ceiling = (PlayerDataCenter.playerBonus):GetWarehouseCapcity(self.itemId)
  self.genSpeed = (PlayerDataCenter.playerBonus):GetAutoRecoverItemSpeed(self.itemId)
  if self.itemId == ConstGlobalItem.SKey then
    (PlayerDataCenter.stamina):BroadcastStamina()
  end
end

AutoResourceGeneratorData.UpdateItemCeil = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self.ceiling = (PlayerDataCenter.playerBonus):GetWarehouseCapcity(self.itemId)
  if self.itemId == ConstGlobalItem.SKey then
    (PlayerDataCenter.stamina):BroadcastStamina()
  end
end

AutoResourceGeneratorData.UpdateItemSpeed = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if self.accRate == nil then
    self.genSpeed = (PlayerDataCenter.playerBonus):GetAutoRecoverItemSpeed(self.itemId)
  else
    self.genSpeed = (PlayerDataCenter.playerBonus):GetAutoRecoverItemSpeed(self.itemId) * (1 + self.accRate)
  end
  if self.itemId == ConstGlobalItem.SKey then
    (PlayerDataCenter.stamina):BroadcastStamina()
  end
end

AutoResourceGeneratorData.SetAccRate = function(self, accRate)
  -- function num : 0_4 , upvalues : _ENV
  self.accRate = accRate
  local oringSpeed = (PlayerDataCenter.playerBonus):GetAutoRecoverItemSpeed(self.itemId)
  self.genSpeed = oringSpeed * (1 + accRate)
  if self.itemId == ConstGlobalItem.SKey then
    (PlayerDataCenter.stamina):BroadcastStamina()
  end
end

AutoResourceGeneratorData.GetCurrentNum = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if self.startTm == nil or self.genSpeed == nil then
    return 0, 0
  end
  local num = self.originalValue
  local remainSecond = 0
  if self.ceiling <= num then
    return num, remainSecond
  end
  local timestamp = PlayerDataCenter.timestamp
  local interval = timestamp - self.startTm
  if interval < -1 then
    return num, remainSecond
  end
  local frag = self.frag + interval * self.genSpeed
  local num = num + (math.floor)(frag / 100000)
  if self.ceiling <= num then
    num = self.ceiling
  else
    if self.genSpeed == 0 then
      remainSecond = 0
    else
      local remainFrag = 100000 - frag % 100000
      remainSecond = (math.ceil)(remainFrag / self.genSpeed)
    end
  end
  do
    return num, remainSecond
  end
end

AutoResourceGeneratorData.GetARGCeiling = function(self)
  -- function num : 0_6
  return self.ceiling
end

AutoResourceGeneratorData.GetARGGenSpeedPerSecond = function(self, isBase)
  -- function num : 0_7 , upvalues : _ENV
  do
    if isBase then
      local oringSpeed = (PlayerDataCenter.playerBonus):GetAutoRecoverItemSpeed(self.itemId)
      return oringSpeed / 100000
    end
    return self.genSpeed / 100000
  end
end

return AutoResourceGeneratorData

