local UIHeroSkin = class("UIHeroSkin", UIBaseWindow)
local base = UIBaseWindow
local UINHeroSkin = require("Game.Skin.UI.UINHeroSkin")
local cs_DoTween = ((CS.DG).Tweening).DOTween
local JumpManager = require("Game.Jump.JumpManager")
local CS_LeanTouch = ((CS.Lean).Touch).LeanTouch
local HeroCubismInteration = require("Game.Hero.Live2D.HeroCubismInteration")
local HeroLookTargetController = require("Game.Hero.Live2D.HeroLookTargetController")
local eMoveDir = {Left = 1, Right = 2}
local heroDragScaleLimit = {max = 1.7, min = 0.7}
local heroDragPosXLimit = {200, 200}
local heroDragPosYLimit = {200, -200}
UIHeroSkin.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINHeroSkin
  (UIUtil.SetTopStatus)(self, self.OnReturn)
  AudioManager:PlayAudioById(1111)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Buy, self, self.OnClickBuy)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Equip, self, self.OnClickUse)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Goto, self, self.OnClickGoto)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_SwitchLeft, self, self.OnClickLeftSwitch)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_SwitchRight, self, self.OnClickRightSwitch)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_ReturnNormal, self, self.OnClickViewReturn)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_ViewHero, self, self.OnClickViewHero)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).tog_Live2D, self, self.OnChangeLive2dValue)
  self.resLoader = ((CS.ResLoader).Create)()
  self.skinPool = (UIItemPool.New)(UINHeroSkin, (self.ui).skinPreviewItem)
  ;
  ((self.ui).skinPreviewItem):SetActive(false)
  self.__OnClickSkinItem = BindCallback(self, self.OnClickSkinItem)
  self.__OnGesture = BindCallback(self, self.OnGesture)
  self.itemLength = ((((self.ui).skinPreviewItem).transform).sizeDelta).x
  self.oriHeroNodePos = (((self.ui).heroNode).transform).localPosition
  self.oriPicHolderPos = (((self.ui).picHolder).transform).localPosition
  self.oriHeroFadePos = (((self.ui).heroFade).transform).localPosition
end

UIHeroSkin.OnShow = function(self)
  -- function num : 0_1 , upvalues : _ENV, base
  do
    if self.l2dBinding ~= nil then
      local interation = (((self.l2dBinding).renderController).transform):GetComponent(typeof((((((CS.Live2D).Cubism).Samples).OriginalWorkflow).Demo).CubismInterationController))
      if interation ~= nil then
        interation:RestartBodyAnimation()
      end
    end
    ;
    (base.OnShow)(self)
  end
end

UIHeroSkin._ResetData = function(self)
  -- function num : 0_2
  self.isHideUse = false
  self.skinIds = nil
  self.heroId = nil
  self.curIndex = 0
  self.usingIndex = 0
  self.buyCallback = nil
  self.closeCallback = nil
  self.changeCallback = nil
  self.heroDataList = nil
  self._isInPreview = false
  self.heroSwitchIndex = nil
end

UIHeroSkin.InitSkinBySkinList = function(self, skinId, skinIds, isHideUse, buyCallback, closeCallback)
  -- function num : 0_3 , upvalues : _ENV
  self:_ResetData()
  local skinCtr = ControllerManager:GetController(ControllerTypeId.Skin, true)
  self.isHideUse = isHideUse
  self.skinIds = {}
  local selectSkinId = nil
  for i,v in ipairs(skinIds) do
    if (PlayerDataCenter.skinData):IsUseful(v) then
      (table.insert)(self.skinIds, v)
      if v == skinId then
        selectSkinId = skinId
      end
    end
  end
  if selectSkinId == nil then
    selectSkinId = (self.skinIds)[1]
  end
  self.heroId = skinCtr:GetHeroId(selectSkinId)
  self.curIndex = 1
  self.buyCallback = buyCallback
  self.closeCallback = closeCallback
  ;
  (((self.ui).btn_SwitchLeft).gameObject):SetActive(false)
  ;
  (((self.ui).btn_SwitchRight).gameObject):SetActive(false)
  for i,v in ipairs(self.skinIds) do
    if selectSkinId == v then
      self.curIndex = i
    end
  end
  if self.winTween ~= nil then
    (self.winTween):Complete()
  end
  self:InitView()
end

