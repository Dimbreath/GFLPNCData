local UISelectBoardHero = class("UISelectBoardHero", UIBaseWindow)
local base = UIBaseWindow
local CS_ResLoader = CS.ResLoader
local util = require("XLua.Common.xlua_util")
local UINHeroSortList = require("Game.Hero.NewUI.SortList.UINHeroSortList")
local UINSortButtonGroup = require("Game.Hero.NewUI.SortList.UINSortButtonGroup")
local UINSiftCondition = require("Game.Hero.NewUI.SortList.UINSiftCondition")
local HeroSortEnum = require("Game.Hero.NewUI.HeroSortEnum")
local HeroFilterEnum = require("Game.Hero.NewUI.HeroFilterEnum")
UISelectBoardHero.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, CS_ResLoader, UINHeroSortList, UINSortButtonGroup, HeroSortEnum
  self.changeBoardHeroCallback = nil
  ;
  (UIUtil.SetTopStatus)(self, self.OnReturnClick)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Comfirm, self, self.Confirm)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Filter, self, self.OnBtnFilterClick)
  ;
  (((self.ui).btn_Comfirm).gameObject):SetActive(true)
  self.resloader = (CS_ResLoader.Create)()
  local HeroSortList = (UINHeroSortList.New)()
  HeroSortList:Init(((self.ui).heroListFade).gameObject)
  HeroSortList:InitHeroSortList(self.resloader, nil, BindCallback(self, self._OnSelectHeroItem), false, false, true, false)
  HeroSortList:SetHeroListAnchorPosOffset(1)
  HeroSortList:RefreshHeroSortList()
  HeroSortList:ShowHeroPower(false)
  self.heroSortList = HeroSortList
  local sortButtonGroup = (UINSortButtonGroup.New)()
  sortButtonGroup:Init((self.ui).buttonGroup)
  self.sortButtonGroup = sortButtonGroup
  ;
  (self.sortButtonGroup):InitSortButtonGroup(HeroSortEnum.SortMannerDefine, BindCallback(self, self.__OnBtnSortItemClick), (HeroSortEnum.eSortResource).boardHero)
end

UISelectBoardHero.InitSelectBoardHero = function(self, heroData)
  -- function num : 0_1
  self._isInit = true
  self.OriginalHeroData = heroData
  ;
  (self.heroSortList):__RefreshSelectHero(heroData)
  self:ShowHeroCollection()
  self._isInit = false
end

UISelectBoardHero._OnSelectHeroItem = function(self, heroData, selectItem)
  -- function num : 0_2 , upvalues : _ENV
  if self._selectHeroData ~= heroData then
    self._selectHeroData = heroData
    if not self._isInit then
      AudioManager:PlayAudioById(1058)
    end
  end
end

UISelectBoardHero.__OnBtnSortItemClick = function(self, sortFunc)
  -- function num : 0_3
  (self.heroSortList):RefreshHeroSortList(nil, sortFunc)
end

UISelectBoardHero.OnBtnFilterClick = function(self)
  -- function num : 0_4 , upvalues : UINSiftCondition, HeroFilterEnum, _ENV
  do
    if self.siftCondition == nil then
      local SiftConditionPage = (UINSiftCondition.New)()
      SiftConditionPage:Init((self.ui).sortConditionNode)
      SiftConditionPage:InitSiftCondition(HeroFilterEnum.eKindType, HeroFilterEnum.eKindMaxCount, BindCallback(self, self.OnFilterConfirmAction))
      self.siftCondition = SiftConditionPage
    end
    ;
    (self.siftCondition):Show()
  end
end

UISelectBoardHero.OnFilterConfirmAction = function(self, sortKindData)
  -- function num : 0_5 , upvalues : _ENV
  self.sortKindData = sortKindData
  if self.__SiftFunction == nil then
    self.__SiftFunction = BindCallback(self, self.SiftFunction)
  end
  ;
  (self.heroSortList):RefreshHeroSortList(self.__SiftFunction, nil)
end

UISelectBoardHero.SiftFunction = function(self, heroData)
  -- function num : 0_6 , upvalues : HeroFilterEnum, _ENV
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

UISelectBoardHero.Confirm = function(self)
  -- function num : 0_7 , upvalues : _ENV, util
  if self.changeBoardHeroCallback ~= nil and (self.OriginalHeroData).dataId ~= ((self.heroSortList).selectHero).dataId then
    (self.changeBoardHeroCallback)((self.heroSortList).selectHero, function()
    -- function num : 0_7_0 , upvalues : _ENV, self, util
    (NetworkManager:GetNetwork(NetworkTypeID.Object)):CS_User_ModifyShowGirl(((self.heroSortList).selectHero).dataId)
    AudioManager:RemoveAllVoice(true)
    local waitFunc = function()
      -- function num : 0_7_0_0 , upvalues : _ENV
      (coroutine.yield)(nil)
      ;
      (ControllerManager:GetController(ControllerTypeId.HomeController)):PlayVoReturnHome()
      ;
      (UIUtil.OnClickBack)()
    end

    self.__waitCoroutine = (GR.StartCoroutine)((util.cs_generator)(waitFunc))
  end
)
  else
    ;
    (UIUtil.OnClickBack)()
  end
end

UISelectBoardHero.ShowHeroCollection = function(self)
  -- function num : 0_8 , upvalues : _ENV
  local totalCount = (ConfigData.hero_data).totalHeroCount
  local collectRate = 0
  collectRate = (math.ceil)(PlayerDataCenter.heroCount / totalCount * 100)
  ;
  (((self.ui).tex_Trim).gameObject):SetActive(collectRate / 100 > 0)
  ;
  ((self.ui).tex_Collect):SetIndex(0, tostring(collectRate))
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UISelectBoardHero.OnReturnClick = function(self)
  -- function num : 0_9
  self:OnCloseWin()
  self:Delete()
end

UISelectBoardHero.OnDelete = function(self)
  -- function num : 0_10 , upvalues : _ENV, base
  if self.__waitCoroutine ~= nil then
    (GR.StopCoroutine)(self.__waitCoroutine)
    self.__waitCoroutine = nil
  end
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
  ;
  (self.heroSortList):Delete()
  ;
  (self.sortButtonGroup):Delete()
  ;
  (base.OnDelete)(self)
end

return UISelectBoardHero

