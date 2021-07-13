-- params : ...
-- function num : 0 , upvalues : _ENV
local UINHeroSortList = class("UINHeroSortList", UIBaseNode)
local base = UIBaseNode
local UINHeroCardItem = require("Game.Hero.NewUI.UINHeroCardItem")
local SpecificHeroDataRuler = require("Game.PlayerData.Hero.SpecificHeroDataRuler")
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
  self.__onLockedHeroItemClicked = BindCallback(self, self.__OnLockedHeroItemClicked)
  self.__onUpdateHeroEvent = BindCallback(self, self.__OnUpdateHeroEvent)
  self.__isFirstInit = true
  self.__OnSkinChange = BindCallback(self, self.OnSkinChange)
  MsgCenter:AddListener(eMsgEventId.OnHeroSkinChange, self.__OnSkinChange)
end

UINHeroSortList.InitHeroSortList = function(self, resloader, customSelectHero, onItemClick, ableNoSelect, ableSelectSame, isShowSelected, autoSelect, specificHeroDataRuler, showLockedHeros)
  -- function num : 0_1 , upvalues : _ENV
  if isShowSelected == nil then
    isShowSelected = true
  end
  self.isShowSelected = isShowSelected
  self.specificHeroDataRuler = specificHeroDataRuler
  if self.__isFirstInit then
    MsgCenter:AddListener(eMsgEventId.UpdateHero, self.__onUpdateHeroEvent)
    self.__isFirstInit = false
  end
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R10 in 'UnsetPending'

  if ((self.ui).scrollRest).horizontal then
    ((self.ui).scrollRest).horizontalNormalizedPosition = 1
  end
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R10 in 'UnsetPending'

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
  if showLockedHeros then
    self.originLockedHeroList = {}
  else
    self.originLockedHeroList = nil
  end
  self:__LoadHeroItemList(showLockedHeros)
end

UINHeroSortList.SetHeroListAnchorPosOffset = function(self, anchorPosOffset)
  -- function num : 0_2
  self.__anchorPosOffset = anchorPosOffset
end

UINHeroSortList.RefreshHeroSortList = function(self, funcSift, funcSort, isShowLockedHero)
  -- function num : 0_3 , upvalues : _ENV
  if funcSift ~= nil then
    self.funcSift = funcSift
  end
  if funcSort ~= nil then
    self.funcSort = funcSort
  end
  if isShowLockedHero ~= nil then
    self.isShowLockedHero = isShowLockedHero
  end
  self.curHeroList = {}
  self.curLockedHeroList = {}
  local curSelectHero = nil
  for index,heroData in ipairs(self.originHeroList) do
    if self.funcSift == nil or (self.funcSift)(heroData) then
      (table.insert)(self.curHeroList, heroData)
      if heroData == self.selectHero then
        curSelectHero = heroData
      end
    end
  end
  if self.isShowLockedHero and self.originLockedHeroList ~= nil then
    for index,heroData in ipairs(self.originLockedHeroList) do
      if self.funcSift == nil or (self.funcSift)(heroData) then
        (table.insert)(self.curLockedHeroList, heroData)
      end
    end
  end
  do
    if self.funcSort ~= nil then
      (table.sort)(self.curHeroList, self.funcSort)
      if self.isShowLockedHero then
        (table.sort)(self.curLockedHeroList, self.funcSort)
      end
    end
    if self.__customSelectHero ~= nil then
      (self.__customSelectHero)(curSelectHero)
    end
    -- DECOMPILER ERROR at PC91: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.ui).scrollRest).totalCount = #self.curHeroList + #self.curLockedHeroList
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

UINHeroSortList.__LoadHeroItemList = function(self, showLockedHeros)
  -- function num : 0_7 , upvalues : _ENV, SpecificHeroDataRuler
  self.originHeroList = {}
  self.selectHero = nil
  local showHeroDic = {}
  if self.specificHeroDataRuler ~= nil then
    if (self.specificHeroDataRuler).heroIds ~= nil and #(self.specificHeroDataRuler).heroIds > 0 then
      for i,v in ipairs((self.specificHeroDataRuler).heroIds) do
        local heroData = (PlayerDataCenter.specialRuleGenerator):GetSpecificHeroData(v, self.specificHeroDataRuler)
        showHeroDic[v] = heroData
      end
    else
      do
        for k,v in pairs(PlayerDataCenter.heroDic) do
          local heroData = (PlayerDataCenter.specialRuleGenerator):GetSpecificHeroData(k, self.specificHeroDataRuler)
          showHeroDic[k] = heroData
        end
        do
          for k,v in pairs(PlayerDataCenter.heroDic) do
            showHeroDic[k] = v
          end
          do
            if showLockedHeros then
              for heroId,hero_dataCfg in pairs(ConfigData.hero_data) do
                if not hero_dataCfg.is_locked and showHeroDic[heroId] == nil then
                  local specificHeroDataRuler = (SpecificHeroDataRuler.New)(1, hero_dataCfg.rank, 0)
                  local heroData = (PlayerDataCenter.specialRuleGenerator):CreateSpecificHeroData(heroId, specificHeroDataRuler)
                  heroData.isLockedHero = true
                  ;
                  (table.insert)(self.originLockedHeroList, heroData)
                end
              end
              ;
              (table.sort)(self.originLockedHeroList, function(a, b)
    -- function num : 0_7_0
    do return a.dataId < b.dataId end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
            end
            for k,v in pairs(showHeroDic) do
              (table.insert)(self.originHeroList, v)
            end
          end
        end
      end
    end
  end
end

UINHeroSortList.__OnHeroItemClicked = function(self, heroData)
  -- function num : 0_8
  self:__RefreshSelectHero(heroData)
end

UINHeroSortList.__OnLockedHeroItemClicked = function(self, heroData)
  -- function num : 0_9 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroInfomation, function(window)
    -- function num : 0_9_0 , upvalues : heroData
    if window ~= nil then
      window:InitHeroInformation(heroData, nil, true)
    end
  end
)
end

