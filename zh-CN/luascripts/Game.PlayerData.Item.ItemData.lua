-- params : ...
-- function num : 0 , upvalues : _ENV
local ItemData = class("ItemData")
ItemData.ctor = function(self, dataId, count)
  -- function num : 0_0 , upvalues : _ENV
  self.dataId = dataId
  self.__count = count or 1
  local itemCfg = (ConfigData.item)[self.dataId]
  if itemCfg == nil then
    error("item cfg is null,Id:" .. tostring(self.dataId))
    return 
  end
  self.itemCfg = itemCfg
  self.type = (self.itemCfg).type
  self.quality = (self.itemCfg).quality
end

ItemData.UpdateData = function(self, data)
  -- function num : 0_1
  self:SetCount(data.count)
end

ItemData.GetCount = function(self)
  -- function num : 0_2
  return self.__count
end

ItemData.SetCount = function(self, value)
  -- function num : 0_3
  if self.__count ~= value then
    self.__count = value
    self:OnCountChanged()
  end
end

ItemData.AddCount = function(self, num)
  -- function num : 0_4
  if num ~= 0 then
    self.__count = self.__count + num
    self:OnCountChanged()
  end
end

ItemData.OnCountChanged = function(self)
  -- function num : 0_5
end

ItemData.ContainActionType = function(self, actionId)
  -- function num : 0_6
  do return (self.itemCfg).action_type == actionId end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

ItemData.GetActionArg = function(self, index)
  -- function num : 0_7
  return ((self.itemCfg).arg)[index] or 0
end

ItemData.GetName = function(self)
  -- function num : 0_8 , upvalues : _ENV
  return (LanguageUtil.GetLocaleText)((self.itemCfg).name)
end

ItemData.GetIcon = function(self)
  -- function num : 0_9
  return (self.itemCfg).icon
end

ItemData.GetDescribe = function(self)
  -- function num : 0_10 , upvalues : _ENV
  return (LanguageUtil.GetLocaleText)((self.itemCfg).describe)
end

ItemData.GetColor = function(self)
  -- function num : 0_11 , upvalues : _ENV
  return ItemQualityColor[self.quality]
end

ItemData.GetQuality = function(self)
  -- function num : 0_12
  return self.quality
end

return ItemData

-- params : ...
-- function num : 0 , upvalues : _ENV
local ItemData = class("ItemData")
ItemData.ctor = function(self, dataId, count)
    -- function num : 0_0 , upvalues : _ENV
    self.dataId = dataId
    self.__count = count or 1
    local itemCfg = (ConfigData.item)[self.dataId]
    if itemCfg == nil then
        error("item cfg is null,Id:" .. tostring(self.dataId))
        return
    end
    self.itemCfg = itemCfg
    self.type = (self.itemCfg).type
    self.quality = (self.itemCfg).quality
end

ItemData.UpdateData = function(self, data)
    -- function num : 0_1
    self:SetCount(data.count)
end

ItemData.GetCount = function(self)
    -- function num : 0_2
    return self.__count
end

ItemData.SetCount = function(self, value)
    -- function num : 0_3
    if self.__count ~= value then
        self.__count = value
        self:OnCountChanged()
    end
end

ItemData.AddCount = function(self, num)
    -- function num : 0_4
    if num ~= 0 then
        self.__count = self.__count + num
        self:OnCountChanged()
    end
end

ItemData.OnCountChanged = function(self)
    -- function num : 0_5
end

ItemData.ContainActionType = function(self, actionId)
    -- function num : 0_6
    do return (self.itemCfg).action_type == actionId end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

ItemData.GetActionArg = function(self, index)
    -- function num : 0_7
    return ((self.itemCfg).arg)[index] or 0
end

ItemData.GetName = function(self)
    -- function num : 0_8 , upvalues : _ENV
    return (LanguageUtil.GetLocaleText)((self.itemCfg).name)
end

ItemData.GetIcon = function(self)
    -- function num : 0_9
    return (self.itemCfg).icon
end

ItemData.GetDescribe = function(self)
    -- function num : 0_10 , upvalues : _ENV
    return (LanguageUtil.GetLocaleText)((self.itemCfg).describe)
end

ItemData.GetColor = function(self)
    -- function num : 0_11 , upvalues : _ENV
    return ItemQualityColor[self.quality]
end

ItemData.GetQuality = function(self)
    -- function num : 0_12
    return self.quality
end

return ItemData

