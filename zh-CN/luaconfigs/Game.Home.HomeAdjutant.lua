-- params : ...
-- function num : 0 , upvalues : _ENV
local HomeAdjutant = class("HomeAdjutant")
local cs_ResLoader = CS.ResLoader
HomeAdjutant.ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.homeController = ControllerManager:GetController(ControllerTypeId.HomeController, true)
  self._LoadBoardHero = BindCallback(self, self.LoadBoardHero)
  self.__OnSkinChange = BindCallback(self, self.OnSkinChange)
  MsgCenter:AddListener(eMsgEventId.OnHeroSkinChange, self.__OnSkinChange)
end

HomeAdjutant.InitHomeAdjutant = function(self, bind, heroHolder)
  -- function num : 0_1 , upvalues : _ENV
  self.bind = bind
  self.heroHolder = heroHolder
  self.isInit = true
  if (math.random)(1000) == 666 then
    if self.Live2DResloader ~= nil then
      (self.Live2DResloader):Put2Pool()
      self.Live2DResloader = nil
    end
    if self.l2dModelIns ~= nil then
      DestroyUnityObject(self.l2dModelIns)
      self.l2dModelIns = nil
    end
    self:LoadHeroPic("miemiezi", function()
    -- function num : 0_1_0 , upvalues : self, _ENV
    self.__randTimer = (TimerManager:GetTimer(0.6, function()
      -- function num : 0_1_0_0 , upvalues : self
      self.__randTimer = nil
      self:LoadBoardHero((self.homeController):GetAdjutant())
    end
, nil, true)):Start()
  end
)
    return 
  end
  self:LoadBoardHero((self.homeController):GetAdjutant())
  self:RecordPosOnBorn()
end

HomeAdjutant.LoadBoardHero = function(self, heroData, finishCallback, isForce)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC14: Unhandled construct in 'MakeBoolean' P1

  -- DECOMPILER ERROR at PC14: Unhandled construct in 'MakeBoolean' P1

  if not isForce and heroData ~= nil and (self.homeController).homeCurrAdjutantHeroData == heroData then
    -- DECOMPILER ERROR at PC14: Unhandled construct in 'MakeBoolean' P1

    if not self.isInit and finishCallback ~= nil then
      finishCallback()
    end
    return 
  end
  if self.__randTimer ~= nil then
    (self.__randTimer):Stop()
    self.__randTimer = nil
  end
  self.isInit = false
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.homeController).homeCurrAdjutantHeroData = heroData
  self:RecoverLastL2DRenderData()
  local resName = heroData:GetResPicName()
  local Live2DPath = PathConsts:GetCharacterLive2DPath(resName)
  local haveLive2D = ((CS.ResManager).Instance):ContainsAsset(Live2DPath)
  if haveLive2D then
    if self.bigImgResloader ~= nil then
      (self.bigImgResloader):Put2Pool()
      self.bigImgResloader = nil
    end
    if self.bigImgGameObject ~= nil then
      DestroyUnityObject(self.bigImgGameObject)
      self.bigImgGameObject = nil
    end
    self:LoadLive2D(Live2DPath, finishCallback)
  else
    if self.Live2DResloader ~= nil then
      (self.Live2DResloader):Put2Pool()
      self.Live2DResloader = nil
    end
    if self.l2dModelIns ~= nil then
      DestroyUnityObject(self.l2dModelIns)
      self.l2dModelIns = nil
    end
    self.l2dBinding = nil
    self:LoadHeroPic(resName, finishCallback)
  end
end

HomeAdjutant.LoadHeroPic = function(self, resName, finishCallback)
  -- function num : 0_3 , upvalues : cs_ResLoader, _ENV
  if self.bigImgResloader ~= nil then
    (self.bigImgResloader):Put2Pool()
    self.bigImgResloader = nil
  end
  self.bigImgResloader = (cs_ResLoader.Create)()
  ;
  (self.bigImgResloader):LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath(resName), function(prefab)
    -- function num : 0_3_0 , upvalues : _ENV, self, finishCallback
    DestroyUnityObject(self.bigImgGameObject)
    self.bigImgGameObject = prefab:Instantiate((self.heroHolder).transform)
    local comPerspHandle = (self.bigImgGameObject):FindComponent(eUnityComponentID.CommonPicController)
    comPerspHandle:SetL2DPicPosType("Home", true)
    if finishCallback ~= nil then
      finishCallback()
    end
  end
)
end