UINHeroSortList.__RefreshSelectHero = function(self, heroData)
  -- function num : 0_10
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
  -- function num : 0_11 , upvalues : _ENV
  for k,v in ipairs(heroList) do
    local heroItem = self:__GetHeroItemById(k)
    if heroItem ~= nil then
      heroItem:RefreshHeroCardItem()
      heroItem:SetEfficiencyActive(self.__showHeroPower or false)
    else
      local heroData = nil
      if self.specificHeroDataRuler ~= nil then
        heroData = (PlayerDataCenter.specialRuleGenerator):GetSpecificHeroData(k, self.specificHeroDataRuler)
      else
        heroData = (PlayerDataCenter.heroDic)[k]
      end
      if heroData ~= nil then
        (table.insert)(self.originHeroList, heroData)
      end
    end
  end
  self:RefreshHeroSortList()
end

UINHeroSortList.SetCustomCardClass = function(self, class)
  -- function num : 0_12
  self.customCardClass = class
end

UINHeroSortList.SetCustonDataDic = function(self, customDataDic)
  -- function num : 0_13
  self.customDataDic = customDataDic
end

UINHeroSortList.__OnInstantiateItem = function(self, go)
  -- function num : 0_14 , upvalues : UINHeroCardItem
  local heroItem = nil
  if self.customCardClass ~= nil then
    heroItem = ((self.customCardClass).New)()
  else
    heroItem = (UINHeroCardItem.New)()
  end
  heroItem:Init(go)
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.heroItemDic)[go] = heroItem
end

UINHeroSortList.__OnChangeItem = function(self, go, index)
  -- function num : 0_15 , upvalues : _ENV
  local heroItem = (self.heroItemDic)[go]
  if heroItem == nil then
    error("UINHeroSortList error:Can\'t find heroItem")
  end
  if index + 1 <= #self.curHeroList then
    local heroData = (self.curHeroList)[index + 1]
    if heroData == nil then
      error("UINHeroSortList error:Can\'t find heroData")
    end
    heroItem:InitHeroCardItem(heroData, self.resloader, self.__selectHeroFunc, self.customDataDic)
    heroItem:SetEfficiencyActive(self.__showHeroPower or false)
    if self.selectHero ~= heroData then
      heroItem:SetSelectActive(not self.isShowSelected, nil)
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
            do
              local heroData = (self.curLockedHeroList)[index + 1 - #self.curHeroList]
              if heroData == nil then
                error("UINHeroSortList error:Can\'t find heroData")
              end
              heroItem:InitHeroCardItem(heroData, self.resloader, self.__onLockedHeroItemClicked, self.customDataDic)
              heroItem:SetEfficiencyActive(false)
              heroItem:SetRedDotActive(false)
              -- DECOMPILER ERROR: 9 unprocessed JMP targets
            end
          end
        end
      end
    end
  end
end

UINHeroSortList.__GetHeroItemByData = function(self, heroData)
  -- function num : 0_16 , upvalues : _ENV
  for k,v in ipairs(self.curHeroList) do
    if v == heroData then
      local index = k - 1
      return self:__GetHeroItemByIndex(index)
    end
  end
  return nil
end

UINHeroSortList.__GetHeroItemById = function(self, heroId)
  -- function num : 0_17 , upvalues : _ENV
  for k,v in ipairs(self.curHeroList) do
    if v.dataId == heroId then
      local index = k - 1
      return self:__GetHeroItemByIndex(index)
    end
  end
  return nil
end

UINHeroSortList.__GetHeroItemByIndex = function(self, index)
  -- function num : 0_18
  local go = ((self.ui).scrollRest):GetCellByIndex(index)
  if go ~= nil then
    return (self.heroItemDic)[go]
  end
  return nil
end

UINHeroSortList.ShowHeroPower = function(self, showPower)
  -- function num : 0_19
  self.__showHeroPower = showPower or false
end

UINHeroSortList.OnSkinChange = function(self, heroId, skinId)
  -- function num : 0_20 , upvalues : _ENV
  for k,v in pairs(self.heroItemDic) do
    if (v.heroData).dataId == heroId then
      v:UpdateSkin()
      break
    end
  end
end

UINHeroSortList.OnDelete = function(self)
  -- function num : 0_21 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.UpdateHero, self.__onUpdateHeroEvent)
  MsgCenter:RemoveListener(eMsgEventId.OnHeroSkinChange, self.__OnSkinChange)
  ;
  (base.OnDelete)(self)
end

return UINHeroSortList

