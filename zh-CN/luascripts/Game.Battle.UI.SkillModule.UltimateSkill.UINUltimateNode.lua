-- params : ...
-- function num : 0 , upvalues : _ENV
local UINUltimateNode = class("UINUltimateNode", UIBaseNode)
local base = UIBaseNode
local UINUltSkillHeroItem = require("Game.Battle.UI.SkillModule.UltimateSkill.UINUltSkillHeroItem")
local UINUltSkillMpParticleItem = require("Game.Battle.UI.SkillModule.UltimateSkill.UINUltSkillMpParticleItem")
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType
local CS_DOTween = ((CS.DG).Tweening).DOTween
local ProgressAnimSpeed = 1.5
local MaskRadiusMax = 1
local MaskRadius = 0.3
UINUltimateNode.ctor = function(self, resloader)
  -- function num : 0_0
  self.resloader = resloader
end

UINUltimateNode.OnInit = function(self)
  -- function num : 0_1 , upvalues : _ENV, UINUltSkillHeroItem, UINUltSkillMpParticleItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_videoRenderer, self, self.OnClickVideo)
  self.__OnHeroItemClicked = BindCallback(self, self.OnHeroItemClicked)
  self.__ShowSkillInfo = BindCallback(self, self.ShowSkillInfo)
  self.__HideSkillInfo = BindCallback(self, self.HideSkillInfo)
  self.__OnRecycleMpParticle = BindCallback(self, self.__RecycleMpParticle)
  ;
  ((self.ui).heroHeadItem):SetActive(false)
  self.heroItemPool = (UIItemPool.New)(UINUltSkillHeroItem, (self.ui).heroHeadItem)
  ;
  ((self.ui).mpParticleItem):SetActive(false)
  self.mpParticleItem = (UIItemPool.New)(UINUltSkillMpParticleItem, (self.ui).mpParticleItem)
  -- DECOMPILER ERROR at PC58: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).focusMask).enabled = false
  self.maskMaterial = (((CS.UnityEngine).Object).Instantiate)((self.ui).mat_maskFoucus)
  -- DECOMPILER ERROR at PC70: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).focusMask).material = self.maskMaterial
  -- DECOMPILER ERROR at PC73: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).videoRenderer).enabled = false
  self.__skillFillAmount = 0
  self.__skillEfficent = (ConfigData.game_config).ultMpEfficent / (ConfigData.game_config).ultMpMaxEfficent
end

UINUltimateNode.InitBattlePlayerUltSkill = function(self, battleSkillList, useSkillFunc, stopVideoFunc)
  -- function num : 0_2
  self.useSkillFunc = useSkillFunc
  self.stopVideoFunc = stopVideoFunc
  self:CreateUltSkillHero(battleSkillList)
end

UINUltimateNode.CreateUltSkillHero = function(self, battleSkillList)
  -- function num : 0_3
  self.hasUltSkill = false
  self.heroItemDic = {}
  ;
  (self.heroItemPool):HideAll()
  local index = 0
  for i = 0, battleSkillList.Count - 1 do
    local battleSkill = battleSkillList[i]
    if battleSkill ~= nil then
      self:AddHeroUltSkill(battleSkill, index)
      index = index + 1
      if not self.hasUltSkill then
        self.hasUltSkill = true
      end
    end
  end
end

UINUltimateNode.OnHeroItemClicked = function(self, battleSkill)
  -- function num : 0_4
  if self.useSkillFunc ~= nil then
    (self.useSkillFunc)(battleSkill)
  end
end

UINUltimateNode.OnClickVideo = function(self)
  -- function num : 0_5
  if self.stopVideoFunc ~= nil then
    (self.stopVideoFunc)()
  end
end

UINUltimateNode.ShowSkillInfo = function(self, item, battleSkill)
  -- function num : 0_6 , upvalues : _ENV, HAType, VAType
  local win = UIManager:ShowWindow(UIWindowTypeID.FloatingFrame)
  win:SetTitleAndContext(battleSkill.name, (battleSkill.skillCfg):GetLevelDescribe(battleSkill.level))
  win:FloatTo(item.transform, HAType.right, VAType.up)
end

UINUltimateNode.HideSkillInfo = function(self)
  -- function num : 0_7 , upvalues : _ENV
  UIManager:HideWindow(UIWindowTypeID.FloatingFrame)
end

