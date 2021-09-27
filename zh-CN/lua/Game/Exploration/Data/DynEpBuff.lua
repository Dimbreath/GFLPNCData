local DynEpBuff = class("DynEpBuff")
DynEpBuff.ctor = function(self, id)
  -- function num : 0_0 , upvalues : _ENV
  self.dataId = id
  local buffCfg = (ConfigData.exploration_buff)[self.dataId]
  if buffCfg == nil then
    error("exploration buff cfg is null,id:" .. tostring(self.dataId))
    return 
  end
  self.epBuffCfg = buffCfg
end

DynEpBuff.InitDynEpBuffInfo = function(self, buff)
  -- function num : 0_1
  if buff.info ~= nil then
    self.expireTm = (buff.info).expireTm
    self.cnt = (buff.info).cnt
    self.durationLayer = (buff.info).durationLayer
  else
    self.expireTm = -1
    self.cnt = -1
    self.durationLayer = -1
  end
end

DynEpBuff.InitDynEpBuffItemId = function(self, itemId, level)
  -- function num : 0_2 , upvalues : _ENV
  local itemCfg = (ConfigData.item)[itemId]
  if itemCfg == nil then
    error("Cant get item cfg, id = " .. tostring(itemId))
    return 
  end
  self.itemCfg = itemCfg
  self._level = level or 1
end

DynEpBuff.IsBuffNeedShowOnBuffList = function(self)
  -- function num : 0_3
  return (self.epBuffCfg).is_listshow
end

DynEpBuff.GetEpBuffCfg = function(self)
  -- function num : 0_4
  return self.epBuffCfg
end

DynEpBuff.GetSpecificLogicPara = function(self, logic)
  -- function num : 0_5
  if (self.epBuffCfg).logic ~= logic then
    return false
  end
  return true, (self.epBuffCfg).logic_num, (self.epBuffCfg).logic_per
end

DynEpBuff.GetEpBuffBuyPrice = function(self, epModuleId)
  -- function num : 0_6 , upvalues : _ENV
  local epTypeCfg = (ConfigData.exploration_type)[epModuleId]
  if epTypeCfg == nil then
    error("Cant get exploration_type cfg, epModuleId = " .. tostring(epModuleId))
    return 0
  end
  return (epTypeCfg.chip_buff_price)[self._level] or 0
end

DynEpBuff.GetEpBuffName = function(self)
  -- function num : 0_7 , upvalues : _ENV
  return (LanguageUtil.GetLocaleText)((self.epBuffCfg).name)
end

DynEpBuff.GetEpBuffIcon = function(self)
  -- function num : 0_8 , upvalues : _ENV
  return CRH:GetSprite((self.epBuffCfg).icon, CommonAtlasType.ExplorationIcon)
end

DynEpBuff.GetEpBuffDescribe = function(self)
  -- function num : 0_9 , upvalues : _ENV
  return (LanguageUtil.GetLocaleText)((self.epBuffCfg).describe)
end

return DynEpBuff

