-- params : ...
-- function num : 0 , upvalues : _ENV
local UIHeroStarUp = class("UIHeroStarUp", UIBaseWindow)
local base = UIBaseWindow
local UIHStarUpInfoNode = require("Game.Hero.NewUI.UpgradeStar.UIHStarUpInfoNode")
local UIHStarUpSkillNode = require("Game.Hero.NewUI.UpgradeStar.UIHStarUpSkillNode")
local cs_ResLoader = CS.ResLoader
local cs_MessageCommon = CS.MessageCommon
UIHeroStarUp.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UIHStarUpInfoNode, UIHStarUpSkillNode
  (UIUtil.AddButtonListener)((self.ui).btn_LeftArrow, self, self.__OnClickLeftArrow)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_RightArrow, self, self.__OnClickRightArrow)
  self.starUpInfoNode = (UIHStarUpInfoNode.New)()
  ;
  (self.starUpInfoNode):Init((self.ui).obj_InfoNode)
  self.starUpSkillNode = (UIHStarUpSkillNode.New)()
  ;
  (self.starUpSkillNode):Init((self.ui).obj_SkillNode)
  ;
  ((self.ui).obj_SkillNode):SetActive(false)
  self.__onPreveteItemClick = BindCallback(self, self.__PreveteItemClick)
  self.__onStarUpClick = BindCallback(self, self.__StarUpClick)
  self.networkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Hero)
end

UIHeroStarUp.InitHeroStarUp = function(self, resloader, hideCallBack, switchHeroFunc)
  -- function num : 0_1 , upvalues : _ENV
  (UIUtil.SetTopStatus)(self, self.OnClickBack)
  self.resloader = resloader
  self.hideCallBack = hideCallBack
  self.switchHeroFunc = switchHeroFunc
end

UIHeroStarUp.SwitchHero = function(self, heroData, reUseBigImgResLoader)
  -- function num : 0_2
  self.heroData = heroData
  self:RefreshAll(reUseBigImgResLoader)
  self:__PlayAllDOTween()
end

UIHeroStarUp.RefreshAll = function(self, reUseBigImgResLoader, heroId)
  -- function num : 0_3
  (self.starUpSkillNode):Hide()
  if heroId ~= nil and heroId ~= (self.heroData).dataId then
    return 
  end
  self:RefreshHeroStaticInfo(reUseBigImgResLoader)
  ;
  (self.starUpInfoNode):RefreshStarUpInfoUI(self.heroData, self.__onPreveteItemClick, self.__onStarUpClick)
end

UIHeroStarUp.RefreshHeroStaticInfo = function(self, reUseBigImgResLoader)
  -- function num : 0_4 , upvalues : _ENV, cs_ResLoader
  local campIcon = (LanguageUtil.GetLocaleText)(((self.heroData):GetCampCfg()).icon)
  ;
  (self.resloader):LoadABAssetAsync(PathConsts:GetCampPicPath(campIcon), function(texture)
    -- function num : 0_4_0 , upvalues : _ENV, self
    if IsNull(self.transform) then
      return 
    end
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Camp).texture = texture
  end
)
  local bigImgResLoader = nil
  if reUseBigImgResLoader ~= nil then
    bigImgResLoader = reUseBigImgResLoader
  else
    if self.bigImgResloader ~= nil then
      (self.bigImgResloader):Put2Pool()
    end
    self.bigImgResloader = (cs_ResLoader.Create)()
    bigImgResLoader = self.bigImgResloader
  end
  if not IsNull(self.bigImgGameObject) then
    (self.bigImgGameObject):SetActive(false)
  end
  bigImgResLoader:LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath((self.heroData):GetResName()), function(prefab)
    -- function num : 0_4_1 , upvalues : _ENV, self
    DestroyUnityObject(self.bigImgGameObject)
    self.bigImgGameObject = prefab:Instantiate((self.ui).heroHolder)
    local commonPicCtrl = (self.bigImgGameObject):FindComponent(eUnityComponentID.CommonPicController)
    commonPicCtrl:SetPosType("HeroList")
    ;
    (self.bigImgGameObject):SetActive(true)
  end
)
end

UIHeroStarUp.__PlayAllDOTween = function(self)
  -- function num : 0_5
  for i = 1, #(self.ui).heroTweens do
    local tween = ((self.ui).heroTweens)[i]
    tween:DORestart(false)
  end
end

UIHeroStarUp.__OnClickLeftArrow = function(self)
  -- function num : 0_6
  if self.switchHeroFunc ~= nil then
    local newHeroData, reUseBigImgResloader = (self.switchHeroFunc)(-1)
    self:SwitchHero(newHeroData, reUseBigImgResloader)
  end
end

UIHeroStarUp.__OnClickRightArrow = function(self)
  -- function num : 0_7
  if self.switchHeroFunc ~= nil then
    local newHeroData, reUseBigImgResloader = (self.switchHeroFunc)(1)
    self:SwitchHero(newHeroData, reUseBigImgResloader)
  end
end

UIHeroStarUp.OnClickBack = function(self)
  -- function num : 0_8 , upvalues : _ENV
  if self.hideCallBack ~= nil then
    (self.hideCallBack)()
  end
  local win = UIManager:GetWindow(UIWindowTypeID.HeroState)
  if win ~= nil and not win.active then
    win.active = true
    ;
    (win.gameObject):SetActive(true)
  end
  ;
  (self.starUpSkillNode):Hide()
  self:Hide()
end

UIHeroStarUp.__PreveteItemClick = function(self, preData)
  -- function num : 0_9
  if preData == nil or preData.preType ~= 2 then
    return 
  end
  ;
  (self.starUpSkillNode):InitStarUpSkillNode(preData.data, preData.preUSkilllevel, self.resloader)
  ;
  (self.starUpSkillNode):Show()
end

UIHeroStarUp.__StarUpClick = function(self)
  -- function num : 0_10 , upvalues : _ENV, cs_MessageCommon
  local ableUp, fitFrag, fitCurrency, fitExtr = (self.heroData):AbleUpgradeStar()
  if ableUp then
    if self.__StarUpCompleteFunc == nil then
      self.__StarUpCompleteFunc = BindCallback(self, self.__OnStarUpComplete)
    end
    ;
    (self.networkCtrl):SendHeroAddStar((self.heroData).dataId, self.__StarUpCompleteFunc)
  else
    if not fitFrag or not fitCurrency or not fitExtr then
      (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.hero_CantUpgrade))
    end
  end
end

UIHeroStarUp.__OnStarUpComplete = function(self)
  -- function num : 0_11
  self:RefreshAll()
end

UIHeroStarUp.OnDelect = function(self)
  -- function num : 0_12 , upvalues : base
  for i = 1, #(self.ui).heroTweens do
    local tween = ((self.ui).heroTweens)[i]
    tween:DOKill()
  end
  ;
  (base.OnDelete)(self)
end

return UIHeroStarUp