UINUltimateNode.AddHeroUltSkill = function(self, battleSkill, index)
  -- function num : 0_8 , upvalues : _ENV
  local heroItem = (self.heroItemPool):GetOne()
  heroItem:InitUltSkillHeroItem(battleSkill, self.resloader, self.__OnHeroItemClicked, index, (self.ui).efx_offsetZ)
  heroItem:SetShowUltSkillInfoFunc(self.__ShowSkillInfo, self.__HideSkillInfo)
  local heroId = (battleSkill.maker).roleDataId
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R5 in 'UnsetPending'

  if (self.heroItemDic)[heroId] == nil then
    (self.heroItemDic)[heroId] = heroItem
  else
    error((string.format)("为英雄%d配置了多个必杀技，请检查配置表。", heroId))
  end
  if self.__highlightIntensity ~= nil then
    heroItem:UltSkillUsable(self.__useEnable, self.__highlightIntensity)
  end
end

UINUltimateNode.DisableHeroUltSkill = function(self, heroId, disable)
  -- function num : 0_9
  self.__useEnable = not disable
  local heroItem = (self.heroItemDic)[heroId]
  if heroItem ~= nil then
    heroItem:DisableUltSkillHeroItem(disable)
  end
  local isAllDisable = self:CheckAllHeroItemDisable()
  if isAllDisable and self.__tweenLeft then
    ((self.ui).tweenLeft):DOPlayBackwards()
    self.__tweenLeft = false
  end
end

UINUltimateNode.CheckAllHeroItemDisable = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local isAllDisable = true
  for k,v in pairs(self.heroItemDic) do
    if v ~= nil and not v:IsHeroItemDisabled() then
      isAllDisable = false
      break
    end
  end
  do
    return isAllDisable
  end
end

UINUltimateNode.UpdateUltSkill = function(self, useEnable, curRatio, nextRatio, factor, interpolation)
  -- function num : 0_11 , upvalues : _ENV, ProgressAnimSpeed
  local fillAount = (Mathf.Lerp)(self.__skillFillAmount, nextRatio, interpolation * ProgressAnimSpeed)
  self:RefreshUltMpFillAmount(fillAount)
  self:RefreshUltSkillHero(useEnable, ((self.ui).img_AdvValue).fillAmount)
  self:RefreshUltMpSpeed(factor, true)
end

UINUltimateNode.UpdateUltSkillForce = function(self, useEnable, curRatio, factor)
  -- function num : 0_12
  self:RefreshUltMpFillAmount(curRatio)
  self:RefreshUltSkillHero(useEnable, ((self.ui).img_AdvValue).fillAmount)
  self:RefreshUltMpSpeed(factor, false)
end

UINUltimateNode.RefreshUltSkillHero = function(self, useEnable, fillAount)
  -- function num : 0_13 , upvalues : _ENV
  self.__useEnable = useEnable
  if self.__useEnable and self.hasUltSkill then
    local efcMentioned = false
    if not self.__tweenLeft and not self:CheckAllHeroItemDisable() then
      ((self.ui).tweenLeft):DOPlayForward()
      self.__tweenLeft = true
      efcMentioned = true
    end
    local intensity = (fillAount - 0.1) / 0.9
    if self.__highlightIntensity ~= intensity or efcMentioned then
      self.__highlightIntensity = intensity
      for k,heroItem in pairs(self.heroItemDic) do
        heroItem:UltSkillUsable(true, intensity)
        if efcMentioned then
          heroItem:ShowEfcMetioned()
        end
      end
    end
  else
    do
      if self.__tweenLeft then
        ((self.ui).tweenLeft):DOPlayBackwards()
        self.__tweenLeft = false
      end
      for k,heroItem in pairs(self.heroItemDic) do
        heroItem:UltSkillUsable(false)
      end
    end
  end
end

UINUltimateNode.RefreshUltMpFillAmount = function(self, fillAount)
  -- function num : 0_14 , upvalues : _ENV
  self.__skillFillAmount = fillAount
  local efficent = self.__skillEfficent
  local invalidFillAmount = (math.min)(fillAount / efficent, 1)
  local validFillAmount = (math.min)((math.max)(fillAount - efficent, 0) / (1 - efficent), 1)
  if ((self.ui).img_Value).fillAmount < 1 and invalidFillAmount == 1 then
    AudioManager:PlayAudioById(1005)
  end
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).img_Value).fillAmount = invalidFillAmount
  if ((self.ui).img_AdvValue).fillAmount < 1 and validFillAmount == 1 then
    AudioManager:PlayAudioById(1006)
  end
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).img_AdvValue).fillAmount = validFillAmount
  local posY = 0
  if invalidFillAmount >= 1 then
    posY = ((((self.ui).img_Value).transform).rect).height * (validFillAmount - 0.5)
  else
    posY = ((((self.ui).img_Value).transform).rect).height * (invalidFillAmount - 0.5)
  end
  -- DECOMPILER ERROR at PC71: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).progressPoint).anchoredPosition = (Vector2.New)(0, posY)
