local UINUltSkillHeroItem = class("UINUltSkillHeroItem", UIBaseNode)
local base = UIBaseNode
local UINHeroHeadItem = require("Game.CommonUI.Hero.UINHeroHeadItem")
UINUltSkillHeroItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINHeroHeadItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (((self.ui).btnPlus_Root).onClick):AddListener(BindCallback(self, self.__OnClick))
  ;
  (((self.ui).btnPlus_Root).onPress):AddListener(BindCallback(self, self.__OnLongPress))
  ;
  (((self.ui).btnPlus_Root).onPressUp):AddListener(BindCallback(self, self.__OnPressUp))
  if self.headItem == nil then
    self.headItem = (UINHeroHeadItem.New)()
  end
  ;
  (self.headItem):Init((self.ui).heroHeadItem)
  if (self.ui).fxp_metioned ~= nil then
    self.__MentionEffectCompleted = BindCallback(self, self.MentionEffectCompleted)
    ;
    ((self.ui).fxp_metioned):InitEffectCommon(self.__MentionEffectCompleted, ((self.ui).fxp_metioned).name)
  end
end

UINUltSkillHeroItem.InitUltSkillHeroItem = function(self, battleSkill, resloader, clickFunc, itemIndex, offsetZ, heroData)
  -- function num : 0_1
  self:SetEfxPos(itemIndex, offsetZ)
  self.battleSkill = battleSkill
  self.clickFunc = clickFunc
  self.isSkillNoCD = battleSkill.totalCDTime == 0
  self._hasUltSkill = true
  self.__disable = false
  self.__inUltSkillCd = false
  self:_InitHeadItem(heroData, resloader)
  self:HideEffect()
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UINUltSkillHeroItem.InitHeroHeadItem = function(self, heroData, resloader)
  -- function num : 0_2
  self._hasUltSkill = false
  self:_InitHeadItem(heroData, resloader)
end

UINUltSkillHeroItem._InitHeadItem = function(self, heroData, resloader)
  -- function num : 0_3 , upvalues : _ENV
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R3 in 'UnsetPending'

  (self.gameObject).name = tostring(heroData.dataId)
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).img_CD).enabled = false
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).highlight).enabled = false
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).img_HasUltimate).enabled = self._hasUltSkill or false
  ;
  (self.headItem):InitHeroHeadItem(heroData, resloader)
end

UINUltSkillHeroItem.SetShowUltSkillInfoFunc = function(self, showSkillInfoFunc, hideSkillInfoFunc)
  -- function num : 0_4
  self.showSkillInfoFunc = showSkillInfoFunc
  self.hideSkillInfoFunc = hideSkillInfoFunc
end

UINUltSkillHeroItem.OnUpdateLogic_UltSkillItem = function(self, intensity)
  -- function num : 0_5
  if self.isSkillNoCD then
    return 
  end
  if not self._hasUltSkill then
    return 
  end
  local skill = self.battleSkill
  if skill:IsReadyToTake() and not (skill.maker):IsAbandonUltSkill() and self.__inUltSkillCd then
    self.__inUltSkillCd = false
    -- DECOMPILER ERROR at PC24: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).img_CD).enabled = false
    if self.__usable then
      self:UltSkillUsable(true, intensity)
    end
  end
  if not self.__inUltSkillCd then
    self:UltSkillUsable(false)
    self.__inUltSkillCd = true
    -- DECOMPILER ERROR at PC42: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).img_CD).enabled = true
  end
  self.curCDRatio = (skill.totalCDTime - skill.UICdTime) / skill.totalCDTime
  self.nextCDRatio = (skill.totalCDTime - skill.NextUICdTime) / skill.totalCDTime
  -- DECOMPILER ERROR at PC58: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).img_CD).fillAmount = self.curCDRatio
end

UINUltSkillHeroItem.OnUpdateRender_UltSkillItem = function(self, deltaTime, interpolation)
  -- function num : 0_6 , upvalues : _ENV
  if self.isSkillNoCD then
    return 
  end
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R3 in 'UnsetPending'

  if ((self.ui).img_CD).enabled then
    ((self.ui).img_CD).fillAmount = (Mathf.Lerp)(self.curCDRatio, self.nextCDRatio, interpolation)
  end
end

UINUltSkillHeroItem.__OnClick = function(self)
  -- function num : 0_7
  if self.__disable then
    return 
  end
  if self.clickFunc ~= nil then
    (self.clickFunc)(self.battleSkill)
  end
end

UINUltSkillHeroItem.__OnLongPress = function(self)
  -- function num : 0_8
  if self.showSkillInfoFunc ~= nil then
    (self.showSkillInfoFunc)(self, self.battleSkill)
  end
end

UINUltSkillHeroItem.__OnPressUp = function(self)
  -- function num : 0_9
  if self.hideSkillInfoFunc ~= nil then
    (self.hideSkillInfoFunc)()
  end
end

