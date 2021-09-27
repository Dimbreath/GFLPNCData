local UINAvgHeroPic = class("UINAvgHeroPic")
local eAvgImgPosType = require("Game.Avg.Enum.eAvgImgPosType")
local AvgImgTweenUntil = require("Game.Avg.AvgImgTweenUntil")
local CS_ResLoader = CS.ResLoader
local CS_DOTweenAnimation = ((CS.DG).Tweening).DOTweenAnimation
local CS_GameObject = (CS.UnityEngine).GameObject
local CS_RectTransform = (CS.UnityEngine).RectTransform
local CS_RawImage = ((CS.UnityEngine).UI).RawImage
local CS_Ease = ((CS.DG).Tweening).Ease
local CS_Material = (CS.UnityEngine).Material
UINAvgHeroPic.InitAvgHeroPic = function(self, imgCfg, heroItemPrefab, tweenCompleteEvent)
  -- function num : 0_0 , upvalues : _ENV, CS_DOTweenAnimation
  self.imgId = imgCfg.imgId
  self.imgCfg = imgCfg
  self.tweenCompleteEvent = tweenCompleteEvent
  self.gameObject = heroItemPrefab:Instantiate()
  self.transform = (self.gameObject).transform
  self.ui = {}
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (((self.ui).breatheRoot).gameObject):SetActive(false)
  local breathTweenList = ((self.ui).breatheRoot):GetComponents(typeof(CS_DOTweenAnimation))
  local delay = (math.random)() * 2
  for i = 0, breathTweenList.Length - 1 do
    local dt = breathTweenList[i]
    dt.delay = delay
  end
  ;
  (self.gameObject):SetActive(true)
  self.immediateComplete = false
  self.tweenCfgList = {}
  self:LoadHeroPic()
end

UINAvgHeroPic.LoadHeroPic = function(self)
  -- function num : 0_1 , upvalues : CS_ResLoader, _ENV, CS_Material, AvgImgTweenUntil
  self.loadResComplete = false
  self.resloader = (CS_ResLoader.Create)()
  local path = PathConsts:GetCharacterBigImgPrefabPath((self.imgCfg).imgPath)
  ;
  (self.resloader):LoadABAssetAsync(path, function(prefab)
    -- function num : 0_1_0 , upvalues : self, _ENV, CS_Material, AvgImgTweenUntil
    local go = prefab:Instantiate((self.ui).breatheRoot)
    self.picGo = go
    local commonPicCtrl = go:FindComponent(eUnityComponentID.CommonPicController)
    do
      if (self.imgCfg).posId ~= nil then
        local posType = "AvgHero" .. tostring((self.imgCfg).posId)
        if commonPicCtrl:SetPosType(posType) == false then
          warn((string.format)("[SetPosType]Avg hero posId error, imgPath = %s, posType = %s", (self.imgCfg).imgPath, posType))
        end
      end
      self.commonPicCtrl = commonPicCtrl
      -- DECOMPILER ERROR at PC39: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (self.ui).rawImg = go:FindComponent(eUnityComponentID.RawImage)
      self.heroMatDefault = CS_Material((self.ui).heroFaceMat)
      -- DECOMPILER ERROR at PC48: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((self.ui).rawImg).material = self.heroMatDefault
      self:InitAvgHeroPicParam()
      self.loadResComplete = true
      for k,tweenCfg in ipairs(self.tweenCfgList) do
        (AvgImgTweenUntil.Tween)(self, tweenCfg)
      end
      self:PlayAvgImgTween()
      if self.faceId ~= nil then
        self:AvgHeroChangeFace(self.faceId)
      end
      ;
      (((self.ui).breatheRoot).gameObject):SetActive(true)
    end
  end
)
end