end

UINUltimateNode.RefreshUltMpSpeed = function(self, speed, withTween)
  -- function num : 0_15 , upvalues : _ENV
  if self.__ultMpSpeed == speed then
    return 
  end
  self.__ultMpSpeed = speed
  local speedStr = nil
  if speed >= 10 then
    speedStr = tostring((math.floor)(speed))
  else
    speedStr = (string.format)("%.1f", speed)
  end
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_Speed).text = speedStr
  local clampSpeed = (math.min)(speed, 10)
  local posY = ((((self.ui).speedItem).parent).sizeDelta).y * (clampSpeed - 1) / 9
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).speedItem).anchoredPosition = (Vector2.New)(0, posY)
  if withTween then
    local value = clampSpeed / 10
    local endValue = (Vector3.New)(value, value, value)
    -- DECOMPILER ERROR at PC57: Confused about usage of register: R8 in 'UnsetPending'

    ;
    ((self.ui).tweenSpeed).endValueV3 = endValue
    ;
    ((self.ui).tweenSpeed):DORestart()
  end
end

UINUltimateNode.CreateMpParticle = function(self, startPos, ratio)
  -- function num : 0_16 , upvalues : _ENV
  if ratio == 0 then
    return 
  end
  local mpPartItem = (self.mpParticleItem):GetOne()
  local endPos = UIManager:World2UIPosition(((self.ui).progressPoint).position, nil, nil, UIManager.UICamera)
  mpPartItem:InitUltSkillMpParticle(startPos, endPos, ratio, self.__OnRecycleMpParticle)
end

UINUltimateNode.__RecycleMpParticle = function(self, mpPartItem)
  -- function num : 0_17
  (self.mpParticleItem):HideOne(mpPartItem)
end

UINUltimateNode.ShowUltSkillFocusMask = function(self, show)
  -- function num : 0_18 , upvalues : MaskRadiusMax, CS_DOTween, MaskRadius
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  if show then
    ((self.ui).focusMask).enabled = true
    ;
    (self.maskMaterial):SetFloat("_Radius", MaskRadiusMax)
    local startRadius = (self.maskMaterial):GetFloat("_Radius")
    do
      (CS_DOTween.To)(function()
    -- function num : 0_18_0 , upvalues : startRadius
    return startRadius
  end
, function(x)
    -- function num : 0_18_1 , upvalues : self
    (self.maskMaterial):SetFloat("_Radius", x)
  end
, MaskRadius, 0.7)
    end
  else
    do
      -- DECOMPILER ERROR at PC24: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((self.ui).focusMask).enabled = false
    end
  end
end

UINUltimateNode.UpdateUltSkillFocusMask = function(self, screenPos)
  -- function num : 0_19 , upvalues : _ENV
  (self.maskMaterial):SetVector("_Item", (Vector4.New)(screenPos.x, screenPos.y, 0, 0))
end

UINUltimateNode.GetUltSkillMovieRenderer = function(self)
  -- function num : 0_20
  return (self.ui).videoRenderer
end

UINUltimateNode.ChangeUltSkillUIOrder = function(self, change)
  -- function num : 0_21
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  if change then
    ((self.ui).canvas_heroList).overrideSorting = true
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).canvas_progress).overrideSorting = true
    ;
    ((self.ui).tween_progress):DORestart()
  else
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).canvas_heroList).overrideSorting = false
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).canvas_progress).overrideSorting = false
    ;
    ((self.ui).tween_progress):DORewind()
  end
end

UINUltimateNode.OnDelete = function(self)
  -- function num : 0_22 , upvalues : _ENV, base
  if self.maskMaterial ~= nil then
    DestroyUnityObject(self.maskMaterial)
    self.maskMaterial = nil
  end
  self:ShowUltSkillFocusMask(false)
  ;
  (base.OnDelete)(self)
end

return UINUltimateNode

