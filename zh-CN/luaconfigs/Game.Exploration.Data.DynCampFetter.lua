-- params : ...
-- function num : 0 , upvalues : _ENV
local DynCampFetter = class("DynCampFetter")
local eCampFetterCoolDownType = (require("Game.Exploration.ExplorationEnum")).eCampFetterCoolDownType
local eCampFetterCDType = (require("Game.Exploration.ExplorationEnum")).eCampFetterCDType
DynCampFetter.ctor = function(self, campId, campConCfg, campCount)
  -- function num : 0_0
  self.campId = campId
  self.campConCfg = campConCfg
  self.campHeroNum = campCount or 0
  self.isActive = false
  self.activeId = nil
  self.couldUseActive = false
  self.activeCdValue = nil
  self:InitActiveFetterSkill()
end

DynCampFetter.GetCampFetterCampId = function(self)
  -- function num : 0_1
  return self.campId
end

DynCampFetter.GetCampHeroNum = function(self)
  -- function num : 0_2
  return self.campHeroNum
end

DynCampFetter.InitActiveFetterSkill = function(self)
  -- function num : 0_3
  self.isActive = (self.campConCfg).is_active ~= 0 and (self.campConCfg).is_show_active ~= 0
  if self.isActive then
    self.activeId = (self.campConCfg).is_active
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

DynCampFetter.GetIsHaveActiveFetterSkill = function(self)
  -- function num : 0_4
  return self.isActive
end

DynCampFetter.GetActiveFetterSkillID = function(self)
  -- function num : 0_5
  return self.activeId
end

DynCampFetter.GetActiceFetterCDType = function(self)
  -- function num : 0_6
  return (self.campConCfg).cool_down_type
end

DynCampFetter.GetActiveFetterUID = function(self)
  -- function num : 0_7
  if not self.isActive then
    return nil
  end
  local uid = self.campId << 32 | (self.campConCfg).fetters_num
  return uid, self.campId, (self.campConCfg).fetters_num
end

DynCampFetter.GetActiveFetterDes = function(self)
  -- function num : 0_8 , upvalues : _ENV
  if not self.isActive then
    return ""
  end
  return (LanguageUtil.GetLocaleText)(((ConfigData.camp_active_skill)[self:GetActiveFetterSkillID()]).des)
end

DynCampFetter.GetActiveFetterSkillCD = function(self, extraUID)
  -- function num : 0_9
  if extraUID ~= nil then
    if self.extraCdValue == nil then
      return false
    else
      return (self.extraCdValue)[extraUID]
    end
  end
  return self.activeCdValue, (self.campConCfg).cool_down_param - (self.activeCdValue or 1) + 1
end

DynCampFetter.GetCouldeUseActiveFetterSkill = function(self, extraUID)
  -- function num : 0_10
  if extraUID ~= nil then
    if self.couldUseExtraActive == nil then
      return false
    else
      return (self.couldUseExtraActive)[extraUID]
    end
  end
  return self.couldUseActive
end

DynCampFetter.SetActiveValue = function(self, value, extraUID)
  -- function num : 0_11
  if extraUID ~= nil then
    if self.couldUseExtraActive == nil then
      self.couldUseExtraActive = {}
      self.extraCdValue = {}
    end
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self.couldUseExtraActive)[extraUID] = value <= 0
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self.extraCdValue)[extraUID] = value
    return 
  end
  if value <= 0 then
    self.couldUseActive = true
  else
    self.couldUseActive = false
  end
  self.activeCdValue = value
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

DynCampFetter.GetAllCampFetter = function(self)
  -- function num : 0_12 , upvalues : _ENV
  local campFetterList = {}
  local usingNum = 0
  for _,unlockCount in ipairs(((ConfigData.camp_connection).fetterList)[self.campId]) do
    local isUsing = unlockCount <= (self.campConCfg).fetters_num
    ;
    (table.insert)(campFetterList, {cfg = ((ConfigData.camp_connection)[self.campId])[unlockCount], isUsing = isUsing})
    if isUsing then
      usingNum = usingNum + 1
    end
  end
  do return campFetterList, usingNum end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

return DynCampFetter

