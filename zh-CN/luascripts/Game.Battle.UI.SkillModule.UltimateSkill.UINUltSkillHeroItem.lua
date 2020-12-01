-- params : ...
-- function num : 0 , upvalues : _ENV
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
  self.headItem = (UINHeroHeadItem.New)()
  ;
  (self.headItem):Init((self.ui).heroHeadItem)
  if (self.ui).fxp_metioned ~= nil then
    self.__MentionEffectCompleted = BindCallback(self, self.MentionEffectCompleted)
    ;
    ((self.ui).fxp_metioned):InitEffectCommon(self.__MentionEffectCompleted, ((self.ui).fxp_metioned).name)
  end
end

UINUltSkillHeroItem.InitUltSkillHeroItem = function(self, battleSkill, resloader, clickFunc, itemIndex, offsetZ)
  -- function num : 0_1 , upvalues : _ENV
  self:SetEfxPos(itemIndex, offsetZ)
  self.battleSkill = battleSkill
  self.clickFunc = clickFunc
  local heroData = ((battleSkill.maker).character).heroData
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (self.gameObject).name = tostring(heroData.dataId)
  ;
  (self.headItem):InitHeroHeadItem(heroData, resloader)
  self:HideEffect()
end

UINUltSkillHeroItem.SetShowUltSkillInfoFunc = function(self, showSkillInfoFunc, hideSkillInfoFunc)
  -- function num : 0_2
  self.showSkillInfoFunc = showSkillInfoFunc
  self.hideSkillInfoFunc = hideSkillInfoFunc
end

UINUltSkillHeroItem.__OnClick = function(self)
  -- function num : 0_3
  if self.__disable then
    return 
  end
  if self.clickFunc ~= nil then
    (self.clickFunc)(self.battleSkill)
  end
end

UINUltSkillHeroItem.__OnLongPress = function(self)
  -- function num : 0_4
  if self.showSkillInfoFunc ~= nil then
    (self.showSkillInfoFunc)(self, self.battleSkill)
  end
end

UINUltSkillHeroItem.__OnPressUp = function(self)
  -- function num : 0_5
  if self.hideSkillInfoFunc ~= nil then
    (self.hideSkillInfoFunc)()
  end
end

UINUltSkillHeroItem.UltSkillUsable = function(self, usable, intensity)
  -- function num : 0_6
  self.__usable = usable
  if self.__disable then
    usable = false
  end
  ;
  (self.headItem):TransparentHeroHeadItem(not usable)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).highlight).enabled = usable
  if usable then
    local color = ((self.ui).highlight).color
    color.a = intensity
    self:AdjustEffect(intensity)
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).highlight).color = color
  else
    do
      self:HideEffect()
    end
  end
end

UINUltSkillHeroItem.TweenLeft = function(self, isLeft)
  -- function num : 0_7
  if isLeft then
    ((self.ui).tweenLeft):DOPlayForward()
  else
    ;
    ((self.ui).tweenLeft):DOPlayBackwards()
  end
end

UINUltSkillHeroItem.SetEfxPos = function(self, index, offsetZ)
  -- function num : 0_8
  local posZ = offsetZ.x - index * offsetZ.y
  self:__ChangeSingleEfxPosZ(((self.ui).fxp_metioned).transform, posZ)
  self:__ChangeSingleEfxPosZ(((self.ui).fxp_lvl1).transform, posZ)
  self:__ChangeSingleEfxPosZ(((self.ui).fxp_lvl2).transform, posZ)
end

UINUltSkillHeroItem.__ChangeSingleEfxPosZ = function(self, trans, posZ)
  -- function num : 0_9 , upvalues : _ENV
  trans.localPosition = (Vector3.New)(((((self.ui).fxp_metioned).transform).localPosition).x, ((((self.ui).fxp_metioned).transform).localPosition).y, posZ)
end

UINUltSkillHeroItem.ShowEfcMetioned = function(self)
  -- function num : 0_10
  if (self.ui).fxp_metioned ~= nil and not self.__disable then
    ((self.ui).fxp_metioned):PlayWithoutPos()
  end
end

