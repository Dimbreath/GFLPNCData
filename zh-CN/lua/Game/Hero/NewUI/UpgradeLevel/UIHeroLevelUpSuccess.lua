local UIHeroLevelUpSuccess = class("UIHeroLevelUpSuccess", UIBaseWindow)
local base = UIBaseWindow
local athSlots = {17, 18, 19, 20}
local athSlotListId = {[17] = 1, [18] = 2, [19] = 3, [20] = 4}
local UINHeroLevelUpAttrItem = require("Game.Hero.NewUI.UpgradeStar.UINStarUpAttrItem")
UIHeroLevelUpSuccess.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.Push2BackStack)(self, self.OnBtnCloseClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Close, self, self.OnClickClose)
  ;
  ((self.ui).attriItem):SetActive(false)
end

UIHeroLevelUpSuccess.InitHeroLevelData = function(self, lastHeroData, heroData)
  -- function num : 0_1 , upvalues : _ENV, UINHeroLevelUpAttrItem
  ((self.ui).tex_Title):SetIndex(0)
  ;
  ((self.ui).uiAdapter):AdaptBgUI()
  ;
  ((self.ui).tex_OldLevel):SetIndex(0, tostring(lastHeroData.level))
  ;
  ((self.ui).tex_NewLevel):SetIndex(0, tostring(heroData.level))
  local changeList = heroData:GetDifferAttrWhenRankUp(nil, heroData.level, lastHeroData.rank, lastHeroData.level)
  if #changeList < 0 then
    (((self.ui).attriNode).gameObject):SetActive(false)
  else
    ;
    (((self.ui).attriNode).gameObject):SetActive(true)
    ;
    (table.sort)(changeList, function(a, b)
    -- function num : 0_1_0
    if a.attrId >= b.attrId then
      do return a.property ~= b.property end
      do return a.property < b.property end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
)
    for index,data in ipairs(changeList) do
      local item = (UINHeroLevelUpAttrItem.New)()
      local go = ((self.ui).attriItem):Instantiate()
      go:SetActive(true)
      item:Init(go)
      item:InitAttrItem(data.oldAttr, data.newAttr, data.attrId)
    end
  end
  do
    AudioManager:PlayAudioById(1023)
    self:__DisplayAthSlotInfo(lastHeroData, heroData)
  end
end

UIHeroLevelUpSuccess.FriendShipLevelUp = function(self, lastLevel, newLevel)
  -- function num : 0_2 , upvalues : _ENV
  AudioManager:PlayAudioById(1074)
  ;
  ((self.ui).tex_Title):SetIndex(1)
  ;
  ((self.ui).uiAdapter):AdaptBgUI()
  ;
  ((self.ui).tex_OldLevel):SetIndex(0, tostring(lastLevel))
  ;
  ((self.ui).tex_NewLevel):SetIndex(0, tostring(newLevel))
  ;
  (((self.ui).attriNode).gameObject):SetActive(false)
end

UIHeroLevelUpSuccess.AthAffixLevelUp = function(self, fromLv, toLv, fromValue, toValue, attrId)
  -- function num : 0_3 , upvalues : _ENV, UINHeroLevelUpAttrItem
  ((self.ui).tex_Title):SetIndex(2)
  ;
  ((self.ui).uiAdapter):AdaptBgUI()
  ;
  ((self.ui).tex_OldLevel):SetIndex(0, tostring(fromLv))
  ;
  ((self.ui).tex_NewLevel):SetIndex(0, tostring(toLv))
  ;
  (((self.ui).attriNode).gameObject):SetActive(true)
  local item = (UINHeroLevelUpAttrItem.New)()
  local go = ((self.ui).attriItem):Instantiate()
  go:SetActive(true)
  item:Init(go)
  item:InitAttrItem(fromValue, toValue, attrId)
end

UIHeroLevelUpSuccess.__DisplayAthSlotInfo = function(self, lastHeroData, heroData)
  -- function num : 0_4 , upvalues : _ENV, athSlots, athSlotListId, UINHeroLevelUpAttrItem
  local oldSlotList = lastHeroData.athslotList
  local slotList = heroData:GetAthSlotList()
  for _,id in ipairs(athSlots) do
    if oldSlotList[athSlotListId[id]] ~= slotList[athSlotListId[id]] then
      local item = (UINHeroLevelUpAttrItem.New)()
      local go = ((self.ui).attriItem):Instantiate()
      go:SetActive(true)
      item:Init(go)
      item:InitAttrItem(id, (lastHeroData.athslotList)[athSlotListId[id]], athSlotListId[id])
    end
  end
end

UIHeroLevelUpSuccess.SetLevelUpBackClickAction = function(self, clickAction)
  -- function num : 0_5
  self.__clickAction = clickAction
end

UIHeroLevelUpSuccess.OnClickClose = function(self)
  -- function num : 0_6 , upvalues : _ENV
  (UIUtil.OnClickBack)()
end

UIHeroLevelUpSuccess.OnBtnCloseClicked = function(self)
  -- function num : 0_7
  do
    if self.__clickAction ~= nil then
      local bindfunc = self.__clickAction
      self.__clickAction = nil
      bindfunc()
    end
    self:Delete()
  end
end

UIHeroLevelUpSuccess.OnDelete = function(self)
  -- function num : 0_8 , upvalues : base
  (base.OnDelete)(self)
end

return UIHeroLevelUpSuccess

