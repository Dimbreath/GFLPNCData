local UINHeroCardItem = class("UINHeroCardItem", UIBaseNode)
local base = UIBaseNode
UINHeroCardItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_HeroItem, self, self.OnItemClicked)
  ;
  (((self.ui).img_OnSelect).gameObject):SetActive(false)
  ;
  (((self.ui).img_star).gameObject):SetActive(false)
  ;
  ((self.ui).obj_isBench):SetActive(false)
  self:SetRedDotActive(false)
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.ui).starArr = {}
  for i = 1, (ConfigData.hero_rank).maxStar / 2 do
    local go = (((self.ui).img_star).gameObject):Instantiate()
    go:SetActive(true)
    local imgItemInfo = go:GetComponent(typeof(CS.UiImageItemInfo))
    ;
    (table.insert)((self.ui).starArr, imgItemInfo)
  end
  self:SetEfficiencyActive(false)
  -- DECOMPILER ERROR at PC72: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.ui).potentialImgWidth = ((((self.ui).img_LimitUp).sprite).textureRect).width
  local mat = (((CS.UnityEngine).Object).Instantiate)(((self.ui).img_Hero).material)
  -- DECOMPILER ERROR at PC83: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).img_Hero).material = mat
end

UINHeroCardItem.InitHeroCardItem = function(self, heroData, resloader, clickedAction)
  -- function num : 0_1
  self.heroData = heroData
  self.resloader = resloader
  self.onClickedAction = clickedAction
  self.__initTexture = true
  self:RefreshHeroCardItem()
end

UINHeroCardItem.RefreshHeroCardItem = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self.heroData == nil then
    return 
  end
  ;
  ((self.ui).obj_Locked):SetActive((self.heroData).isLockedHero)
  if (self.heroData).isLockedHero then
    self:RefreshFragMerge()
  end
  self:__SetStarUI((self.heroData).star)
  self:__SetHeroLevel((self.heroData).level)
  self:__SetPotential((self.heroData).potential)
  ;
  ((self.ui).tex_HeroID):SetIndex(0, tostring((self.heroData).dataId))
  -- DECOMPILER ERROR at PC42: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = (self.heroData):GetName()
  -- DECOMPILER ERROR at PC49: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).img_Quality).color = HeroRareColor[(self.heroData).rare]
  -- DECOMPILER ERROR at PC56: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).img_QualityLight).color = HeroRareColor[(self.heroData).rare]
  -- DECOMPILER ERROR at PC68: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).img_Career).sprite = CRH:GetSprite(((self.heroData):GetCareerCfg()).icon, CommonAtlasType.CareerCamp)
  if self.__initTexture then
    self.__initTexture = false
    -- DECOMPILER ERROR at PC75: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Hero).enabled = false
    self:UpdateSkin()
    local campIcon = (LanguageUtil.GetLocaleText)(((self.heroData):GetCampCfg()).icon)
    -- DECOMPILER ERROR at PC89: Confused about usage of register: R2 in 'UnsetPending'

    if campIcon ~= nil then
      ((self.ui).img_Camp).enabled = false
      self:__SetTexture(PathConsts:GetCampPicPath(campIcon), (self.ui).img_Camp)
    end
  end
end

UINHeroCardItem.UpdateSkin = function(self)
  -- function num : 0_3 , upvalues : _ENV
  self:__SetTexture(PathConsts:GetCharacterPicPath((self.heroData):GetResPicName()), (self.ui).img_Hero, function()
    -- function num : 0_3_0 , upvalues : self
    if (self.heroData).isLockedHero then
      (((self.ui).img_Hero).material):SetFloat("_CoverColorRate", 1)
    else
      ;
      (((self.ui).img_Hero).material):SetFloat("_CoverColorRate", 0)
    end
  end
)
end

UINHeroCardItem.OnItemClicked = function(self)
  -- function num : 0_4
  if self.onClickedAction ~= nil then
    (self.onClickedAction)(self.heroData)
  end