HomeAdjutant.LoadLive2D = function(self, Live2DPath, finishCallback)
  -- function num : 0_4 , upvalues : cs_ResLoader, _ENV
  if self.Live2DResloader ~= nil then
    (self.Live2DResloader):Put2Pool()
    self.Live2DResloader = nil
  end
  self.Live2DResloader = (cs_ResLoader.Create)()
  ;
  (self.Live2DResloader):LoadABAssetAsync(Live2DPath, function(l2dModelAsset)
    -- function num : 0_4_0 , upvalues : _ENV, self, finishCallback
    DestroyUnityObject(self.l2dModelIns)
    self.l2dModelIns = l2dModelAsset:Instantiate(((self.bind).live2DRoot).transform)
    self.l2dBinding = {}
    ;
    (UIUtil.LuaUIBindingTable)(self.l2dModelIns, self.l2dBinding)
    local canvasGroup = (self.bind).canvas_canvasGroup
    -- DECOMPILER ERROR at PC22: Confused about usage of register: R2 in 'UnsetPending'

    if canvasGroup ~= nil then
      ((self.l2dBinding).renderController).uiCanvasGroup = canvasGroup
    end
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.l2dBinding).renderController).InfluencedByUICanvas = true
    ;
    ((self.l2dBinding).commonPerpectiveHandle):SetRenderCamera((self.bind).live2DRoot)
    ;
    ((self.l2dBinding).commonPerpectiveHandle):SetL2DPosType("Home", true)
    if finishCallback ~= nil then
      finishCallback()
    end
  end
)
end

HomeAdjutant.OnSkinChange = function(self, heroId, skinId)
  -- function num : 0_5
  if (self.homeController):GetAdjutantHeroId() == heroId then
    self:LoadBoardHero(((self.homeController):GetAdjutant()), nil, true)
  end
end

HomeAdjutant.RecoverLastL2DRenderData = function(self)
  -- function num : 0_6
  if self.l2dBinding ~= nil and (self.l2dBinding).commonPerpectiveHandle ~= nil then
    ((self.l2dBinding).commonPerpectiveHandle):RecoverRenderCameraData()
  end
end

HomeAdjutant.RecordPosOnBorn = function(self)
  -- function num : 0_7
  if self.heroHolder ~= nil then
    self.picHolderPosOnBornX = (((self.heroHolder).transform).localPosition).x
  end
  if ((self.bind).live2DRoot).transform ~= nil then
    self.live2DHolderPosOnBornX = ((((self.bind).live2DRoot).transform).localPosition).x
  end
end

HomeAdjutant.HomeRightUnfoldRate = function(self, rate)
  -- function num : 0_8
  if not rate then
    rate = 0
  end
  local xValue = self.picHolderPosOnBornX or 0
  local offsXValue = (self.bind).picHolderSliderRatio * rate + xValue
  ;
  ((self.heroHolder).transform):SetLocalX(offsXValue)
  xValue = self.live2DHolderPosOnBornX or 0
  offsXValue = (self.bind).live2dHolderSliderRatio * rate + (xValue)
  ;
  (((self.bind).live2DRoot).transform):SetLocalX(offsXValue)
end

HomeAdjutant.Delete = function(self)
  -- function num : 0_9 , upvalues : _ENV
  if self.__randTimer ~= nil then
    (self.__randTimer):Stop()
    self.__randTimer = nil
  end
  if self.bigImgResloader ~= nil then
    (self.bigImgResloader):Put2Pool()
    self.bigImgResloader = nil
  end
  if self.Live2DResloader ~= nil then
    (self.Live2DResloader):Put2Pool()
    self.Live2DResloader = nil
  end
  MsgCenter:RemoveListener(eMsgEventId.OnHeroSkinChange, self.__OnSkinChange)
end

return HomeAdjutant

