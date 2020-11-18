-- params : ...
-- function num : 0 , upvalues : _ENV
local UINHeroSortList = class("UINHeroSortList", UIBaseNode)
local base = UIBaseNode
local eSortMannerType, SortMannerDefine = (table.unpack)(require("Game.Hero.SortList.HeroSortMannerHelper"))
local eSortKindType, eSortKindMaxCount = (table.unpack)(require("Game.Hero.SortList.HeroSortKindHelper"))
local UINHeroCardItem = require("Game.Hero.SortList.UINHeroCardItem")
local UINSortKindItem = require("Game.Hero.SortList.UINSortKindItem")
UINHeroSortList.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Manner, self, self.OnBtnSortMannerClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Kind, self, self.OnBtnKindClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Sort, self, self.OnBtnSortClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_KindReset, self, self.OnBtnKindResetClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_KindConfirm, self, self.OnBtnKindConfirmClicked)
  -- DECOMPILER ERROR at PC46: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.ui).mannerNode = ((((self.ui).manner_Item).transform).parent).gameObject
  ;
  ((self.ui).manner_Item):SetActive(false)
  ;
  ((self.ui).kind_Item):SetActive(false)
  self:__RefreshSortButtton()
  self:__InitSortManner()
  self:__InitSortKind()
  self.heroItemDic = {}
  self.__selectHeroFunc = BindCallback(self, self.__OnHeroItemClicked)
  -- DECOMPILER ERROR at PC76: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).scrollView).onInstantiateItem = BindCallback(self, self.__OnNewItem)
  -- DECOMPILER ERROR at PC83: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).scrollView).onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.__isFirstInit = true
  self.__onUpdateHeroEvent = BindCallback(self, self.OnUpdateHeroEvent)
end

UINHeroSortList.InitHeroSortList = function(self, resloader, refreshSelectHeroUI, conditionFunc, customSelectHero, ableNoSelect)
  -- function num : 0_1 , upvalues : _ENV, eSortMannerType
  if self.__isFirstInit then
    self.__isFirstInit = nil
    MsgCenter:AddListener(eMsgEventId.UpdateHero, self.__onUpdateHeroEvent)
  end
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R6 in 'UnsetPending'

  if ((self.ui).scrollView).horizontal then
    ((self.ui).scrollView).horizontalNormalizedPosition = 1
  end
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R6 in 'UnsetPending'

  if ((self.ui).scrollView).vertical then
    ((self.ui).scrollView).verticalNormalizedPosition = 1
  end
  self.sortMannerType = eSortMannerType.Rare
  self.is_ascend_order = false
  self:ClearSelectHero()
  self:__RefreshSortButtton()
  self:__ResetSortKindData()
  self.resloader = resloader
  self.__refreshSelectHeroUI = refreshSelectHeroUI
  self.__conditionFunc = conditionFunc
  self.__customSelectHero = customSelectHero
  self.ableNoSelect = ableNoSelect or false
  self:__LoadHeroItemList()
end

UINHeroSortList.InitShowRedDot = function(self, show)
  -- function num : 0_2
  self.showRedDot = show
end

UINHeroSortList.SetInFormationHero = function(self, formationList)
  -- function num : 0_3 , upvalues : _ENV
  if self.inFormationDic ~= nil then
    for heroId,v in pairs(self.inFormationDic) do
      local heroItem = self:GetHeroItemById(heroId)
      if heroItem ~= nil then
        heroItem:SetInFormationActive(false)
      end
    end
  end
  do
    self.inFormationDic = {}
    if formationList == nil then
      return 
    end
    for k,heroId in pairs(formationList) do
      local heroItem = self:GetHeroItemById(heroId)
      if heroItem ~= nil then
        heroItem:SetInFormationActive(true)
        -- DECOMPILER ERROR at PC35: Confused about usage of register: R8 in 'UnsetPending'

        ;
        (self.inFormationDic)[heroId] = true
      end
    end
  end
end