UINUltSkillHeroItem.UltSkillUsable = function(self, usable, intensity)
  -- function num : 0_10
  if self.battleSkill ~= nil and (self.battleSkill).maker ~= nil and ((self.battleSkill).maker):IsAbandonUltSkill() then
    usable = false
  end
  self.__usable = usable
  if self.__disable or self.__inUltSkillCd then
    usable = false
  end
  ;
  (self.headItem):TransparentHeroHeadItem(not usable)
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).highlight).enabled = usable
  if usable then
    local color = ((self.ui).highlight).color
    color.a = intensity
    self:AdjustEffect(intensity)
    -- DECOMPILER ERROR at PC40: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).highlight).color = color
  else
    do
      self:HideEffect()
    end
  end
end

UINUltSkillHeroItem.TweenLeft = function(self, isLeft)
  -- function num : 0_11
  if isLeft then
    ((self.ui).tweenLeft):DOPlayForward()
  else
    ;
    ((self.ui).tweenLeft):DOPlayBackwards()
  end
end

UINUltSkillHeroItem.SetEfxPos = function(self, index, offsetZ)
  -- function num : 0_12
  local posZ = offsetZ.x - index * offsetZ.y
  self:__ChangeSingleEfxPosZ(((self.ui).fxp_metioned).transform, posZ)
  self:__ChangeSingleEfxPosZ(((self.ui).fxp_lvl1).transform, posZ)
  self:__ChangeSingleEfxPosZ(((self.ui).fxp_lvl2).transform, posZ)
end

UINUltSkillHeroItem.__ChangeSingleEfxPosZ = function(self, trans, posZ)
  -- function num : 0_13 , upvalues : _ENV
  trans.localPosition = (Vector3.New)(((((self.ui).fxp_metioned).transform).localPosition).x, ((((self.ui).fxp_metioned).transform).localPosition).y, posZ)
end

UINUltSkillHeroItem.ShowEfcMetioned = function(self)
  -- function num : 0_14
  if (self.ui).fxp_metioned ~= nil and not self.__disable then
    ((self.ui).fxp_metioned):PlayWithoutPos()
  end
end

UINUltSkillHeroItem.MentionEffectCompleted = function(self, effect)
  -- function num : 0_15
  if not self.__disable then
    local intensity = ((self.ui).highlight).color
    if intensity.a >= 0.9 then
      if (self.ui).fxp_lvl1 ~= nil and ((self.ui).fxp_lvl1).activeSelf then
        ((self.ui).fxp_lvl1):SetActive(false)
      end
      if (self.ui).fxp_lvl2 ~= nil and not ((self.ui).fxp_lvl2).activeSelf then
        ((self.ui).fxp_lvl2):SetActive(true)
      end
    else
      if (self.ui).fxp_lvl1 ~= nil and not ((self.ui).fxp_lvl1).activeSelf then
        ((self.ui).fxp_lvl1):SetActive(true)
      end
      if (self.ui).fxp_lvl2 ~= nil and ((self.ui).fxp_lvl2).activeSelf then
        ((self.ui).fxp_lvl2):SetActive(false)
      end
    end
  end
end

UINUltSkillHeroItem.AdjustEffect = function(self, intensity)
  -- function num : 0_16
  if not self.__disable then
    if intensity >= 1 then
      if (self.ui).fxp_lvl1 ~= nil and ((self.ui).fxp_lvl1).activeSelf then
        ((self.ui).fxp_lvl1):SetActive(false)
      end
      if (self.ui).fxp_lvl2 ~= nil and not ((self.ui).fxp_lvl2).activeSelf then
        ((self.ui).fxp_lvl2):SetActive(true)
      end
    else
      if (self.ui).fxp_lvl1 ~= nil and not ((self.ui).fxp_lvl1).activeSelf then
        ((self.ui).fxp_lvl1):SetActive(true)
      end
      if (self.ui).fxp_lvl2 ~= nil and ((self.ui).fxp_lvl2).activeSelf then
        ((self.ui).fxp_lvl2):SetActive(false)
      end
    end
  end
end

UINUltSkillHeroItem.HideEffect = function(self)
  -- function num : 0_17
  if (self.ui).fxp_lvl1 ~= nil and ((self.ui).fxp_lvl1).activeSelf then
    ((self.ui).fxp_lvl1):SetActive(false)
  end
  if (self.ui).fxp_lvl2 ~= nil and ((self.ui).fxp_lvl2).activeSelf then
    ((self.ui).fxp_lvl2):SetActive(false)
  end
end

UINUltSkillHeroItem.IsHeroItemDisabled = function(self)
  -- function num : 0_18
  if not self.__disable then
    return self.__inUltSkillCd
  end
end

UINUltSkillHeroItem.DisableUltSkillHeroItem = function(self, disable)
  -- function num : 0_19
  self.__disable = disable
  if disable then
    (self.headItem):TransparentHeroHeadItem(true)
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).highlight).enabled = false
    self:HideEffect()
  else
    ;
    (self.headItem):TransparentHeroHeadItem(not self.__usable)
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).highlight).enabled = self.__usable
    if self.__usable then
      self:AdjustEffect((((self.ui).highlight).color).a)
    end
  end
end

UINUltSkillHeroItem.OnHide = function(self)
  -- function num : 0_20
  self.clickFunc = nil
  self.battleSkill = nil
  self.__disable = false
  self.__inUltSkillCd = false
end

UINUltSkillHeroItem.OnDelete = function(self)
  -- function num : 0_21 , upvalues : base
  (self.headItem):Delete()
  ;
  (base.OnDelete)(self)
end

return UINUltSkillHeroItem

