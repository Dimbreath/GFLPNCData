local UIHeroSkinShowTool = class("UIHeroSkinShowTool")
local HeroCubismInteration = require("Game.Hero.Live2D.HeroCubismInteration")
local HeroLookTargetController = require("Game.Hero.Live2D.HeroLookTargetController")
local cs_ResManger = (CS.ResManager).Instance
UIHeroSkinShowTool.InitSkinShow = function(self, heroHolder, picHolder, sortingLayer)
  -- function num : 0_0
  self.heroHolder = heroHolder
  self.picHolder = picHolder
  self.sortingLayer = sortingLayer
end

UIHeroSkinShowTool.ShowSkinById = function(self, skinId)
  -- function num : 0_1 , upvalues : _ENV, cs_ResManger, HeroCubismInteration
  local skinCfg = (ConfigData.skin)[skinId]
  if skinCfg == nil then
    error("skin cfg is null,skinId:" .. tostring(skinId))
    return 
  end
  if self.l2dModelIns ~= nil then
    DestroyUnityObject(self.l2dModelIns)
  end
  if self.bigImgGameObject ~= nil then
    DestroyUnityObject(self.bigImgGameObject)
  end
  local resPath = PathConsts:GetCharacterLive2DPath(skinCfg.src_id_pic)
  local haveLive2D = cs_ResManger:ContainsAsset(resPath)
  local isLocked = (HeroCubismInteration.JudgeL2DLocked)(skinCfg.id)
  if haveLive2D and not isLocked then
    self:LoadLive2D(resPath, skinCfg)
  else
    self:LoadPic(PathConsts:GetCharacterBigImgPrefabPath(skinCfg.src_id_pic))
  end
end

UIHeroSkinShowTool.LoadLive2D = function(self, path, skinCfg)
  -- function num : 0_2 , upvalues : _ENV, HeroCubismInteration, HeroLookTargetController
  if self.Live2DResloader ~= nil then
    (self.Live2DResloader):Put2Pool()
    self.Live2DResloader = nil
  end
  if self.heroCubismInteration ~= nil then
    (self.heroCubismInteration):Delete()
    self.heroCubismInteration = nil
  end
  self.Live2DResloader = ((CS.ResLoader).Create)()
  ;
  (self.Live2DResloader):LoadABAssetAsync(path, function(l2dModelAsset)
    -- function num : 0_2_0 , upvalues : self, _ENV, HeroCubismInteration, skinCfg, HeroLookTargetController
    self.l2dModelIns = l2dModelAsset:Instantiate((self.heroHolder).transform)
    ;
    ((self.l2dModelIns).transform):SetLayer(LayerMask.UI)
    local cs_CubismInterationController = ((self.l2dModelIns).gameObject):GetComponent(typeof((((((CS.Live2D).Cubism).Samples).OriginalWorkflow).Demo).CubismInterationController))
    if cs_CubismInterationController ~= nil then
      self.heroCubismInteration = (HeroCubismInteration.New)()
      local heroId = skinCfg.heroId
      local skinId = skinCfg.id
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
      -- DECOMPILER ERROR at PC72: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((self.l2dBinding).renderController).SortingLayer = self.sortingLayer
      -- DECOMPILER ERROR at PC76: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((self.l2dBinding).renderController).uiCanvasGroup = self.heroHolder
      ;
      ((self.l2dBinding).commonPerpectiveHandle):SetL2DPosType("SkinPreview", false)
    end
  end
)
end

UIHeroSkinShowTool.LoadPic = function(self, path)
  -- function num : 0_3 , upvalues : _ENV
  if self.bigImgResloader ~= nil then
    (self.bigImgResloader):Put2Pool()
    self.bigImgResloader = nil
  end
  self.bigImgResloader = ((CS.ResLoader).Create)()
  ;
  (self.bigImgResloader):LoadABAssetAsync(path, function(prefab)
    -- function num : 0_3_0 , upvalues : self, _ENV
    self.bigImgGameObject = prefab:Instantiate((self.picHolder).transform)
    local commonPicCtrl = (self.bigImgGameObject):FindComponent(eUnityComponentID.CommonPicController)
    commonPicCtrl:SetPosType("HeroList")
  end
)
end

UIHeroSkinShowTool.OnDelete = function(self)
  -- function num : 0_4
  if self.Live2DResloader ~= nil then
    (self.Live2DResloader):Put2Pool()
    self.Live2DResloader = nil
  end
  if self.heroCubismInteration ~= nil then
    (self.heroCubismInteration):Delete()
    self.heroCubismInteration = nil
  end
  if self.bigImgResloader ~= nil then
    (self.bigImgResloader):Put2Pool()
    self.bigImgResloader = nil
  end
end

return UIHeroSkinShowTool