UINHeroSortList.SetEnteredHero = function(self, stationedHeroList)
  -- function num : 0_4 , upvalues : _ENV
  if self.stationedHeroDic ~= nil then
    for heroId,v in pairs(self.stationedHeroDic) do
      local heroItem = self:GetHeroItemById(heroId)
      if heroItem ~= nil then
        heroItem:SetIsWorkingActive(false)
      end
    end
  end
  do
    self.stationedHeroDic = {}
    if stationedHeroList == nil then
      return 
    end
    for k,heroId in pairs(stationedHeroList) do
      local heroItem = self:GetHeroItemById(heroId)
      if heroItem ~= nil then
        heroItem:SetIsWorkingActive(true)
        -- DECOMPILER ERROR at PC35: Confused about usage of register: R8 in 'UnsetPending'

        ;
        (self.stationedHeroDic)[heroId] = true
      end
    end
  end
end

UINHeroSortList.RefreshHeroList = function(self)
  -- function num : 0_5 , upvalues : _ENV, eSortKindType, SortMannerDefine, eSortMannerType
  self.curHeroList = {}
  local curSelectHero = nil
  for k,heroData in ipairs(self.originHeroList) do
    local starConfig = (self.sortKindData)[eSortKindType.Star]
    if not starConfig.nocondition then
      local starOk = (starConfig.selectIndexs)[heroData.star]
    end
    local campConfig = (self.sortKindData)[eSortKindType.Camp]
    if not campConfig.nocondition then
      local campOk = (campConfig.selectIndexs)[heroData.camp]
    end
    local careerConfig = (self.sortKindData)[eSortKindType.Career]
    if not careerConfig.nocondition then
      local careerOk = (careerConfig.selectIndexs)[heroData.career]
    end
    if starOk and campOk and careerOk then
      (table.insert)(self.curHeroList, heroData)
      if heroData == self.selectHero then
        curSelectHero = heroData
      end
    end
  end
  local sortData = SortMannerDefine[self.sortMannerType]
  if sortData == nil then
    sortData = SortMannerDefine[eSortMannerType.Rare]
  end
  local sortFunc = nil
  if self.is_ascend_order then
    sortFunc = sortData.asceSort
  else
    sortFunc = sortData.descSort
  end
  ;
  (table.sort)(self.curHeroList, sortFunc)
  if self.__customSelectHero ~= nil then
    curSelectHero = (self.__customSelectHero)(curSelectHero)
  end
  -- DECOMPILER ERROR at PC80: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).scrollView).totalCount = #self.curHeroList
  ;
  ((self.ui).scrollView):RefillCells()
  if curSelectHero ~= nil then
    for k,v in ipairs(self.curHeroList) do
      if v == curSelectHero then
        self.selectHeroIndex = k
        break
      end
    end
  end
  do
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
        self:__RefreshSelectHero((self.curHeroList)[1], 1)
      end
    end
  end
end

UINHeroSortList.__LoadHeroItemList = function(self)
  -- function num : 0_6 , upvalues : _ENV
  self.originHeroList = {}
  self.selectHero = nil
  for k,v in pairs(PlayerDataCenter.heroDic) do
    if self.__conditionFunc == nil or (self.__conditionFunc)(k, v) then
      (table.insert)(self.originHeroList, v)
    end
  end
  local heroCount = #self.originHeroList
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_HeroCount).text = tostring(heroCount) .. "/" .. tostring(heroCount)
end

UINHeroSortList.__InitSortManner = function(self)
  -- function num : 0_7 , upvalues : _ENV, SortMannerDefine
  for k,v in pairs(SortMannerDefine) do
    local go = ((self.ui).manner_Item):Instantiate()
    do
      go:SetActive(true)
      local index = k
      local sortValue = v
      local texName = (go.transform):FindComponent("Tex_Name", eUnityComponentID.TextItemInfo)
      texName:SetIndex(index - 1)
      local btn = (go.transform):FindComponent("", eUnityComponentID.Button)
      ;
      (btn.onClick):AddListener(function()
    -- function num : 0_7_0 , upvalues : self, index
    ((self.ui).tex_SortManner):SetIndex(index - 1)
    self.sortMannerType = index
    self:__SwitchMannerNodeActive(false)
    self:RefreshHeroList()
  end
)
    end
  end
