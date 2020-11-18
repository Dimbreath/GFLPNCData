-- params : ...
-- function num : 0 , upvalues : _ENV
local ArithmeticData = class("ArithmeticData")
local AthEnum = require("Game.Arithmetic.ArthmeticEnum")
ArithmeticData.ctor = function(self, dataTab)
  -- function num : 0_0 , upvalues : _ENV
  self.uid = dataTab.uid
  self.id = dataTab.uid >> 32
  self:UpdateAthData(dataTab)
  local itemCfg = (ConfigData.item)[self.id]
  if itemCfg == nil then
    error("Can\'t find itemCfg by arithmetic.id, id = " .. tostring(self.id))
    return 
  end
  self.itemCfg = itemCfg
  local athCfg = (ConfigData.arithmetic)[self.id]
  if athCfg == nil then
    error("Can\'t arithmetic cfg, id = " .. tostring(self.id))
    return 
  end
  self.athCfg = athCfg
  self.size = athCfg.size
  self.quality = itemCfg.quality
  self.area_type = athCfg.area_type
  self.suit = athCfg.suit
end

ArithmeticData.UpdateAthData = function(self, dataTab)
  -- function num : 0_1
  self.attrList = dataTab.attr
  self.affixList = dataTab.affix
  self.bindInfo = dataTab.bindInfo
  self.lockUnlock = dataTab.lockUnlock
  self.timeStemp = dataTab.ts
end

ArithmeticData.GetAthMainAttrId = function(self)
  -- function num : 0_2 , upvalues : _ENV
  for k,attr in ipairs(self.attrList) do
    local attrId = attr.id
    local attrCfg = (ConfigData.attribute)[attrId]
    if attrCfg == nil then
      error("Cant get attrCfg, attrId = " .. tostring(attrId))
      return 
    end
    if attrCfg.merge_attribute == 0 then
      return attrId
    else
      return attrCfg.merge_attribute
    end
  end
end

ArithmeticData.GetColor = function(self)
  -- function num : 0_3 , upvalues : _ENV
  return ItemQualityColor[(self.itemCfg).quality]
end

ArithmeticData.GetAthColor = function(self)
  -- function num : 0_4 , upvalues : AthEnum
  return (AthEnum.AthColor)[(self.itemCfg).quality]
end

ArithmeticData.GetAthSize = function(self)
  -- function num : 0_5
  return (self.athCfg).size
end

ArithmeticData.GetAthSuit = function(self)
  -- function num : 0_6
  return (self.athCfg).suit
end

ArithmeticData.GetAthAreaType = function(self)
  -- function num : 0_7
  return (self.athCfg).area_type
end

ArithmeticData.GetAthQuality = function(self)
  -- function num : 0_8
  return (self.itemCfg).quality
end

ArithmeticData.GetIcon = function(self)
  -- function num : 0_9
  return (self.itemCfg).icon
end

ArithmeticData.GetName = function(self)
  -- function num : 0_10 , upvalues : _ENV
  return (LanguageUtil.GetLocaleText)((self.itemCfg).name)
end

ArithmeticData.GetAthFightPower = function(self)
  -- function num : 0_11 , upvalues : _ENV
  do
    if self.__fightPower == nil then
      local athAttr = self:GetAthAttr()
      self.__fightPower = (PlayerDataCenter.allAthData):GetAthFightPower(athAttr)
    end
    return self.__fightPower
  end
end

ArithmeticData.GetAthDensity = function(self)
  -- function num : 0_12 , upvalues : _ENV
  local athAttr = self:GetAthAttr()
  return (PlayerDataCenter.allAthData):GetAthDensity(athAttr, self.size)
end

ArithmeticData.GetAthAttr = function(self)
  -- function num : 0_13 , upvalues : _ENV
  local athAttr = setmetatable({}, {__index = function(tab, key)
    -- function num : 0_13_0
    return 0
  end
})
  for k,attr in ipairs(self.attrList) do
    athAttr[attr.id] = athAttr[attr.id] + attr.value
  end
  for k,affix in ipairs(self.affixList) do
    local cfg = (ConfigData.ath_affix_pool)[affix.id]
    if cfg == nil then
      error("Can\'t find ath_affix_pool, id = " .. tostring(affix.id))
    else
      athAttr[cfg.affix_para] = athAttr[cfg.affix_para] + affix.value
    end
  end
  return athAttr
end

ArithmeticData.IsHaveThisAttr = function(self, attrId)
  -- function num : 0_14 , upvalues : _ENV
  for index,attr in ipairs(self.attrList) do
    if attr.id == attrId then
      return true
    end
  end
  return false
end

ArithmeticData.IsHaveThisViceAttr = function(self, attrId)
  -- function num : 0_15 , upvalues : _ENV
  for index,attr in ipairs(self.affixList) do
    if attr.id == attrId then
      return true
    end
  end
  return false
end

return ArithmeticData