UINUltSkillHeroItem.MentionEffectCompleted = function(self, effect)
  -- function num : 0_11
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
  -- function num : 0_12
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
  -- function num : 0_13
  if (self.ui).fxp_lvl1 ~= nil and ((self.ui).fxp_lvl1).activeSelf then
    ((self.ui).fxp_lvl1):SetActive(false)
  end
  if (self.ui).fxp_lvl2 ~= nil and ((self.ui).fxp_lvl2).activeSelf then
    ((self.ui).fxp_lvl2):SetActive(false)
  end
end

UINUltSkillHeroItem.IsHeroItemDisabled = function(self)
  -- function num : 0_14
  return self.__disable
end

UINUltSkillHeroItem.DisableUltSkillHeroItem = function(self, disable)
  -- function num : 0_15
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
      self:AdjustEffect((((self.ui).hilight).color).a)
    end
  end
end

UINUltSkillHeroItem.OnDelete = function(self)
  -- function num : 0_16 , upvalues : base
  (self.headItem):Delete()
  ;
  (base.OnDelete)(self)
end

return UINUltSkillHeroItem

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINUltSkillHeroItem = class("UINUltSkillHeroItem", UIBaseNode)
local base = UIBaseNode
local UINHeroHeadItem = require("Game.CommonUI.Hero.UINHeroHeadItem")
UINUltSkillHeroItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, UINHeroHeadItem
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (((self.ui).btnPlus_Root).onClick):AddListener(
        BindCallback(self, self.__OnClick));
    (((self.ui).btnPlus_Root).onPress):AddListener(
        BindCallback(self, self.__OnLongPress));
    (((self.ui).btnPlus_Root).onPressUp):AddListener(
        BindCallback(self, self.__OnPressUp))
    self.headItem = (UINHeroHeadItem.New)();
    (self.headItem):Init((self.ui).heroHeadItem)
    if (self.ui).fxp_metioned ~= nil then
        self.__MentionEffectCompleted = BindCallback(self,
                                                     self.MentionEffectCompleted);
        ((self.ui).fxp_metioned):InitEffectCommon(self.__MentionEffectCompleted,
                                                  ((self.ui).fxp_metioned).name)
    end
end

UINUltSkillHeroItem.InitUltSkillHeroItem =
    function(self, battleSkill, resloader, clickFunc, itemIndex, offsetZ)
        -- function num : 0_1 , upvalues : _ENV
        self:SetEfxPos(itemIndex, offsetZ)
        self.battleSkill = battleSkill
        self.clickFunc = clickFunc
        local heroData = ((battleSkill.maker).character).heroData -- DECOMPILER ERROR at PC13: Confused about usage of register: R7 in 'UnsetPending'
        ;
        (self.gameObject).name = tostring(heroData.dataId);
        (self.headItem):InitHeroHeadItem(heroData, resloader)
        self:HideEffect()
    end

UINUltSkillHeroItem.SetShowUltSkillInfoFunc =
    function(self, showSkillInfoFunc, hideSkillInfoFunc)
        -- function num : 0_2
        self.showSkillInfoFunc = showSkillInfoFunc
        self.hideSkillInfoFunc = hideSkillInfoFunc
    end

UINUltSkillHeroItem.__OnClick = function(self)
    -- function num : 0_3
    if self.__disable then return end
    if self.clickFunc ~= nil then (self.clickFunc)(self.battleSkill) end
end

UINUltSkillHeroItem.__OnLongPress = function(self)
    -- function num : 0_4
    if self.showSkillInfoFunc ~= nil then
        (self.showSkillInfoFunc)(self, self.battleSkill)
    end
end

UINUltSkillHeroItem.__OnPressUp = function(self)
    -- function num : 0_5
    if self.hideSkillInfoFunc ~= nil then (self.hideSkillInfoFunc)() end
end

UINUltSkillHeroItem.UltSkillUsable = function(self, usable, intensity)
    -- function num : 0_6
    self.__usable = usable
    if self.__disable then usable = false end
    (self.headItem):TransparentHeroHeadItem(not usable) -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'
    ;
    ((self.ui).highlight).enabled = usable
    if usable then
        local color = ((self.ui).highlight).color
        color.a = intensity
        self:AdjustEffect(intensity) -- DECOMPILER ERROR at PC23: Confused about usage of register: R4 in 'UnsetPending'
        ;
        ((self.ui).highlight).color = color
    else
        do self:HideEffect() end
    end
