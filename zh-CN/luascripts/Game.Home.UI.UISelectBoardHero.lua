-- params : ...
-- function num : 0 , upvalues : _ENV
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
  (UIUtil.CreateTopBtnGroup)((self.ui).topBtnGroup, self, self.Delete)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Comfirm, self, self.Confirm)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Filter, self, self.OnBtnFilterClick)
  ;
  (((self.ui).btn_Comfirm).gameObject):SetActive(true)
  self.resloader = (CS_ResLoader.Create)()
  local HeroSortList = (UINHeroSortList.New)()
  HeroSortList:Init(((self.ui).heroListFade).gameObject)
  HeroSortList:InitHeroSortList(self.resloader, nil, nil, false, false, true, false)
  HeroSortList:SetHeroListAnchorPosOffset(1)
  HeroSortList:RefreshHeroSortList()
  self.heroSortList = HeroSortList
  local sortButtonGroup = (UINSortButtonGroup.New)()
  sortButtonGroup:Init((self.ui).buttonGroup)
  self.sortButtonGroup = sortButtonGroup
  ;
  (self.sortButtonGroup):InitSortButtonGroup(HeroSortEnum.SortMannerDefine, BindCallback(self, self.__OnBtnSortItemClick))
end

UISelectBoardHero.InitSelectBoardHero = function(self, heroData, isFromHome)
  -- function num : 0_1
  (self.heroSortList):__RefreshSelectHero(heroData)
  self.isFromHome = isFromHome
  self:ShowHeroCollection()
end

UISelectBoardHero.__OnBtnSortItemClick = function(self, sortFunc)
  -- function num : 0_2
  (self.heroSortList):RefreshHeroSortList(nil, sortFunc)
end

UISelectBoardHero.OnBtnFilterClick = function(self)
  -- function num : 0_3 , upvalues : UINSiftCondition, HeroFilterEnum, _ENV
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
  -- function num : 0_4 , upvalues : _ENV
  self.sortKindData = sortKindData
  if self.__SiftFunction == nil then
    self.__SiftFunction = BindCallback(self, self.SiftFunction)
  end
  ;
  (self.heroSortList):RefreshHeroSortList(self.__SiftFunction, nil)
end

UISelectBoardHero.SiftFunction = function(self, heroData)
  -- function num : 0_5 , upvalues : HeroFilterEnum
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

UISelectBoardHero.Confirm = function(self)
  -- function num : 0_6 , upvalues : _ENV, util
  (UIUtil.PopFromBackStack)()
  if self.changeBoardHeroCallback ~= nil then
    (self.changeBoardHeroCallback)((self.heroSortList).selectHero, function()
    -- function num : 0_6_0 , upvalues : _ENV, self, util
    (NetworkManager:GetNetwork(NetworkTypeID.Object)):CS_User_ModifyShowGirl(((self.heroSortList).selectHero).dataId)
    local waitFunc = function()
      -- function num : 0_6_0_0 , upvalues : _ENV, self
      (coroutine.yield)(nil)
      self:Delete()
    end

    self.__waitCoroutine = (GR.StartCoroutine)((util.cs_generator)(waitFunc))
  end
)
  else
    self:Delete()
  end
end

UISelectBoardHero.OnHide = function(self)
  -- function num : 0_7 , upvalues : _ENV, base
  do
    if self.isFromHome then
      local homeWin = UIManager:GetWindow(UIWindowTypeID.Home)
      if homeWin ~= nil then
        homeWin:BackFromOtherWin()
      end
    end
    ;
    (base.OnHide)(self)
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

UISelectBoardHero.OnDelete = function(self)
  -- function num : 0_9 , upvalues : _ENV, base
  if self.__waitCoroutine ~= nil then
    (GR.StopCoroutine)(self.__waitCoroutine)
    self.__waitCoroutine = nil
  end
  ;
  (self.heroSortList):Delete()
  ;
  (self.sortButtonGroup):Delete()
  ;
  (base.OnDelete)(self)
end

return UISelectBoardHero

