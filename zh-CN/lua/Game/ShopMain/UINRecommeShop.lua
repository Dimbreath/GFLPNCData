local UINRecommeShop = class("UINRecommeShop", UIBaseNode)
local base = UIBaseNode
local UINRecommeShopPicItem = require("Game.ShopMain.UINRecommeShopPicItem")
local ShopEnum = require("Game.Shop.ShopEnum")
local cs_ResLoader = CS.ResLoader
local HeroCubismInteration = require("Game.Hero.Live2D.HeroCubismInteration")
local HeroLookTargetController = require("Game.Hero.Live2D.HeroLookTargetController")
local config = (ConfigData.recommend_dialogue).config
UINRecommeShop.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINRecommeShopPicItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.picPool = (UIItemPool.New)(UINRecommeShopPicItem, (self.ui).bannerItem)
  ;
  ((self.ui).bannerItem):SetActive(false)
  self.middlePicItem = (UINRecommeShopPicItem.New)()
  ;
  (self.middlePicItem):Init((self.ui).middle)
  self.smallPicItem = (UINRecommeShopPicItem.New)()
  ;
  (self.smallPicItem):Init((self.ui).small)
  self.singlePicItem = (UINRecommeShopPicItem.New)()
  ;
  (self.singlePicItem):Init((self.ui).singleBanner)
  self.countSizeX = (((self.ui).tr_count).sizeDelta).x
  self.__LoopBanner = BindCallback(self, self.LoopBanner)
  ;
  ((self.ui).bannerScroll):onPageIndexChanged("+", self.__LoopBanner)
  self.lastDialogIndex = 0
  self.__getSouldOutItem = BindCallback(self, self.__GetSouldOutItem)
  self.__recycleSouldOutItem = BindCallback(self, self.__RecycleSouldOutItem)
  self.__RefreshAllIsSouldOut = BindCallback(self, self.RefreshAllIsSouldOut)
  self.souldOutPool = (UIItemPool.New)(UIBaseNode, (self.ui).obj_soldOut)
  ;
  ((self.ui).obj_soldOut):SetActive(false)
  MsgCenter:AddListener(eMsgEventId.PayGiftChange, self.__RefreshAllIsSouldOut)
  self.__timerId = nil
end

UINRecommeShop.OnShow = function(self)
  -- function num : 0_1 , upvalues : cs_ResLoader, _ENV
  if self.resloader == nil then
    self.resloader = (cs_ResLoader.Create)()
  end
  if IsNull(self.shopkeeperPicObj) then
    (self.resloader):LoadABAssetAsync(PathConsts:GetCharacterLive2DPath("riko_avg"), function(prefab)
    -- function num : 0_1_0 , upvalues : self, _ENV
    self.shopkeeperPicObj = prefab:Instantiate(((self.ui).heroHolder).transform)
    ;
    ((self.shopkeeperPicObj).transform):SetLayer(LayerMask.UI)
    if ((self.ui).heroNode).activeInHierarchy then
      self:_L2DBingding()
      self:PlayLogin()
    end
  end
)
  else
    if ((self.ui).heroNode).activeInHierarchy and self.l2dBinding ~= nil then
      local interation = (((self.l2dBinding).renderController).transform):GetComponent(typeof((((((CS.Live2D).Cubism).Samples).OriginalWorkflow).Demo).CubismInterationController))
      if interation ~= nil then
        interation:RestartBodyAnimation()
      end
      self:PlayLogin()
    end
  end
end

UINRecommeShop.PlayLogin = function(self)
  -- function num : 0_2 , upvalues : _ENV, config
  local randomIndex = (math.random)(1, #config.login)
  self:PlayLoginAnimation(randomIndex)
  self:ShowTxt((config.login)[randomIndex])
end

UINRecommeShop.PlayLoginAnimation = function(self, loginType)
  -- function num : 0_3 , upvalues : config
  local animLength = nil
  if self.heroCubismInteration ~= nil then
    animLength = (self.heroCubismInteration):PlayShopLoginAnimation(loginType)
    self:ShowTxtAfterTime((config.normal)[1], animLength)
  end
end

UINRecommeShop.AnimationCallFunction = function(self, hitArea, animName, animLength)
  -- function num : 0_4 , upvalues : _ENV, config
  local strlen = #animName
  if (string.find)(animName, "wait") ~= nil then
    self:ShowTxt((config.wait)[tonumber((string.sub)(animName, strlen, strlen + 1))])
    self:ShowTxtAfterTime((config.normal)[1], animLength)
  end
  if (string.find)(animName, "touch") ~= nil then
    self:ShowTxt((config.touch)[tonumber((string.sub)(animName, strlen, strlen + 1))])
    self:ShowTxtAfterTime((config.normal)[1], animLength)
  end
  if (string.find)(animName, "buy") ~= nil then
    self:ShowTxt((config.buy)[tonumber((string.sub)(animName, strlen, strlen + 1))])
    self:ShowTxtAfterTime((config.normal)[1], animLength)
  end
  if (string.find)(animName, "assign") ~= nil then
    local cvId = tonumber(((string.split)(animName, "_"))[2])
    self:ShowTxt(cvId)
    self:ShowTxtAfterTime((config.normal)[1], animLength)
  end
end

UINRecommeShop.ShowTxtAfterTime = function(self, idx, animLength)
  -- function num : 0_5 , upvalues : _ENV
  if animLength == nil then
    return 
  end
  if self.__timerId == nil then
    self.__timerId = TimerManager:StartTimer(animLength, function()
    -- function num : 0_5_0 , upvalues : self, idx
    self:ShowTxt(idx)
  end
)
  else
    TimerManager:StopTimer(self.__timerId)
    self.__timerId = TimerManager:StartTimer(animLength, function()
    -- function num : 0_5_1 , upvalues : self, idx
    self:ShowTxt(idx)
  end
)
  end
end

UINRecommeShop.ShowTxt = function(self, idx)
  -- function num : 0_6 , upvalues : _ENV
  if (ConfigData.recommend_dialogue)[idx] == nil then
    return 
  end
  local dialog = (LanguageUtil.GetLocaleText)(((ConfigData.recommend_dialogue)[idx]).text)
  if (string.IsNullOrEmpty)(dialog) then
    ((self.ui).dialogBox):SetActive(false)
  else
    ;
    ((self.ui).dialogBox):SetActive(true)
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).tex_Dialog).text = dialog
    ;
    ((self.ui).tex_Dialog):StartScrambleTypeWriter()
  end
