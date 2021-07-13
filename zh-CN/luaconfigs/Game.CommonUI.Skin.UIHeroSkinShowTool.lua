-- params : ...
-- function num : 0 , upvalues : _ENV
local UIHeroSkinShowTool = class("UIHeroSkinShowTool")
local cs_ResManger = (CS.ResManager).Instance
UIHeroSkinShowTool.InitSkinShow = function(self, heroHolder, picHolder, sortingLayer)
  -- function num : 0_0
  self.heroHolder = heroHolder
  self.picHolder = picHolder
  self.sortingLayer = sortingLayer
end

UIHeroSkinShowTool.ShowSkinById = function(self, skinId)
  -- function num : 0_1 , upvalues : _ENV, cs_ResManger
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
  if haveLive2D then
    self:LoadLive2D(resPath)
  else
    self:LoadPic(PathConsts:GetCharacterBigImgPrefabPath(skinCfg.src_id_pic))
  end
end

UIHeroSkinShowTool.LoadLive2D = function(self, path)
  -- function num : 0_2 , upvalues : _ENV
  if self.Live2DResloader ~= nil then
    (self.Live2DResloader):Put2Pool()
    self.Live2DResloader = nil
  end
  self.Live2DResloader = ((CS.ResLoader).Create)()
  ;
  (self.Live2DResloader):LoadABAssetAsync(path, function(l2dModelAsset)
    -- function num : 0_2_0 , upvalues : self, _ENV
    self.l2dModelIns = l2dModelAsset:Instantiate((self.heroHolder).transform)
    ;
    ((self.l2dModelIns).transform):SetLayer(LayerMask.UI)
    self.l2dBinding = {}
    ;
    (UIUtil.LuaUIBindingTable)(self.l2dModelIns, self.l2dBinding)
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.l2dBinding).renderController).SortingLayer = self.sortingLayer
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.l2dBinding).renderController).uiCanvasGroup = self.heroHolder
    ;
    ((self.l2dBinding).commonPerpectiveHandle):SetL2DPosType("SkinPreview", false)
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
  if self.bigImgResloader ~= nil then
    (self.bigImgResloader):Put2Pool()
    self.bigImgResloader = nil
  end
end

return UIHeroSkinShowTool

