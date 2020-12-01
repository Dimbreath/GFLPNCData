-- params : ...
-- function num : 0 , upvalues : _ENV
local AttributeBonus = class("AttributeBonus")
AttributeBonus.ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._attriMetatable = {__index = function(tab, key)
    -- function num : 0_0_0
    return 0
  end
}
  self._nestMetatable = {__index = function(tab, key)
    -- function num : 0_0_1 , upvalues : _ENV, self
    tab[key] = setmetatable({}, self._attriMetatable)
    return tab[key]
  end
}
  self.camp = setmetatable({}, self._nestMetatable)
  self.career = setmetatable({}, self._nestMetatable)
  self.allHero = setmetatable({}, self._attriMetatable)
  self.heroAth = {}
  self.SingleHeroBonus = {}
end

AttributeBonus.AddCampBonus = function(self, campId, attrId, attrValue)
  -- function num : 0_1
  local bonus = (self.camp)[campId]
  bonus[attrId] = bonus[attrId] + attrValue
end

AttributeBonus.AddCareerBonus = function(self, careerId, attrId, attrValue)
  -- function num : 0_2
  local bonus = (self.career)[careerId]
  bonus[attrId] = bonus[attrId] + attrValue
end

AttributeBonus.AddAllBonus = function(self, attrId, attrValue)
  -- function num : 0_3
  local bonus = self.allHero
  bonus[attrId] = bonus[attrId] + attrValue
end

AttributeBonus.RemoveCampBonus = function(self, campId, attrId, attrValue)
  -- function num : 0_4
  local bonus = (self.camp)[campId]
  bonus[attrId] = bonus[attrId] - attrValue
end

AttributeBonus.RemoveCareerBonus = function(self, careerId, attrId, attrValue)
  -- function num : 0_5
  local bonus = (self.career)[careerId]
  bonus[attrId] = bonus[attrId] - attrValue
end

AttributeBonus.RemoveAllBonus = function(self, attrId, attrValue)
  -- function num : 0_6
  local bonus = self.allHero
  bonus[attrId] = bonus[attrId] - attrValue
end

AttributeBonus.GetHeroAthBonus = function(self, heroId)
  -- function num : 0_7 , upvalues : _ENV
  if heroId == nil then
    return table.emptytable
  end
  local athBonus = (self.heroAth)[heroId]
  if athBonus == nil then
    athBonus = (PlayerDataCenter.allAthData):GetHeroAthAttr(heroId)
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self.heroAth)[heroId] = athBonus
  end
  return athBonus
end

AttributeBonus.DirtyHeroAthBonus = function(self, heroId)
  -- function num : 0_8
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.heroAth)[heroId] = nil
end

AttributeBonus.SetSingleHroeBonus = function(self, heroId, attrId, value)
  -- function num : 0_9
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R4 in 'UnsetPending'

  if (self.SingleHeroBonus)[heroId] == nil then
    (self.SingleHeroBonus)[heroId] = {}
  end
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R4 in 'UnsetPending'

  if ((self.SingleHeroBonus)[heroId])[attrId] == nil then
    ((self.SingleHeroBonus)[heroId])[attrId] = value
  else
    -- DECOMPILER ERROR at PC22: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.SingleHeroBonus)[heroId])[attrId] = ((self.SingleHeroBonus)[heroId])[attrId] + value
  end
end

AttributeBonus.__GetSingleHroeBonus = function(self, heroId, attrId)
  -- function num : 0_10
  if (self.SingleHeroBonus)[heroId] == nil then
    return 0
  end
  if ((self.SingleHeroBonus)[heroId])[attrId] == nil then
    return 0
  end
  return ((self.SingleHeroBonus)[heroId])[attrId]
end

AttributeBonus.GetAtrBonus = function(self, attrId, campId, careerId, athHeroId)
  -- function num : 0_11
  local athBonusDic = self:GetHeroAthBonus(athHeroId)
  local singleHeroBonus = self:__GetSingleHroeBonus(athHeroId, attrId)
  local bonus = (self.allHero)[attrId] + ((self.camp)[campId])[attrId] + ((self.career)[careerId])[attrId] + (athBonusDic[attrId] or 0) + singleHeroBonus
  return bonus
end

AttributeBonus.AtrBonusAdd = function(self, attrValue, baseAttrId, attrId, campId, careerId, athHeroId)
  -- function num : 0_12 , upvalues : _ENV
  local atrCfg = (ConfigData.attribute)[attrId]
  if atrCfg == nil then
    return 0
  end
  local baseAtrCfg = (ConfigData.attribute)[baseAttrId]
  if baseAtrCfg == nil then
    return 0
  end
  local bonus = self:GetAtrBonus(attrId, campId, careerId, athHeroId)
  if atrCfg.num_type == 1 or baseAtrCfg.num_type == 2 then
    attrValue = attrValue + bonus
  else
    attrValue = (attrValue) * (1000 + bonus) // 1000
  end
  return attrValue
end

return AttributeBonus

