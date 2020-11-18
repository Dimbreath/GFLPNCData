-- params : ...
-- function num : 0 , upvalues : _ENV
local UIHeroLevelUpSuccess = class("UIHeroLevelUpSuccess", UIBaseWindow)
local base = UIBaseWindow
local athSlots = {17, 18, 19, 20}
local athSlotListId = {[17] = 1, [18] = 2, [19] = 3, [20] = 4}
local UINHeroLevelUpAttrItem = require("Game.Hero.NewUI.UpgradeStar.UINStarUpAttrItem")
UIHeroLevelUpSuccess.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.AddButtonListener)((self.ui).btn_Close, self, self.OnBtnCloseClicked)
  ;
  ((self.ui).attriItem):SetActive(false)
end

UIHeroLevelUpSuccess.InitHeroLevelData = function(self, lastHeroData, heroData)
  -- function num : 0_1 , upvalues : _ENV, UINHeroLevelUpAttrItem
  ((self.ui).uiAdapter):AdaptBgUI()
  ;
  ((self.ui).tex_OldLevel):SetIndex(0, tostring(lastHeroData.level))
  ;
  ((self.ui).tex_NewLevel):SetIndex(0, tostring(heroData.level))
  for k,v in ipairs(eHeroShowAttrList) do
    if (lastHeroData.attr)[v] ~= nil and (lastHeroData.attr)[v] ~= 0 then
      local item = (UINHeroLevelUpAttrItem.New)()
      local go = ((self.ui).attriItem):Instantiate()
      go:SetActive(true)
      item:Init(go)
      item:InitAttrItem((lastHeroData.attr)[v], heroData:GetAttr(R15_PC51, nil, true), R14_PC53)
    end
  end
  AudioManager:PlayAudioById(1023)
  self:__DisplayAthSlotInfo(lastHeroData, heroData)
end

UIHeroLevelUpSuccess.__DisplayAthSlotInfo = function(self, lastHeroData, heroData)
  -- function num : 0_2 , upvalues : _ENV, athSlots, athSlotListId, UINHeroLevelUpAttrItem
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

UIHeroLevelUpSuccess.OnBtnCloseClicked = function(self)
  -- function num : 0_3
  self:Delete()
end

UIHeroLevelUpSuccess.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UIHeroLevelUpSuccess

