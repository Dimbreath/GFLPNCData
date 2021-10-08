local base = require("Game.CommonUI.Chip.UINBaseChipDetail")
local UINEpChipDetail = class("UINEpChipDetail", base)
local UINHeroHeadItem = require("Game.CommonUI.Hero.UINHeroHeadItem")
local UINButtonGroup = require("Game.Exploration.UI.SelectChip.UINEpChipDetailButtonGroup")
local ChipEnum = require("Game.PlayerData.Item.ChipEnum")
local cs_DoTween = ((CS.DG).Tweening).DOTween
local cs_EaseLinear = (((CS.DG).Tweening).Ease).Linear
local cs_Material = (CS.UnityEngine).Material
local cs_PropertyNameHash = ((CS.UGUIExtend).Ui3DModifier).propertyNameHash
local cs_DoTweenLoopType = ((CS.DG).Tweening).LoopType
UINEpChipDetail.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, base, UINHeroHeadItem, UINButtonGroup, cs_PropertyNameHash
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (base.OnInit)(self)
  self.heroHeadPool = (UIItemPool.New)(UINHeroHeadItem, (self.ui).obj_HeroHeadItem)
  self.buttonGroup = (UINButtonGroup.New)()
  ;
  (self.buttonGroup):Init((self.ui).obj_Group)
  ;
  ((self.ui).obj_HeroHeadItem):SetActive(false)
  ;
  ((self.ui).obj_AllHero):SetActive(false)
  ;
  ((self.ui).obj_ReCC):SetActive(false)
  if not IsNull((self.ui).root) then
    self._defaultRootPos = ((self.ui).root).localPosition
    self._refreshRootPos = (Vector3.New)((self._defaultRootPos).x, (self._defaultRootPos).y + 60, (self._defaultRootPos).z)
  end
  self.effPrefabDic = {}
  self.dissolveMat = (((CS.UnityEngine).Object).Instantiate)((self.ui).Mat_fXMImage)
  self.initDissolveMat = true
  do
    if self.initDissolveMat and not IsNull(((self.ui).modifier).material) then
      local matrix = (((self.ui).modifier).material):GetMatrix(cs_PropertyNameHash)
      ;
      (self.dissolveMat):SetMatrix(cs_PropertyNameHash, matrix)
      self.initDissolveMat = false
    end
    for i = 1, #(self.ui).Img_ButtomList do
      local image = ((self.ui).Img_ButtomList)[i]
      image.material = self.dissolveMat
    end
    ;
    ((self.ui).Obj_discard):SetActive(false)
    self:SetObjNewTagActive(false)
    ;
    (base.SetBaseBackground)(self, ((self.ui).Fad_Item).transform)
  end
end

UINEpChipDetail.InitEpChipDetail = function(self, index, chipData, dynPlayer, resloader, isHideNxtLvlInfo, powerType, isOwnData)
  -- function num : 0_1 , upvalues : base
  (base.InitBaseChipDetail)(self, index, chipData, dynPlayer, resloader, isHideNxtLvlInfo, isOwnData)
  self:_InitEpChipEffectInfo(chipData, dynPlayer, powerType, isOwnData)
end

UINEpChipDetail._InitEpChipEffectInfo = function(self, chipData, dynPlayer, powerType, isOwnData)
  -- function num : 0_2
  self:_InitHeroHead(chipData, dynPlayer)
  self:_InitFightPower(chipData, dynPlayer, powerType, isOwnData)
  self:_InitReturnCC(chipData, dynPlayer, isOwnData)
  ;
  (self.buttonGroup):InitChipDetailButtonGroup(self)
  local index = (self.level):HasFlashTween() and 1 or 0
  if self.dissolveSeq ~= nil then
    (self.dissolveSeq):Complete()
  end
end

