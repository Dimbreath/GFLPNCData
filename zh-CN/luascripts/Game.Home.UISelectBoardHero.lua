-- params : ...
-- function num : 0 , upvalues : _ENV
local UISelectBoardHero = class("UISelectBoardHero", UIBaseWindow)
local base = UIBaseWindow
local CS_ResLoader = CS.ResLoader
local UINHeroSortList = require("Game.Hero.NewUI.SortList.UINHeroSortList")
local UINSortButtonGroup =
    require("Game.Hero.NewUI.SortList.UINSortButtonGroup")
local UINSiftCondition = require("Game.Hero.NewUI.SortList.UINSiftCondition")
local HeroSortEnum = require("Game.Hero.NewUI.HeroSortEnum")
local HeroFilterEnum = require("Game.Hero.NewUI.HeroFilterEnum")
UISelectBoardHero.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, CS_ResLoader, UINHeroSortList, UINSortButtonGroup, HeroSortEnum
    self.changeBoardHeroCallback = nil;
    (UIUtil.CreateTopBtnGroup)((self.ui).topButtonGroup, self, self.Delete);
    (UIUtil.AddButtonListener)((self.ui).btn_Comfirm, self, self.Confirm);
    (UIUtil.AddButtonListener)((self.ui).btn_Filter, self, self.OnBtnFilterClick)
    self.resloader = (CS_ResLoader.Create)()
    local HeroSortList = (UINHeroSortList.New)()
    HeroSortList:Init((self.ui).heroList)
    HeroSortList:InitHeroSortList(self.resloader, nil, nil, false, false, true,
                                  false)
    HeroSortList:SetHeroListAnchorPosOffset(1)
    HeroSortList:RefreshHeroSortList()
    self.heroSortList = HeroSortList
    local sortButtonGroup = (UINSortButtonGroup.New)()
    sortButtonGroup:Init((self.ui).sortButtonGroup)
    self.sortButtonGroup = sortButtonGroup;
    (self.sortButtonGroup):InitSortButtonGroup(HeroSortEnum.SortMannerDefine,
                                               BindCallback(self,
                                                            self.__OnBtnSortItemClick))
end

UISelectBoardHero.SetDefaultSelect = function(self, heroData)
    -- function num : 0_1
    (self.heroSortList):__RefreshSelectHero(heroData)
end

UISelectBoardHero.__OnBtnSortItemClick =
    function(self, sortFunc)
        -- function num : 0_2
        (self.heroSortList):RefreshHeroSortList(nil, sortFunc)
    end

UISelectBoardHero.OnBtnFilterClick = function(self)
    -- function num : 0_3 , upvalues : UINSiftCondition, HeroFilterEnum, _ENV
    do
        if self.siftCondition == nil then
            local SiftConditionPage = (UINSiftCondition.New)()
            SiftConditionPage:Init((self.ui).sortConditionNode)
            SiftConditionPage:InitSiftCondition(HeroFilterEnum.eKindType,
                                                HeroFilterEnum.eKindMaxCount,
                                                BindCallback(self,
                                                             self.OnFilterConfirmAction))
            self.siftCondition = SiftConditionPage
        end
        (self.siftCondition):Show()
    end
end

UISelectBoardHero.OnFilterConfirmAction =
    function(self, sortKindData)
        -- function num : 0_4 , upvalues : _ENV
        self.sortKindData = sortKindData
        if self.__SiftFunction == nil then
            self.__SiftFunction = BindCallback(self, self.SiftFunction)
        end
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
    -- function num : 0_6 , upvalues : _ENV
    if self.changeBoardHeroCallback ~= nil then
        (self.changeBoardHeroCallback)((self.heroSortList).selectHero)
    end
    (NetworkManager:GetNetwork(NetworkTypeID.Object)):CS_User_ModifyShowGirl(
        ((self.heroSortList).selectHero).dataId)
    self:Delete()
end

UISelectBoardHero.OnHide = function(self)
    -- function num : 0_7 , upvalues : _ENV, base
    local homeWin = UIManager:GetWindow(UIWindowTypeID.Home)
    if homeWin ~= nil then homeWin:BackFromOtherWin() end
    (base.OnHide)(self)
end

UISelectBoardHero.OnDelete = function(self)
    -- function num : 0_8 , upvalues : base
    (self.heroSortList):Delete();
    (self.sortButtonGroup):Delete();
    (base.OnDelete)(self)
end

return UISelectBoardHero

