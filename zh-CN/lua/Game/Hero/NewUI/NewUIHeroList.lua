local NewUIHeroList = class("NewUIHeroList", UIBaseWindow)
local base = UIBaseWindow
local UINHeroSortList = require("Game.Hero.NewUI.SortList.UINHeroSortList")
local UINSortButtonGroup = require("Game.Hero.NewUI.SortList.UINSortButtonGroup")
local UINSiftCondition = require("Game.Hero.NewUI.SortList.UINSiftCondition")
local cs_ResLoader = CS.ResLoader
local HeroFilterEnum = require("Game.Hero.NewUI.HeroFilterEnum")
local HeroSortEnum = require("Game.Hero.NewUI.HeroSortEnum")
local cs_DoTween = ((CS.DG).Tweening).DOTween
NewUIHeroList.OnInit = function(self)
  -- function num : 0_0
  self:__InitUI()
  self:__InitData()
  self:SetHeroListTweens()
end

NewUIHeroList.__InitUI = function(self)
  -- function num : 0_1 , upvalues : _ENV
  (UIUtil.SetTopStatus)(self, self.OnReturnClicked, nil, nil, nil)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Filter, self, self.__OnBtnFilterClick)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).tog_ShowAllHero, self, self.__OnClickShowAllHeroTog)
  ;
  (((self.ui).tog_ShowAllHero).gameObject):SetActive(true)
  ;
  ((self.ui).sortConditionNode):SetActive(false)
  ;
  (((self.ui).btn_Comfirm).gameObject):SetActive(false)
  self:ShowHeroCollection()
end

NewUIHeroList.__InitData = function(self)
  -- function num : 0_2 , upvalues : cs_ResLoader, _ENV
  self.resloader = (cs_ResLoader.Create)()
  self.__returnEvent = nil
  self.__onSelHeroItemClick = BindCallback(self, self.OnSelHeroItemClick)
  self.__onFilterConfirmAction = BindCallback(self, self.__OnFilterConfirmAction)
  self.__onBtnSortItemClick = BindCallback(self, self.__OnBtnSortItemClick)
  self:__InitHeroList()
  self:__InitSortButtonGroup()
  self:InitRedDotEvent()
end

NewUIHeroList.InitRedDotEvent = function(self)
  -- function num : 0_3 , upvalues : _ENV
  self.__onHeroCardRedDotEvent = function(node)
    -- function num : 0_3_0 , upvalues : self
    local heroItem = (self.heroSortList):__GetHeroItemById(node.nodeId)
    if node:GetRedDotCount() <= 0 then
      heroItem:SetRedDotActive(heroItem == nil)
      -- DECOMPILER ERROR: 2 unprocessed JMP targets
    end
  end

  RedDotController:AddListener(RedDotDynPath.HeroCardPath, self.__onHeroCardRedDotEvent)
end

NewUIHeroList.RemoveRedDotEvent = function(self)
  -- function num : 0_4 , upvalues : _ENV
  RedDotController:RemoveListener(RedDotDynPath.HeroCardPath, self.__onHeroCardRedDotEvent)
end

NewUIHeroList.SetReturnEvent = function(self, returnEvent)
  -- function num : 0_5
  self.__returnEvent = returnEvent
end

NewUIHeroList.OnReturnClicked = function(self)
  -- function num : 0_6
  if self.__returnEvent ~= nil then
    (self.__returnEvent)()
    self.__returnEvent = nil
  else
    self:CloseSelf()
  end
end

NewUIHeroList.__InitHeroList = function(self)
  -- function num : 0_7 , upvalues : UINHeroSortList, _ENV
  if self.heroSortList == nil then
    local HeroSortList = (UINHeroSortList.New)()
    HeroSortList:Init(((self.ui).heroListFade).gameObject)
    HeroSortList:SetShowRedDotActive(true)
    HeroSortList:InitHeroSortList(self.resloader, nil, self.__onSelHeroItemClick, true, nil, false, nil, nil, true, true)
    HeroSortList:ShowHeroPower(true)
    self.heroSortList = HeroSortList
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (((self.heroSortList).ui).scrollRest).onReturnItem = function(go)
    -- function num : 0_7_0 , upvalues : self, _ENV
    if ((self.ui).head).constraintActive then
      local heroItem = ((self.heroSortList).heroItemDic)[go]
      local heroData = heroItem.heroData
      local index = (table.indexof)((self.heroSortList).curHeroList, heroData)
      -- DECOMPILER ERROR at PC19: Confused about usage of register: R4 in 'UnsetPending'

      if index == 1 then
        ((self.ui).head).constraintActive = false
      end
    end
  end

    ;
    (self.heroSortList):SetChangeItemCallback(function(index)
    -- function num : 0_7_1 , upvalues : self
    -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

    if index == 1 then
      ((self.ui).head).constraintActive = true
    end
  end
)
  end
end