end

UINHeroCardItem.SetRedDotActive = function(self, active)
  -- function num : 0_5
  ((self.ui).redDot):SetActive(active)
end

UINHeroCardItem.SetSelectActive = function(self, active, isbench)
  -- function num : 0_6
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

  if not isbench or not (self.ui).col_SubSelect then
    ((self.ui).img_OnSelect).color = (self.ui).col_Select
    ;
    ((self.ui).obj_isBench):SetActive(isbench)
    ;
    (((self.ui).img_OnSelect).gameObject):SetActive(active)
  end
end

UINHeroCardItem.SetEfficiencyActive = function(self, active)
  -- function num : 0_7 , upvalues : _ENV
  ((self.ui).obj_efficiency):SetActive(active)
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R2 in 'UnsetPending'

  if active then
    ((self.ui).tex_Efficiency).text = tostring((self.heroData):GetFightingPower())
  end
end

UINHeroCardItem.RefreshFightPower = function(self)
  -- function num : 0_8 , upvalues : _ENV
  if (self.heroData).isLockedHero then
    return 
  end
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tex_Efficiency).text = tostring((self.heroData):GetFightingPower())
end

UINHeroCardItem.RefreshFragMerge = function(self)
  -- function num : 0_9 , upvalues : _ENV
  local couldMerge, curFrage, mergeNeedFrage = (self.heroData):GetIsCouldMerge()
  ;
  ((self.ui).obj_canUnlock):SetActive(couldMerge)
  if couldMerge then
    ((self.ui).tex_ChipCount):SetIndex(0, tostring(curFrage), tostring(mergeNeedFrage))
  else
    ;
    ((self.ui).tex_ChipCount):SetIndex(1, tostring(curFrage), tostring(mergeNeedFrage))
  end
end

UINHeroCardItem.__SetStarUI = function(self, starCount)
  -- function num : 0_10 , upvalues : _ENV
  local count = (math.ceil)(starCount / 2)
  local isHalf = starCount % 2
  for i = 1, count do
    ((((self.ui).starArr)[i]).gameObject):SetActive(true)
    ;
    (((self.ui).starArr)[i]):SetIndex(0)
    if i == count and isHalf == 1 then
      (((self.ui).starArr)[i]):SetIndex(1)
    end
  end
  for i = count + 1, #(self.ui).starArr do
    ((((self.ui).starArr)[i]).gameObject):SetActive(false)
  end
end

UINHeroCardItem.__SetPotential = function(self, potential)
  -- function num : 0_11
  local vec = (((self.ui).img_LimitUp).rectTransform).sizeDelta
  vec.x = (self.ui).potentialImgWidth * potential
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (((self.ui).img_LimitUp).rectTransform).sizeDelta = vec
end

UINHeroCardItem.__SetHeroLevel = function(self, levelNum)
  -- function num : 0_12 , upvalues : _ENV
  ((self.ui).obj_TrimTex):SetActive(levelNum < 10)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_Level).text = tostring(levelNum)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UINHeroCardItem.__SetTexture = function(self, path, rawImageGo, callback)
  -- function num : 0_13 , upvalues : _ENV
  local heroData = self.heroData
  ;
  (self.resloader):LoadABAssetAsync(path, function(texture)
    -- function num : 0_13_0 , upvalues : _ENV, self, heroData, rawImageGo, callback
    if IsNull(self.transform) then
      return 
    end
    if heroData ~= self.heroData then
      return 
    end
    rawImageGo.texture = texture
    rawImageGo.enabled = true
    if callback ~= nil then
      callback()
    end
  end
)
end

UINHeroCardItem.OnDelete = function(self)
  -- function num : 0_14 , upvalues : base
  self.resloader = nil
  ;
  (base.OnDelete)(self)
end

return UINHeroCardItem

