-- params : ...
-- function num : 0 , upvalues : _ENV
local UINHeroSortList = class("UINHeroSortList", UIBaseNode)
local base = UIBaseNode
local UINHeroCardItem = require("Game.Hero.NewUI.UINHeroCardItem")
UINHeroSortList.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.isShowSelected = true
  self.heroItemDic = {}
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).scrollRest).onInstantiateItem = BindCallback(self, self.__OnInstantiateItem)
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).scrollRest).onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.__selectHeroFunc = BindCallback(self, self.__OnHeroItemClicked)
  self.__onUpdateHeroEvent = BindCallback(self, self.__OnUpdateHeroEvent)
  self.__isFirstInit = true
end

UINHeroSortList.InitHeroSortList = function(self, resloader, customSelectHero, onItemClick, ableNoSelect, ableSelectSame, isShowSelected, autoSelect)
  -- function num : 0_1 , upvalues : _ENV
  if isShowSelected == nil then
    isShowSelected = true
  end
  self.isShowSelected = isShowSelected
  if self.__isFirstInit then
    MsgCenter:AddListener(eMsgEventId.UpdateHero, self.__onUpdateHeroEvent)
    self.__isFirstInit = false
  end
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R8 in 'UnsetPending'

  if ((self.ui).scrollRest).horizontal then
    ((self.ui).scrollRest).horizontalNormalizedPosition = 1
  end
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R8 in 'UnsetPending'

  if ((self.ui).scrollRest).vertical then
    ((self.ui).scrollRest).verticalNormalizedPosition = 1
  end
  self.resloader = resloader
  self.ableNoSelect = ableNoSelect or false
  self.ableSelectSame = ableSelectSame or true
  self.autoSelect = autoSelect == nil and true or autoSelect
  self.__customSelectHero = customSelectHero
  self.__onItemClick = onItemClick
  self:ClearSelectHero()
  self:__LoadHeroItemList()
end

UINHeroSortList.SetHeroListAnchorPosOffset = function(self, anchorPosOffset)
  -- function num : 0_2
  self.__anchorPosOffset = anchorPosOffset
end

UINHeroSortList.RefreshHeroSortList = function(self, funcSift, funcSort)
  -- function num : 0_3 , upvalues : _ENV
  if funcSift ~= nil then
    self.funcSift = funcSift
  end
  if funcSort ~= nil then
    self.funcSort = funcSort
  end
  self.curHeroList = {}
  local curSelectHero = nil
  for index,heroData in ipairs(self.originHeroList) do
    if self.funcSift == nil or (self.funcSift)(heroData) then
      (table.insert)(self.curHeroList, heroData)
      if heroData == self.selectHero then
        curSelectHero = heroData
      end
    end
  end
  if self.funcSort ~= nil then
    (table.sort)(self.curHeroList, self.funcSort)
  end
  if self.__customSelectHero ~= nil then
    (self.__customSelectHero)(curSelectHero)
  end
  -- DECOMPILER ERROR at PC50: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).scrollRest).totalCount = #self.curHeroList
  ;
  ((self.ui).scrollRest):RefillCells(0, self.__anchorPosOffset or 0)
  if self.autoSelect then
    if self.ableNoSelect then
      if self.selectHero ~= curSelectHero then
        self:__RefreshSelectHero(curSelectHero)
        return 
      end
      if #self.curHeroList == 0 or curSelectHero == nil then
        self:__RefreshSelectHero(nil)
      end
    else
      if self.selectHero ~= curSelectHero and curSelectHero ~= nil then
        self:__RefreshSelectHero(curSelectHero)
        return 
      end
      if #self.curHeroList > 0 and curSelectHero == nil then
        self:__RefreshSelectHero((self.curHeroList)[1])
      end
    end
  end
  return self.curHeroList
end

UINHeroSortList.SetInFormationHero = function(self, inFormationDic)
  -- function num : 0_4 , upvalues : _ENV
  if self.inFormationDic ~= nil then
    for heroId,v in pairs(self.inFormationDic) do
      local heroItem = self:__GetHeroItemById(heroId)
      if heroItem ~= nil then
        heroItem:SetSelectActive(false)
      end
    end
  end
  do
    self.inFormationDic = inFormationDic
    if inFormationDic == nil then
      return 
    end
    for heroId,isBench in pairs(inFormationDic) do
      local heroItem = self:__GetHeroItemById(heroId)
      if heroItem ~= nil then
        heroItem:SetSelectActive(true, isBench)
      end
    end
  end
end

UINHeroSortList.ClearSelectHero = function(self)
  -- function num : 0_5
  do
    if self.selectHero ~= nil then
      local lastHeroItem = self:__GetHeroItemByData(self.selectHero)
      if lastHeroItem ~= nil and self.isShowSelected then
        lastHeroItem:SetSelectActive(false)
      end
    end
    self.selectHero = nil
  end
