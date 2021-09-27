local HomeAdjutant = class("HomeAdjutant")
local HeroCubismInteration = require("Game.Hero.Live2D.HeroCubismInteration")
local HeroLookTargetController = require("Game.Hero.Live2D.HeroLookTargetController")
local cs_ResLoader = CS.ResLoader
HomeAdjutant.ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.homeController = ControllerManager:GetController(ControllerTypeId.HomeController, true)
  self._LoadBoardHero = BindCallback(self, self.LoadBoardHero)
  self.__OnSkinChange = BindCallback(self, self.OnSkinChange)
  MsgCenter:AddListener(eMsgEventId.OnHeroSkinChange, self.__OnSkinChange)
end

HomeAdjutant.InitHomeAdjutant = function(self, bind, heroHolder, emptyHolder, loadOverCallback)
  -- function num : 0_1 , upvalues : _ENV
  self.bind = bind
  self.heroHolder = heroHolder
  self.isInit = true
  self.emptyHolder = emptyHolder
  self.loadOverCallback = loadOverCallback
  if (math.random)(100000) == 666 then
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
    self.__randTimerId = TimerManager:StartTimer(0.6, function()
      -- function num : 0_1_0_0 , upvalues : self
      self.__randTimerId = nil
      self:LoadBoardHero((self.homeController):GetAdjutant())
    end
, nil, true)
  end
)
    return 
  end
  self:LoadBoardHero((self.homeController):GetAdjutant())
  self:RecordPosOnBorn()
end

HomeAdjutant.LoadBoardHero = function(self, heroData, callback, isForce)
  -- function num : 0_2 , upvalues : _ENV, HeroCubismInteration
  local finishCallback = function()
    -- function num : 0_2_0 , upvalues : callback, self
    if callback ~= nil then
      callback()
    end
    if self.loadOverCallback ~= nil then
      (self.loadOverCallback)()
    end
  end

  -- DECOMPILER ERROR at PC15: Unhandled construct in 'MakeBoolean' P1

  -- DECOMPILER ERROR at PC15: Unhandled construct in 'MakeBoolean' P1

  if not isForce and heroData ~= nil and (self.homeController).homeCurrAdjutantHeroData == heroData then
    -- DECOMPILER ERROR at PC15: Unhandled construct in 'MakeBoolean' P1

    if not self.isInit and finishCallback ~= nil then
      finishCallback()
    end
    return 
  end
  if self.__randTimerId ~= nil then
    TimerManager:StopTimer(self.__randTimerId)
    self.__randTimerId = nil
  end
  self.isInit = false
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.homeController).homeCurrAdjutantHeroData = heroData
  self:RecoverLastL2DRenderData()
  local resName = heroData:GetResPicName()
  local Live2DPath = PathConsts:GetCharacterLive2DPath(resName)
  local haveLive2D = ((CS.ResManager).Instance):ContainsAsset(Live2DPath)
  local isLocked = (HeroCubismInteration.JudgeL2DLocked)(((self.homeController).homeCurrAdjutantHeroData).dataId)
  local homeController = ControllerManager:GetController(ControllerTypeId.HomeController, true)
  if haveLive2D and not isLocked then
    if self.bigImgResloader ~= nil then
      (self.bigImgResloader):Put2Pool()
      self.bigImgResloader = nil
    end
    if self.bigImgGameObject ~= nil then
      DestroyUnityObject(self.bigImgGameObject)
      self.bigImgGameObject = nil
    end
    if self.heroCubismInteration ~= nil then
      (self.heroCubismInteration):Delete()
      self.heroCubismInteration = nil
    end
    self:LoadLive2D(Live2DPath, finishCallback)
    if homeController ~= nil then
      homeController:setIsLive2D(true)
    end
  else
    if self.Live2DResloader ~= nil then
      (self.Live2DResloader):Put2Pool()
      self.Live2DResloader = nil
    end
    if self.l2dModelIns ~= nil then
      DestroyUnityObject(self.l2dModelIns)
      self.l2dModelIns = nil
    end
    if self.heroCubismInteration ~= nil then
      (self.heroCubismInteration):Delete()
      self.heroCubismInteration = nil
    end
    self.l2dBinding = nil
    self:LoadHeroPic(resName, finishCallback)
    if homeController ~= nil then
      homeController:setIsLive2D(false)
    end
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

HomeAdjutant.HideBordGirl = function(self)
  -- function num : 0_4
  if self.l2dModelIns ~= nil then
    (self.heroCubismInteration):IsOpenWait(false)
    ;
    (self.heroCubismInteration):IsOpenRayCast(false)
    ;
    ((self.l2dModelIns).transform):SetParent((self.emptyHolder).transform, false)
  end
  if self.bigImgGameObject ~= nil then
    ((self.bigImgGameObject).transform):SetParent((self.emptyHolder).transform, false)
  end
end