UIHeroSkin.InitSkin = function(self, heroId, usingSkinId, changeCallback, heroDataList, closeCallback)
  -- function num : 0_4 , upvalues : _ENV
  self:_ResetData()
  self.heroId = heroId
  self.curIndex = 1
  self.changeCallback = changeCallback
  self.heroDataList = heroDataList
  self.closeCallback = closeCallback
  local heroCfg = (ConfigData.hero_data)[self.heroId]
  self.skinIds = {0}
  for i,v in ipairs(heroCfg.skin) do
    if (PlayerDataCenter.skinData):IsUseful(v) then
      (table.insert)(self.skinIds, v)
      if v == usingSkinId then
        self.curIndex = #self.skinIds
      end
    end
  end
  self.usingIndex = self.curIndex
  self:InitView()
  local hasSwitch = self.heroDataList ~= nil and #self.heroDataList > 1
  if hasSwitch then
    self.heroSwitchIndex = nil
    for i,v in ipairs(self.heroDataList) do
      if v.dataId == self.heroId then
        self.heroSwitchIndex = i
        break
      end
    end
    hasSwitch = self.heroSwitchIndex ~= nil
  end
  ;
  (((self.ui).btn_SwitchLeft).gameObject):SetActive(hasSwitch)
  ;
  (((self.ui).btn_SwitchRight).gameObject):SetActive(hasSwitch)
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

UIHeroSkin.OnClickLeftSwitch = function(self)
  -- function num : 0_5
  if self._isInPreview then
    return 
  end
  if self.heroSwitchIndex == 1 then
    self.heroSwitchIndex = #self.heroDataList
  else
    self.heroSwitchIndex = self.heroSwitchIndex - 1
  end
  self:RefreShByHeroSwitchIndex()
  if self.changeCallback ~= nil then
    (self.changeCallback)(-1)
  end
end

UIHeroSkin.OnClickRightSwitch = function(self)
  -- function num : 0_6
  if self._isInPreview then
    return 
  end
  if self.heroSwitchIndex == #self.heroDataList then
    self.heroSwitchIndex = 1
  else
    self.heroSwitchIndex = self.heroSwitchIndex + 1
  end
  self:RefreShByHeroSwitchIndex()
  if self.changeCallback ~= nil then
    (self.changeCallback)(1)
  end
end

UIHeroSkin.RefreShByHeroSwitchIndex = function(self)
  -- function num : 0_7 , upvalues : _ENV
  if self.heroSwitchIndex == nil then
    return 
  end
  local heroData = (self.heroDataList)[self.heroSwitchIndex]
  local usingSkinId = heroData.skinId
  self.heroId = heroData.dataId
  self.curIndex = 1
  local heroCfg = (ConfigData.hero_data)[self.heroId]
  self.skinIds = {0}
  for i,v in ipairs(heroCfg.skin) do
    if (PlayerDataCenter.skinData):IsUseful(v) then
      (table.insert)(self.skinIds, v)
      if v == usingSkinId then
        self.curIndex = #self.skinIds
      end
    end
  end
  self.usingIndex = self.curIndex
  self:InitView()
end

UIHeroSkin.InitView = function(self)
  -- function num : 0_8 , upvalues : _ENV
  (self.skinPool):HideAll()
  ;
  (ControllerManager:GetController(ControllerTypeId.Skin, true))
  local skinCtr = nil
  local item = nil
  for _,skinId in ipairs(self.skinIds) do
    item = (self.skinPool):GetOne(true)
    ;
    (item.gameObject):SetActive(true)
    local skinCfg = (ConfigData.skin)[skinId]
    local heroId = self.heroId
    if skinCfg ~= nil and not skinCtr:GetHeroId(skinId) then
      heroId = self.heroId
    end
    item:InitSkinItem(heroId, skinCfg, self.resLoader, self.__OnClickSkinItem)
    ;
    (item.transform):SetParent(((self.ui).rect_skin).transform)
  end
  for i = 1, #(self.skinPool).listItem do
    item = ((self.skinPool).listItem)[i]
    if i == self.curIndex then
      item:SetSelectState(true)
    else
      item:SetSelectState(false)
    end
  end
  self:SetResourceDisplay()
  self:Refresh()
  self:RefreshHaveCount()
  self:LocationHighLightSkinItem()
end