UINAvgHeroPic.InitAvgHeroPicParam = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local imgCfg = self.imgCfg
  local pos = nil
  if imgCfg.pos ~= nil then
    pos = (Vector3.New)((imgCfg.pos)[1], (imgCfg.pos)[2], (imgCfg.pos)[3])
  else
    pos = (((self.ui).rawImg).transform).localPosition
  end
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (((self.ui).rawImg).transform).localPosition = Vector3.zero
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.transform).localPosition = pos
  local rot = nil
  if imgCfg.rot == nil then
    rot = Vector3.zero
  else
    rot = (Vector3.New)((imgCfg.rot)[1], (imgCfg.rot)[2], (imgCfg.rot)[3])
  end
  -- DECOMPILER ERROR at PC46: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.transform).localEulerAngles = rot
  local scale = nil
  if imgCfg.scale == nil then
    scale = Vector3.one
  else
    scale = (Vector3.New)((imgCfg.scale)[1], (imgCfg.scale)[2], (imgCfg.scale)[3])
  end
  -- DECOMPILER ERROR at PC65: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.transform).localScale = scale
  if not imgCfg.isDark or not Color.gray then
    local color = Color.white
  end
  if imgCfg.alpha ~= nil or not (((self.ui).rawImg).color).a then
    local alpha = imgCfg.alpha
  end
  color.a = alpha
  -- DECOMPILER ERROR at PC88: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).rawImg).color = color
  self:__ShowCommunication(imgCfg.comm)
end

UINAvgHeroPic.GetAvgImgOrder = function(self)
  -- function num : 0_3
  return (self.imgCfg).order or 0
end

UINAvgHeroPic.ChangeAvgImgOrder = function(self, order)
  -- function num : 0_4
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.imgCfg).order = order
end

UINAvgHeroPic.GetAvgHeroPicResetData = function(self, posPresetId)
  -- function num : 0_5 , upvalues : _ENV
  local posType = "AvgHero" .. tostring(posPresetId)
  local picPosData = (self.commonPicCtrl):GetPosTypeData(posType)
  if picPosData == nil then
    warn((string.format)("Avg hero posId error, imgPath = %s, posType = %s", (self.imgCfg).imgPath, posType))
  end
  return picPosData
end

UINAvgHeroPic.__ShowCommunication = function(self, show)
  -- function num : 0_6 , upvalues : _ENV
  local avgWindow = UIManager:GetWindow(UIWindowTypeID.Avg)
  if avgWindow == nil then
    return 
  end
  if show and self.commItem == nil and self.commonPicCtrl ~= nil then
    local commItem, heroMat = avgWindow:GetHeroCommItem()
    commItem:InitAvgHeroCommItem((self.commonPicCtrl).avgCommPos, (self.ui).breatheRoot)
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.picGo).transform).localScale = (self.commonPicCtrl).avgCommScale
    -- DECOMPILER ERROR at PC31: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.ui).rawImg).material = heroMat
    self.commItem = commItem
  else
    do
      if not show and self.commItem ~= nil then
        ((self.ui).breatheRoot):SetParent(self.transform)
        -- DECOMPILER ERROR at PC48: Confused about usage of register: R3 in 'UnsetPending'

        ;
        ((self.picGo).transform).localScale = Vector3.one
        avgWindow:ReturnHeroCommItem(self.commItem)
        -- DECOMPILER ERROR at PC55: Confused about usage of register: R3 in 'UnsetPending'

        ;
        ((self.ui).rawImg).material = self.heroMatDefault
        self.commItem = nil
      end
      self:AvgHeroChangeFace(self.faceId)
    end
  end
end

UINAvgHeroPic.AvgHeroDissolveTween = function(self, duration)
  -- function num : 0_7 , upvalues : _ENV, CS_Ease
  local avgWindow = UIManager:GetWindow(UIWindowTypeID.Avg)
  if avgWindow == nil then
    return 
  end
  local matParam = "_Dissolve"
  local dissolveMat = avgWindow:GetAvgHeroDissolveMat()
  dissolveMat:SetFloat(matParam, 0)
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).rawImg).material = dissolveMat
  self:AvgHeroChangeFace(self.faceId)
  if IsNull(self.dissolveEffectGo) then
    local path = PathConsts:GetEffectPath("avg/FXP_Lihui-Dis")
    ;
    (self.resloader):LoadABAssetAsync(path, function(prefab)
    -- function num : 0_7_0 , upvalues : _ENV, self
    if IsNull(prefab) then
      return 
    end
    local go = prefab:Instantiate(self.transform)
    self.dissolveEffectGo = go
  end
)
  else
    do
      ;
      (self.dissolveEffectGo):SetActive(false)
      ;
      (self.dissolveEffectGo):SetActive(true)
      return (dissolveMat:DOFloat(0.55, matParam, duration)):SetEase(CS_Ease.OutQuart)
    end
  end
end

