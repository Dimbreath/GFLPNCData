-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAvgHeroPic = class("UINAvgHeroPic")
local eAvgImgPosType = require("Game.Avg.Enum.eAvgImgPosType")
local AvgImgTweenUntil = require("Game.Avg.AvgImgTweenUntil")
local CS_ResLoader = CS.ResLoader
local CS_DOTweenAnimation = ((CS.DG).Tweening).DOTweenAnimation
local CS_GameObject = (CS.UnityEngine).GameObject
local CS_RectTransform = (CS.UnityEngine).RectTransform
local CS_RawImage = ((CS.UnityEngine).UI).RawImage
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
  self.RefreshAvgHeroFaceColorFunc = BindCallback(self, self.RefreshAvgHeroFaceColor)
  self:LoadHeroPic()
end

UINAvgHeroPic.LoadHeroPic = function(self)
  -- function num : 0_1 , upvalues : CS_ResLoader, _ENV, AvgImgTweenUntil
  self.loadResComplete = false
  self.resloader = (CS_ResLoader.Create)()
  local path = PathConsts:GetCharacterBigImgPrefabPath((self.imgCfg).imgPath)
  ;
  (self.resloader):LoadABAssetAsync(path, function(prefab)
    -- function num : 0_1_0 , upvalues : self, _ENV, AvgImgTweenUntil
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
      self:InitAvgHeroPicParam()
      self.loadResComplete = true
      for k,tweenCfg in ipairs(self.tweenCfgList) do
        (AvgImgTweenUntil.Tween)(self, tweenCfg)
      end
      self:PlayAvgImgTween()
      if self.faceId ~= nil then
        self:AvgHeroChangeFace(self.faceId)
      end
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
  self:RefreshAvgHeroFaceColor()
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
        -- DECOMPILER ERROR at PC54: Confused about usage of register: R3 in 'UnsetPending'

        ;
        ((self.ui).rawImg).material = nil
        self.commItem = nil
      end
      -- DECOMPILER ERROR at PC63: Confused about usage of register: R3 in 'UnsetPending'

      if self.faceRawImg ~= nil then
        (self.faceRawImg).material = ((self.ui).rawImg).material
      end
    end
  end
end

UINAvgHeroPic.RefreshAvgHeroFaceColor = function(self)
  -- function num : 0_7
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  if self.faceRawImg ~= nil then
    (self.faceRawImg).color = ((self.ui).rawImg).color
  end
end

UINAvgHeroPic.AvgHeroChangeFace = function(self, faceId)
  -- function num : 0_8 , upvalues : CS_GameObject, _ENV, CS_RectTransform, CS_RawImage
  self.faceId = faceId
  if not self.loadResComplete then
    return 
  end
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

  if faceId == 0 then
    if self.faceRawImg ~= nil then
      (self.faceRawImg).enabled = false
    end
    return 
  end
  do
    if self.faceRawImg == nil then
      local go = CS_GameObject("Face")
      ;
      (go.transform):SetParent((self.picGo).transform, false)
      go:AddComponent(typeof(CS_RectTransform))
      self.faceRawImg = go:AddComponent(typeof(CS_RawImage))
      -- DECOMPILER ERROR at PC37: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (self.faceRawImg).raycastTarget = false
      -- DECOMPILER ERROR at PC39: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (self.faceRawImg).enabled = false
    end
    -- DECOMPILER ERROR at PC44: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.faceRawImg).transform).sizeDelta = (self.commonPicCtrl).avgFaceSize
    -- DECOMPILER ERROR at PC49: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.faceRawImg).transform).localPosition = (self.commonPicCtrl).avgFacePos
    -- DECOMPILER ERROR at PC54: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self.faceRawImg).material = ((self.ui).rawImg).material
    self:RefreshAvgHeroFaceColor()
    local path = PathConsts:GetCharacterFaceImgPath((self.imgCfg).imgPath, tostring(faceId))
    ;
    (self.resloader):LoadABAssetAsync(path, function(texture)
    -- function num : 0_8_0 , upvalues : self
    if texture == nil then
      return 
    end
    -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (self.faceRawImg).texture = texture
    -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (self.faceRawImg).enabled = true
  end
)
  end
end

UINAvgHeroPic.GetAvgImgType = function(self)
  -- function num : 0_9
  return (self.imgCfg).imgType
end

UINAvgHeroPic.PlayAvgImgTween = function(self)
  -- function num : 0_10
  if self.sequence ~= nil and self.loadResComplete then
    (self.sequence):AppendCallback(self:GetAvgImgTweenCompleteEvent())
    ;
    (self.sequence):Play()
    if self.immediateComplete then
      self:AvgImgTweenDoComplete()
    end
  end
end

UINAvgHeroPic.AddAvgImgTween = function(self, tweenCfg)
  -- function num : 0_11 , upvalues : AvgImgTweenUntil, _ENV
  if self.loadResComplete then
    (AvgImgTweenUntil.Tween)(self, tweenCfg)
  else
    ;
    (table.insert)(self.tweenCfgList, tweenCfg)
  end
end

UINAvgHeroPic.GetAvgImgSequence = function(self)
  -- function num : 0_12
  return self.sequence
end

UINAvgHeroPic.SetAvgImgSequence = function(self, sequence)
  -- function num : 0_13
  self.sequence = sequence
end

UINAvgHeroPic.GetAvgImgTweenCompleteEvent = function(self)
  -- function num : 0_14 , upvalues : _ENV
  if self.__onTweenComplete == nil then
    self.__onTweenComplete = BindCallback(self, self.OnTweenComplete)
  end
  return self.__onTweenComplete
end

UINAvgHeroPic.OnTweenComplete = function(self)
  -- function num : 0_15
  self.sequence = nil
  self.tweenCfgList = {}
  if self.tweenCompleteEvent ~= nil then
    (self.tweenCompleteEvent)(self.imgId)
  end
end

UINAvgHeroPic.AvgImgTweenDoComplete = function(self)
  -- function num : 0_16
  if self.sequence ~= nil and (self.sequence):IsPlaying() then
    (self.sequence):Complete(true)
  else
    self.immediateComplete = true
  end
end

UINAvgHeroPic.Delete = function(self)
  -- function num : 0_17 , upvalues : _ENV
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
  if self.sequence ~= nil then
    (self.sequence):Kill()
    self.sequence = nil
  end
  self:__ShowCommunication(false)
  DestroyUnityObject(self.gameObject)
end

return UINAvgHeroPic

