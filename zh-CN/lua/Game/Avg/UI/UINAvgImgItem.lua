local UINAvgImgItem = class("UINAvgImgItem", UIBaseNode)
local base = UIBaseNode
local eAvgImgType = require("Game.Avg.Enum.eAvgImgType")
local eAvgImgPosType = require("Game.Avg.Enum.eAvgImgPosType")
local AvgImgTweenUntil = require("Game.Avg.AvgImgTweenUntil")
local CS_ResLoader = CS.ResLoader
local CS_MovieManager_ins = (CS.MovieManager).Instance
UINAvgImgItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).rawImg).enabled = false
  self.avgCtrl = ControllerManager:GetController(ControllerTypeId.Avg)
end

UINAvgImgItem.InitAvgImgItem = function(self, imgCfg, parent, tweenCompleteEvent)
  -- function num : 0_1 , upvalues : eAvgImgType
  self.imgId = imgCfg.imgId
  self.imgCfg = imgCfg
  self.tweenCompleteEvent = tweenCompleteEvent
  self.immediateComplete = false
  self.tweenCfgList = {}
  ;
  (self.transform):SetParent(parent)
  self:InitAvgImgParam()
  if (self.imgCfg).imgType ~= eAvgImgType.Movie then
    self:LoadTexture()
  else
    self:LoadMovie()
  end
end

UINAvgImgItem.InitAvgImgParam = function(self)
  -- function num : 0_2 , upvalues : eAvgImgPosType, _ENV
  local imgCfg = self.imgCfg
  local pos = nil
  if imgCfg.posId ~= nil then
    pos = eAvgImgPosType[imgCfg.posId]
  else
    if imgCfg.pos ~= nil then
      pos = (Vector3.New)((imgCfg.pos)[1], (imgCfg.pos)[2], (imgCfg.pos)[3])
    else
      pos = Vector3.zero
    end
  end
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.transform).localPosition = pos
  local rot = nil
  if imgCfg.rot == nil then
    rot = Vector3.zero
  else
    rot = (Vector3.New)((imgCfg.rot)[1], (imgCfg.rot)[2], (imgCfg.rot)[3])
  end
  -- DECOMPILER ERROR at PC44: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.transform).localEulerAngles = rot
  local scale = nil
  if imgCfg.scale == nil then
    scale = Vector3.one
  else
    scale = (Vector3.New)((imgCfg.scale)[1], (imgCfg.scale)[2], (imgCfg.scale)[3])
  end
  -- DECOMPILER ERROR at PC63: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.transform).localScale = scale
  if not imgCfg.isDark or not Color.gray then
    local color = Color.white
  end
  if imgCfg.alpha ~= nil or not (((self.ui).rawImg).color).a then
    local alpha = imgCfg.alpha
  end
  color.a = alpha
  -- DECOMPILER ERROR at PC86: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).rawImg).color = color
end

UINAvgImgItem.LoadTexture = function(self)
  -- function num : 0_3 , upvalues : CS_ResLoader, _ENV, eAvgImgType, AvgImgTweenUntil
  self.loadResComplete = false
  self.resloader = (CS_ResLoader.Create)()
  if (string.IsNullOrEmpty)((self.imgCfg).imgPath) then
    (self.avgCtrl):AvgLogError("imgPath is empty, imgid = " .. tostring(self.imgId))
    return 
  end
  local path = PathConsts:GetAvgImgPath((self.imgCfg).imgPath)
  ;
  (self.resloader):LoadABAssetAsync(path, function(texture)
    -- function num : 0_3_0 , upvalues : self, eAvgImgType, _ENV, AvgImgTweenUntil
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

    ((self.ui).rawImg).texture = texture
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).rawImg).enabled = true
    if (self.imgCfg).imgType ~= eAvgImgType.Character then
      if (self.imgCfg).fullScreen then
        ((self.ui).bgUIAdapter):AdaptBgUI()
      else
        ;
        ((self.ui).rawImg):SetNativeSize()
      end
    end
    self.loadResComplete = true
    for k,tweenCfg in ipairs(self.tweenCfgList) do
      (AvgImgTweenUntil.Tween)(self, tweenCfg)
    end
    self:PlayAvgImgTween()
  end
)
end