UIHeroSkin.Refresh = function(self, moveDir)
  -- function num : 0_9 , upvalues : _ENV, HeroCubismInteration
  local item = ((self.skinPool).listItem)[self.curIndex]
  local skinCfg = item.skinCfg
  local resModel = item.resModelCfg
  local skinCtr = ControllerManager:GetController(ControllerTypeId.Skin, true)
  self.heroId = (item.heroCfg).id
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R6 in 'UnsetPending'

  if skinCfg ~= nil then
    ((self.ui).tex_Intro).text = (LanguageUtil.GetLocaleText)(skinCfg.describe)
  else
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).tex_Intro).text = (LanguageUtil.GetLocaleText)((item.heroCfg).skin_describe)
  end
  if self._lastHeroId ~= self.heroId then
    self._lastHeroId = self.heroId
    -- DECOMPILER ERROR at PC46: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)((item.heroCfg).name)
    -- DECOMPILER ERROR at PC54: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).tex_NameEN).text = (LanguageUtil.GetLocaleText)((item.heroCfg).name_en)
  end
  if skinCfg == nil or not skinCfg.theme then
    local themId = (ConfigData.game_config).defaultSkinThemId
  end
  if self._lastThemId ~= themId then
    self._lastThemId = themId
    local skinThemCfg = (ConfigData.skinTheme)[themId]
    do
      -- DECOMPILER ERROR at PC74: Confused about usage of register: R8 in 'UnsetPending'

      if skinThemCfg ~= nil then
        ((self.ui).img_Head).enabled = false
        ;
        (self.resLoader):LoadABAssetAsync(PathConsts:GetAtlasAssetPath("CommonSkinTheme"), function(atlas)
    -- function num : 0_9_0 , upvalues : self, skinThemCfg
    if atlas == nil then
      return 
    end
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Head).sprite = atlas:GetSprite(skinThemCfg.pic)
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Head).enabled = true
  end
)
      end
    end
  end
  do
    self.isLive2dTogValid = false
    local isLocked = (HeroCubismInteration.JudgeL2DLocked)((self.skinIds)[self.curIndex])
    if item.haveLive2D then
      (((self.ui).tog_Live2D).gameObject):SetActive(not isLocked)
      if skinCfg == nil or not skinCfg.id then
        do
          local isOpen = (PlayerDataCenter.skinData):GetLive2dSwitchState((item.heroCfg).id, not item.haveLive2D or isLocked or 0)
          -- DECOMPILER ERROR at PC118: Confused about usage of register: R9 in 'UnsetPending'

          ;
          ((self.ui).tog_Live2D).isOn = isOpen
          if isOpen then
            ((self.ui).ani_Tog):DORewind()
          else
            ;
            ((self.ui).ani_Tog):DOComplete()
          end
          self.isLive2dTogValid = true
          self:LoadViewRes(moveDir)
          self:RefreshState()
        end
      end
    end
  end
end

UIHeroSkin.SetResourceDisplay = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local ids = nil
  for i,v in ipairs((self.skinPool).listItem) do
    if v.shopGoodsData ~= nil and (ids == nil or not (table.contain)(ids, (v.shopGoodsData).currencyId)) then
      if not ids then
        ids = {}
      end
      ;
      (table.insert)(ids, (v.shopGoodsData).currencyId)
      if (v.shopGoodsData).currencyId == ConstGlobalItem.PaidSubItem and not (table.contain)(ids, ConstGlobalItem.PaidItem) then
        (table.insert)(ids, ConstGlobalItem.PaidItem)
      end
    end
  end
  if ids ~= nil then
    (table.sort)(ids, function(a, b)
    -- function num : 0_10_0
    do return a < b end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  end
  ;
  (UIUtil.RefreshTopResId)(ids)
end

UIHeroSkin.RefreshState = function(self)
  -- function num : 0_11 , upvalues : _ENV
  (((self.ui).btn_Buy).gameObject):SetActive(false)
  ;
  (((self.ui).btn_Equip).gameObject):SetActive(false)
  ;
  (((self.ui).btn_Goto).gameObject):SetActive(false)
  ;
  ((self.ui).obj_Equipped):SetActive(false)
  ;
  ((self.ui).obj_ShowOnly):SetActive(false)
  ;
  ((self.ui).obj_StarUp):SetActive(false)
  ;
  ((self.ui).obj_Has):SetActive(false)
  if self.usingIndex ~= nil and self.curIndex == self.usingIndex then
    ((self.ui).obj_Equipped):SetActive(true)
    return 
  end
  local item = ((self.skinPool).listItem)[self.curIndex]
  local skinCfg = item.skinCfg
  local isHave = skinCfg ~= nil and (PlayerDataCenter.skinData):IsHaveSkin(skinCfg.id)
  if isHave then
    (((self.ui).btn_Equip).gameObject):SetActive(not self.isHideUse)
    ;
    ((self.ui).obj_Has):SetActive(self.isHideUse)
    return 
  end
  local skinCtr = ControllerManager:GetController(ControllerTypeId.Skin, true)
  if skinCtr:CheckSourceValid(skinCfg.id) then
    if item.shopGoodsData then
      (((self.ui).btn_Buy).gameObject):SetActive(true)
      local priceItem = (ConfigData.item)[(item.shopGoodsData).currencyId]
      -- DECOMPILER ERROR at PC112: Confused about usage of register: R6 in 'UnsetPending'

      ;
      ((self.ui).img_Price).sprite = CRH:GetSprite(priceItem.small_icon)
      -- DECOMPILER ERROR at PC119: Confused about usage of register: R6 in 'UnsetPending'

      ;
      ((self.ui).tex_Price).text = tostring((item.shopGoodsData).newCurrencyNum)
    elseif skinCfg.jumpId ~= nil and skinCfg.jumpId > 0 then
      (((self.ui).btn_Goto).gameObject):SetActive(true)
    elseif skinCfg.condition == proto_csmsg_SystemFunctionID.SystemFunctionID_HeroRank then
      ((self.ui).obj_StarUp):SetActive(true)
    else
      ((self.ui).obj_ShowOnly):SetActive(true)
    end
    return 
  end
  ;
  ((self.ui).obj_ShowOnly):SetActive(true)
  -- DECOMPILER ERROR: 8 unprocessed JMP targets
end

UIHeroSkin.LoadViewRes = function(self, moveDir)
  -- function num : 0_12 , upvalues : _ENV, eMoveDir, HeroCubismInteration
  if self._heroNodeTween ~= nil then
    (self._heroNodeTween):Kill()
    self._heroNodeTween = nil
  end
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((self.ui).heroNode).transform).localPosition = self.oriHeroNodePos
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((self.ui).picHolder).transform).localPosition = self.oriPicHolderPos
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((self.ui).heroFade).transform).localPosition = self.oriHeroFadePos
  self._isInPreview = false
  local item = ((self.skinPool).listItem)[self.curIndex]
  local resModel = item.resModelCfg
  if not IsNull(self.l2dModelIns) then
    DestroyUnityObject(self.l2dModelIns)
  end
  if not IsNull(self.bigImgGameObject) then
    DestroyUnityObject(self.bigImgGameObject)
  end
  local curMoveDir = nil
  curMoveDir = moveDir == nil and eMoveDir.Right or moveDir
  local resPath = PathConsts:GetCharacterLive2DPath(resModel.src_id_pic)
  if self.Live2DResloader ~= nil then
    (self.Live2DResloader):Put2Pool()
    self.Live2DResloader = nil
    self.l2dBinding = nil
  end
  if self.heroCubismInteration ~= nil then
    (self.heroCubismInteration):Delete()
    self.heroCubismInteration = nil
  end
  if self.bigImgResloader ~= nil then
    (self.bigImgResloader):Put2Pool()
    self.bigImgResloader = nil
  end
  self.l2dBinding = nil
  if item.haveLive2D and not (HeroCubismInteration.JudgeL2DLocked)((self.skinIds)[self.curIndex]) then
    if ((self.ui).tog_Live2D).isOn then
      self:__LoadLive2D(resPath, curMoveDir)
    else
      self:__LoadPic(PathConsts:GetCharacterBigImgPrefabPath(resModel.src_id_pic), curMoveDir)
    end
  else
    self:__LoadPic(PathConsts:GetCharacterBigImgPrefabPath(resModel.src_id_pic), curMoveDir)
  end
