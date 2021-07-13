-- params : ...
-- function num : 0 , upvalues : _ENV
local base = require("Game.CommonUI.Chip.UINBaseChipDetail")
local UINEpChipDetail = class("UINEpChipDetail", base)
local UINSelectChipAttrItem = require("Game.Exploration.UI.SelectChip.UINSelectChipAttrItem")
local UINHeroHeadItem = require("Game.CommonUI.Hero.UINHeroHeadItem")
local cs_DoTween = ((CS.DG).Tweening).DOTween
local cs_Material = (CS.UnityEngine).Material
local cs_PropertyNameHash = ((CS.UGUIExtend).Ui3DModifier).propertyNameHash
UINEpChipDetail.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, base, UINSelectChipAttrItem, UINHeroHeadItem, cs_PropertyNameHash
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (base.OnInit)(self)
  self.attrItemPool = (UIItemPool.New)(UINSelectChipAttrItem, (self.ui).obj_AttriItem)
  self.heroHeadPool = (UIItemPool.New)(UINHeroHeadItem, (self.ui).obj_HeroHeadItem)
  self:SetChipEffectHeroNodeActive(false)
  self:SetTacticNodeActive(false)
  ;
  ((self.ui).obj_AttriItem):SetActive(false)
  ;
  ((self.ui).obj_HeroHeadItem):SetActive(false)
  ;
  ((self.ui).obj_AllHero):SetActive(false)
  ;
  ((self.ui).obj_Price):SetActive(false)
  ;
  ((self.ui).obj_ReCC):SetActive(false)
  self:SetSelectAnima(false)
  ;
  ((self.ui).obj_OnSelect):SetActive(false)
  if not IsNull((self.ui).root) then
    self._defaultRootPos = ((self.ui).root).localPosition
    self._refreshRootPos = (Vector3.New)((self._defaultRootPos).x, (self._defaultRootPos).y + 60, (self._defaultRootPos).z)
  end
  self.effPrefabDic = {}
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Click, self, self.OnClickChipPanel)
  ;
  (base.SetBtnToParentHolder)(self, ((self.ui).btn_Click).transform)
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
  end
end

UINEpChipDetail.InitEpChipDetail = function(self, index, chipData, dynPlayer, resloader, clickEvent, isHideNxtLvlInfo, powerType, isOwnData, showBuyPrice)
  -- function num : 0_1 , upvalues : base
  (base.InitBaseChipDetail)(self, index, chipData, dynPlayer, resloader, isHideNxtLvlInfo, isOwnData)
  self._clickEvent = clickEvent
  self:_InitEpChipEffectInfo(chipData, dynPlayer, powerType, isOwnData, showBuyPrice)
end

UINEpChipDetail._InitEpChipEffectInfo = function(self, chipData, dynPlayer, powerType, isOwnData, showBuyPrice)
  -- function num : 0_2
  self:_InitAttrItem(chipData)
  self:_InitHeroHead(chipData, dynPlayer)
  self:_InitFightPower(chipData, dynPlayer, powerType, isOwnData)
  self:_InitReturnCC(chipData, dynPlayer, isOwnData)
  self:_InitShowBuyPrice(chipData, showBuyPrice)
  local index = (self.level):HasFlashTween() and 1 or 0
  ;
  ((self.ui).tex_ClickFront):SetIndex(index)
  if self.dissolveSeq ~= nil then
    (self.dissolveSeq):Complete()
  end
end

UINEpChipDetail._InitAttrItem = function(self, chipData)
  -- function num : 0_3
end

UINEpChipDetail._InitHeroHead = function(self, chipData, dynPlayer)
  -- function num : 0_4 , upvalues : _ENV
  if dynPlayer == nil then
    return 
  end
  ;
  (self.heroHeadPool):HideAll()
  local validCharacters = chipData:GetValidRoleList(dynPlayer.heroList, eBattleRoleBelong.player)
  local isAllHero = #dynPlayer.heroList <= #validCharacters
  ;
  ((self.ui).obj_HeroHeadList):SetActive(not isAllHero)
  ;
  ((self.ui).obj_AllHero):SetActive(isAllHero)
  if not isAllHero then
    for _,dynHero in pairs(validCharacters) do
      local heroHeadItem = (self.heroHeadPool):GetOne()
      heroHeadItem:InitHeroHeadItem(dynHero.heroData, self.__resloader)
      heroHeadItem:Show()
    end
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
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
    self.fightPower = dynPlayer:GetChipCombatEffect(chipData, isOwnData) * 100
    ;
    ((self.ui).tex_Power):SetIndex(0, GetPreciseDecimalStr(self.fightPower, 1))
  elseif powerType == eChipDetailPowerType.Subtract then
    ((self.ui).obj_PowerNode):SetActive(true)
    self.fightPower = dynPlayer:GetChipOriginFightPower(chipData) * 100
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

UINEpChipDetail._InitShowBuyPrice = function(self, chipData, showBuyPrice)
  -- function num : 0_7 , upvalues : _ENV
  ((self.ui).obj_Price):SetActive(showBuyPrice)
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R3 in 'UnsetPending'

  if showBuyPrice then
    ((self.ui).tex_Price).text = tostring(chipData:GetChipBuyPrice(ExplorationManager:GetEpModuleId()))
  end
end

UINEpChipDetail.GetInPlayFightPower = function(self, dynPlayer, isSubtract)
  -- function num : 0_8
  if isSubtract then
    return dynPlayer:GetChipOriginFightPower(self._chipData, true) * 100
  else
    return dynPlayer:GetChipCombatEffect(self._chipData, self._isOwnData, true) * 100
  end
end

