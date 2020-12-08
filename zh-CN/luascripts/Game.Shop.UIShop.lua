-- params : ...
-- function num : 0 , upvalues : _ENV
local UIShop = class("UIShop", UIBaseWindow)
local base = UIBaseWindow
local cs_Resloader = CS.ResLoader
local cs_DoTween = ((CS.DG).Tweening).DOTween
local ShopEnum = require("Game.Shop.ShopEnum")
local UINResourceGroup = require("Game.CommonUI.ResourceGroup.UINResourceGroup")
local UINShopTog = require("Game.Shop.UINShopTog")
local UINShopShelfTog = require("Game.Shop.UINShopShelfTog")
local UINShopRefreshNode = require("Game.Shop.UINShopRefreshNode")
local UINShopNormalGoodsList = require("Game.Shop.UINShopNormalGoodsList")
local UINShopHeroGoodsList = require("Game.Shop.UINShopHeroGoodsList")
UIShop.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, cs_Resloader, UINResourceGroup, UINShopTog, UINShopShelfTog, UINShopRefreshNode, UINShopNormalGoodsList, UINShopHeroGoodsList
  self.ctrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
  self.resloader = (cs_Resloader.Create)()
  self._OpenShopePage = BindCallback(self, self.OpenShopePage)
  self._RefreshGoodsNode = BindCallback(self, self.RefreshGoodsNode)
  ;
  (UIUtil.CreateTopBtnGroup)((self.ui).obj_topButtonGroup, self, self.Delete)
  self.resourceGroup = (UINResourceGroup.New)()
  ;
  (self.resourceGroup):Init((self.ui).obj_resourceGroup)
  self.shopTogPool = (UIItemPool.New)(UINShopTog, (self.ui).obj_shopTog)
  ;
  ((self.ui).obj_shopTog):SetActive(false)
  self.shopTogRedDotDic = {}
  self.shelfTypeTogPool = (UIItemPool.New)(UINShopShelfTog, (self.ui).obj_ShelfTypeTog)
  ;
  ((self.ui).obj_ShelfTypeTog):SetActive(false)
  self.refreshNode = (UINShopRefreshNode.New)()
  ;
  (self.refreshNode):Init((self.ui).obj_RefreshNode)
  ;
  (self.refreshNode):SetCallback(self._OpenShopePage)
  self.NormalGoodsList = (UINShopNormalGoodsList.New)()
  ;
  (self.NormalGoodsList):Init((self.ui).obj_shopItemList)
  self.HeroGoodsList = (UINShopHeroGoodsList.New)()
  ;
  (self.HeroGoodsList):Init((self.ui).obj_heroItemList)
  ;
  (self.HeroGoodsList):InitList(self.resloader)
  self:SetShopAllTween()
end

UIShop.InitShopTogList = function(self, openShopId)
  -- function num : 0_1 , upvalues : _ENV, ShopEnum
  local isOpenTog = false
  ;
  (self.shopTogPool):HideAll()
  for k,shopId in ipairs((ConfigData.shop).id_sort_list) do
    local shopCfg = (ConfigData.shop)[shopId]
    if shopCfg.shop_type ~= (ShopEnum.eShopType).Resource and (CheckCondition.CheckLua)(shopCfg.pre_condition, shopCfg.pre_para1, shopCfg.pre_para2) then
      local shopTog = (self.shopTogPool):GetOne()
      shopTog:InitShopTog(shopCfg, self._OpenShopePage)
      -- DECOMPILER ERROR at PC36: Confused about usage of register: R10 in 'UnsetPending'

      ;
      (self.shopTogRedDotDic)[shopId] = (shopTog.ui).obj_RedDot
      if openShopId == nil and not isOpenTog then
        shopTog:SetSelected(true)
        isOpenTog = true
      end
    end
    if shopId == openShopId then
      shopTog:SetSelected(true)
      isOpenTog = true
    end
  end
  do
    if not isOpenTog and #(self.shopTogPool).listItem > 0 then
      local firstTog = ((self.shopTogPool).listItem)[1]
      firstTog:SetSelected(true)
    end
    self:InitRedDotEvent()
  end
end

UIShop.OpenShopePage = function(self, shopId)
  -- function num : 0_2 , upvalues : _ENV
  (self.ctrl):GetShopData(shopId, function(shopData)
    -- function num : 0_2_0 , upvalues : self, _ENV, shopId
    self.curShopData = shopData
    self:RefreshShelfTogList(shopData)
    self:RefreshShopRefreshNode(shopData)
    if not shopData.isHavePages then
      self:RefreshGoodsNode(shopData, nil)
    else
      local firstPageTog = ((self.shelfTypeTogPool).listItem)[1]
      firstPageTog:SetSelected(true)
    end
    do
      local chouldHideTop = false
      if (not shopData.isHavePages or (table.count)(shopData.shopPagesDic) == 1) and not shopData.isRefreshShop then
        chouldHideTop = true
      end
      self:MinRedDotNum(shopId)
      ;
      (self.ctrl):StartOneShopRedDot(shopData)
      ;
      ((self.ui).obj_shelfNode):SetActive(not chouldHideTop)
    end
  end
)
  if self.pageTween ~= nil then
    (self.pageTween):Restart()
  end