end

UIHeroSkin.__LoadLive2D = function(self, path, curMoveDir)
  -- function num : 0_13 , upvalues : _ENV, HeroCubismInteration, HeroLookTargetController
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R3 in 'UnsetPending'

  ((self.ui).heroFade).alpha = 0
  self.Live2DResloader = ((CS.ResLoader).Create)()
  ;
  (self.Live2DResloader):LoadABAssetAsync(path, function(l2dModelAsset)
    -- function num : 0_13_0 , upvalues : self, _ENV, HeroCubismInteration, HeroLookTargetController, curMoveDir
    self.l2dModelIns = l2dModelAsset:Instantiate(((self.ui).heroFade).transform)
    ;
    ((self.l2dModelIns).transform):SetLayer(LayerMask.UI)
    local cs_CubismInterationController = ((self.l2dModelIns).gameObject):GetComponent(typeof((((((CS.Live2D).Cubism).Samples).OriginalWorkflow).Demo).CubismInterationController))
    if cs_CubismInterationController ~= nil then
      self.heroCubismInteration = (HeroCubismInteration.New)()
      local heroId = self.heroId
      local skinId = (self.skinIds)[self.curIndex]
      ;
      (self.heroCubismInteration):InitHeroCubism(cs_CubismInterationController, heroId, skinId, UIManager:GetUICamera(), false)
    end
    do
      self.l2dBinding = {}
      ;
      (UIUtil.LuaUIBindingTable)(self.l2dModelIns, self.l2dBinding)
      local cubismLookController = ((self.l2dModelIns).gameObject):GetComponent(typeof(((((CS.Live2D).Cubism).Framework).LookAt).CubismLookController))
      ;
      (HeroLookTargetController.OpenLookTarget)(cubismLookController, ((self.l2dBinding).lookTarget).gameObject, UIManager:GetUICamera())
      -- DECOMPILER ERROR at PC77: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((self.l2dBinding).renderController).SortingLayer = self:GetWindowSortingLayer()
      -- DECOMPILER ERROR at PC80: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((self.l2dBinding).renderController).InfluencedByUICanvas = true
      -- DECOMPILER ERROR at PC85: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((self.l2dBinding).renderController).uiCanvasGroup = (self.ui).heroFade
      ;
      ((self.l2dBinding).commonPerpectiveHandle):SetL2DPosType("HeroSkin", false)
      self:_MoveHeroHolderTween((self.ui).heroFade, curMoveDir)
    end
  end
)
end