UINEpChipDetail._InitHeroHead = function(self, chipData, dynPlayer)
  -- function num : 0_3 , upvalues : _ENV, cs_DoTween, cs_EaseLinear
  (self.heroHeadPool):HideAll()
  self:_SetTacticNodeActive(false)
  ;
  ((self.ui).obj_AllHero):SetActive(false)
  ;
  ((self.ui).obj_HeroMask):SetActive(false)
  if dynPlayer == nil then
    return 
  end
  if not chipData:IsConsumeSkillChip() or not 1 then
    self:_SetTacticNodeActive(true, chipData == nil or not chipData:IsValidDynPlayer() or 0)
    do return  end
    local validCharacters = chipData:GetValidRoleList(dynPlayer.heroList, eBattleRoleBelong.player)
    local isAllHero = #dynPlayer.heroList <= #validCharacters
    ;
    (((self.ui).tran_heroHeadList).gameObject):SetActive(not isAllHero)
    ;
    ((self.ui).obj_AllHero):SetActive(isAllHero)
    if isAllHero then
      return 
    end
    ;
    ((self.ui).obj_HeroMask):SetActive(true)
    for _,dynHero in pairs(validCharacters) do
      local heroHeadItem = (self.heroHeadPool):GetOne()
      heroHeadItem:InitHeroHeadItem(dynHero.heroData, self.__resloader)
      heroHeadItem:Show()
    end
    ;
    (((CS.UnityEngine).Canvas).ForceUpdateCanvases)()
    local maskWidth = (((self.ui).tran_HeroHeadMask).rect).width
    local headListWidth = (((self.ui).tran_heroHeadList).rect).width
    -- DECOMPILER ERROR at PC100: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self.ui).tran_heroHeadList).localPosition = Vector3.zero
    -- DECOMPILER ERROR at PC105: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self.ui).tran_heroHeadList).anchoredPosition = Vector2.zero
    self:_ClearHeroHeadSequece()
    if headListWidth < maskWidth then
      return 
    end
    local sequece = (cs_DoTween.Sequence)()
    sequece:AppendInterval(1)
    sequece:Append(((((self.ui).tran_heroHeadList):DOLocalMoveX(maskWidth - headListWidth, 4)):SetRelative(true)):SetEase(cs_EaseLinear))
    sequece:AppendInterval(1)
    sequece:SetAutoKill(false)
    sequece:SetLoops(-1)
    self._heroHeadSeq = sequece
    -- DECOMPILER ERROR: 4 unprocessed JMP targets
  end
end

UINEpChipDetail._ClearHeroHeadSequece = function(self)
  -- function num : 0_4
  if self._heroHeadSeq ~= nil then
    (self._heroHeadSeq):Kill()
    self._heroHeadSeq = nil
  end
end

UINEpChipDetail._InitFightPower = function(self, chipData, dynPlayer, powerType, isOwnData)
  -- function num : 0_5 , upvalues : _ENV
  ((self.ui).obj_PowerNode):SetActive(dynPlayer == nil)
  if dynPlayer == nil then
    return 
  end
  self.fightPower = 0
  if powerType == eChipDetailPowerType.Add or powerType == nil then
    ((self.ui).obj_PowerNode):SetActive(true)
    self.fightPower = dynPlayer:GetChipCombatEffect(chipData, isOwnData)
    ;
    ((self.ui).tex_Power):SetIndex(0, GetPreciseDecimalStr(self.fightPower, 1))
  elseif powerType == eChipDetailPowerType.Subtract then
    ((self.ui).obj_PowerNode):SetActive(true)
    self.fightPower = dynPlayer:GetChipDiscardFightPower(chipData)
    ;
    ((self.ui).tex_Power):SetIndex(1, GetPreciseDecimalStr(self.fightPower, 1))
  else
    ((self.ui).obj_PowerNode):SetActive(false)
  end
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

UINEpChipDetail._InitReturnCC = function(self, chipData, dynPlayer, isOwnData)
  -- function num : 0_6 , upvalues : _ENV
  ((self.ui).obj_ReCC):SetActive(false)
  if dynPlayer == nil then
    return 
  end
  if not isOwnData then
    local returnMoney = dynPlayer:GetChipReturnMoney(chipData.dataId, chipData:GetCount())
    if returnMoney > 0 and (self.ui).obj_ReCC ~= nil then
      ((self.ui).obj_ReCC):SetActive(true)
      -- DECOMPILER ERROR at PC31: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.ui).tex_ReCC).text = tostring(returnMoney)
    end
  end
end

UINEpChipDetail.GetInPlayFightPower = function(self, dynPlayer, isSubtract)
  -- function num : 0_7
  if isSubtract then
    return dynPlayer:GetChipDiscardFightPower(self._chipData, true)
  else
    return dynPlayer:GetChipCombatEffect(self._chipData, self._isOwnData, true)
  end
end

UINEpChipDetail.OnSelectChipChanged = function(self, select)
  -- function num : 0_8
  if select then
    self:UnSelectAlpha(not select)
  end
  self:SetSelectAnima(select)
  self:ShowHeroHeadOrTacticActive(select)
end

UINEpChipDetail.ShowHeroHeadOrTacticActive = function(self, active)
  -- function num : 0_9
end

UINEpChipDetail.UnSelectAlpha = function(self, boolean)
  -- function num : 0_10 , upvalues : _ENV
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  if not boolean or not Vector3.one then
    ((self.ui).tran_Mask).localScale = Vector3.zero
  end
end

