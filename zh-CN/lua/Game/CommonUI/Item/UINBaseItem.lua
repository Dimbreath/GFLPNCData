local UINBaseItem = class("UINBaseItem", UIBaseNode)
local base = UIBaseNode
local GuideEnum = require("Game.Guide.GuideEnum")
UINBaseItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.__IsLoadedGreatLoopFx = false
  self.__GreatLoopFxGo = nil
  self.__IsLoadedGreatBlastFx = false
  self.__GreatBlastFxGo = nil
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Root, self, self.OnClickItemRoot)
  self.defaultQual = ((self.ui).Img_Quality).sprite
  self.defaultQualColor = ((self.ui).img_QualityColor).color
end

UINBaseItem.InitBaseItem = function(self, itemCfg, clickEvent, clickExtrEvent, isHideLoopFx)
  -- function num : 0_1 , upvalues : _ENV
  self.itemCfg = itemCfg
  self.clickEvent = clickEvent
  self.clickExtrEvent = clickExtrEvent
  self.quality = itemCfg.quality
  local sprite = CRH:GetSpriteByItemConfig(itemCfg)
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R6 in 'UnsetPending'

  if itemCfg.type == eItemType.Avatar or itemCfg.type == eItemType.Skin or itemCfg.type == eItemType.AvatarFrame or itemCfg.action_type == eItemActionType.HeroCard then
    ((self.ui).Img_Quality).sprite = self.defaultQual
    -- DECOMPILER ERROR at PC36: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).img_QualityColor).color = self.defaultQualColor
  else
    self:_SetItemQuality(itemCfg)
  end
  -- DECOMPILER ERROR at PC43: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).Img_ItemPic).sprite = sprite
  ;
  ((self.ui).obj_IsFrag):SetActive(false)
  ;
  ((self.ui).obj_isHreo):SetActive(false)
  ;
  (((self.ui).img_isSmallIcon).gameObject):SetActive(false)
  local smallIcon = itemCfg.small_icon
  if itemCfg.action_type == eItemActionType.HeroCardFrag then
    ((self.ui).obj_IsFrag):SetActive(true)
    ;
    ((self.ui).obj_isHreo):SetActive(true)
  else
    if smallIcon ~= "" and smallIcon ~= nil then
      ((self.ui).obj_IsFrag):SetActive(true)
      ;
      (((self.ui).img_isSmallIcon).gameObject):SetActive(true)
      -- DECOMPILER ERROR at PC98: Confused about usage of register: R7 in 'UnsetPending'

      ;
      ((self.ui).img_isSmallIcon).sprite = CRH:GetSprite(smallIcon)
    end
  end
  -- DECOMPILER ERROR at PC107: Confused about usage of register: R7 in 'UnsetPending'

  if itemCfg.small_icon_type then
    ((self.ui).img_isSmallIcon).color = ItemQualityColor[itemCfg.quality]
  else
    -- DECOMPILER ERROR at PC113: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self.ui).img_isSmallIcon).color = Color.white
  end
  self:CloseGreatRewardLoopFx()
  local isGreatItem = ((ConfigData.game_config).itemWithGreatFxDic)[itemCfg.id]
  if isGreatItem and not isHideLoopFx then
    if not self.__IsLoadedGreatLoopFx then
      self:LoadGetGreatRewardLoopFx()
    else
      ;
      (self.__GreatLoopFxGo):SetActive(true)
    end
  end
end

UINBaseItem.SetNotNeedAnyJump = function(self, bool)
  -- function num : 0_2
  self.notNeedAnyJump = bool
end

UINBaseItem.OnClickItemRoot = function(self)
  -- function num : 0_3 , upvalues : _ENV, GuideEnum
  if self.clickEvent ~= nil then
    (self.clickEvent)(self.itemCfg)
  else
    if GuideManager.inGuide and not GuideManager:HasGuideFeature((GuideEnum.GuideFeature).ItemDetail) then
      return 
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(win)
    -- function num : 0_3_0 , upvalues : self
    if win ~= nil then
      win:SetNotNeedAnyJump(self.notNeedAnyJump)
      win:InitCommonItemDetail(self.itemCfg)
    end
  end
)
  end
  if self.clickExtrEvent ~= nil then
    (self.clickExtrEvent)(self.itemCfg)
  end
end

UINBaseItem._SetItemQuality = function(self, itemCfg)
  -- function num : 0_4 , upvalues : _ENV
  if itemCfg.heroId ~= nil and itemCfg.type == eItemType.HeroCard then
    local heroCfg = (ConfigData.hero_data)[itemCfg.heroId]
    local rare = ((ConfigData.hero_rank)[heroCfg.rank]).rare
    self.quality = eHeroRareToQaulity[rare]
  end
  do
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).Img_Quality).sprite = CRH:GetSprite(ItemQualitySprite[self.quality], CommonAtlasType.BaseItemQuailty)
    -- DECOMPILER ERROR at PC36: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).img_QualityColor).color = ItemQualityColor[self.quality]
  end
