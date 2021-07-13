-- params : ...
-- function num : 0 , upvalues : _ENV
local DynPlayerData = class("DynPlayerData")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
DynPlayerData.ctor = function(self, data)
  -- function num : 0_0 , upvalues : ExplorationEnum
  self.data = data
  self.baseAttr = {}
  self.ratioAttr = {}
  self.extraAttr = {}
  self.originAttr = {}
  if self.data ~= nil then
    self:__updateBaseAttr(self.data)
  end
  self.intensity = 0
  self.hpPer = ExplorationEnum.eHeroHpPercent
  self.moveSpeed = 0
  self.attackRange = 10
end

DynPlayerData.RefreshDynData = function(self, data)
  -- function num : 0_1
  self.data = data
  if self.data ~= nil then
    self:__updateBaseAttr(self.data)
  end
end

DynPlayerData.__updateBaseAttr = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  if data ~= nil and data.attr ~= nil then
    local attrData = (self.data).attr
    for i = 2, max_property_count + 1 do
      -- DECOMPILER ERROR at PC15: Confused about usage of register: R7 in 'UnsetPending'

      (self.originAttr)[i - 1] = attrData[i]
    end
  end
end

DynPlayerData.GetOriginAttr = function(self, attrId)
  -- function num : 0_3
  return (self.originAttr)[attrId] or 0
end

DynPlayerData.GetRatioAttr = function(self, attrId)
  -- function num : 0_4
  return (self.ratioAttr)[attrId] or 0
end

DynPlayerData.GetExtraAttr = function(self, attrId)
  -- function num : 0_5
  return (self.extraAttr)[attrId] or 0
end

DynPlayerData.GetRealAttr = function(self, attrId)
  -- function num : 0_6 , upvalues : _ENV
  return (((self.originAttr)[attrId] or 0) + ((self.baseAttr)[attrId] or 0)) * (eHeroAttrPercent + ((self.ratioAttr)[attrId] or 0)) // eHeroAttrPercent + ((self.extraAttr)[attrId] or 0)
end

DynPlayerData.GetBaseAttr = function(self, attrId)
  -- function num : 0_7
  return (self.baseAttr)[attrId] or 0
end

DynPlayerData.SetBaseAttr = function(self, attrId, value)
  -- function num : 0_8
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self.baseAttr)[attrId] = value
end

DynPlayerData.SetRatioAttr = function(self, attrId, value)
  -- function num : 0_9 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self.ratioAttr)[attrId] = value
  if attrId == eHeroAttr.maxHp then
    self.maxHp = self:GetRealAttr(eHeroAttr.maxHp)
  end
end

DynPlayerData.SetExtraAttr = function(self, attrId, value)
  -- function num : 0_10 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self.extraAttr)[attrId] = value
  if attrId == eHeroAttr.maxHp then
    self.maxHp = self:GetRealAttr(eHeroAttr.maxHp)
  end
end

return DynPlayerData