UINEpChipDetail.SetSelectAnima = function(self, active)
  -- function num : 0_11
end

UINEpChipDetail.SetUnSelectAlpha = function(self)
  -- function num : 0_12
  self:UnSelectAlpha(true)
end

UINEpChipDetail._SetTacticNodeActive = function(self, active, index)
  -- function num : 0_13
  ((self.ui).obj_TacticNode):SetActive(active)
  if not index then
    ((self.ui).text_TacticNode):SetIndex(not active or 0)
    ;
    ((self.ui).textEn_TacticNode):SetIndex(index or 0)
  end
end

UINEpChipDetail.EnableChipDetailPanelClick = function(self, enable)
  -- function num : 0_14
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).canvasGroup).interactable = enable
end

UINEpChipDetail.GetChipDetailPanelData = function(self)
  -- function num : 0_15
  return self._chipData
end

UINEpChipDetail.GetAutoTipsHolder = function(self)
  -- function num : 0_16
  return (self.ui).tran_AutoTipsHolder
end

UINEpChipDetail.GetChipItemTransform = function(self)
  -- function num : 0_17
  return ((self.ui).img_Icon).transform
end

UINEpChipDetail.ShowChipPanelRefreshTween = function(self, updItemFunc, index, onlyMoveDown)
  -- function num : 0_18 , upvalues : cs_DoTween
  self:_ClearRefreshSequece()
  self:EnableChipDetailPanelClick(false)
  local sequece = (cs_DoTween.Sequence)()
  local deplay = 0
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R6 in 'UnsetPending'

  if not onlyMoveDown then
    ((self.ui).canvasGroup).alpha = 1
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).root).localPosition = self._defaultRootPos
    deplay = 0.04 * index
    sequece:Insert(deplay, ((self.ui).root):DOLocalMoveY((self._refreshRootPos).y, 0.2))
    sequece:Insert(deplay, ((self.ui).canvasGroup):DOFade(0, 0.2))
  end
  sequece:InsertCallback(deplay, function()
    -- function num : 0_18_0 , upvalues : updItemFunc, self
    updItemFunc()
    self:UnSelectAlpha(false)
    self:SetSelectAnima(false)
    self:ShowHeroHeadOrTacticActive(false)
  end
)
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R6 in 'UnsetPending'

  if onlyMoveDown then
    ((self.ui).canvasGroup).alpha = 0
    -- DECOMPILER ERROR at PC49: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).root).localPosition = self._refreshRootPos
    deplay = 0.04 * index
  end
  deplay = deplay + 0.2
  sequece:Insert(deplay, ((self.ui).root):DOLocalMoveY((self._defaultRootPos).y, 0.2))
  sequece:Insert(deplay, ((self.ui).canvasGroup):DOFade(1, 0.2))
  sequece:OnComplete(function()
    -- function num : 0_18_1 , upvalues : self
    self:EnableChipDetailPanelClick(true)
  end
)
  self._refreshSequece = sequece
end

UINEpChipDetail._ClearRefreshSequece = function(self)
  -- function num : 0_19
  if self._refreshSequece ~= nil then
    (self._refreshSequece):Kill()
    self._refreshSequece = nil
  end
end

UINEpChipDetail.ShowEpChipDetailEff = function(self, xRotate)
  -- function num : 0_20 , upvalues : _ENV
  if self.effItemData ~= nil then
    ((self.effItemData).go):SetActive(false)
    ;
    ((self.effItemData).eff):Stop()
  end
  if not (self.level):HasFlashTween() then
    return 
  end
  local quality = (self._chipData):GetQuality()
  local path = ChipDetailEffPatch[quality]
  local effItemData = (self.effPrefabDic)[quality]
  if effItemData ~= nil then
    (effItemData.eff):Play()
    ;
    (effItemData.go):SetActive(true)
    self.effItemData = effItemData
    return 
  end
  ;
  (self._resloader):LoadABAssetAsync(path, function(prefab)
    -- function num : 0_20_0 , upvalues : _ENV, self, effItemData, xRotate, quality
    if IsNull(prefab) then
      return 
    end
    if self.ui == nil then
      return 
    end
    if (self.ui).tran_EffHolder == nil or IsNull(((self.ui).tran_EffHolder).gameObject) then
      return 
    end
    effItemData = {}
    local go = prefab:Instantiate((self.ui).tran_EffHolder)
    local particleSystem = go:GetComponentInChildren(typeof((CS.UnityEngine).ParticleSystem))
    particleSystem:Stop()
    ;
    (go.transform):Rotate((Vector3.New)(xRotate or 0, 0, 0))
    particleSystem:Play()
    effItemData.go = go
    effItemData.eff = particleSystem
    -- DECOMPILER ERROR at PC56: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self.effPrefabDic)[quality] = effItemData
    self.effItemData = effItemData
  end
)
end

