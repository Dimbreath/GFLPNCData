-- params : ...
-- function num : 0 , upvalues : _ENV
local UINFriendshipLevel = class("UINFriendshipLevel", UIBaseNode)
local base = UIBaseNode
UINFriendshipLevel.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.curLevel = nil
  self.curExp = nil
  self.addExp = nil
  self.nextLevel = nil
  self.curTotalExp = nil
  self.levelTotalExp = {}
  self.maxLevel = #ConfigData.friendship_level
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.levelTotalExp)[0] = 0
  for level,data in ipairs(ConfigData.friendship_level) do
    -- DECOMPILER ERROR at PC29: Confused about usage of register: R6 in 'UnsetPending'

    (self.levelTotalExp)[level] = (self.levelTotalExp)[level - 1] + data.friendship
  end
end

UINFriendshipLevel.InitFriendShipPresent = function(self, heroId)
  -- function num : 0_1 , upvalues : _ENV
  self.curLevel = (PlayerDataCenter.allFriendshipData):GetLevel(heroId)
  self.curExp = (PlayerDataCenter.allFriendshipData):GetExp(heroId)
  self.curTotalExp = (self.levelTotalExp)[self.curLevel - 1] + self.curExp
  self.addExp = 0
  self.nextLevel = self.curLevel
  self:RefrshUI()
end

UINFriendshipLevel.AddExp = function(self, exp)
  -- function num : 0_2
  if self.maxLevel <= self.nextLevel then
    return false, 0
  end
  local maxNeedExp = exp
  self.addExp = self.addExp + exp
  while (self.levelTotalExp)[self.nextLevel] <= self.addExp + self.curTotalExp do
    if self.nextLevel == self.maxLevel then
      maxNeedExp = (self.levelTotalExp)[self.nextLevel] - (self.addExp - exp + self.curTotalExp)
      self.addExp = self.addExp - exp + (maxNeedExp)
      break
    end
    self.nextLevel = self.nextLevel + 1
  end
  self:RefrshUI()
  return true, maxNeedExp
end

UINFriendshipLevel.MinExp = function(self, exp)
  -- function num : 0_3 , upvalues : _ENV
  self.addExp = (math.max)(self.addExp - exp, 0)
  while self.addExp + self.curTotalExp < (self.levelTotalExp)[self.nextLevel - 1] do
    self.nextLevel = self.nextLevel - 1
  end
  self:RefrshUI()
  return true
end

UINFriendshipLevel.RefrshUI = function(self)
  -- function num : 0_4 , upvalues : _ENV
  ((self.ui).tex_CurrentLevel):SetIndex(0, tostring(self.curLevel))
  if self.curLevel < self.nextLevel then
    ((self.ui).arrow):SetActive(true)
    ;
    (((self.ui).tex_NextLevel).gameObject):SetActive(true)
    ;
    ((self.ui).tex_NextLevel):SetIndex(0, tostring(self.nextLevel))
  else
    ;
    ((self.ui).arrow):SetActive(false)
    ;
    (((self.ui).tex_NextLevel).gameObject):SetActive(false)
  end
  if self.addExp > 0 then
    (((self.ui).tex_AddExp).gameObject):SetActive(true)
    ;
    ((self.ui).tex_AddExp):SetIndex(0, tostring(self.addExp))
  else
    ;
    (((self.ui).tex_AddExp).gameObject):SetActive(false)
  end
  local thisLevelExp = ((ConfigData.friendship_level)[self.nextLevel]).friendship
  local lastLevelExp = (self.levelTotalExp)[self.nextLevel - 1]
  local thisLevelHasExp = self.addExp + self.curTotalExp - lastLevelExp
  ;
  ((self.ui).tex_TotalExp):SetIndex(0, tostring(thisLevelHasExp), tostring(thisLevelExp))
  -- DECOMPILER ERROR at PC94: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).img_Bar).fillAmount = thisLevelHasExp / thisLevelExp
  self.whenAddData = {level = self.nextLevel, exp = thisLevelHasExp}
end

UINFriendshipLevel.GetMaxAddableEXP = function(self, includeNewAdd)
  -- function num : 0_5
  if includeNewAdd then
    return (self.levelTotalExp)[self.maxLevel] - (self.addExp + self.curTotalExp)
  else
    return (self.levelTotalExp)[self.maxLevel] - self.curTotalExp
  end
end

UINFriendshipLevel.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnDelete)(self)
end

return UINFriendshipLevel