end

UINHeroSortList.OnBtnSortMannerClicked = function(self)
  -- function num : 0_8
  self:__SwitchMannerNodeActive(not ((self.ui).mannerNode).activeSelf)
end

UINHeroSortList.__SwitchMannerNodeActive = function(self, open)
  -- function num : 0_9 , upvalues : _ENV
  if open then
    ((self.ui).mannerNode):SetActive(true)
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).img_SortCube).color = (self.ui).color_highlight
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).img_SortTri).color = (self.ui).color_highlight
  else
    ;
    ((self.ui).mannerNode):SetActive(false)
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).img_SortCube).color = Color.white
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).img_SortTri).color = Color.white
  end
end

UINHeroSortList.__InitSortKind = function(self)
  -- function num : 0_10 , upvalues : eSortKindType, _ENV, eSortKindMaxCount, UINSortKindItem
  self.sortKindData = {
[eSortKindType.Star] = {parent = (self.ui).kind_star, 
kindItems = {}
, 
selectIndexs = {}
, nocondition = true}
, 
[eSortKindType.Camp] = {parent = (self.ui).kind_camp, 
kindItems = {}
, 
selectIndexs = {}
, nocondition = true}
, 
[eSortKindType.Career] = {parent = (self.ui).kind_career, 
kindItems = {}
, 
selectIndexs = {}
, nocondition = true}
}
  local selectFunc = BindCallback(self, self.__OnSortKindItemClicked)
  for k,v in pairs(eSortKindType) do
    for i = 1, eSortKindMaxCount[v] do
      local go = ((self.ui).kind_Item):Instantiate(((self.sortKindData)[v]).parent)
      go:SetActive(true)
      local kindItem = (UINSortKindItem.New)()
      kindItem:Init(go.transform)
      kindItem:InitKindItem(v, i, selectFunc)
      ;
      (table.insert)(((self.sortKindData)[v]).kindItems, kindItem)
    end
  end
end

UINHeroSortList.__OnSortKindItemClicked = function(self, kindType, index, select)
  -- function num : 0_11
end

UINHeroSortList.OnBtnKindClicked = function(self)
  -- function num : 0_12
  local needActive = not ((self.ui).kindNode).activeSelf
  if needActive then
    self:__SwitchSortKindNodeActive(true)
  else
    self:OnBtnKindConfirmClicked()
  end
end

UINHeroSortList.__SwitchSortKindNodeActive = function(self, open)
  -- function num : 0_13 , upvalues : _ENV
  if open then
    ((self.ui).kindNode):SetActive(true)
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).img_KindCube).color = (self.ui).color_highlight
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).img_KindTri).color = (self.ui).color_highlight
  else
    ;
    ((self.ui).kindNode):SetActive(false)
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).img_KindCube).color = Color.white
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).img_KindTri).color = Color.white
  end
end

UINHeroSortList.OnBtnKindConfirmClicked = function(self)
  -- function num : 0_14 , upvalues : _ENV, eSortKindType, eSortKindMaxCount
  local selectCount = 0
  for k,v in pairs(eSortKindType) do
    local noCondition = true
    for i = 1, eSortKindMaxCount[v] do
      local kindItem = (((self.sortKindData)[v]).kindItems)[i]
      local isSelect = kindItem.select
      if isSelect then
        noCondition = false
        selectCount = selectCount + 1
      end
      -- DECOMPILER ERROR at PC22: Confused about usage of register: R14 in 'UnsetPending'

      ;
      (((self.sortKindData)[v]).selectIndexs)[i] = isSelect
    end
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R8 in 'UnsetPending'

    ;
    ((self.sortKindData)[v]).nocondition = noCondition
  end
  self:__SwitchSortKindNodeActive(false)
  self:RefreshHeroList()
  ;
  ((self.ui).tex_SortKind):SetIndex(selectCount > 0 and 1 or 0)
end

UINHeroSortList.OnBtnKindResetClicked = function(self)
  -- function num : 0_15
  self:__ResetSortKindData()
  self:RefreshHeroList()
end

