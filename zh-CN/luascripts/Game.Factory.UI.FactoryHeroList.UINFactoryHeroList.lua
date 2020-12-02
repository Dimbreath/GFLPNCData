-- params : ...
-- function num : 0 , upvalues : _ENV
local UINFactoryHeroList = class("UINFactoryHeroList", UIBaseNode)
local base = UIBaseNode
local UINHeroSortList = require("Game.Hero.NewUI.SortList.UINHeroSortList")
local UINSortButtonGroup = require("Game.Hero.NewUI.SortList.UINSortButtonGroup")
local UINSiftCondition = require("Game.Hero.NewUI.SortList.UINSiftCondition")
local UINFactoryHeroListCard = require("Game.Factory.UI.FactoryHeroList.UINFactoryHeroListCard")
local HeroFilterEnum = require("Game.Hero.NewUI.HeroFilterEnum")
local HeroSortEnum = require("Game.Hero.NewUI.HeroSortEnum")
local cs_ResLoader = CS.ResLoader
local cs_DoTween = ((CS.DG).Tweening).DOTween
local cs_MessageCommon = CS.MessageCommon
local ENTER_LIMIT = 3
UINFactoryHeroList.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, cs_ResLoader
  self.factoryController = ControllerManager:GetController(ControllerTypeId.Factory, false)
  self.resloader = (cs_ResLoader.Create)()
  self.__OnClickHeroItem = BindCallback(self, self.m_OnClickHeroItem)
  self.__OnFilterConfirmAction = BindCallback(self, self.m_OnFilterConfirmAction)
  self.__OnClickBtnSortItem = BindCallback(self, self.m_OnClickBtnSortItem)
  self.SelectedHeroIds = {}
  self.SavedSelectedHeroIds = {}
  self.CardDatas = {}
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Filter, self, self.m_OnClickBtnFilter)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Comfirm, self, self.m_OnClickConfirm)
  self:SetHeroListTweens()
end

UINFactoryHeroList.SetCallback = function(self, EnergyAddCallback, confirmCallback)
  -- function num : 0_1
  self.EnergyAddCallback = EnergyAddCallback
  self.confirmCallback = confirmCallback
end

UINFactoryHeroList.InitFactoryHeroList = function(self, roomIndex)
  -- function num : 0_2 , upvalues : _ENV
  self.roomIndex = roomIndex
  ;
  ((self.ui).topBtnGroup):SetActive(false)
  ;
  ((self.ui).sortConditionNode):SetActive(false)
  ;
  (((self.ui).btn_Comfirm).gameObject):SetActive(false)
  self:m_InitHeroList()
  self:m_InitSortButtonGroup()
  self:ShowHeroCollection()
  ;
  (self.pageSequence):Restart()
  self:ReadCurEntered()
  self.SavedSelectedHeroIds = (table.deepCopy)(self.SelectedHeroIds)
end

UINFactoryHeroList.ReadCurEntered = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local AllEnteredHeroIds = (self.factoryController):GetRoomHeroList()
  self.SelectedHeroIds = {}
  self.CardDatas = {}
  for roomIndex,heroList in pairs(AllEnteredHeroIds) do
    if roomIndex == self.roomIndex then
      for index,value in ipairs(heroList) do
        -- DECOMPILER ERROR at PC19: Confused about usage of register: R12 in 'UnsetPending'

        (self.SelectedHeroIds)[index] = value
        -- DECOMPILER ERROR at PC25: Confused about usage of register: R12 in 'UnsetPending'

        ;
        (self.CardDatas)[value] = {roomIndex = roomIndex, num = index, isInOtherFactory = false}
      end
    else
      do
        for index,value in ipairs(heroList) do
          -- DECOMPILER ERROR at PC37: Confused about usage of register: R12 in 'UnsetPending'

          (self.CardDatas)[value] = {roomIndex = roomIndex, isInOtherFactory = true}
        end
        do
          -- DECOMPILER ERROR at PC40: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC40: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC40: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  for heroId,cardData in pairs(self.CardDatas) do
    local cardItem = (self.heroSortList):__GetHeroItemById(heroId)
    if cardItem ~= nil then
      cardItem:RefreshFactoryUI(cardData)
    end
  end
  ;
  (self.heroSortList):SetCustonDataDic(self.CardDatas)
  ;
  (self.heroSortList):RefreshHeroSortList()
  self:UpdateEnergyAdd(true)
end

