-- params : ...
-- function num : 0 , upvalues : _ENV
local UINFriendshipLevel = class("UINFriendshipLevel", UIBaseNode)
local base = UIBaseNode
local UINTweenUtil = require("Game.CommonUI.Tween.UINTweenUtil")
UINFriendshipLevel.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.curLevel = nil
  self.curExp = nil
  self.addExp = nil
  self.nextLevel = nil
  self.curTotalExp = nil
  self.levelTotalExp = {}
  self.overflowExp = 0
  self.maxLevel = #ConfigData.friendship_level
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.levelTotalExp)[0] = 0
  for level,data in ipairs(ConfigData.friendship_level) do
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R6 in 'UnsetPending'

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
  if not self._hasExpTween then
    self:RefrshUI()
  end
end

UINFriendshipLevel.AddExp = function(self, exp, singleAddExp)
  -- function num : 0_2 , upvalues : _ENV
  if self.maxLevel <= self.nextLevel then
    return false, 0
  end
  local maxNeedExp = exp
  self.addExp = self.addExp + exp
  while (self.levelTotalExp)[self.nextLevel] <= self.addExp + self.curTotalExp do
    if self.nextLevel == self.maxLevel then
      maxNeedExp = (self.levelTotalExp)[self.nextLevel] - (self.addExp - exp + self.curTotalExp)
      self.addExp = self.addExp - exp + (maxNeedExp)
      self.overflowExp = exp - (maxNeedExp)
      self.overflowExp = self.overflowExp % singleAddExp
      break
    end
    self.nextLevel = self.nextLevel + 1
  end
  self:_KillExpBarSeq()
  self:RefrshUI()
  AudioManager:PlayAudioById(1064)
  return true, maxNeedExp
end

UINFriendshipLevel.MinExp = function(self, exp)
  -- function num : 0_3 , upvalues : _ENV
  do
    if self.overflowExp ~= 0 then
      local oExp = exp
      exp = oExp - self.overflowExp
      self.overflowExp = self.overflowExp - oExp
      if self.overflowExp <= 0 then
        self.overflowExp = 0
      end
      if exp < 0 then
        exp = 0
      end
    end
    self.addExp = (math.max)(self.addExp - exp, 0)
    while self.addExp + self.curTotalExp < (self.levelTotalExp)[self.nextLevel - 1] do
      self.nextLevel = self.nextLevel - 1
    end
    self:_KillExpBarSeq()
    self:RefrshUI()
    AudioManager:PlayAudioById(1065)
    return true
  end
end

UINFriendshipLevel.RefrshUI = function(self)
  -- function num : 0_4 , upvalues : _ENV
  ((self.ui).tex_CurrentLevel):SetIndex(0, tostring(self.curLevel))
  local isUnder = self.curLevel < self.nextLevel
  ;
  ((self.ui).arrow):SetActive(isUnder)
  ;
  (((self.ui).tex_NextLevel).gameObject):SetActive(isUnder)
  if isUnder then
    ((self.ui).tex_NextLevel):SetIndex(0, tostring(self.nextLevel))
  end
  if self.addExp > 0 then
    (((self.ui).tex_AddExp).gameObject):SetActive(true)
    ;
    ((self.ui).tex_AddExp):SetIndex(0, tostring(self.addExp))
  else
    (((self.ui).tex_AddExp).gameObject):SetActive(false)
  end
  local thisLevelExp = ((ConfigData.friendship_level)[self.nextLevel]).friendship
  local lastLevelExp = (self.levelTotalExp)[self.nextLevel - 1]
  local thisLevelHasExp = self.addExp + self.curTotalExp - lastLevelExp
  ;
  ((self.ui).tex_TotalExp):SetIndex(0, tostring(thisLevelHasExp), tostring(thisLevelExp))
  -- DECOMPILER ERROR at PC86: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).img_Bar).fillAmount = thisLevelHasExp / thisLevelExp
  self.whenAddData = {level = self.nextLevel, exp = thisLevelHasExp}
  self.tweenDiffData = {oldLevel = self.curLevel, oldRate = self.curTotalExp ~= 0 and self.curExp / self.curTotalExp or 0, level = self.nextLevel, rate = thisLevelHasExp / thisLevelExp}
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

UINFriendshipLevel.GetMaxAddableEXP = function(self, includeNewAdd)
  -- function num : 0_5
  if includeNewAdd then
    return (self.levelTotalExp)[self.maxLevel] - (self.addExp + self.curTotalExp)
  else
    return (self.levelTotalExp)[self.maxLevel] - self.curTotalExp
  end
end

UINFriendshipLevel.ShowExpBarTween = function(self, tweenDiffData)
  -- function num : 0_6 , upvalues : _ENV, UINTweenUtil
  ((self.ui).tex_CurrentLevel):SetIndex(0, tostring(tweenDiffData.oldLevel))
  self._hasExpTween = true
  self._expSeq = (UINTweenUtil.CreateExpBarSequence)((self.ui).img_Bar, tweenDiffData, nil, function()
    -- function num : 0_6_0 , upvalues : self
    self:_KillExpBarSeq()
    self:RefrshUI()
  end
, function(tempLevel)
    -- function num : 0_6_1 , upvalues : self, _ENV
    ((self.ui).tex_CurrentLevel):SetIndex(0, tostring(tempLevel))
  end
)
end

UINFriendshipLevel._KillExpBarSeq = function(self)
  -- function num : 0_7
  self._hasExpTween = false
  if self._expSeq ~= nil then
    (self._expSeq):Kill()
    self._expSeq = nil
  end
end

UINFriendshipLevel.OnDelete = function(self)
  -- function num : 0_8 , upvalues : base
  self:_KillExpBarSeq()
  ;
  (base.OnDelete)(self)
end

return UINFriendshipLevel

