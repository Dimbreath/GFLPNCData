-- params : ...
-- function num : 0 , upvalues : _ENV
local UIBattleResultCharacterItem = class("UIBattleResultCharacterItem", UIBaseNode)
local base = UIBaseNode
local UINHeroHeadItem = require("Game.CommonUI.Hero.UINHeroHeadItem")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
UIBattleResultCharacterItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINHeroHeadItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.headItem = (UINHeroHeadItem.New)()
  ;
  (self.headItem):Init((self.ui).obj_heroHeadItem)
  ;
  ((self.ui).obj_lvUp):SetActive(false)
  ;
  ((self.ui).obj_friendship):SetActive(false)
end

UIBattleResultCharacterItem.InitCharacterItem = function(self, dynHero, resLoader, clickCallback)
  -- function num : 0_1
  self.heroData = dynHero.heroData
  ;
  (self.headItem):InitHeroHeadItem(self.heroData, resLoader, clickCallback)
end

UIBattleResultCharacterItem.RefershExpData = function(self, lastHeroData)
  -- function num : 0_2
  local exp = (self.heroData):GetHeroExpAddFromLevel(lastHeroData.level, lastHeroData.exp)
  local expFromList, expToList = (self.heroData):GetUpgradeLevelProcess(lastHeroData.level, lastHeroData.exp, exp)
  self.expFromList = expFromList
  self.expToList = expToList
  self.progessCount = #expFromList
  self.lastHeroData = lastHeroData
  self.upgradeSpeed = (self.ui).upgradeSpeed
  if self.progessCount == 1 then
    local curLevelTotalExp = (self.heroData):GetExpByLevel(lastHeroData.level)
    local ratio = exp / curLevelTotalExp
    local animaTime = ratio / self.upgradeSpeed
    if animaTime < (self.ui).upgradeMinTime then
      self.upgradeSpeed = ratio / (self.ui).upgradeMinTime
    end
  end
  do
    if self.progessCount <= 0 then
      self.isAniComplete = true
      self:RefreshLevelUI((self.heroData).level, exp, (self.heroData).expRatio)
      return 
    end
    self.isAniComplete = false
    self.curGetExp = 0
    self:RefreshLevelProgress(1)
  end
end

UIBattleResultCharacterItem.RefreshFriendShipData = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local addValue = (ConfigData.game_config).FriendshipPerBattle
  if addValue > 0 then
    ((self.ui).obj_friendship):SetActive(true)
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).tex_Friendship).text = "+" .. addValue
  else
    ;
    ((self.ui).obj_friendship):SetActive(false)
  end
end

UIBattleResultCharacterItem.RefreshLevelProgress = function(self, index)
  -- function num : 0_4
  if #self.expFromList < index then
    self.isAniComplete = true
    self:RefreshLevelUI(self.curLevel, self.curGetExp, self.curExp / self.curLevelTotalExp)
    return 
  end
  if index > 1 then
    ((self.ui).obj_lvUp):SetActive(true)
  end
  self.curIndex = index
  self.curLevel = (self.lastHeroData).level + index - 1
  self.curLevelTotalExp = (self.heroData):GetExpByLevel(self.curLevel)
  self.curExp = (self.expFromList)[index]
  self.curToExp = (self.expToList)[index]
  self:RefreshLevelUI(self.curLevel, self.curGetExp, self.curExp / self.curLevelTotalExp)
end

UIBattleResultCharacterItem.RefreshLevelUI = function(self, curLevel, curGetExp, fillAmount)
  -- function num : 0_5 , upvalues : _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R4 in 'UnsetPending'

  ((self.ui).tex_level).text = tostring(curLevel)
  ;
  ((self.ui).tex_addExp):SetIndex(0, tostring(curGetExp))
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).img_exp).fillAmount = fillAmount
end

UIBattleResultCharacterItem.UpdateExp = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if self.isAniComplete then
    return 
  end
  local increase = (math.floor)(self.curLevelTotalExp * self.upgradeSpeed * Time.unscaledDeltaTime)
  if (increase == 0 and 1) or self.curToExp <= self.curExp + increase then
    self.curGetExp = self.curGetExp - self.curExp + self.curToExp
    self.curExp = self.curToExp
    self:RefreshLevelProgress(self.curIndex + 1)
    return 
  else
    self.curGetExp = self.curGetExp + increase
    self.curExp = self.curExp + increase
    self:RefreshLevelUI(self.curLevel, self.curGetExp, self.curExp / self.curLevelTotalExp)
  end
end

UIBattleResultCharacterItem.OnDelete = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnDelete)(self)
end

return UIBattleResultCharacterItem