end

UINRecommeShop.InitRecomme = function(self, pageId)
  -- function num : 0_7 , upvalues : _ENV, ShopEnum
  self.shopPageCfg = (ConfigData.shop_page)[pageId]
  if (self.shopPageCfg).style == (ShopEnum.eRecommeStyle).SingleModel then
    self:RefreshSignleModel()
  else
    if (self.shopPageCfg).style == (ShopEnum.eRecommeStyle).MultiModel then
      self:RefreshMultiModel()
    end
  end
  self:RefreshAllIsSouldOut()
end

UINRecommeShop.RefreshSignleModel = function(self)
  -- function num : 0_8 , upvalues : _ENV
  ((self.ui).recomNode):SetActive(false)
  ;
  (self.singlePicItem):Show()
  local recommeCfg = (ConfigData.shop_recommend)[((self.shopPageCfg).imgs)[1]]
  ;
  (self.singlePicItem):InitRecommeShopPic(recommeCfg, self.resloader)
end

UINRecommeShop.RefreshMultiModel = function(self)
  -- function num : 0_9 , upvalues : _ENV, ShopEnum
  ((self.ui).recomNode):SetActive(true)
  ;
  (self.singlePicItem):Hide()
  local bannerCfgList = {}
  local middleCfg, smallCfg = nil, nil
  for i,v in ipairs((self.shopPageCfg).imgs) do
    local cfg = (ConfigData.shop_recommend)[v]
    if cfg.type == (ShopEnum.eRecommePicType).Banner then
      (table.insert)(bannerCfgList, cfg)
    else
      if cfg.type == (ShopEnum.eRecommePicType).Middle then
        middleCfg = cfg
      else
        if cfg.type == (ShopEnum.eRecommePicType).Small then
          smallCfg = cfg
        end
      end
    end
  end
  if middleCfg ~= nil then
    (self.middlePicItem):Show()
    ;
    (self.middlePicItem):InitRecommeShopPic(middleCfg, self.resloader)
  else
    ;
    (self.middlePicItem):Hide()
  end
  if smallCfg ~= nil then
    (self.smallPicItem):Show()
    ;
    (self.smallPicItem):InitRecommeShopPic(smallCfg, self.resloader)
  else
    ;
    (self.smallPicItem):Hide()
  end
  local bannerCount = #bannerCfgList
  if bannerCount > 1 then
    (table.sort)(bannerCfgList, function(a, b)
    -- function num : 0_9_0
    do return a.id < b.id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  end
  ;
  (self.picPool):HideAll()
  for i,v in ipairs(bannerCfgList) do
    local item = (self.picPool):GetOne()
    item:InitRecommeShopPic(v, self.resloader)
  end
  if bannerCount < 2 then
    local scrollRect = (((self.ui).bannerScroll).gameObject):GetComponent(typeof(((CS.UnityEngine).UI).ScrollRect))
    if scrollRect ~= nil then
      scrollRect.horizontal = false
    end
    ;
    (((self.ui).tr_count).gameObject):SetActive(false)
    self.countDefaultPos = nil
  else
    do
      do
        local scrollRect = (((self.ui).bannerScroll).gameObject):GetComponent(typeof(((CS.UnityEngine).UI).ScrollRect))
        if scrollRect ~= nil then
          scrollRect.horizontal = true
        end
        -- DECOMPILER ERROR at PC145: Confused about usage of register: R6 in 'UnsetPending'

        ;
        ((self.ui).tr_count).sizeDelta = (Vector2.New)(self.countSizeX * bannerCount, (((self.ui).tr_count).sizeDelta).y)
        self.countDefaultPos = (Vector2.New)(0, (((self.ui).tr_CurrNum).localPosition).y)
        -- DECOMPILER ERROR at PC162: Confused about usage of register: R6 in 'UnsetPending'

        ;
        (self.countDefaultPos).x = -(((self.ui).tr_count).sizeDelta).x / 2
        -- DECOMPILER ERROR at PC166: Confused about usage of register: R6 in 'UnsetPending'

        ;
        ((self.ui).tr_CurrNum).localPosition = self.countDefaultPos
        ;
        ((self.ui).bannerScroll):InitPosList(bannerCount)
        ;
        ((self.ui).bannerScroll):SetPageIndexImmediate(0)
        ;
        ((self.ui).bannerScroll):SetInterval((ConfigData.game_config).shopBannerTime)
      end
    end
  end
end

UINRecommeShop.SetInGuideShopHeroActive = function(self, active)
  -- function num : 0_10 , upvalues : _ENV
  ((self.ui).heroNode):SetActive(active)
  if active then
    ((self.ui).tex_Dialog):StartScrambleTypeWriter(true)
    if self.l2dBinding == nil and not IsNull(self.shopkeeperPicObj) then
      self:_L2DBingding()
    end
    if self.l2dBinding ~= nil then
      local interation = (((self.l2dBinding).renderController).transform):GetComponent(typeof((((((CS.Live2D).Cubism).Samples).OriginalWorkflow).Demo).CubismInterationController))
      if interation ~= nil then
        interation:RestartBodyAnimation()
      end
    end
  end
end

UINRecommeShop._L2DBingding = function(self)
  -- function num : 0_11 , upvalues : _ENV, HeroCubismInteration, HeroLookTargetController
  local cs_CubismInterationController = ((self.shopkeeperPicObj).gameObject):GetComponent(typeof((((((CS.Live2D).Cubism).Samples).OriginalWorkflow).Demo).CubismInterationController))
  if cs_CubismInterationController ~= nil then
    self.heroCubismInteration = (HeroCubismInteration.New)()
    ;
    (self.heroCubismInteration):InitShopCubism(cs_CubismInterationController, UIManager:GetUICamera(), BindCallback(self, self.AnimationCallFunction))
  end
  self.l2dBinding = {}
  ;
  (UIUtil.LuaUIBindingTable)(self.shopkeeperPicObj, self.l2dBinding)
  local cubismLookController = ((self.shopkeeperPicObj).gameObject):GetComponent(typeof(((((CS.Live2D).Cubism).Framework).LookAt).CubismLookController))
  ;
  (HeroLookTargetController.OpenLookTarget)(cubismLookController, ((self.l2dBinding).lookTarget).gameObject, UIManager:GetUICamera())
  -- DECOMPILER ERROR at PC59: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.l2dBinding).renderController).SortingLayer = "UIHigh"
  -- DECOMPILER ERROR at PC62: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.l2dBinding).renderController).InfluencedByUICanvas = true
  -- DECOMPILER ERROR at PC67: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.l2dBinding).renderController).uiCanvasGroup = (self.ui).heroHolder
  ;
  ((self.l2dBinding).commonPerpectiveHandle):SetL2DPosType("RecommeShop", false)
