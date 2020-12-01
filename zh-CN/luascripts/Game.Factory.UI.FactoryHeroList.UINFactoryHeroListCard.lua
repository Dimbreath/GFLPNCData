-- params : ...
-- function num : 0 , upvalues : _ENV
local UINHeroCardItem = require("Game.Hero.NewUI.UINHeroCardItem")
local UINFactoryHeroListCard = class("UINFactoryHeroListCard", UINHeroCardItem)
local base = UINHeroCardItem
local UINFactoryHeroListCardAccItem = require("Game.Factory.UI.FactoryHeroList.UINFactoryHeroListCardAccItem")
UINFactoryHeroListCard.OnInit = function(self)
  -- function num : 0_0 , upvalues : base, _ENV, UINFactoryHeroListCardAccItem
  (base.OnInit)(self)
  self.factoryController = ControllerManager:GetController(ControllerTypeId.Factory, false)
  self.accItemPool = (UIItemPool.New)(UINFactoryHeroListCardAccItem, (self.ui).additionItem)
  ;
  ((self.ui).additionItem):SetActive(false)
end

UINFactoryHeroListCard.InitHeroCardItem = function(self, heroData, resloader, clickedAction, customDataDic)
  -- function num : 0_1 , upvalues : base
  local cardData = nil
  if customDataDic == nil then
    cardData = nil
  else
    cardData = customDataDic[heroData.dataId]
  end
  self:RefreshFactoryUI(cardData)
  ;
  (base.InitHeroCardItem)(self, heroData, resloader, clickedAction)
end

UINFactoryHeroListCard.RefreshFactoryUI = function(self, cardData)
  -- function num : 0_2 , upvalues : _ENV
  self.cardData = cardData
  if cardData == nil then
    ((self.ui).obj_dispatchNode):SetActive(false)
    ;
    ((self.ui).obj_custom_OnSelect):SetActive(false)
    return 
  end
  if cardData.num ~= nil then
    local levelRate, friendshipRate, RankRate = (self.factoryController):GetOneHeroAccrateDetail(cardData.roomIndex, (self.heroData).dataId)
    local oringinalSpeed = (self.factoryController):GetRoomEnegeyBaseSpeedByIndex(cardData.roomIndex)
    local rateList = {}
    ;
    (table.insert)(rateList, levelRate)
    ;
    (table.insert)(rateList, friendshipRate)
    ;
    (table.insert)(rateList, RankRate)
    ;
    (self.accItemPool):HideAll()
    for i = 1, 3 do
      local item = (self.accItemPool):GetOne()
      item:SetValue(i - 1, oringinalSpeed, rateList[i])
    end
    ;
    ((self.ui).obj_dispatchNode):SetActive(false)
    ;
    ((self.ui).obj_custom_OnSelect):SetActive(true)
    -- DECOMPILER ERROR at PC74: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self.ui).tex_FactoryNum).text = tostring(cardData.num)
    -- DECOMPILER ERROR at PC80: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self.ui).tex_HeroName).text = (self.heroData):GetName()
  else
    do
      ;
      ((self.ui).obj_custom_OnSelect):SetActive(false)
      if cardData.isInOtherFactory then
        ((self.ui).obj_dispatchNode):SetActive(true)
      else
        ;
        ((self.ui).obj_dispatchNode):SetActive(false)
      end
    end
  end
end

UINFactoryHeroListCard.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UINFactoryHeroListCard

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINHeroCardItem = require("Game.Hero.NewUI.UINHeroCardItem")
local UINFactoryHeroListCard = class("UINFactoryHeroListCard", UINHeroCardItem)
local base = UINHeroCardItem
local UINFactoryHeroListCardAccItem = require(
                                          "Game.Factory.UI.FactoryHeroList.UINFactoryHeroListCardAccItem")
UINFactoryHeroListCard.OnInit = function(self)
    -- function num : 0_0 , upvalues : base, _ENV, UINFactoryHeroListCardAccItem
    (base.OnInit)(self)
    self.factoryController = ControllerManager:GetController(
                                 ControllerTypeId.Factory, false)
    self.accItemPool = (UIItemPool.New)(UINFactoryHeroListCardAccItem,
                                        (self.ui).additionItem);
    ((self.ui).additionItem):SetActive(false)
end

UINFactoryHeroListCard.InitHeroCardItem =
    function(self, heroData, resloader, clickedAction, customDataDic)
        -- function num : 0_1 , upvalues : base
        local cardData = nil
        if customDataDic == nil then
            cardData = nil
        else
            cardData = customDataDic[heroData.dataId]
        end
        self:RefreshFactoryUI(cardData);
        (base.InitHeroCardItem)(self, heroData, resloader, clickedAction)
    end

UINFactoryHeroListCard.RefreshFactoryUI =
    function(self, cardData)
        -- function num : 0_2 , upvalues : _ENV
        self.cardData = cardData
        if cardData == nil then
            ((self.ui).obj_dispatchNode):SetActive(false);
            ((self.ui).obj_custom_OnSelect):SetActive(false)
            return
        end
        if cardData.num ~= nil then
            local levelRate, friendshipRate, RankRate =
                (self.factoryController):GetOneHeroAccrateDetail(
                    cardData.roomIndex, (self.heroData).dataId)
            local oringinalSpeed =
                (self.factoryController):GetRoomEnegeyBaseSpeedByIndex(
                    cardData.roomIndex)
            local rateList = {};
            (table.insert)(rateList, levelRate);
            (table.insert)(rateList, friendshipRate);
            (table.insert)(rateList, RankRate);
            (self.accItemPool):HideAll()
            for i = 1, 3 do
                local item = (self.accItemPool):GetOne()
                item:SetValue(i - 1, oringinalSpeed, rateList[i])
            end
            ((self.ui).obj_dispatchNode):SetActive(false);
            ((self.ui).obj_custom_OnSelect):SetActive(true) -- DECOMPILER ERROR at PC74: Confused about usage of register: R7 in 'UnsetPending'
            ;
            ((self.ui).tex_FactoryNum).text = tostring(cardData.num) -- DECOMPILER ERROR at PC80: Confused about usage of register: R7 in 'UnsetPending'
            ;
            ((self.ui).tex_HeroName).text = (self.heroData):GetName()
        else
            do

                ((self.ui).obj_custom_OnSelect):SetActive(false)
                if cardData.isInOtherFactory then
                    ((self.ui).obj_dispatchNode):SetActive(true)
                else

                    ((self.ui).obj_dispatchNode):SetActive(false)
                end
            end
        end
    end

UINFactoryHeroListCard.OnDelete = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnDelete)(self)
end

return UINFactoryHeroListCard