UIHeroSkin.__LoadPic = function(self, path, curMoveDir)
  -- function num : 0_14 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R3 in 'UnsetPending'

  ((self.ui).picFade).alpha = 0
  self.bigImgResloader = ((CS.ResLoader).Create)()
  ;
  (self.bigImgResloader):LoadABAssetAsync(path, function(prefab)
    -- function num : 0_14_0 , upvalues : _ENV, self, curMoveDir
    if IsNull(prefab) then
      return 
    end
    self.bigImgGameObject = prefab:Instantiate(((self.ui).picHolder).transform)
    local commonPicCtrl = (self.bigImgGameObject):FindComponent(eUnityComponentID.CommonPicController)
    commonPicCtrl:SetPosType("HeroSkin")
    self:_MoveHeroHolderTween((self.ui).picFade, curMoveDir)
  end
)
end

UIHeroSkin.RefreshHaveCount = function(self)
  -- function num : 0_15 , upvalues : _ENV
  local countMax = #(self.skinPool).listItem
  local countHave = 0
  for _,item in pairs((self.skinPool).listItem) do
    if item.skinCfg == nil or (PlayerDataCenter.skinData):IsHaveSkin((item.skinCfg).id) then
      countHave = countHave + 1
    end
  end
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_HasCount).text = tostring(countHave) .. "/" .. tostring(countMax)
end

UIHeroSkin.OnClickLeft = function(self)
  -- function num : 0_16 , upvalues : eMoveDir
  if self.curIndex > 1 then
    self:SetItemChange(-1)
    self:Refresh(eMoveDir.Left)
  end
end

UIHeroSkin.OnClickRight = function(self)
  -- function num : 0_17 , upvalues : eMoveDir
  if self.curIndex < #(self.skinPool).listItem then
    self:SetItemChange(1)
    self:Refresh(eMoveDir.Right)
  end
end

UIHeroSkin.OnClickSkinItem = function(self, item)
  -- function num : 0_18 , upvalues : _ENV
  if self.draging then
    return 
  end
  local index = self:_GetIndexByItem(item)
  do
    if index or self.curIndex ~= self.curIndex then
      local diff = index - self.curIndex
      self:SetItemChange(diff)
      self:Refresh(diff > 0)
      AudioManager:PlayAudioById(1111)
    end
    self:LocationHighLightSkinItem()
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

UIHeroSkin.LocationHighLightSkinItem = function(self)
  -- function num : 0_19 , upvalues : _ENV
  (((CS.UnityEngine).Canvas).ForceUpdateCanvases)()
  local scrollWidth = ((((self.ui).skinScroll).transform).rect).width
  local rectWidth = ((((self.ui).skinScroll).content).rect).width
  local overRectIndex = (math.floor)(scrollWidth / (rectWidth / #(self.skinPool).listItem))
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R4 in 'UnsetPending'

  if self.curIndex <= overRectIndex then
    ((self.ui).skinScroll).horizontalNormalizedPosition = 0
  else
    local allOverCount = #(self.skinPool).listItem - overRectIndex
    local overCount = self.curIndex - overRectIndex
    -- DECOMPILER ERROR at PC39: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).skinScroll).horizontalNormalizedPosition = overCount / allOverCount
  end
end

UIHeroSkin.OnClickBuy = function(self)
  -- function num : 0_20 , upvalues : _ENV
  if self._isInPreview then
    return 
  end
  local item = ((self.skinPool).listItem)[self.curIndex]
  local resIds = {}
  ;
  (table.insert)(resIds, (item.shopGoodsData).currencyId)
  if not (table.contain)(resIds, ConstGlobalItem.PaidItem) and ((item.shopGoodsData).currencyId == ConstGlobalItem.PaidSubItem or (item.shopGoodsData).currencyId == ConstGlobalItem.SkinTicket) then
    (table.insert)(resIds, 1, ConstGlobalItem.PaidItem)
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.QuickBuy, function(window)
    -- function num : 0_20_0 , upvalues : item, resIds, self
    window:SlideIn()
    window:InitBuyFixedCountGood(1, item.shopGoodsData, true, resIds, function()
      -- function num : 0_20_0_0 , upvalues : item, self
      item:Refresh()
      self:RefreshState()
      self:RefreshHaveCount()
      if self.buyCallback ~= nil then
        (self.buyCallback)()
      end
    end
)
  end
)
end

UIHeroSkin.OnClickGoto = function(self)
  -- function num : 0_21 , upvalues : JumpManager
  if self._isInPreview then
    return 
  end
  local item = ((self.skinPool).listItem)[self.curIndex]
  local skinCfg = item.skinCfg
  JumpManager:Jump(skinCfg.jumpId)
end

UIHeroSkin.OnClickUse = function(self)
  -- function num : 0_22 , upvalues : _ENV
  if self._isInPreview then
    return 
  end
  if self.curIndex == self.usingIndex then
    return 
  end
  local item = ((self.skinPool).listItem)[self.curIndex]
  local skinCfg = item.skinCfg
  local callback = function()
    -- function num : 0_22_0 , upvalues : self
    self.usingIndex = self.curIndex
    self:RefreshState()
  end

  local heroNetCtr = NetworkManager:GetNetwork(NetworkTypeID.Hero)
  heroNetCtr:CS_HERO_SkinChange(self.heroId, skinCfg ~= nil and skinCfg.id or 0, callback)
  AudioManager:PlayAudioById(1119)