end

UINBaseItem.SetPressCallback = function(self, pressEvent, responseOnceByPress)
  -- function num : 0_5
  self.pressEvent = pressEvent
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).btn_Root).responseOnceByPress = responseOnceByPress
  ;
  (((self.ui).btn_Root).onPressUp):AddListener(function()
    -- function num : 0_5_0 , upvalues : self
    (self.pressEvent)(self.itemCfg, false)
  end
)
  ;
  (((self.ui).btn_Root).onPress):AddListener(function()
    -- function num : 0_5_1 , upvalues : self
    (self.pressEvent)(self.itemCfg, true)
  end
)
end

UINBaseItem.GetQuality = function(self)
  -- function num : 0_6
  return self.quality
end

UINBaseItem.LoadGetRewardFx = function(self, resloader, xRotate)
  -- function num : 0_7 , upvalues : _ENV
  local path = ItemEffPatch[(self.itemCfg).quality]
  resloader:LoadABAssetAsync(path, function(prefab)
    -- function num : 0_7_0 , upvalues : _ENV, self, xRotate
    if IsNull(prefab) or self.__stop or IsNull(self.transform) then
      return 
    end
    local go = prefab:Instantiate(self.transform)
    local particleSystem = go:GetComponentInChildren(typeof((CS.UnityEngine).ParticleSystem))
    local usIParticle = go:GetComponentInChildren(typeof(((CS.Coffee).UIExtensions).UIParticle))
    particleSystem:Stop()
    ;
    (go.transform):Rotate((Vector3.New)(xRotate or 0, 0, 0))
    particleSystem:Play()
  end
)
end

UINBaseItem.LoadGetGreatRewardFx = function(self, resloader, xRotate)
  -- function num : 0_8 , upvalues : _ENV
  if self.__IsLoadedGreatLoopFx then
    (self.__GreatLoopFxGo):SetActive(false)
  end
  if self.__IsLoadedGreatBlastFx then
    (self.__GreatBlastFxGo):SetActive(true)
  end
  local path = ItemEffPatch.greetBlastThenLoop
  resloader:LoadABAssetAsync(path, function(prefab)
    -- function num : 0_8_0 , upvalues : _ENV, self, xRotate
    if IsNull(prefab) or self.__stop or IsNull(self.transform) then
      return 
    end
    local go = prefab:Instantiate(self.transform)
    local particleSystem = go:GetComponentInChildren(typeof((CS.UnityEngine).ParticleSystem))
    local usIParticle = go:GetComponentInChildren(typeof(((CS.Coffee).UIExtensions).UIParticle))
    particleSystem:Stop()
    ;
    (go.transform):Rotate((Vector3.New)(xRotate or 0, 0, 0))
    particleSystem:Play()
    self.__IsLoadedGreatBlastFx = true
    self.__GreatBlastFxGo = go
  end
)
end

UINBaseItem.LoadGetGreatRewardLoopFx = function(self, xRotate)
  -- function num : 0_9 , upvalues : _ENV
  if not (self.ui).isNeedGreatFX then
    return 
  end
  local prefab = (CRH:GetBaseItemFx()).greetLoop
  if IsNull(prefab) or self.__stop or IsNull(self.transform) then
    return 
  end
  local go = prefab:Instantiate(self.transform)
  local particleSystem = go:GetComponentInChildren(typeof((CS.UnityEngine).ParticleSystem))
  local usIParticle = go:GetComponentInChildren(typeof(((CS.Coffee).UIExtensions).UIParticle))
  particleSystem:Stop()
  ;
  (go.transform):Rotate((Vector3.New)(xRotate or 0, 0, 0))
  particleSystem:Play()
  self.__IsLoadedGreatLoopFx = true
  self.__GreatLoopFxGo = go
end

UINBaseItem.CloseGreatRewardLoopFx = function(self)
  -- function num : 0_10
  if self.__IsLoadedGreatLoopFx then
    (self.__GreatLoopFxGo):SetActive(false)
  end
  if self.__IsLoadedGreatBlastFx then
    (self.__GreatBlastFxGo):SetActive(false)
  end
end

UINBaseItem.EnableButton = function(self, flag)
  -- function num : 0_11
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).btn_Root).enabled = flag
end

UINBaseItem.OnHide = function(self)
  -- function num : 0_12
  self.__stop = true
end

UINBaseItem.OnDelete = function(self)
  -- function num : 0_13 , upvalues : base
  (base.OnDelete)(self)
end

return UINBaseItem