HomeAdjutant.ShowBordGirl = function(self)
  -- function num : 0_5
  if self.l2dModelIns ~= nil then
    (self.heroCubismInteration):IsOpenWait(true)
    ;
    (self.heroCubismInteration):IsOpenRayCast(true)
    ;
    ((self.l2dModelIns).transform):SetParent(((self.bind).live2DRoot).transform, false)
  end
  if self.bigImgGameObject ~= nil then
    ((self.bigImgGameObject).transform):SetParent((self.heroHolder).transform, false)
  end
end

HomeAdjutant.IsOpenLive2DWait = function(self, flag)
  -- function num : 0_6
  if self.heroCubismInteration ~= nil then
    (self.heroCubismInteration):IsOpenWait(flag)
    ;
    (self.heroCubismInteration):IsOpenRayCast(flag)
  end
end

HomeAdjutant.LoadLive2D = function(self, Live2DPath, finishCallback)
  -- function num : 0_7 , upvalues : cs_ResLoader, _ENV, HeroCubismInteration, HeroLookTargetController
  if self.Live2DResloader ~= nil then
    (self.Live2DResloader):Put2Pool()
    self.Live2DResloader = nil
  end
  self.Live2DResloader = (cs_ResLoader.Create)()
  ;
  (self.Live2DResloader):LoadABAssetAsync(Live2DPath, function(l2dModelAsset)
    -- function num : 0_7_0 , upvalues : _ENV, self, HeroCubismInteration, HeroLookTargetController, finishCallback
    DestroyUnityObject(self.l2dModelIns)
    self.l2dModelIns = l2dModelAsset:Instantiate(((self.bind).live2DRoot).transform)
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.l2dModelIns).gameObject).layer = (((self.bind).live2DRoot).gameObject).layer
    local heroId = ((self.homeController).homeCurrAdjutantHeroData).dataId
    local skinId = ((self.homeController).homeCurrAdjutantHeroData).skinId
    local cs_CubismInterationController = ((self.l2dModelIns).gameObject):GetComponent(typeof((((((CS.Live2D).Cubism).Samples).OriginalWorkflow).Demo).CubismInterationController))
    if cs_CubismInterationController ~= nil then
      self.heroCubismInteration = (HeroCubismInteration.New)()
      ;
      (self.heroCubismInteration):InitHeroCubism(cs_CubismInterationController, heroId, skinId, UIManager:GetMainCamera(), true)
    end
    self.l2dBinding = {}
    ;
    (UIUtil.LuaUIBindingTable)(self.l2dModelIns, self.l2dBinding)
    local canvasGroup = (self.bind).canvas_canvasGroup
    -- DECOMPILER ERROR at PC63: Confused about usage of register: R5 in 'UnsetPending'

    if canvasGroup ~= nil then
      ((self.l2dBinding).renderController).uiCanvasGroup = canvasGroup
    end
    local cubismLookController = ((self.l2dModelIns).gameObject):GetComponent(typeof(((((CS.Live2D).Cubism).Framework).LookAt).CubismLookController))
    ;
    (HeroLookTargetController.OpenLookTarget)(cubismLookController, ((self.l2dBinding).lookTarget).gameObject, UIManager:GetMainCamera())
    local cubismCriwareAudioMouthInput = ((self.l2dModelIns).gameObject):GetComponent(typeof(CS.CubismCriwareAudioMouthInput))
    cubismCriwareAudioMouthInput.enabled = (self.homeController):JudgeMouseOpen()
    -- DECOMPILER ERROR at PC99: Confused about usage of register: R7 in 'UnsetPending'

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
  -- function num : 0_8
  if (self.homeController):GetAdjutantHeroId() == heroId then
    self:LoadBoardHero(((self.homeController):GetAdjutant()), nil, true)
  end
end

HomeAdjutant.RecoverLastL2DRenderData = function(self)
  -- function num : 0_9
  if self.l2dBinding ~= nil and (self.l2dBinding).commonPerpectiveHandle ~= nil then
    ((self.l2dBinding).commonPerpectiveHandle):RecoverRenderCameraData()
  end
end

HomeAdjutant.RecordPosOnBorn = function(self)
  -- function num : 0_10
  if self.heroHolder ~= nil then
    self.picHolderPosOnBornX = (((self.heroHolder).transform).localPosition).x
  end
  if ((self.bind).live2DRoot).transform ~= nil then
    self.live2DHolderPosOnBornX = ((((self.bind).live2DRoot).transform).localPosition).x
  end
end

HomeAdjutant.HomeRightUnfoldRate = function(self, rate)
  -- function num : 0_11
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
  -- function num : 0_12 , upvalues : _ENV
  if self.__randTimerId ~= nil then
    TimerManager:StopTimer(self.__randTimerId)
    self.__randTimerId = nil
  end
  if self.bigImgResloader ~= nil then
    (self.bigImgResloader):Put2Pool()
    self.bigImgResloader = nil
  end
  if self.Live2DResloader ~= nil then
    (self.Live2DResloader):Put2Pool()
    self.Live2DResloader = nil
  end
  if self.heroCubismInteration ~= nil then
    (self.heroCubismInteration):Delete()
    self.heroCubismInteration = nil
  end
  MsgCenter:RemoveListener(eMsgEventId.OnHeroSkinChange, self.__OnSkinChange)
end

return HomeAdjutant

