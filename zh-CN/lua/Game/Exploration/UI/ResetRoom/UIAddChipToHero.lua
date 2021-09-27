local UIAddChipToHero = class("UIAddChipToHero", UIBaseWindow)
local base = UIBaseWindow
local UIHeroDetailItem = require("Game.Exploration.UI.ResetRoom.UIAddChipHeroDetail")
local UIChipItemDetail = require("Game.CommonUI.Item.UINChipItemDetail")
local cs_ResLoader = CS.ResLoader
UIAddChipToHero.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UIHeroDetailItem, cs_ResLoader, UIChipItemDetail
  self.poolHeroItem = (UIItemPool.New)(UIHeroDetailItem, (self.ui).heroItem)
  self.heroItemDic = {}
  self.resLoader = (cs_ResLoader.Create)()
  self.chipDetailItem = (UIChipItemDetail.New)()
  ;
  (self.chipDetailItem):Init((self.ui).chipDetail)
  ;
  ((self.ui).heroItem):SetActive(false)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Skip, self, self.__OnSkipButtonClick)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Comfirm, self, self.__OnComfirmButtonClick)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).tog_ShowAttri, self, self.__OnAllHeroPropertyShow)
  self.__onHeroItemClick = BindCallback(self, self.__OnHeroItemClick)
end

UIAddChipToHero.InitAddChipToHero = function(self, ctrl, heroList, chipData, onSkipAction, onComfirmAction)
  -- function num : 0_1
  self.ctrl = ctrl
  self.heroList = heroList
  self.onSkipAction = onSkipAction
  self.onComfirmAction = onComfirmAction
  self:ExecuteNext(heroList, chipData)
end

UIAddChipToHero.ExecuteNext = function(self, heroList, chipData)
  -- function num : 0_2 , upvalues : _ENV
  self.currChipData = chipData
  ;
  (self.chipDetailItem):InitChipDetail(chipData)
  ;
  (self.poolHeroItem):HideAll()
  for _,heroData in ipairs(heroList) do
    local heroItem = (self.heroItemDic)[heroData.dataId]
    if heroItem == nil then
      heroItem = (self.poolHeroItem):GetOne()
    end
    heroItem:InitHeroDetailItem(heroData, self.resLoader, self.__onHeroItemClick)
    ;
    (heroItem.gameObject):SetActive(true)
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (self.heroItemDic)[heroData.dataId] = heroItem
  end
  self:__OnAllHeroPropertyShow(false)
end

UIAddChipToHero.__OnHeroItemClick = function(self, heroData)
  -- function num : 0_3 , upvalues : _ENV
  local heroItem = (self.heroItemDic)[heroData.dataId]
  if heroItem == nil then
    error("UIAddChipToHero:__OnHeroItemClick heroItem is nil")
    return 
  end
  if self.currHeroItem == nil then
    self.currHeroItem = heroItem
    ;
    (self.currHeroItem):SetSelectActive(true)
  else
    if self.currHeroItem ~= heroItem then
      (self.currHeroItem):SetSelectActive(false)
      heroItem:SetSelectActive(true)
      self.currHeroItem = heroItem
    end
  end
end

UIAddChipToHero.__OnAllHeroPropertyShow = function(self, value)
  -- function num : 0_4 , upvalues : _ENV
  for id,HeroItem in pairs(self.heroItemDic) do
    HeroItem:ShowProperty(value)
  end
end

UIAddChipToHero.__OnSkipButtonClick = function(self)
  -- function num : 0_5
  if self.onSkipAction ~= nil then
    (self.onSkipAction)(self)
  end
end

UIAddChipToHero.__OnComfirmButtonClick = function(self)
  -- function num : 0_6
  if self.onComfirmAction ~= nil then
    (self.onComfirmAction)(self)
  end
end

UIAddChipToHero.CloseAddChipToHero = function(self)
  -- function num : 0_7
  self:Delete()
end

UIAddChipToHero.OnDelete = function(self)
  -- function num : 0_8 , upvalues : _ENV, base
  if self.resLoader ~= nil then
    (self.resLoader):Put2Pool()
    self.resLoader = nil
  end
  if self.heroItemDic ~= nil then
    for id,heroItem in pairs(self.heroItemDic) do
      heroItem:OnDelete()
    end
    self.heroItemDic = nil
  end
  ;
  (base.OnDelete)(self)
end

return UIAddChipToHero