UINHeroSortList.__ResetSortKindData = function(self)
  -- function num : 0_16 , upvalues : _ENV, eSortKindType, eSortKindMaxCount
  for k,v in pairs(eSortKindType) do
    for i = 1, eSortKindMaxCount[v] do
      local kindItem = (((self.sortKindData)[v]).kindItems)[i]
      kindItem.select = false
      kindItem:SetUISelectActive(false)
      -- DECOMPILER ERROR at PC19: Confused about usage of register: R11 in 'UnsetPending'

      ;
      (((self.sortKindData)[v]).selectIndexs)[i] = false
    end
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.sortKindData)[v]).nocondition = true
  end
  self:__SwitchSortKindNodeActive(false)
  ;
  ((self.ui).tex_SortKind):SetIndex(0)
end

UINHeroSortList.OnBtnSortClicked = function(self)
  -- function num : 0_17
  self.is_ascend_order = not self.is_ascend_order
  self:__RefreshSortButtton()
  self:RefreshHeroList()
end

UINHeroSortList.__RefreshSortButtton = function(self)
  -- function num : 0_18 , upvalues : _ENV
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  if self.is_ascend_order then
    ((self.ui).img_Descending).color = Color.white
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Ascending).color = (self.ui).color_highlight
    ;
    ((self.ui).tex_Sort):SetIndex(1)
  else
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Descending).color = (self.ui).color_highlight
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Ascending).color = Color.white
    ;
    ((self.ui).tex_Sort):SetIndex(0)
  end
end

UINHeroSortList.__OnHeroItemClicked = function(self, heroData)
  -- function num : 0_19
  self:__RefreshSelectHero(heroData)
end

UINHeroSortList.__RefreshSelectHero = function(self, heroData, heroIndex)
  -- function num : 0_20 , upvalues : _ENV
  if heroData == nil then
    if self.ableNoSelect then
      do
        if self.selectHero ~= nil then
          local lastHeroItem = self:__GetHeroItemByData(self.selectHero)
          if lastHeroItem ~= nil then
            lastHeroItem:SetSelectActive(false)
          end
        end
        self.selectHero = nil
        self.selectHeroIndex = 0
        if self.__refreshSelectHeroUI ~= nil then
          (self.__refreshSelectHeroUI)(nil)
        end
        do return  end
        if self.selectHero == heroData then
          do
            if self.ableNoSelect then
              local lastHeroItem = self:__GetHeroItemByData(self.selectHero)
              if lastHeroItem ~= nil then
                lastHeroItem:SetSelectActive(false)
              end
              self.selectHero = nil
              self.selectHeroIndex = 0
              if self.__refreshSelectHeroUI ~= nil then
                (self.__refreshSelectHeroUI)(nil)
              end
            end
            do return  end
            if not heroIndex then
              for k,v in ipairs(self.curHeroList) do
                if v == heroData then
                  self.selectHeroIndex = k
                  break
                end
              end
            else
              do
                self.selectHeroIndex = heroIndex
                do
                  if self.selectHero ~= nil then
                    local lastHeroItem = self:__GetHeroItemByData(self.selectHero)
                    if lastHeroItem ~= nil then
                      lastHeroItem:SetSelectActive(false)
                    end
                  end
                  self.selectHero = heroData
                  local heroItem = self:__GetHeroItemByData(self.selectHero)
                  if heroItem ~= nil then
                    heroItem:SetSelectActive(true)
                  end
                  if self.__refreshSelectHeroUI ~= nil then
                    (self.__refreshSelectHeroUI)(heroData)
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

UINHeroSortList.SwitchToPrevHero = function(self)
  -- function num : 0_21
  if #self.curHeroList <= 0 then
    return 
  end
  if not self.selectHeroIndex then
    return 
  end
  local nextIndex = 0
  if self.selectHeroIndex == 1 then
    nextIndex = #self.curHeroList
  else
    nextIndex = self.selectHeroIndex - 1
  end
  self:__RefreshSelectHero((self.curHeroList)[nextIndex], nextIndex)
end