UINEpChipDetail.OnSelectChipChanged = function(self, select)
  -- function num : 0_9
  if select then
    ((self.ui).ani_Select):DORestart()
    self:UnSelectAlpha(not select)
  else
    ;
    ((self.ui).ani_Select):DOPlayBackwards()
  end
  ;
  ((self.ui).obj_OnSelect):SetActive(select)
  self:SetSelectAnima(select)
  self:ShowHeroHeadOrTacticActive(select)
end

UINEpChipDetail.ShowHeroHeadOrTacticActive = function(self, active)
  -- function num : 0_10
  self:SetTacticNodeActive(false)
  self:SetChipEffectHeroNodeActive(false)
  if self.__chipData ~= nil and (self.__chipData):IsValidDynPlayer() then
    self:SetTacticNodeActive(active)
    return 
  end
  self:SetChipEffectHeroNodeActive(active)
end

UINEpChipDetail.UnSelectAlpha = function(self, boolean)
  -- function num : 0_11 , upvalues : _ENV
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  if not boolean or not Vector3.one then
    ((self.ui).tran_Mask).localScale = Vector3.zero
  end
end

UINEpChipDetail.SetSelectAnima = function(self, active)
  -- function num : 0_12
  ((self.ui).obj_SelectLine):SetActive(active)
end

UINEpChipDetail.SetUnSelectAlpha = function(self)
  -- function num : 0_13
  self:UnSelectAlpha(true)
  self:SetSelectAnima(false)
end

UINEpChipDetail.SetTacticNodeActive = function(self, active)
  -- function num : 0_14
  ((self.ui).obj_TacticNode):SetActive(active)
end

UINEpChipDetail.SetChipEffectHeroNodeActive = function(self, active)
  -- function num : 0_15
  ((self.ui).obj_HeroHeadNode):SetActive(active)
end

UINEpChipDetail.SetBtnToParentHolder = function(self, childTrans)
  -- function num : 0_16 , upvalues : base
  if childTrans ~= nil then
    (((self.ui).btn_Click).gameObject):SetActive(false)
    ;
    (base.SetBtnToParentHolder)(self, childTrans)
  end
end

UINEpChipDetail.EnableChipDetailPanelClick = function(self, enable)
  -- function num : 0_17
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).canvasGroup).interactable = enable
end

UINEpChipDetail.GetChipDetailPanelData = function(self)
  -- function num : 0_18
  return self._chipData
end

UINEpChipDetail.GetAutoTipsHolder = function(self)
  -- function num : 0_19
  return (self.ui).tran_AutoTipsHolder
end

UINEpChipDetail.GetChipItemTransform = function(self)
  -- function num : 0_20
  return ((self.ui).img_Icon).transform
end

UINEpChipDetail.OnClickChipPanel = function(self)
  -- function num : 0_21
  if self._clickEvent ~= nil then
    (self._clickEvent)(self)
  end
end

UINEpChipDetail.ShowChipPanelRefreshTween = function(self, updItemFunc, index, onlyMoveDown)
  -- function num : 0_22 , upvalues : cs_DoTween
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
    -- function num : 0_22_0 , upvalues : updItemFunc, self
    updItemFunc()
    ;
    ((self.ui).ani_Select):DORewind()
    self:UnSelectAlpha(false)
    ;
    ((self.ui).obj_OnSelect):SetActive(false)
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
    -- function num : 0_22_1 , upvalues : self
    self:EnableChipDetailPanelClick(true)
  end
)
  self._refreshSequece = sequece
end

UINEpChipDetail._ClearRefreshSequece = function(self)
  -- function num : 0_23
  if self._refreshSequece ~= nil then
    (self._refreshSequece):Kill()
    self._refreshSequece = nil
  end
end

UINEpChipDetail.ShowEpChipDetailEff = function(self, xRotate)
  -- function num : 0_24 , upvalues : _ENV
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
    -- function num : 0_24_0 , upvalues : _ENV, self, effItemData, xRotate, quality
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
  -- function num : 0_25
  self.onDissolveTweenComplete = Action
end

UINEpChipDetail.PlayDissolveTween = function(self)
  -- function num : 0_26 , upvalues : cs_DoTween
  self:InitDissolveTweenSetting()
  if self.dissolveSeq ~= nil then
    (self.dissolveSeq):Restart()
    return 
  end
  local dissolveSeq = (cs_DoTween.Sequence)()
  dissolveSeq:SetAutoKill(false)
  dissolveSeq:SetLink(self.gameObject)
  dissolveSeq:InsertCallback(0, function()
    -- function num : 0_26_0 , upvalues : self
    ((self.dissolveMat):DOFloat(0, "_add", 0.35)):SetLink(self.gameObject)
    ;
    ((self.dissolveMat):DOFloat(0.36, "_DissolutionAlpha", 0.35)):SetLink(self.gameObject)
  end
)
  dissolveSeq:AppendInterval(0.35)
  dissolveSeq:AppendCallback(function()
    -- function num : 0_26_1 , upvalues : self
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
    -- function num : 0_26_2 , upvalues : self
    ((self.ui).Obj_discard):SetActive(false)
    if self.onDissolveTweenComplete ~= nil then
      (self.onDissolveTweenComplete)(self.index)
    end
  end
)
  self.dissolveSeq = dissolveSeq
end

UINEpChipDetail.InitDissolveTweenSetting = function(self)
  -- function num : 0_27
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

UINEpChipDetail.OnDelete = function(self)
  -- function num : 0_28 , upvalues : _ENV, base
  ((self.ui).ani_Select):DOKill()
  self:_ClearRefreshSequece()
  DestroyUnityObject(self.dissolveMat)
  ;
  (base.OnDelete)(self)
end

return UINEpChipDetail