end

UINHeroSortList.SetShowRedDotActive = function(self, active)
  -- function num : 0_6
  self.showRedDot = active
end

UINHeroSortList.__LoadHeroItemList = function(self)
  -- function num : 0_7 , upvalues : _ENV
  self.originHeroList = {}
  self.selectHero = nil
  for index,heroData in pairs(PlayerDataCenter.heroDic) do
    (table.insert)(self.originHeroList, heroData)
  end
end

UINHeroSortList.__OnHeroItemClicked = function(self, heroData)
  -- function num : 0_8
  self:__RefreshSelectHero(heroData)
end

UINHeroSortList.__RefreshSelectHero = function(self, heroData)
  -- function num : 0_9
  if heroData == nil then
    return 
  end
  do
    if heroData == self.selectHero and self.ableNoSelect and not self.ableSelectSame then
      local lastHeroItem = self:__GetHeroItemByData(self.selectHero)
      if lastHeroItem ~= nil and self.isShowSelected then
        lastHeroItem:SetSelectActive(false)
      end
      self.selectHero = nil
      return 
    end
    do
      if self.selectHero ~= nil then
        local lastHeroItem = self:__GetHeroItemByData(self.selectHero)
        if lastHeroItem ~= nil and self.isShowSelected then
          lastHeroItem:SetSelectActive(false)
        end
        self.selectHero = nil
      end
      self.selectHero = heroData
      local selectItem = self:__GetHeroItemByData(self.selectHero)
      if selectItem ~= nil and self.isShowSelected then
        selectItem:SetSelectActive(true)
      end
      if self.__onItemClick ~= nil then
        (self.__onItemClick)(heroData, selectItem)
      end
    end
  end
end

UINHeroSortList.__OnUpdateHeroEvent = function(self, heroList)
  -- function num : 0_10 , upvalues : _ENV
  for k,v in ipairs(heroList) do
    local heroItem = self:__GetHeroItemById(k)
    if heroItem ~= nil then
      heroItem:RefreshHeroCardItem()
    else
      local heroData = (PlayerDataCenter.heroDic)[k]
      if heroData ~= nil then
        (table.insert)(self.originHeroList, heroData)
      end
    end
  end
  self:RefreshHeroSortList()
end

UINHeroSortList.__OnInstantiateItem = function(self, go)
  -- function num : 0_11 , upvalues : UINHeroCardItem
  local heroItem = (UINHeroCardItem.New)()
  heroItem:Init(go)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.heroItemDic)[go] = heroItem
end

UINHeroSortList.__OnChangeItem = function(self, go, index)
  -- function num : 0_12 , upvalues : _ENV
  local heroItem = (self.heroItemDic)[go]
  if heroItem == nil then
    error("UINHeroSortList error:Can\'t find heroItem")
  end
  local heroData = (self.curHeroList)[index + 1]
  if heroData == nil then
    error("UINHeroSortList error:Can\'t find heroData")
  end
  heroItem:InitHeroCardItem(heroData, self.resloader, self.__selectHeroFunc)
  if self.selectHero ~= heroData then
    heroItem:SetSelectActive(not self.isShowSelected)
    if (self.inFormationDic)[heroData.dataId] == nil then
      local inFormation = self.inFormationDic == nil
      do
        local isBench = (self.inFormationDic)[heroData.dataId]
        heroItem:SetSelectActive(inFormation, isBench)
        do
          if self.showRedDot then
            local ok, heroNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.HeroWindow, heroData.dataId)
            heroItem:SetRedDotActive(not ok or heroNode:GetRedDotCount() > 0)
          end
          -- DECOMPILER ERROR: 7 unprocessed JMP targets
        end
      end
    end
  end
end

UINHeroSortList.__GetHeroItemByData = function(self, heroData)
  -- function num : 0_13 , upvalues : _ENV
  for k,v in ipairs(self.curHeroList) do
    if v == heroData then
      local index = k - 1
      return self:__GetHeroItemByIndex(index)
    end
  end
  return nil
end

UINHeroSortList.__GetHeroItemById = function(self, heroId)
  -- function num : 0_14 , upvalues : _ENV
  for k,v in ipairs(self.curHeroList) do
    if v.dataId == heroId then
      local index = k - 1
      return self:__GetHeroItemByIndex(index)
    end
  end
  return nil
end

UINHeroSortList.__GetHeroItemByIndex = function(self, index)
  -- function num : 0_15
  local go = ((self.ui).scrollRest):GetCellByIndex(index)
  if go ~= nil then
    return (self.heroItemDic)[go]
  end
  return nil
end

UINHeroSortList.OnDelete = function(self)
  -- function num : 0_16 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.UpdateHero, self.__onUpdateHeroEvent)
  ;
  (base.OnDelete)(self)
end

return UINHeroSortList