end

UINRecommeShop.LoopBanner = function(self, index)
  -- function num : 0_12 , upvalues : _ENV
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R2 in 'UnsetPending'

  if self.countDefaultPos ~= nil then
    ((self.ui).tr_CurrNum).localPosition = (Vector2.New)((self.countDefaultPos).x + self.countSizeX * index, (self.countDefaultPos).y)
  end
end

UINRecommeShop.RefreshAllIsSouldOut = function(self)
  -- function num : 0_13 , upvalues : _ENV
  local couldRefreshIsouldOutList = {self.middlePicItem, self.smallPicItem, self.singlePicItem}
  ;
  (table.insertto)(couldRefreshIsouldOutList, (self.picPool).listItem)
  for _,shopPicItem in pairs(couldRefreshIsouldOutList) do
    shopPicItem:UpdateSouldOut(self.__getSouldOutItem, self.__recycleSouldOutItem)
  end
end

UINRecommeShop.__GetSouldOutItem = function(self)
  -- function num : 0_14
  return (self.souldOutPool):GetOne()
end

UINRecommeShop.__RecycleSouldOutItem = function(self, souldItem)
  -- function num : 0_15
  (self.souldOutPool):HideOne(souldItem)
end

UINRecommeShop.OnDelete = function(self)
  -- function num : 0_16 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.PayGiftChange, self.__RefreshAllIsSouldOut)
  if not IsNull(self.shopkeeperPicObj) then
    DestroyUnityObject(self.shopkeeperPicObj)
    self.shopkeeperPicObj = nil
  end
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
  if self.heroCubismInteration ~= nil then
    (self.heroCubismInteration):Delete()
    self.heroCubismInteration = nil
  end
  if self.__timerId ~= nil then
    TimerManager:StopTimer(self.__timerId)
  end
  ;
  (self.souldOutPool):DeleteAll()
  ;
  (base.OnDelete)(self)
end

return UINRecommeShop