UINAvgImgItem.LoadMovie = function(self)
  -- function num : 0_4 , upvalues : CS_MovieManager_ins, _ENV, AvgImgTweenUntil
  self.moviePlayer = CS_MovieManager_ins:GetMoviePlayer()
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).rawImg).enabled = true
  ;
  (self.moviePlayer):SetVideoRender((self.ui).rawImg)
  ;
  (self.moviePlayer):PlayVideo((self.imgCfg).imgPath, nil, 1, true)
  ;
  ((self.ui).bgUIAdapter):AdaptBgUI()
  self.loadResComplete = true
  for k,tweenCfg in ipairs(self.tweenCfgList) do
    (AvgImgTweenUntil.Tween)(self, tweenCfg)
  end
  self:PlayAvgImgTween()
end

UINAvgImgItem.GetAvgImgOrder = function(self)
  -- function num : 0_5
  return (self.imgCfg).order or 0
end

UINAvgImgItem.ChangeAvgImgOrder = function(self, order)
  -- function num : 0_6
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.imgCfg).order = order
end

UINAvgImgItem.PlayAvgImgTween = function(self)
  -- function num : 0_7
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

UINAvgImgItem.AddAvgImgTween = function(self, tweenCfg)
  -- function num : 0_8 , upvalues : AvgImgTweenUntil, _ENV
  if self.loadResComplete then
    (AvgImgTweenUntil.Tween)(self, tweenCfg)
  else
    ;
    (table.insert)(self.tweenCfgList, tweenCfg)
  end
end

UINAvgImgItem.GetAvgImgSequence = function(self)
  -- function num : 0_9
  return self.sequence
end

UINAvgImgItem.SetAvgImgSequence = function(self, sequence)
  -- function num : 0_10
  self.sequence = sequence
end

UINAvgImgItem.GetAvgImgTweenCompleteEvent = function(self)
  -- function num : 0_11 , upvalues : _ENV
  if self.__onTweenComplete == nil then
    self.__onTweenComplete = BindCallback(self, self.OnTweenComplete)
  end
  return self.__onTweenComplete
end

UINAvgImgItem.OnTweenComplete = function(self)
  -- function num : 0_12
  self.sequence = nil
  self.tweenCfgList = {}
  if self.tweenCompleteEvent ~= nil then
    (self.tweenCompleteEvent)(self.imgId)
  end
end

UINAvgImgItem.AvgImgTweenDoComplete = function(self)
  -- function num : 0_13
  if self.sequence ~= nil and (self.sequence):IsPlaying() then
    (self.sequence):Complete(true)
  else
    self.immediateComplete = true
  end
end

UINAvgImgItem.GetAvgImgType = function(self)
  -- function num : 0_14
  return (self.imgCfg).imgType
end

UINAvgImgItem.OnHide = function(self)
  -- function num : 0_15
  self:OnRecycleAvgImg()
end

UINAvgImgItem.OnRecycleAvgImg = function(self)
  -- function num : 0_16 , upvalues : CS_MovieManager_ins
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
  if self.moviePlayer ~= nil then
    CS_MovieManager_ins:ReturnMoviePlayer(self.moviePlayer)
    self.moviePlayer = nil
  end
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).rawImg).texture = nil
  if self.sequence ~= nil then
    (self.sequence):Kill()
    self.sequence = nil
  end
end

UINAvgImgItem.OnDelete = function(self)
  -- function num : 0_17 , upvalues : base
  self:OnRecycleAvgImg()
  ;
  (base.OnDelete)(self)
end

return UINAvgImgItem