end

UIHeroSkin.OnChangeLive2dValue = function(self, flag)
  -- function num : 0_23 , upvalues : _ENV
  if self._isInPreview then
    return 
  end
  if not self.isLive2dTogValid then
    return 
  end
  local item = ((self.skinPool).listItem)[self.curIndex]
  ;
  (PlayerDataCenter.skinData):RecordLive2dSwitchState((item.heroCfg).id, item.skinCfg ~= nil and (item.skinCfg).id or 0, flag)
  self:LoadViewRes()
  if flag then
    ((self.ui).ani_Tog):DOPlayBackwards()
  else
    ;
    ((self.ui).ani_Tog):DOPlayForward()
  end
end

UIHeroSkin.OnClickViewHero = function(self)
  -- function num : 0_24 , upvalues : _ENV, CS_LeanTouch
  if self._isInPreview then
    return 
  end
  self._isInPreview = true
  ;
  ((self.ui).normalNode):SetActive(false)
  ;
  ((self.ui).viewNode):SetActive(true)
  AudioManager:PlayAudioById(1061)
  ;
  (UIUtil.HideTopStatus)()
  if self._heroNodeTween ~= nil then
    (self._heroNodeTween):Kill()
    self._heroNodeTween = nil
  end
  self:CalcaluteDragLimit()
  self._heroNodeTween = (((self.ui).heroNode).transform):DOLocalMove((Vector3.New)(0, 0, 0), 0.5)
  ;
  (self._heroNodeTween):OnComplete(function()
    -- function num : 0_24_0 , upvalues : self
    (self._heroNodeTween):Kill()
    self._heroNodeTween = nil
  end
)
  ;
  (CS_LeanTouch.OnGesture)("+", self.__OnGesture)
end

UIHeroSkin.OnClickViewReturn = function(self)
  -- function num : 0_25 , upvalues : _ENV, cs_DoTween, CS_LeanTouch
  ((self.ui).normalNode):SetActive(true)
  ;
  ((self.ui).viewNode):SetActive(false)
  AudioManager:PlayAudioById(1111)
  ;
  (UIUtil.ReShowTopStatus)()
  if self._heroNodeTween ~= nil then
    (self._heroNodeTween):Kill()
    self._heroNodeTween = nil
  end
  self._heroNodeTween = (cs_DoTween.Sequence)()
  ;
  (self._heroNodeTween):Insert(0, (((self.ui).heroNode).transform):DOLocalMove(self.oriHeroNodePos, 0.5))
  ;
  (self._heroNodeTween):Insert(0, (((self.ui).picHolder).transform):DOLocalMove(self.oriPicHolderPos, 0.5))
  ;
  (self._heroNodeTween):Insert(0, (((self.ui).heroFade).transform):DOLocalMove(self.oriHeroFadePos, 0.5))
  ;
  (self._heroNodeTween):Insert(0, (((self.ui).picHolder).transform):DOScale((Vector3.New)(1, 1, 1), 0.5))
  ;
  (self._heroNodeTween):Insert(0, (((self.ui).heroFade).transform):DOScale((Vector3.New)(1, 1, 1), 0.5))
  ;
  (self._heroNodeTween):OnComplete(function()
    -- function num : 0_25_0 , upvalues : self
    (self._heroNodeTween):Kill()
    self._heroNodeTween = nil
    self._isInPreview = false
  end
)
  ;
  (CS_LeanTouch.OnGesture)("-", self.__OnGesture)
end

UIHeroSkin.CalcaluteDragLimit = function(self, isInDrag)
  -- function num : 0_26 , upvalues : heroDragPosXLimit, heroDragPosYLimit, _ENV
  if not isInDrag then
    local xMin = -((((self.ui).viewNode).transform).rect).width / 2 + heroDragPosXLimit[1]
    local xMax = ((((self.ui).viewNode).transform).rect).width / 2 - heroDragPosXLimit[2]
    if xMax < xMin then
      xMin = xMin - heroDragPosXLimit[2]
      xMax = xMax + heroDragPosXLimit[1]
    end
    local yMin = -((((self.ui).viewNode).transform).rect).height / 2 + heroDragPosYLimit[1]
    local yMax = ((((self.ui).viewNode).transform).rect).height / 2 - heroDragPosYLimit[2]
    if yMax < yMin then
      yMin = yMin - heroDragPosYLimit[1]
      yMax = yMax - heroDragPosYLimit[2]
    end
    self.heroDragPosLimitX = {xMin, xMax}
    self.heroDragPosLimitY = {yMin, yMax}
  end
  do
    if not IsNull(self.bigImgGameObject) then
      if not isInDrag then
        self.bigImgGameObjectHeight = nil
        self.heroDragPicPosLimitY = nil
        local rectTr = (self.bigImgGameObject):GetComponent(typeof((CS.UnityEngine).RectTransform))
        if not IsNull(rectTr) then
          self.bigImgGameObjectHeight = (rectTr.rect).height * (rectTr.localScale).y
        end
      end
      do
        if self.bigImgGameObjectHeight ~= nil then
          local limitYMin = (-self.bigImgGameObjectHeight / 2 - (((self.bigImgGameObject).transform).localPosition).y + 200) * ((((self.ui).picHolder).transform).localScale).y
          local limitYMax = (self.bigImgGameObjectHeight / 2 - (((self.bigImgGameObject).transform).localPosition).y) * ((((self.ui).picHolder).transform).localScale).y
          self.heroDragPicPosLimitY = {limitYMin, limitYMax}
        end
      end
    end
  end