end

UIShop.RefreshShelfTogList = function(self, shopData)
  -- function num : 0_3 , upvalues : _ENV
  (self.shelfTypeTogPool):HideAll()
  if shopData.isHavePages then
    for pageId,_ in pairs(shopData.shopPagesDic) do
      local item = (self.shelfTypeTogPool):GetOne()
      item:InitShelfTog(shopData, pageId, self._RefreshGoodsNode)
      item:SetSelected(false)
    end
  end
end

UIShop.RefreshShopRefreshNode = function(self, shopData)
  -- function num : 0_4
  if shopData:GetIsRefreshShop() then
    (self.refreshNode):Show()
    ;
    (self.refreshNode):InitRefreshNode(shopData)
  else
    ;
    (self.refreshNode):Hide()
  end
end

UIShop.RefreshGoodsNode = function(self, shopData, pageId)
  -- function num : 0_5 , upvalues : _ENV
  local shopGoodsDic = {}
  if pageId == nil then
    shopGoodsDic = shopData.shopGoodsDic
  else
    local data = (shopData.shopPagesDic)[pageId]
    for _,shelfId in ipairs(data.shelfIds) do
      shopGoodsDic[shelfId] = (shopData.shopGoodsDic)[shelfId]
    end
  end
  do
    if shopData.isHeroTypeShop then
      (self.NormalGoodsList):Hide()
      ;
      (self.HeroGoodsList):Show()
      ;
      (self.HeroGoodsList):RefreshShelfItems(shopGoodsDic)
    else
      ;
      (self.HeroGoodsList):Hide()
      ;
      (self.NormalGoodsList):Show()
      ;
      (self.NormalGoodsList):RefreshShelfItems(shopGoodsDic)
    end
    self:SetResourceDisplay(shopData, shopGoodsDic)
  end
end

UIShop.SetResourceDisplay = function(self, shopData, shopGoodsDic)
  -- function num : 0_6 , upvalues : _ENV
  local ids = {}
  for _,goodsData in pairs(shopGoodsDic) do
    if not (table.contain)(ids, goodsData.currencyId) then
      (table.insert)(ids, goodsData.currencyId)
    end
  end
  if shopData:GetIsRefreshShop() and shopData.couldFresh and not (table.contain)(ids, (shopData.refreshCost).costId) then
    (table.insert)(ids, (shopData.refreshCost).costId)
  end
  ;
  (table.sort)(ids, function(a, b)
    -- function num : 0_6_0
    do return a < b end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (self.resourceGroup):SetResourceIds(ids)
end

UIShop.InitRedDotEvent = function(self)
  -- function num : 0_7 , upvalues : _ENV
  for shopId,redGo in pairs(self.shopTogRedDotDic) do
    local ok, shopNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ShopWindow, shopId)
    redGo:SetActive(not ok or shopNode:GetRedDotCount() > 0)
  end
  self.__onShopRedDotEvent = function(node)
    -- function num : 0_7_0 , upvalues : self
    local redDotGo = (self.shopTogRedDotDic)[node.nodeId]
    if node:GetRedDotCount() <= 0 then
      redDotGo:SetActive(redDotGo == nil)
      -- DECOMPILER ERROR: 2 unprocessed JMP targets
    end
  end

  RedDotController:AddListener(RedDotDynPath.ShopPath, self.__onShopRedDotEvent)
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

UIShop.MinRedDotNum = function(self, shopId)
  -- function num : 0_8 , upvalues : _ENV
  local ok, shopNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ShopWindow, shopId)
  if ok then
    shopNode:SetRedDotCount(0)
  end
end

UIShop.OnHide = function(self)
  -- function num : 0_9 , upvalues : _ENV, base
  local homeWin = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeWin ~= nil then
    homeWin:BackFromOtherWin()
  end
  ;
  (base.OnHide)(self)
end

UIShop.SetShopAllTween = function(self)
  -- function num : 0_10
  self.pageTween = self:__SetDOFade((self.ui).pageFade, 0.35)
end

UIShop.__SetDOFade = function(self, canvasGroup, time)
  -- function num : 0_11
  canvasGroup.alpha = 0.6
  local tween = ((canvasGroup:DOFade(1, time)):Pause()):SetAutoKill(false)
  return tween
end

UIShop.KillShopAllTweens = function(self)
  -- function num : 0_12
  if self.pageTween ~= nil then
    (self.pageTween):Kill()
    self.pageTween = nil
  end
end

UIShop.OnDelete = function(self)
  -- function num : 0_13 , upvalues : _ENV, base
  RedDotController:RemoveListener(RedDotDynPath.ShopPath, self.__onShopRedDotEvent)
  local win = UIManager:GetWindow(UIWindowTypeID.QuickBuy)
  if win ~= nil then
    win:Delete()
  end
  ;
  (self.NormalGoodsList):Delete()
  ;
  (self.HeroGoodsList):Delete()
  ;
  (self.refreshNode):Delete()
  ;
  (self.resourceGroup):Delete()
  self:KillShopAllTweens()
  ;
  (base.OnDelete)(self)
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
end

return UIShop

