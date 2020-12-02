-- params : ...
-- function num : 0 , upvalues : _ENV
local UINHomeAdjutant = class("UINHomeAdjutant", UIBaseNode)
local base = UIBaseNode
local cs_ResLoader = CS.ResLoader
UINHomeAdjutant.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.homeController = ControllerManager:GetController(ControllerTypeId.HomeController, true)
  self._LoadBoardHero = BindCallback(self, self.LoadBoardHero)
end

UINHomeAdjutant.InitHomeAdjutant = function(self, bind)
  -- function num : 0_1
  self.bind = bind
  self.isInit = true
  self:LoadBoardHero((self.homeController):GetAdjutant())
end

UINHomeAdjutant.LoadBoardHero = function(self, heroData, finishCallback)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC12: Unhandled construct in 'MakeBoolean' P1

  if heroData ~= nil and (self.homeController).homeCurrAdjutantHeroData == heroData then
    -- DECOMPILER ERROR at PC12: Unhandled construct in 'MakeBoolean' P1

    if not self.isInit and finishCallback ~= nil then
      finishCallback()
    end
    return 
  end
  self.isInit = false
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.homeController).homeCurrAdjutantHeroData = heroData
  local resName = heroData:GetResName()
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
    self:LoadHeroPic(resName, finishCallback)
  end
end

UINHomeAdjutant.LoadHeroPic = function(self, resName, finishCallback)
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
    self.bigImgGameObject = prefab:Instantiate(self.transform)
    local comPerspHandle = (self.bigImgGameObject):FindComponent(eUnityComponentID.CommonPicController)
    comPerspHandle:SetRenderCamera((self.bind).live2DRoot)
    comPerspHandle:SetL2DPicPosType("Home", true)
    if finishCallback ~= nil then
      finishCallback()
    end
  end
)
end

UINHomeAdjutant.LoadLive2D = function(self, Live2DPath, finishCallback)
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

UINHomeAdjutant.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnDelete)(self)
end

return UINHomeAdjutant