UINFactoryHeroList.m_InitHeroList = function(self)
  -- function num : 0_4 , upvalues : UINHeroSortList, UINFactoryHeroListCard
  if self.heroSortList == nil then
    local HeroSortList = (UINHeroSortList.New)()
    HeroSortList:Init(((self.ui).heroListFade).gameObject)
    HeroSortList:SetShowRedDotActive(false)
    HeroSortList:SetCustomCardClass(UINFactoryHeroListCard)
    HeroSortList:InitHeroSortList(self.resloader, nil, self.__OnClickHeroItem, true, false, false, false)
    self.heroSortList = HeroSortList
  end
end

UINFactoryHeroList.m_OnClickHeroItem = function(self, heroData, selectItem)
  -- function num : 0_5 , upvalues : _ENV, ENTER_LIMIT, cs_MessageCommon
  for index,heroId in ipairs(self.SelectedHeroIds) do
    if heroData.dataId == heroId then
      local oldNum = ((self.CardDatas)[heroData.dataId]).num
      ;
      (table.remove)(self.SelectedHeroIds, index)
      -- DECOMPILER ERROR at PC24: Confused about usage of register: R9 in 'UnsetPending'

      if not ((self.CardDatas)[heroData.dataId]).isInOtherFactory then
        (self.CardDatas)[heroData.dataId] = nil
      else
        -- DECOMPILER ERROR at PC29: Confused about usage of register: R9 in 'UnsetPending'

        ;
        ((self.CardDatas)[heroData.dataId]).num = nil
      end
      for index,heroId in ipairs(self.SelectedHeroIds) do
        -- DECOMPILER ERROR at PC36: Confused about usage of register: R14 in 'UnsetPending'

        ((self.CardDatas)[heroId]).num = index
        local cardItem = (self.heroSortList):__GetHeroItemById(heroId)
        if cardItem ~= nil then
          cardItem:RefreshFactoryUI((self.CardDatas)[heroId])
        end
      end
      self:ShowHeroChange(heroData, selectItem)
      return 
    end
  end
  if ENTER_LIMIT <= #self.SelectedHeroIds then
    (cs_MessageCommon.ShowMessageTips)((string.format)(ConfigData:GetTipContent(TipContent.Factory_HeroEnterLimit), tostring(ENTER_LIMIT)))
    return 
  end
  local ApplySelect = function()
    -- function num : 0_5_0 , upvalues : _ENV, self, heroData, selectItem
    (table.insert)(self.SelectedHeroIds, heroData.dataId)
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R0 in 'UnsetPending'

    if (self.CardDatas)[heroData.dataId] == nil then
      (self.CardDatas)[heroData.dataId] = {roomIndex = self.roomIndex, num = #self.SelectedHeroIds, isInOtherFactory = false}
    else
      -- DECOMPILER ERROR at PC26: Confused about usage of register: R0 in 'UnsetPending'

      ;
      ((self.CardDatas)[heroData.dataId]).num = #self.SelectedHeroIds
    end
    self:ShowHeroChange(heroData, selectItem)
  end

  if (self.CardDatas)[heroData.dataId] ~= nil and ((self.CardDatas)[heroData.dataId]).isInOtherFactory then
    (cs_MessageCommon.ShowMessageBox)(ConfigData:GetTipContent(TipContent.Factory_ConfirmSwitchHero), ApplySelect, nil)
  else
    ApplySelect()
  end
end

UINFactoryHeroList.ShowHeroChange = function(self, heroData, selectItem)
  -- function num : 0_6 , upvalues : _ENV
  selectItem:RefreshFactoryUI((self.CardDatas)[heroData.dataId])
  local isChanged = false
  if #self.SavedSelectedHeroIds ~= #self.SelectedHeroIds then
    isChanged = true
  else
    for index,heroId in ipairs(self.SavedSelectedHeroIds) do
      if heroId ~= (self.SelectedHeroIds)[index] then
        isChanged = true
        break
      end
    end
  end
  do
    ;
    (((self.ui).btn_Comfirm).gameObject):SetActive(isChanged)
    self:UpdateEnergyAdd()
  end
end

UINFactoryHeroList.UpdateEnergyAdd = function(self, isInit)
  -- function num : 0_7
  if self.EnergyAddCallback ~= nil then
    (self.EnergyAddCallback)(self.SelectedHeroIds, isInit)
  end
end

UINFactoryHeroList.m_OnClickConfirm = function(self)
  -- function num : 0_8
  (self.factoryController):SetRoomHeroList(self.roomIndex, self.SelectedHeroIds, self.confirmCallback)
end

UINFactoryHeroList.m_InitSortButtonGroup = function(self)
  -- function num : 0_9 , upvalues : UINSortButtonGroup, HeroSortEnum
  if self.sortButtonGroup == nil then
    local sortButtonGroup = (UINSortButtonGroup.New)()
    sortButtonGroup:Init((self.ui).buttonGroup)
    sortButtonGroup:InitSortButtonGroup(HeroSortEnum.SortMannerDefine, self.__OnClickBtnSortItem)
    self.sortButtonGroup = sortButtonGroup
  end
end

UINFactoryHeroList.m_OnClickBtnSortItem = function(self, sortFunc)
  -- function num : 0_10
  if self.heroSortList == nil then
    self:m_InitHeroList()
  end
  ;
  (self.heroSortList):RefreshHeroSortList(nil, sortFunc)
end

UINFactoryHeroList.m_OnClickBtnFilter = function(self)
  -- function num : 0_11 , upvalues : UINSiftCondition, HeroFilterEnum
  do
    if self.siftCondition == nil then
      local SiftConditionPage = (UINSiftCondition.New)()
      SiftConditionPage:Init((self.ui).sortConditionNode)
      SiftConditionPage:InitSiftCondition(HeroFilterEnum.eKindType, HeroFilterEnum.eKindMaxCount, self.__OnFilterConfirmAction)
      self.siftCondition = SiftConditionPage
    end
    ;
    (self.siftCondition):Show()
  end
end

UINFactoryHeroList.m_OnFilterConfirmAction = function(self, sortKindData)
  -- function num : 0_12 , upvalues : _ENV
  self.sortKindData = sortKindData
  if self.heroSortList == nil then
    self:m_InitHeroList()
  end
  ;
  (self.heroSortList):RefreshHeroSortList((BindCallback(self, self.__SiftFunction)), nil)
end

UINFactoryHeroList.__SiftFunction = function(self, heroData)
  -- function num : 0_13 , upvalues : HeroFilterEnum
  local rareConfig = (self.sortKindData)[(HeroFilterEnum.eKindType).Rare]
  if not rareConfig.nocondition then
    local rankOk = (rareConfig.selectIndexs)[heroData.rare]
  end
  local campConfig = (self.sortKindData)[(HeroFilterEnum.eKindType).Camp]
  if not campConfig.nocondition then
    local campOk = (campConfig.selectIndexs)[heroData.camp]
  end
  local careerConfig = (self.sortKindData)[(HeroFilterEnum.eKindType).Career]
  if not careerConfig.nocondition then
    local careerOk = (careerConfig.selectIndexs)[heroData.career]
  end
  if rankOk and campOk and careerOk then
    return true
  else
    return false
  end
end

UINFactoryHeroList.ShowHeroCollection = function(self)
  -- function num : 0_14 , upvalues : _ENV
  local totalCount = (ConfigData.hero_data).totalHeroCount
  local collectRate = 0
  collectRate = (math.ceil)(PlayerDataCenter.heroCount / totalCount * 100)
  ;
  (((self.ui).tex_Trim).gameObject):SetActive(collectRate / 100 > 0)
  ;
  ((self.ui).tex_Collect):SetIndex(0, tostring(collectRate))
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UINFactoryHeroList.SetHeroListTweens = function(self)
  -- function num : 0_15 , upvalues : cs_DoTween
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  ((self.ui).decorFade).alpha = 0
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).heroListFade).alpha = 0
  self.pageSequence = (cs_DoTween.Sequence)()
  ;
  (self.pageSequence):Append((((self.ui).decorFade):DOFade(1, 0.1)):SetLoops(3))
  ;
  (self.pageSequence):Append(((self.ui).heroListFade):DOFade(1, 0.15))
  ;
  (self.pageSequence):SetDelay(0.1)
  ;
  (self.pageSequence):SetAutoKill(false)
end

UINFactoryHeroList.DeleteHeroListTweens = function(self)
  -- function num : 0_16
  if self.pageSequence ~= nil then
    (self.pageSequence):Kill()
    self.pageSequence = nil
  end
end

UINFactoryHeroList.OnHide = function(self)
  -- function num : 0_17 , upvalues : _ENV, base
  MsgCenter:Broadcast(eMsgEventId.UIHeroListClosed)
  UIManager:PlayDoFade((self.ui).canvasGroup, 1, 0, 0.25, BindCallback(self, base.Delete))
  UIManager:PlayFov(90, 30, 0.25)
  ;
  (base.OnHide)(self)
end

UINFactoryHeroList.OnDelete = function(self)
  -- function num : 0_18 , upvalues : base
  self:DeleteHeroListTweens()
  if self.sortButtonGroup ~= nil then
    (self.sortButtonGroup):Delete()
  end
  if self.siftCondition ~= nil then
    (self.siftCondition):Delete()
  end
  if self.heroSortList ~= nil then
    (self.heroSortList):Delete()
  end
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
  ;
  (base.OnDelete)(self)
end

return UINFactoryHeroList

