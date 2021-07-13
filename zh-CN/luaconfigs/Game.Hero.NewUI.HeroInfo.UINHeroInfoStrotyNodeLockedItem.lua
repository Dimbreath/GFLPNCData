-- params : ...
-- function num : 0 , upvalues : _ENV
local UINHeroInfoStrotyNodeLockedItem = class("UINHeroInfoStrotyNodeLockedItem", UIBaseNode)
local base = UIBaseNode
local eHeroInfoenum = require("Game.Hero.NewUI.HeroInfo.eHeroInfoenum")
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
UINHeroInfoStrotyNodeLockedItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseItemWithCount
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Unlock, self, self.__OnClickUnlock)
  self.baseItemWithCount = (UINBaseItemWithCount.New)()
  ;
  (self.baseItemWithCount):Init((self.ui).uINBaseItemWithCount)
end

UINHeroInfoStrotyNodeLockedItem.InitHISNLockedItem = function(self, storyData, unlockCallback)
  -- function num : 0_1 , upvalues : eHeroInfoenum, _ENV
  self.storyData = storyData
  self.unlockCallback = unlockCallback
  if storyData.state == (eHeroInfoenum.achriveState).locked then
    self:__SetUIState(false)
  else
    if storyData.state == (eHeroInfoenum.achriveState).completed then
      self:__SetUIState(true)
    else
      error("UINHeroInfoStrotyNodeLockedItem state is not legal")
    end
  end
  local itemId = (((self.storyData).cfg).awardIds)[1]
  local num = (((self.storyData).cfg).awardNums)[1]
  local itemCfg = (ConfigData.item)[itemId]
  ;
  (self.baseItemWithCount):InitItemWithCount(itemCfg, num)
end

UINHeroInfoStrotyNodeLockedItem.__SetUIState = function(self, isCompleted)
  -- function num : 0_2 , upvalues : _ENV
  (((self.ui).btn_Unlock).gameObject):SetActive(isCompleted)
  local color = nil
  ;
  ((self.ui).redDot):SetActive(isCompleted)
  if isCompleted then
    ((self.ui).imgInfo_LockIcon):SetIndex(1)
    ;
    ((self.ui).texInfo_Condition):SetIndex(1)
    color = (self.ui).color_completed
  else
    ;
    ((self.ui).imgInfo_LockIcon):SetIndex(0)
    ;
    ((self.ui).texInfo_Condition):SetIndex(0, tostring(((self.storyData).cfg).friendship_level))
    color = (self.ui).color_locked
  end
  -- DECOMPILER ERROR at PC46: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Condition).color = color
  -- DECOMPILER ERROR at PC49: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).img_LockIcon).color = color
  -- DECOMPILER ERROR at PC52: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).text).color = color
end

UINHeroInfoStrotyNodeLockedItem.__OnClickUnlock = function(self)
  -- function num : 0_3
  if self.unlockCallback ~= nil then
    (self.unlockCallback)(self.storyData)
  end
end

UINHeroInfoStrotyNodeLockedItem.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UINHeroInfoStrotyNodeLockedItem