UINHeroSortList.SwitchToNextHero = function(self)
  -- function num : 0_22
  if #self.curHeroList <= 0 then
    return 
  end
  if not self.selectHeroIndex then
    return 
  end
  local nextIndex = 0
  if self.selectHeroIndex == #self.curHeroList then
    nextIndex = 1
  else
    nextIndex = self.selectHeroIndex + 1
  end
  self:__RefreshSelectHero((self.curHeroList)[nextIndex], nextIndex)
end

UINHeroSortList.ClearSelectHero = function(self)
  -- function num : 0_23
  do
    if self.selectHero ~= nil then
      local lastHeroItem = self:__GetHeroItemByData(self.selectHero)
      if lastHeroItem ~= nil then
        lastHeroItem:SetSelectActive(false)
      end
    end
    self.selectHero = nil
    self.selectHeroIndex = 0
  end
end

UINHeroSortList.OnUpdateHeroEvent = function(self, heroList)
  -- function num : 0_24 , upvalues : _ENV
  for k,v in pairs(heroList) do
    local heroItem = self:GetHeroItemById(k)
    if heroItem ~= nil then
      heroItem:RefreshHeroHeroData()
    else
      local heroData = (PlayerDataCenter.heroDic)[k]
      if heroData ~= nil and (self.__conditionFunc == nil or (self.__conditionFunc)(heroData.dataId, heroData)) then
        (table.insert)(self.originHeroList, heroData)
      end
    end
  end
  self:RefreshHeroList()
  if self.selectHero ~= nil and heroList[(self.selectHero).dataId] ~= nil and self.__refreshSelectHeroUI ~= nil then
    (self.__refreshSelectHeroUI)(self.selectHero)
  end
end

UINHeroSortList.__OnNewItem = function(self, go)
  -- function num : 0_25 , upvalues : UINHeroCardItem
  local heroItem = (UINHeroCardItem.New)()
  heroItem:Init(go)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.heroItemDic)[go] = heroItem
end

UINHeroSortList.__OnChangeItem = function(self, go, index)
  -- function num : 0_26 , upvalues : _ENV
  local heroItem = (self.heroItemDic)[go]
  if heroItem == nil then
    error("Can\'t find heroItem by gameObject")
    return 
  end
  local heroData = (self.curHeroList)[index + 1]
  if heroData == nil then
    error("Can\'t find heroData by index, index = " .. tonumber(index))
  end
  heroItem:InitHeroHeroData(heroData, self.resloader, self.__selectHeroFunc)
  local isSelect = self.selectHero == heroData
  heroItem:SetSelectActive(isSelect)
  if (self.inFormationDic)[heroData.dataId] == nil then
    do
      local inFormation = self.inFormationDic == nil
      heroItem:SetInFormationActive(inFormation)
      do
        if self.showRedDot then
          local ok, heroNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.HeroWindow, heroData.dataId)
          heroItem:SetRedDotActive(not ok or heroNode:GetRedDotCount() > 0)
        end
        -- DECOMPILER ERROR: 6 unprocessed JMP targets
      end
    end
  end
end

UINHeroSortList.__GetHeroItemByData = function(self, heroData)
  -- function num : 0_27 , upvalues : _ENV
  for k,v in ipairs(self.curHeroList) do
    if v == heroData then
      local index = k - 1
      return self:__GetHeroItemGoByIndex(index)
    end
  end
  return nil
end

UINHeroSortList.GetHeroItemById = function(self, heroId)
  -- function num : 0_28 , upvalues : _ENV
  for k,v in ipairs(self.curHeroList) do
    if v.dataId == heroId then
      local index = k - 1
      return self:__GetHeroItemGoByIndex(index)
    end
  end
  return nil
end

UINHeroSortList.__GetHeroItemGoByIndex = function(self, index)
  -- function num : 0_29
  local go = ((self.ui).scrollView):GetCellByIndex(index)
  do
    if go ~= nil then
      local heroItem = (self.heroItemDic)[go]
      return heroItem
    end
    return nil
  end
end

UINHeroSortList.OnDelete = function(self)
  -- function num : 0_30 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.UpdateHero, self.__onUpdateHeroEvent)
  ;
  (base.OnDelete)(self)
end

return UINHeroSortList