end

UIHeroSkin.LimitDragPos = function(self, targetPos)
  -- function num : 0_27 , upvalues : _ENV
  targetPos.x = (math.clamp)(targetPos.x, (self.heroDragPosLimitX)[1], (self.heroDragPosLimitX)[2])
  if not IsNull(self.bigImgGameObject) and self.heroDragPicPosLimitY ~= nil then
    targetPos.y = (math.clamp)(targetPos.y, (self.heroDragPicPosLimitY)[1], (self.heroDragPicPosLimitY)[2])
  else
    targetPos.y = (math.clamp)(targetPos.y, (self.heroDragPosLimitY)[1], (self.heroDragPosLimitY)[2])
  end
end

UIHeroSkin.OnReturn = function(self)
  -- function num : 0_28
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  if self.l2dBinding ~= nil then
    ((self.l2dBinding).renderController).uiCanvasGroup = (self.ui).canvasGroup
  end
  ;
  ((self.ui).frameAni):DOPlayBackwards()
  self:Delete()
  if self.closeCallback ~= nil then
    (self.closeCallback)()
  end
end

UIHeroSkin.SetItemChange = function(self, num)
  -- function num : 0_29
  (((self.skinPool).listItem)[self.curIndex]):SetSelectState(false)
  self.curIndex = self.curIndex + num
  ;
  (((self.skinPool).listItem)[self.curIndex]):SetSelectState(true)
end

UIHeroSkin._GetIndexByItem = function(self, item)
  -- function num : 0_30 , upvalues : _ENV
  local index = nil
  for i,v in ipairs((self.skinPool).listItem) do
    if v == item then
      return i
    end
  end
  return nil
end

UIHeroSkin._RefreshCol = function(self, heroId)
  -- function num : 0_31 , upvalues : _ENV
  local rare = 1
  if (PlayerDataCenter.heroDic)[heroId] ~= nil then
    rare = ((PlayerDataCenter.heroDic)[heroId]).rare
  else
    local heroCfg = (ConfigData.hero_data)[heroId]
    local rankCfg = (ConfigData.hero_rank)[heroCfg.rank]
    rare = rankCfg.rare
  end
  do
    self:_RefreshColsTween(HeroRareColor[rare])
  end
end

UIHeroSkin._RefreshColsTween = function(self, endColor)
  -- function num : 0_32 , upvalues : _ENV, cs_DoTween
  if self.endColor == nil then
    self.endColor = endColor
    for index,image in ipairs((self.ui).arr_cols) do
      image.color = endColor
    end
  else
    do
      if self.cloSeq ~= nil then
        (self.cloSeq):Kill()
        self.cloSeq = nil
      end
      local cloSeq = (cs_DoTween.Sequence)()
      for index,image in ipairs((self.ui).arr_cols) do
        cloSeq:Insert(0, image:DOColor(endColor, 0.3))
      end
      self.cloSeq = cloSeq
    end
  end
end

UIHeroSkin._MoveHeroHolderTween = function(self, canvasGroup, curMoveDir)
  -- function num : 0_33 , upvalues : cs_DoTween, eMoveDir, _ENV
  if self.moveSeq ~= nil then
    (self.moveSeq):Kill(true)
    self.moveSeq = nil
  end
  local moveSeq = (cs_DoTween.Sequence)()
  moveSeq:Append(canvasGroup:DOFade(1, 0.35))
  local transform = canvasGroup.transform
  local pos = transform.localPosition
  local moveX = 404
  if curMoveDir == eMoveDir.Left then
    transform.localPosition = (Vector3.New)(pos.x - moveX, pos.y, pos.z)
    moveSeq:Join(((canvasGroup.transform):DOLocalMoveX(moveX, 0.45)):SetRelative(true))
  else
    transform.localPosition = (Vector3.New)(pos.x + moveX, pos.y, pos.z)
    moveSeq:Join(((canvasGroup.transform):DOLocalMoveX(-moveX, 0.45)):SetRelative(true))
  end
  self.moveSeq = moveSeq
end

