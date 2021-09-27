local UIPreviewSkin = class("UIPreviewSkin", UIBaseWindow)
local base = UIBaseWindow
local HeroCubismInteration = require("Game.Hero.Live2D.HeroCubismInteration")
local HeroLookTargetController = require("Game.Hero.Live2D.HeroLookTargetController")
UIPreviewSkin.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.skinCtrl = ControllerManager:GetController(ControllerTypeId.Skin, true)
  ;
  (((self.ui).img_Star).gameObject):SetActive(false)
  self.starList = {}
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_background, self, self.__OnClickClose)
end

UIPreviewSkin.OnShow = function(self)
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

UIPreviewSkin.ShowSkinPreview = function(self, skinId, heroStar)
  -- function num : 0_2 , upvalues : _ENV, HeroCubismInteration
  (UIUtil.SetTopStatus)(self, self.Delete)
  local heroId = (self.skinCtrl):GetHeroId(skinId)
  local skinCfg = (ConfigData.skin)[skinId]
  local resModelCfg = (self.skinCtrl):GetResModel(heroId, skinCfg ~= nil and skinCfg.id or nil)
  local heroData = (PlayerDataCenter.heroDic)[heroId]
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).tex_HeroName).text = heroData:GetName()
  if heroStar ~= nil then
    self:__RefreshStar(heroStar)
  end
  local resPath = PathConsts:GetCharacterLive2DPath(resModelCfg.src_id_pic)
  local haveLive2D = ((CS.ResManager).Instance):ContainsAsset(resPath)
  self.l2dBinding = nil
  if haveLive2D and not (HeroCubismInteration.JudgeL2DLocked)(skinCfg.id) then
    self:__LoadLive2D(resPath, skinCfg)
  else
    self:__LoadPic(PathConsts:GetCharacterBigImgPrefabPath(resModelCfg.src_id_pic))
  end
end

UIPreviewSkin.__RefreshStar = function(self, heroStar)
  -- function num : 0_3 , upvalues : _ENV
  for k,v in ipairs(self.starList) do
    (v.gameObject):SetActive(false)
    v:SetIndex(0)
  end
  local count = (math.ceil)(heroStar / 2)
  local isHalf = heroStar % 2 == 1
  for i = 1, count do
    local star = (self.starList)[i]
    if star == nil then
      star = ((((self.ui).img_Star).gameObject):Instantiate()):GetComponent(typeof(CS.UiImageItemInfo))
      ;
      (table.insert)(self.starList, star)
    end
    ;
    (star.gameObject):SetActive(true)
    if isHalf and i == count then
      star:SetIndex(1)
    end
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

UIPreviewSkin.__LoadLive2D = function(self, path, skinCfg)
  -- function num : 0_4 , upvalues : _ENV, HeroCubismInteration, HeroLookTargetController
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
    -- function num : 0_4_0 , upvalues : self, _ENV, HeroCubismInteration, skinCfg, HeroLookTargetController
    self.l2dModelIns = l2dModelAsset:Instantiate(((self.ui).heroHolder).transform)
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
      ((self.l2dBinding).renderController).SortingLayer = "UIMiddle"
      -- DECOMPILER ERROR at PC77: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((self.l2dBinding).renderController).uiCanvasGroup = (self.ui).heroHolder
      ;
      ((self.l2dBinding).commonPerpectiveHandle):SetL2DPosType("SkinPreview", false)
    end
  end
)
end

UIPreviewSkin.__LoadPic = function(self, path)
  -- function num : 0_5 , upvalues : _ENV
  if self.bigImgResloader ~= nil then
    (self.bigImgResloader):Put2Pool()
    self.bigImgResloader = nil
  end
  self.bigImgResloader = ((CS.ResLoader).Create)()
  ;
  (self.bigImgResloader):LoadABAssetAsync(path, function(prefab)
    -- function num : 0_5_0 , upvalues : self, _ENV
    self.bigImgGameObject = prefab:Instantiate(((self.ui).picHolder).transform)
    local commonPicCtrl = (self.bigImgGameObject):FindComponent(eUnityComponentID.CommonPicController)
    commonPicCtrl:SetPosType("SkinPreview")
  end
)
end

UIPreviewSkin.__OnClickClose = function(self)
  -- function num : 0_6 , upvalues : _ENV
  (UIUtil.OnClickBack)()
end

UIPreviewSkin.OnDelete = function(self)
  -- function num : 0_7 , upvalues : _ENV, base
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
  if not IsNull(self.bigImgGameObject) then
    DestroyUnityObject(self.bigImgGameObject)
  end
  if not IsNull(self.l2dModelIns) then
    DestroyUnityObject(self.l2dModelIns)
  end
  ;
  (base.OnDelete)(self)
end

return UIPreviewSkin

