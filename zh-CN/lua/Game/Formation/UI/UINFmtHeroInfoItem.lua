local UINFmtHeroInfoItem = class("UINFmtHeroInfoItem", UIBaseNode)
local base = UIBaseNode
local UINFmtHeroHpBarItem = require("Game.Formation.UI.UINFmtHeroHpBarItem")
local cs_tweening = (CS.DG).Tweening
UINFmtHeroInfoItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (((self.ui).img_star).gameObject):SetActive(false)
  self.starList = {}
  self.potentialImgWidth = ((((self.ui).img_Limit).sprite).textureRect).width
  ;
  ((self.ui).hPBar):SetActive(false)
end

UINFmtHeroInfoItem.InitFmtHeroInfo = function(self, heroData, uiFmtRoot, isVirtualData)
  -- function num : 0_1
  self.uiFmtRoot = uiFmtRoot
  self.heroData = heroData
  self.isVirtualData = isVirtualData
  self:RefreshFmtheroInfo()
end

UINFmtHeroInfoItem.RefreshFmtheroInfo = function(self)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ((self.ui).img_Career).sprite = CRH:GetSprite(((self.heroData):GetCareerCfg()).icon, CommonAtlasType.CareerCamp)
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = (self.heroData):GetName()
  self:SetFmtHeroInfoItemLv((self.heroData).level)
  for k,v in ipairs(self.starList) do
    (v.gameObject):SetActive(false)
    v:SetIndex(0)
  end
  local star = (self.heroData).star
  local count = (math.ceil)(star / 2)
  local isHalf = star % 2 == 1
  for i = 1, count do
    local star = (self.starList)[i]
    if star == nil then
      star = ((((self.ui).img_star).gameObject):Instantiate()):GetComponent(typeof(CS.UiImageItemInfo))
      ;
      (table.insert)(self.starList, star)
    end
    ;
    (star.gameObject):SetActive(true)
    if isHalf and i == count then
      star:SetIndex(1)
    end
  end
  self:__SetPotential((self.heroData).potential)
  self:RefreshReddotTip()
  self:RefreshLevelTip()
  self:RefreshSupport()
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

UINFmtHeroInfoItem.UpdFmtHeroInfoItemHp = function(self, hpPer)
  -- function num : 0_3 , upvalues : UINFmtHeroHpBarItem, _ENV
  if self.hpBarItem == nil then
    self.hpBarItem = (UINFmtHeroHpBarItem.New)()
    ;
    (self.hpBarItem):Init((self.ui).hPBar)
    ;
    (self.hpBarItem):Show()
  end
  local maxHp = (self.heroData):GetAttr(eHeroAttr.maxHp)
  ;
  (self.hpBarItem):InitFmtHeroHpBarItem(hpPer, maxHp)
end

UINFmtHeroInfoItem.SetFmtHeroInfoItemLv = function(self, level)
  -- function num : 0_4 , upvalues : _ENV
  ((self.ui).tex_HeroLevel):SetIndex(0, tostring(level))
end

UINFmtHeroInfoItem.__SetPotential = function(self, potential)
  -- function num : 0_5
  local vec = (((self.ui).img_Limit).rectTransform).sizeDelta
  vec.x = self.potentialImgWidth * potential
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (((self.ui).img_Limit).rectTransform).sizeDelta = vec
end

UINFmtHeroInfoItem.UpdateFmtHeroInfoPos = function(self, position)
  -- function num : 0_6
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.transform).anchoredPosition = position
end

UINFmtHeroInfoItem.SetChangeMarkState = function(self, flag)
  -- function num : 0_7 , upvalues : _ENV
  if not IsNull((self.ui).tween_CanChange) then
    (((self.ui).tween_CanChange).gameObject):SetActive(flag)
    if flag then
      ((self.ui).tween_CanChange):DORestart()
    else
      ;
      ((self.ui).tween_CanChange):DOPause()
    end
  end
end

UINFmtHeroInfoItem.FmtHeroAblePotential = function(self)
  -- function num : 0_8
  if self.isVirtualData then
    return false
  end
  return self.__heroAblePotential
end