NewUIHeroList.OnSelHeroItemClick = function(self, heroData)
  -- function num : 0_8 , upvalues : _ENV
  if heroData == nil then
    return 
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroState, function(windows)
    -- function num : 0_8_0 , upvalues : _ENV, heroData, self
    if windows == nil then
      error((LanguageUtil.GetLocaleText)(heroData.name) .. "Click can\'t show state")
      return 
    end
    local heroList = {}
    for index,heroData in ipairs((self.heroSortList).curHeroList) do
      if not heroData.isLockedHero then
        (table.insert)(heroList, heroData)
      end
    end
    windows:InitHeroState(heroData, heroList, function()
      -- function num : 0_8_0_0 , upvalues : _ENV, self
      for go,heroItem in pairs((self.heroSortList).heroItemDic) do
        heroItem:RefreshHeroCardItem()
        heroItem:RefreshFightPower()
      end
    end
)
    windows:RegistFromeWindowTypeID(UIWindowTypeID.HeroList)
    local parWin = UIManager:GetWindow(UIWindowTypeID.HeroList)
    if parWin ~= nil then
      parWin:Hide()
    end
  end
)
end

NewUIHeroList.__InitSortButtonGroup = function(self)
  -- function num : 0_9 , upvalues : UINSortButtonGroup, HeroSortEnum
  if self.sortButtonGroup == nil then
    local sortButtonGroup = (UINSortButtonGroup.New)()
    sortButtonGroup:Init((self.ui).buttonGroup)
    sortButtonGroup:InitSortButtonGroup(HeroSortEnum.SortMannerDefine, self.__onBtnSortItemClick, (HeroSortEnum.eSortResource).heroList)
    self.sortButtonGroup = sortButtonGroup
  end
end

NewUIHeroList.__OnBtnSortItemClick = function(self, sortFunc)
  -- function num : 0_10
  if self.heroSortList == nil then
    self:__InitHeroList()
  end
  ;
  (self.heroSortList):RefreshHeroSortList(nil, sortFunc)
end

NewUIHeroList.__OnBtnFilterClick = function(self)
  -- function num : 0_11 , upvalues : UINSiftCondition, HeroFilterEnum
  do
    if self.siftCondition == nil then
      local SiftConditionPage = (UINSiftCondition.New)()
      SiftConditionPage:Init((self.ui).sortConditionNode)
      SiftConditionPage:InitSiftCondition(HeroFilterEnum.eKindType, HeroFilterEnum.eKindMaxCount, self.__onFilterConfirmAction)
      self.siftCondition = SiftConditionPage
    end
    ;
    (self.siftCondition):Show()
  end
end

NewUIHeroList.__OnClickShowAllHeroTog = function(self, bool)
  -- function num : 0_12
  (self.heroSortList):RefreshHeroSortList(nil, nil, bool)
end

NewUIHeroList.__OnFilterConfirmAction = function(self, sortKindData)
  -- function num : 0_13 , upvalues : _ENV
  self.sortKindData = sortKindData
  if self.heroSortList == nil then
    self:__InitHeroList()
  end
  ;
  (self.heroSortList):RefreshHeroSortList((BindCallback(self, self.__SiftFunction)), nil)
end

NewUIHeroList.__SiftFunction = function(self, heroData)
  -- function num : 0_14 , upvalues : HeroFilterEnum, _ENV
  local rareConfig = (self.sortKindData)[(HeroFilterEnum.eKindType).Rank]
  local Star = (math.floor)(heroData.rank / 2)
  if Star == 0 then
    Star = 1
  end
  if not rareConfig.nocondition then
    local rankOk = (rareConfig.selectIndexs)[Star]
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

NewUIHeroList.ShowHeroCollection = function(self)
  -- function num : 0_15 , upvalues : _ENV
  local totalCount = (ConfigData.hero_data).totalHeroCount
  local collectRate = 0
  collectRate = (math.ceil)(PlayerDataCenter.heroCount / totalCount * 100)
  ;
  (((self.ui).tex_Trim).gameObject):SetActive(collectRate / 100 > 0)
  ;
  ((self.ui).tex_Collect):SetIndex(0, tostring(collectRate))
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

NewUIHeroList.SetHeroListTweens = function(self)
  -- function num : 0_16 , upvalues : cs_DoTween
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

NewUIHeroList.DeleteHeroListTweens = function(self)
  -- function num : 0_17
  if self.pageSequence ~= nil then
    (self.pageSequence):Kill()
    self.pageSequence = nil
  end
end

NewUIHeroList.Roll2Hero = function(self, heroId)
  -- function num : 0_18 , upvalues : _ENV
  local targetIndex = nil
  for index,heroData in ipairs((self.heroSortList).curHeroList) do
    if heroData.dataId == heroId then
      targetIndex = index - 1
      return 
    end
  end
  ;
  (self.heroSortList):SrollToCell(targetIndex, 5000)
end

NewUIHeroList.CloseSelf = function(self)
  -- function num : 0_19
  self:Delete()
end

NewUIHeroList.Delete = function(self)
  -- function num : 0_20 , upvalues : _ENV, base
  self:OnCloseWin()
  do
    if self.fromType == eBaseWinFromWhere.home then
      local homeWin = UIManager:GetWindow(UIWindowTypeID.Home)
      if homeWin ~= nil then
        AudioManager:RemoveAllVoice()
      end
    end
    ;
    (base.Delete)(self)
  end
end

NewUIHeroList.OnDelete = function(self)
  -- function num : 0_21 , upvalues : _ENV, base
  self:RemoveRedDotEvent()
  MsgCenter:Broadcast(eMsgEventId.UIHeroListClosed)
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
  self:DeleteHeroListTweens()
  ;
  (base.OnDelete)(self)
end

return NewUIHeroList