UINEpChipDetail.OnDissolveTweenCompleteAction = function(self, Action)
  -- function num : 0_21
  self.onDissolveTweenComplete = Action
end

UINEpChipDetail.PlayDissolveTween = function(self)
  -- function num : 0_22 , upvalues : cs_DoTween
  self:InitDissolveTweenSetting()
  if self.dissolveSeq ~= nil then
    (self.dissolveSeq):Restart()
    return 
  end
  local dissolveSeq = (cs_DoTween.Sequence)()
  dissolveSeq:SetAutoKill(false)
  dissolveSeq:SetLink(self.gameObject)
  dissolveSeq:InsertCallback(0, function()
    -- function num : 0_22_0 , upvalues : self
    ((self.dissolveMat):DOFloat(0, "_add", 0.35)):SetLink(self.gameObject)
    ;
    ((self.dissolveMat):DOFloat(0.36, "_DissolutionAlpha", 0.35)):SetLink(self.gameObject)
  end
)
  dissolveSeq:AppendInterval(0.35)
  dissolveSeq:AppendCallback(function()
    -- function num : 0_22_1 , upvalues : self
    ((self.dissolveMat):DOFloat(0.5, "_add", 0.35)):SetLink(self.gameObject)
    ;
    ((self.dissolveMat):DOFloat(0, "_DissolutionAlpha", 0.35)):SetLink(self.gameObject)
    ;
    (((self.ui).Fad_Item):DOFade(0, 0.35)):SetLink(self.gameObject)
    ;
    ((self.ui).Obj_discard):SetActive(true)
  end
)
  dissolveSeq:AppendInterval((((self.ui).Ani_discard).clip).length)
  dissolveSeq:OnComplete(function()
    -- function num : 0_22_2 , upvalues : self
    ((self.ui).Obj_discard):SetActive(false)
    if self.onDissolveTweenComplete ~= nil then
      (self.onDissolveTweenComplete)(self.index)
    end
  end
)
  self.dissolveSeq = dissolveSeq
end

UINEpChipDetail.InitDissolveTweenSetting = function(self)
  -- function num : 0_23
  ((self.ui).Obj_discard):SetActive(false)
  ;
  ((self.ui).Fad_Item):DOKill()
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).Fad_Item).alpha = 1
  ;
  (self.dissolveMat):DOKill()
  ;
  (self.dissolveMat):SetFloat("_add", 1)
  ;
  (self.dissolveMat):SetFloat("_DissolutionAlpha", 0)
end

UINEpChipDetail.SetObjNewTagActive = function(self, active, chipShowState)
  -- function num : 0_24 , upvalues : ChipEnum, _ENV, cs_DoTweenLoopType
  if active then
    if chipShowState == (ChipEnum.eChipShowState).NewState then
      (((self.ui).img_New).gameObject):SetActive(true)
      ;
      ((self.ui).img_New):SetIndex(0)
      ;
      ((self.ui).tex_New):SetIndex(0)
    else
      if chipShowState == (ChipEnum.eChipShowState).UpState then
        (((self.ui).img_New).gameObject):SetActive(true)
        ;
        ((self.ui).img_New):SetIndex(1)
        ;
        ((self.ui).tex_New):SetIndex(1)
      else
        ;
        (((self.ui).img_New).gameObject):SetActive(false)
      end
    end
    ;
    (((self.ui).img_New).image):DOKill()
    -- DECOMPILER ERROR at PC60: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (((self.ui).img_New).image).color = Color.white
    if (((self.ui).img_New).gameObject).activeInHierarchy then
      (((((self.ui).img_New).image):DOFade(0, 0.7)):SetLoops(-1, cs_DoTweenLoopType.Yoyo)):SetLink(((self.ui).img_New).gameObject)
    end
  else
    ;
    (((self.ui).img_New).gameObject):SetActive(false)
  end
  local index = chipShowState == (ChipEnum.eChipShowState).NewState and 0 or 1
  ;
  (self.buttonGroup):RefreshBtnSelectUI(index)
end

UINEpChipDetail.GetDetailButtonGroup = function(self)
  -- function num : 0_25
  return self.buttonGroup
end

UINEpChipDetail.OnDelete = function(self)
  -- function num : 0_26 , upvalues : _ENV, base
  self:_ClearRefreshSequece()
  self:_ClearHeroHeadSequece()
  DestroyUnityObject(self.dissolveMat)
  ;
  (base.OnDelete)(self)
end

return UINEpChipDetail