UINFmtHeroInfoItem.RefreshLevelTip = function(self)
  -- function num : 0_9
  self.__heroAblePotential = false
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self.ui).img_CanLevelUp).image).enabled = false
  if self.heroData == nil or self.isVirtualData then
    return 
  end
  if (self.heroData).isFriendSupport or (self.heroData).isFixedFmtHero then
    return 
  end
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R1 in 'UnsetPending'

  if (self.heroData):CanHeroUsePotential() then
    (((self.ui).img_CanLevelUp).image).enabled = true
    ;
    ((self.ui).img_CanLevelUp):SetIndex(1)
    self.__heroAblePotential = true
    return 
  end
  if not (self.heroData):AbleUpLevel() then
    return 
  end
  local canLevelUp, _ = (self.heroData):GenHeroCanQuickLevelUp()
  -- DECOMPILER ERROR at PC51: Confused about usage of register: R3 in 'UnsetPending'

  if canLevelUp then
    (((self.ui).img_CanLevelUp).image).enabled = true
    ;
    ((self.ui).img_CanLevelUp):SetIndex(0)
  end
end

UINFmtHeroInfoItem.RefreshSupport = function(self)
  -- function num : 0_10
  ((self.ui).obj_isSupport):SetActive((self.heroData).isFriendSupport)
end

UINFmtHeroInfoItem.RefreshReddotTip = function(self)
  -- function num : 0_11 , upvalues : _ENV, cs_tweening
  local isShow = false
  do
    if self.heroData ~= nil and not self.isVirtualData then
      local ok, redNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.HeroWindow, (self.heroData).dataId, RedDotStaticTypeId.HeroStarUp)
      if ok and redNode:GetRedDotCount() > 0 then
        isShow = true
      end
    end
    if (self.heroData).isFriendSupport or (self.heroData).isFixedFmtHero then
      isShow = false
    end
    if isShow then
      if self.extraStar == nil then
        self.extraStar = ((((self.ui).img_star).gameObject):Instantiate()):GetComponent(typeof(CS.UiImageItemInfo))
      end
      if (self.heroData):IsHalfStar() then
        local index = 1
        for i = 1, #self.starList do
          if not (((self.starList)[i]).gameObject).activeSelf then
            index = i - 1
            break
          end
          if i == #self.starList then
            index = i
          end
        end
        do
          do
            local parentTr = ((self.starList)[index]).transform
            ;
            ((self.extraStar).transform):SetParent(parentTr)
            -- DECOMPILER ERROR at PC88: Confused about usage of register: R4 in 'UnsetPending'

            ;
            ((self.extraStar).transform).localPosition = Vector3.zero
            ;
            (self.extraStar):SetIndex(0)
            ;
            ((self.extraStar).transform):SetParent((((self.ui).img_star).transform).parent)
            ;
            ((self.extraStar).transform):SetAsLastSibling()
            ;
            (self.extraStar):SetIndex(1)
            if self.extraStarTween ~= nil then
              (self.extraStarTween):Rewind()
              ;
              (self.extraStarTween):Kill()
              self.extraStarTween = nil
            end
            ;
            ((self.extraStar).gameObject):SetActive(true)
            self.extraStarTween = (((self.extraStar).image):DOFade(0.2, 0.5)):SetLoops(-1, (cs_tweening.LoopType).Yoyo)
            if self.extraStarTween ~= nil then
              (self.extraStarTween):Rewind()
              ;
              (self.extraStarTween):Kill()
              self.extraStarTween = nil
            end
            if self.extraStar ~= nil then
              ((self.extraStar).gameObject):SetActive(false)
            end
          end
        end
      end
    end
  end
end

UINFmtHeroInfoItem.OnDelete = function(self)
  -- function num : 0_12 , upvalues : base
  if self.extraStarTween ~= nil then
    (self.extraStarTween):Rewind()
    ;
    (self.extraStarTween):Kill()
    self.extraStarTween = nil
  end
  if self.hpBarItem ~= nil then
    (self.hpBarItem):Delete()
  end
  ;
  (base.OnDelete)(self)
end

return UINFmtHeroInfoItem