end

UINUltSkillHeroItem.TweenLeft = function(self, isLeft)
    -- function num : 0_7
    if isLeft then
        ((self.ui).tweenLeft):DOPlayForward()
    else

        ((self.ui).tweenLeft):DOPlayBackwards()
    end
end

UINUltSkillHeroItem.SetEfxPos = function(self, index, offsetZ)
    -- function num : 0_8
    local posZ = offsetZ.x - index * offsetZ.y
    self:__ChangeSingleEfxPosZ(((self.ui).fxp_metioned).transform, posZ)
    self:__ChangeSingleEfxPosZ(((self.ui).fxp_lvl1).transform, posZ)
    self:__ChangeSingleEfxPosZ(((self.ui).fxp_lvl2).transform, posZ)
end

UINUltSkillHeroItem.__ChangeSingleEfxPosZ =
    function(self, trans, posZ)
        -- function num : 0_9 , upvalues : _ENV
        trans.localPosition = (Vector3.New)(
                                  ((((self.ui).fxp_metioned).transform).localPosition).x,
                                  ((((self.ui).fxp_metioned).transform).localPosition).y,
                                  posZ)
    end

UINUltSkillHeroItem.ShowEfcMetioned = function(self)
    -- function num : 0_10
    if (self.ui).fxp_metioned ~= nil and not self.__disable then
        ((self.ui).fxp_metioned):PlayWithoutPos()
    end
end

UINUltSkillHeroItem.MentionEffectCompleted =
    function(self, effect)
        -- function num : 0_11
        if not self.__disable then
            local intensity = ((self.ui).highlight).color
            if intensity.a >= 0.9 then
                if (self.ui).fxp_lvl1 ~= nil and ((self.ui).fxp_lvl1).activeSelf then
                    ((self.ui).fxp_lvl1):SetActive(false)
                end
                if (self.ui).fxp_lvl2 ~= nil and
                    not ((self.ui).fxp_lvl2).activeSelf then
                    ((self.ui).fxp_lvl2):SetActive(true)
                end
            else
                if (self.ui).fxp_lvl1 ~= nil and
                    not ((self.ui).fxp_lvl1).activeSelf then
                    ((self.ui).fxp_lvl1):SetActive(true)
                end
                if (self.ui).fxp_lvl2 ~= nil and ((self.ui).fxp_lvl2).activeSelf then
                    ((self.ui).fxp_lvl2):SetActive(false)
                end
            end
        end
    end

UINUltSkillHeroItem.AdjustEffect = function(self, intensity)
    -- function num : 0_12
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
    -- function num : 0_13
    if (self.ui).fxp_lvl1 ~= nil and ((self.ui).fxp_lvl1).activeSelf then
        ((self.ui).fxp_lvl1):SetActive(false)
    end
    if (self.ui).fxp_lvl2 ~= nil and ((self.ui).fxp_lvl2).activeSelf then
        ((self.ui).fxp_lvl2):SetActive(false)
    end
end

UINUltSkillHeroItem.IsHeroItemDisabled =
    function(self)
        -- function num : 0_14
        return self.__disable
    end

UINUltSkillHeroItem.DisableUltSkillHeroItem =
    function(self, disable)
        -- function num : 0_15
        self.__disable = disable
        if disable then
            (self.headItem):TransparentHeroHeadItem(true) -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'
            ;
            ((self.ui).highlight).enabled = false
            self:HideEffect()
        else

            (self.headItem):TransparentHeroHeadItem(not self.__usable) -- DECOMPILER ERROR at PC21: Confused about usage of register: R2 in 'UnsetPending'
            ;
            ((self.ui).highlight).enabled = self.__usable
            if self.__usable then
                self:AdjustEffect((((self.ui).hilight).color).a)
            end
        end
    end

UINUltSkillHeroItem.OnDelete = function(self)
    -- function num : 0_16 , upvalues : base
    (self.headItem):Delete();
    (base.OnDelete)(self)
end

return UINUltSkillHeroItem