UIHeroSkin.OnGesture = function(self, fingerList)
  -- function num : 0_34 , upvalues : _ENV, heroDragScaleLimit
  if self._heroNodeTween ~= nil then
    return 
  end
  if fingerList.Count == 1 then
    local touch = fingerList[0]
    local lastPos = UIManager:Screen2UIPosition(touch.LastScreenPosition, ((self.transform).gameObject):GetComponent(typeof((CS.UnityEngine).RectTransform)), UIManager.UICamera)
    local curPos = UIManager:Screen2UIPosition(touch.ScreenPosition, ((self.transform).gameObject):GetComponent(typeof((CS.UnityEngine).RectTransform)), UIManager.UICamera)
    local diffPos = curPos - lastPos
    diffPos = (Vector3.New)(diffPos.x, diffPos.y, 0)
    local targetPos = (((self.ui).picHolder).transform).localPosition + diffPos
    self:LimitDragPos(targetPos)
    -- DECOMPILER ERROR at PC57: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (((self.ui).picHolder).transform).localPosition = targetPos
    -- DECOMPILER ERROR at PC61: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (((self.ui).heroFade).transform).localPosition = targetPos
  else
    do
      if fingerList.Count == 2 then
        local touch1 = fingerList[0]
        local touch2 = fingerList[1]
        local lastDiffX = (touch1.LastScreenPosition).x - (touch2.LastScreenPosition).x
        local lastDiffY = (touch1.LastScreenPosition).y - (touch2.LastScreenPosition).y
        local curDiffX = (touch1.ScreenPosition).x - (touch2.ScreenPosition).x
        local curDiffY = (touch1.ScreenPosition).y - (touch2.ScreenPosition).y
        local diff = (Mathf.Sqrt)((Mathf.Pow)(curDiffX, 2) + (Mathf.Pow)(curDiffY, 2)) - (Mathf.Sqrt)((Mathf.Pow)(lastDiffX, 2) + (Mathf.Pow)(lastDiffY, 2))
        local scale = ((((self.ui).picHolder).transform).localScale).x + diff / 500 * (heroDragScaleLimit.max - heroDragScaleLimit.min)
        scale = (math.clamp)(scale, heroDragScaleLimit.min, heroDragScaleLimit.max)
        -- DECOMPILER ERROR at PC144: Confused about usage of register: R10 in 'UnsetPending'

        ;
        (((self.ui).picHolder).transform).localScale = (Vector3.New)(scale, scale, scale)
        -- DECOMPILER ERROR at PC154: Confused about usage of register: R10 in 'UnsetPending'

        ;
        (((self.ui).heroFade).transform).localScale = (Vector3.New)(scale, scale, scale)
        self:CalcaluteDragLimit(true)
        local targetPos = (((self.ui).picHolder).transform).localPosition
        self:LimitDragPos(targetPos)
        -- DECOMPILER ERROR at PC168: Confused about usage of register: R11 in 'UnsetPending'

        ;
        (((self.ui).picHolder).transform).localPosition = targetPos
        -- DECOMPILER ERROR at PC172: Confused about usage of register: R11 in 'UnsetPending'

        ;
        (((self.ui).heroFade).transform).localPosition = targetPos
      end
    end
  end
end

UIHeroSkin.OnDelete = function(self)
  -- function num : 0_35 , upvalues : CS_LeanTouch, base
  if self.pageSequence ~= nil then
    (self.pageSequence):Kill(true)
    self.pageSequence = nil
  end
  if self.cloSeq ~= nil then
    (self.cloSeq):Kill()
    self.cloSeq = nil
  end
  if self.moveSeq ~= nil then
    (self.moveSeq):Kill()
    self.moveSeq = nil
  end
  if self._heroNodeTween ~= nil then
    (self._heroNodeTween):Kill()
    self._heroNodeTween = nil
  end
  ;
  ((self.ui).frameAni):DOKill()
  if self._isInPreview then
    self._isInPreview = false
    ;
    (CS_LeanTouch.OnGesture)("-", self.__OnGesture)
  end
  ;
  (base.OnDelete)(self)
end

UIHeroSkin.OnDeleteEntity = function(self)
  -- function num : 0_36 , upvalues : CS_LeanTouch, base
  if self._isInPreview then
    self._isInPreview = false
    ;
    (CS_LeanTouch.OnGesture)("-", self.__OnGesture)
  end
  ;
  (self.resLoader):Put2Pool()
  self.resLoader = nil
  if self.Live2DResloader ~= nil then
    (self.Live2DResloader):Put2Pool()
    self.Live2DResloader = nil
    self.l2dBinding = nil
  end
  if self.heroCubismInteration ~= nil then
    (self.heroCubismInteration):Delete()
    self.heroCubismInteration = nil
  end
  if self.bigImgResloader ~= nil then
    (self.bigImgResloader):Put2Pool()
    self.bigImgResloader = nil
  end
  ;
  (base.OnDeleteEntity)(self)
end

return UIHeroSkin