-- params : ...
-- function num : 0 , upvalues : _ENV
local AttributeBonus = class("AttributeBonus")
AttributeBonus.ctor = function(self)
    -- function num : 0_0 , upvalues : _ENV
    self._attriMetatable = {
        __index = function(tab, key)
            -- function num : 0_0_0
            return 0
        end
    }
    self._nestMetatable = {
        __index = function(tab, key)
            -- function num : 0_0_1 , upvalues : _ENV, self
            tab[key] = setmetatable({}, self._attriMetatable)
            return tab[key]
        end
    }
    self.camp = setmetatable({}, self._nestMetatable)
    self.career = setmetatable({}, self._nestMetatable)
    self.allHero = setmetatable({}, self._attriMetatable)
    self.heroAth = {}
    self.SingleHeroBonus = {}
end

AttributeBonus.AddCampBonus = function(self, campId, attrId, attrValue)
    -- function num : 0_1
    local bonus = (self.camp)[campId]
    bonus[attrId] = bonus[attrId] + attrValue
end

AttributeBonus.AddCareerBonus = function(self, careerId, attrId, attrValue)
    -- function num : 0_2
    local bonus = (self.career)[careerId]
    bonus[attrId] = bonus[attrId] + attrValue
end

AttributeBonus.AddAllBonus = function(self, attrId, attrValue)
    -- function num : 0_3
    local bonus = self.allHero
    bonus[attrId] = bonus[attrId] + attrValue
end

AttributeBonus.RemoveCampBonus = function(self, campId, attrId, attrValue)
    -- function num : 0_4
    local bonus = (self.camp)[campId]
    bonus[attrId] = bonus[attrId] - attrValue
end

AttributeBonus.RemoveCareerBonus = function(self, careerId, attrId, attrValue)
    -- function num : 0_5
    local bonus = (self.career)[careerId]
    bonus[attrId] = bonus[attrId] - attrValue
end

AttributeBonus.RemoveAllBonus = function(self, attrId, attrValue)
    -- function num : 0_6
    local bonus = self.allHero
    bonus[attrId] = bonus[attrId] - attrValue
end

AttributeBonus.GetHeroAthBonus = function(self, heroId)
    -- function num : 0_7 , upvalues : _ENV
    if heroId == nil then return table.emptytable end
    local athBonus = (self.heroAth)[heroId]
    if athBonus == nil then
        athBonus = (PlayerDataCenter.allAthData):GetHeroAthAttr(heroId) -- DECOMPILER ERROR at PC16: Confused about usage of register: R3 in 'UnsetPending'
        ;
        (self.heroAth)[heroId] = athBonus
    end
    return athBonus
end

AttributeBonus.DirtyHeroAthBonus = function(self, heroId)
    -- function num : 0_8
    -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

    (self.heroAth)[heroId] = nil
end

AttributeBonus.SetSingleHroeBonus = function(self, heroId, attrId, value)
    -- function num : 0_9
    -- DECOMPILER ERROR at PC6: Confused about usage of register: R4 in 'UnsetPending'

    if (self.SingleHeroBonus)[heroId] == nil then
        (self.SingleHeroBonus)[heroId] = {}
    end
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R4 in 'UnsetPending'

    if ((self.SingleHeroBonus)[heroId])[attrId] == nil then
        ((self.SingleHeroBonus)[heroId])[attrId] = value
    else
        -- DECOMPILER ERROR at PC22: Confused about usage of register: R4 in 'UnsetPending'


        ((self.SingleHeroBonus)[heroId])[attrId] =
            ((self.SingleHeroBonus)[heroId])[attrId] + value
    end
end

AttributeBonus.__GetSingleHroeBonus = function(self, heroId, attrId)
    -- function num : 0_10
    if (self.SingleHeroBonus)[heroId] == nil then return 0 end
    if ((self.SingleHeroBonus)[heroId])[attrId] == nil then return 0 end
    return ((self.SingleHeroBonus)[heroId])[attrId]
end

AttributeBonus.GetAtrBonus = function(self, attrId, campId, careerId, athHeroId)
    -- function num : 0_11
    local athBonusDic = self:GetHeroAthBonus(athHeroId)
    local singleHeroBonus = self:__GetSingleHroeBonus(athHeroId, attrId)
    local bonus = (self.allHero)[attrId] + ((self.camp)[campId])[attrId] +
                      ((self.career)[careerId])[attrId] +
                      (athBonusDic[attrId] or 0) + singleHeroBonus
    return bonus
end

AttributeBonus.AtrBonusAdd = function(self, attrValue, baseAttrId, attrId,
                                      campId, careerId, athHeroId)
    -- function num : 0_12 , upvalues : _ENV
    local atrCfg = (ConfigData.attribute)[attrId]
    if atrCfg == nil then return 0 end
    local baseAtrCfg = (ConfigData.attribute)[baseAttrId]
    if baseAtrCfg == nil then return 0 end
    local bonus = self:GetAtrBonus(attrId, campId, careerId, athHeroId)
    if atrCfg.num_type == 1 or baseAtrCfg.num_type == 2 then
        attrValue = attrValue + bonus
    else
        attrValue = (attrValue) * (1000 + bonus) // 1000
    end
    return attrValue
end

return AttributeBonus