UINAvgHeroPic.AvgHeroChangeFace = function(self, faceId)
  -- function num : 0_8 , upvalues : _ENV
  self.faceId = faceId or 0
  if not self.loadResComplete then
    return 
  end
  if faceId == 0 then
    self:_EnableFace(false)
    return 
  end
  local heroImgSize = (((self.ui).rawImg).transform).sizeDelta
  local faceSize = (self.commonPicCtrl).avgFaceSize
  local facePos = (Vector2.New)(((self.commonPicCtrl).avgFacePos).x, ((self.commonPicCtrl).avgFacePos).y)
  local scale = (Vector2.New)(faceSize.x / heroImgSize.x, faceSize.y / heroImgSize.y)
  ;
  (((self.ui).rawImg).material):SetTextureScale("_FaceTex", scale)
  local offset = facePos - (Vector2.New)(faceSize.x / 2, faceSize.y / 2) + (Vector2.New)(heroImgSize.x / 2, heroImgSize.y / 2)
  offset = (Vector2.New)(offset.x / heroImgSize.x, offset.y / heroImgSize.y)
  ;
  (((self.ui).rawImg).material):SetTextureOffset("_FaceTex", offset)
  local path = PathConsts:GetCharacterFaceImgPath((self.imgCfg).imgPath, tostring(faceId))
  ;
  (self.resloader):LoadABAssetAsync(path, function(texture)
    -- function num : 0_8_0 , upvalues : self
    if texture == nil then
      return 
    end
    ;
    (((self.ui).rawImg).material):SetTexture("_FaceTex", texture)
    self:_EnableFace(true)
  end
)
end

UINAvgHeroPic._EnableFace = function(self, enable)
  -- function num : 0_9
  if enable then
    (((self.ui).rawImg).material):EnableKeyword("FACE_TEX_ENABLE")
  else
    ;
    (((self.ui).rawImg).material):DisableKeyword("FACE_TEX_ENABLE")
  end
end

UINAvgHeroPic.GetAvgImgType = function(self)
  -- function num : 0_10
  return (self.imgCfg).imgType
end

UINAvgHeroPic.PlayAvgImgTween = function(self)
  -- function num : 0_11
  if self.sequence ~= nil and self.loadResComplete then
    if self.immediateComplete then
      (self.sequence):Complete()
      self:OnTweenComplete()
      return 
    end
    ;
    (self.sequence):AppendCallback(self:GetAvgImgTweenCompleteEvent())
    ;
    (self.sequence):Play()
  end
end

UINAvgHeroPic.AddAvgImgTween = function(self, tweenCfg)
  -- function num : 0_12 , upvalues : AvgImgTweenUntil, _ENV
  if self.loadResComplete then
    (AvgImgTweenUntil.Tween)(self, tweenCfg)
  else
    ;
    (table.insert)(self.tweenCfgList, tweenCfg)
  end
end

UINAvgHeroPic.GetAvgImgSequence = function(self)
  -- function num : 0_13
  return self.sequence
end

UINAvgHeroPic.SetAvgImgSequence = function(self, sequence)
  -- function num : 0_14
  self.sequence = sequence
end

UINAvgHeroPic.GetAvgImgTweenCompleteEvent = function(self)
  -- function num : 0_15 , upvalues : _ENV
  if self.__onTweenComplete == nil then
    self.__onTweenComplete = BindCallback(self, self.OnTweenComplete)
  end
  return self.__onTweenComplete
end

UINAvgHeroPic.OnTweenComplete = function(self)
  -- function num : 0_16
  self.sequence = nil
  self.tweenCfgList = {}
  if self.tweenCompleteEvent ~= nil then
    (self.tweenCompleteEvent)(self.imgId)
  end
end

UINAvgHeroPic.AvgImgTweenDoComplete = function(self)
  -- function num : 0_17
  if self.sequence ~= nil and (self.sequence):IsPlaying() then
    (self.sequence):Complete(true)
  else
    self.immediateComplete = true
  end
end

UINAvgHeroPic.Delete = function(self)
  -- function num : 0_18 , upvalues : _ENV
  if self.sequence ~= nil then
    (self.sequence):Kill()
    self.sequence = nil
  end
  self:__ShowCommunication(false)
  DestroyUnityObject(self.heroMatDefault)
  self.heroMatDefault = nil
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
  DestroyUnityObject(self.gameObject)
end

return UINAvgHeroPic

