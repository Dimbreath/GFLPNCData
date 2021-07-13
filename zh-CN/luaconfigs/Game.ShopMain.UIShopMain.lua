-- params : ...
-- function num : 0 , upvalues : _ENV
local UIShopMain = class("UIShopMain", UIBaseWindow)
local base = UIBaseWindow
local UINShopLeftPageWithSub = require("Game.ShopMain.UINShopLeftPageWithSub")
local UINShopLeftPage = require("Game.ShopMain.UINShopLeftPage")
local UINShopShelfTog = require("Game.Shop.UINShopShelfTog")
local UINShopRefreshNode = require("Game.Shop.UINShopRefreshNode")
local UINShopNormalGoodsList = require("Game.Shop.UINShopNormalGoodsList")
local UINShopHeroGoodsList = require("Game.Shop.UINShopHeroGoodsList")
local UINMonthCard = require("Game.ShopMain.UINMonthCard")
local UINRecommeShop = require("Game.ShopMain.UINRecommeShop")
local UINShopNormalGiftList = require("Game.Shop.UINShopNormalGiftList")
local UINShopNormalRechargeList = require("Game.Shop.UINShopNormalRechargeList")
local cs_Resloader = CS.ResLoader
local ShopEnum = require("Game.Shop.ShopEnum")
local JumpManager = require("Game.Jump.JumpManager")
local CS_Input = (CS.UnityEngine).Input
UIShopMain.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINShopLeftPage, UINShopLeftPageWithSub, UINShopShelfTog, cs_Resloader, UINShopRefreshNode, UINShopNormalGoodsList, UINShopHeroGoodsList, UINMonthCard, UINRecommeShop, UINShopNormalGiftList, UINShopNormalRechargeList, CS_Input
  (UIUtil.SetTopStatus)(self, self.OnReturnClicked, nil, nil, nil)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Recommend, self, self.OnClickRecomeShop)
  self.leftPagePool = (UIItemPool.New)(UINShopLeftPage, (self.ui).obj_btn_Page)
  self.leftPageWithSubPool = (UIItemPool.New)(UINShopLeftPageWithSub, (self.ui).obj_btn_PageHasSub)
  ;
  ((self.ui).obj_btn_Page):SetActive(false)
  ;
  ((self.ui).obj_btn_PageHasSub):SetActive(false)
  self.shelfTypeTogPool = (UIItemPool.New)(UINShopShelfTog, (self.ui).tog_ShelfType)
  ;
  ((self.ui).tog_ShelfType):SetActive(false)
  self.__OpenShopFunc = BindCallback(self, self.OpenShop)
  self.__OpenShopRefreshFunc = BindCallback(self, self.OpenShopWithRefrsh)
  self._RefreshGoodsNode = BindCallback(self, self.RefreshGoodsNode)
  self._RefreshRecomeNode = BindCallback(self, self.RefreshRecomeNode)
  self.ctrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
  self.resloader = (cs_Resloader.Create)()
  self.atlasResloader = (cs_Resloader.Create)()
  self.refreshNode = (UINShopRefreshNode.New)()
  ;
  (self.refreshNode):Init((self.ui).obj_refreshNode)
  ;
  (self.refreshNode):SetCallback(self.__OpenShopRefreshFunc)
  self.NormalGoodsList = (UINShopNormalGoodsList.New)()
  ;
  (self.NormalGoodsList):Init((self.ui).shopItemList)
  self.HeroGoodsList = (UINShopHeroGoodsList.New)()
  ;
  (self.HeroGoodsList):Init((self.ui).heroItemList)
  ;
  (self.HeroGoodsList):InitList(self.resloader, (self.ui).quickPurchaseRoot)
  self.monthCardNode = (UINMonthCard.New)()
  ;
  (self.monthCardNode):Init((self.ui).uI_ShopMonthCard)
  self.recommeShopNode = (UINRecommeShop.New)()
  ;
  (self.recommeShopNode):Init((self.ui).uI_ShopRecommend)
  self.giftBagList = (UINShopNormalGiftList.New)()
  ;
  (self.giftBagList):Init((self.ui).giftBagList)
  self.rechargeList = (UINShopNormalRechargeList.New)()
  ;
  (self.rechargeList):Init((self.ui).quartzBagList)
  ;
  ((self.ui).obj_recomme_RedDot):SetActive(false)
  self.width_normalShelf = (((self.ui).rectTr_shelfNode).sizeDelta).x
  self.__multiTouchEnabledBeforeOpen = CS_Input.multiTouchEnabled
  CS_Input.multiTouchEnabled = false
  self.__RedDotEvent = BindCallback(self, self.OnShopReddotRefresh)
  RedDotController:AddListener(RedDotDynPath.ShopPath, self.__RedDotEvent)
end

UIShopMain.InitShopMain = function(self, shopId, shopDataId, pageId)
  -- function num : 0_1 , upvalues : _ENV, ShopEnum
  self.autoJumpShopDataId = shopDataId ~= nil and shopDataId > 0 and shopDataId or nil
  self.autoJumpPageId = pageId ~= nil and pageId > 0 and pageId or nil
  self.seletecShopId = 0
  local table_classification = {}
  for k,v in pairs(ConfigData.shop_classification) do
    (table.insert)(table_classification, v)
  end
  ;
  (table.sort)(table_classification, function(a, b)
    -- function num : 0_1_0
    do return a.id < b.id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (self.leftPagePool):HideAll()
  ;
  (self.leftPageWithSubPool):HideAll()
  local showShopdic = {}
  for i,v in ipairs(table_classification) do
    local isOpend = false
    for _,shopId in ipairs(v.sub_ids) do
      local tempOpend = (self.ctrl):ShopIsUnlock(shopId)
      if tempOpend then
        showShopdic[shopId] = true
      end
      if not isOpend then
        isOpend = tempOpend
      end
    end
    if isOpend then
      if #v.sub_ids == 1 then
        local item = (self.leftPagePool):GetOne(true)
        ;
        (item.gameObject):SetActive(true)
        ;
        (item.transform):SetParent(((self.ui).obj_leftPage_rect).transform)
        item:InitPage(v.id, self.__OpenShopFunc, self.atlasResloader)
      else
        do
          do
            local item = (self.leftPageWithSubPool):GetOne(true)
            ;
            (item.gameObject):SetActive(true)
            ;
            (item.transform):SetParent(((self.ui).obj_leftPage_rect).transform)
            item:InitPage(v.id, self.__OpenShopFunc, self.atlasResloader)
            -- DECOMPILER ERROR at PC108: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC108: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC108: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC108: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC108: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
  if shopId ~= nil and not showShopdic[shopId] then
    shopId = nil
  end
  ;
  (((self.ui).btn_Recommend).gameObject):SetActive(false)
  if shopId ~= nil then
    for k,v in pairs(ConfigData.shop) do
      if v.shop_type == (ShopEnum.eShopType).Recommend and (self.ctrl):ShopIsUnlock(k) then
        (((self.ui).btn_Recommend).gameObject):SetActive(true)
        break
      end
    end
  else
    do
      for k,v in pairs(ConfigData.shop) do
        if shopId == nil and showShopdic[k] ~= nil then
          shopId = k
        else
          if v.shop_type == (ShopEnum.eShopType).Recommend and (self.ctrl):ShopIsUnlock(k) then
            (((self.ui).btn_Recommend).gameObject):SetActive(true)
            shopId = k
            break
          end
        end
      end
      do
        self:InitOpenShop(shopId)
        local _SelectLocationItem = function(listItem)
    -- function num : 0_1_1 , upvalues : _ENV, self
    for i,v in ipairs(listItem) do
      if v:ContainShopId(self.seletecShopId) then
        return v
      end
    end
  end

        local selectItem = _SelectLocationItem((self.leftPagePool).listItem)
        if selectItem == nil then
          selectItem = _SelectLocationItem((self.leftPageWithSubPool).listItem)
        end
        if selectItem ~= nil then
          (UIUtil.ScrollRectLocation)((self.ui).scroll, selectItem, true)
        end
      end
    end
  end
end

UIShopMain.SetShopMainCloseFunc = function(self, closeFunc)
  -- function num : 0_2
  self._closeFunc = closeFunc
end

UIShopMain.InitOpenShop = function(self, id)
  -- function num : 0_3 , upvalues : _ENV
  local shopCfg = (ConfigData.shop)[id]
  if shopCfg == nil then
    return 
  end
  self:OpenShop(id)
end

UIShopMain.OpenShopWithRefrsh = function(self, id)
  -- function num : 0_4
  self.seletecShopId = 0
  self:OpenShop(id)
end

UIShopMain._CheckRecommendValid = function(self, pageCfg)
  -- function num : 0_5 , upvalues : _ENV, JumpManager
  local imgsList = {}
  local isOpen = false
  for _,imgNum in ipairs(pageCfg.imgs) do
    local recommedCfg = (ConfigData.shop_recommend)[imgNum]
    if recommedCfg ~= nil then
      if recommedCfg.jump_target == (JumpManager.eJumpTarget).DynActivity then
        self.frameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
        local frameData = (self.frameCtrl):GetActivityFrameData((recommedCfg.jump_arg)[1])
        if frameData ~= nil then
          isOpen = frameData:GetCouldShowActivity()
        else
          isOpen = false
        end
      else
        do
          do
            isOpen = true
            if isOpen then
              (table.insert)(imgsList, isOpen)
            end
            -- DECOMPILER ERROR at PC45: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC45: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC45: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC45: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC45: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
  do return #imgsList > 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UIShopMain.OpenShop = function(self, id)
  -- function num : 0_6 , upvalues : _ENV, ShopEnum
  if self.seletecShopId == id then
    return 
  end
  self.seletecShopId = id
  for i,v in ipairs((self.leftPageWithSubPool).listItem) do
    v:RefreshState(self.seletecShopId)
  end
  for i,v in ipairs((self.leftPagePool).listItem) do
    v:RefreshState(self.seletecShopId)
  end
  ;
  (self.monthCardNode):Hide()
  ;
  (self.recommeShopNode):Hide()
  ;
  ((self.ui).uI_ShopNormal):SetActive(false)
  ;
  (self.HeroGoodsList):Hide()
  ;
  (self.NormalGoodsList):Hide()
  ;
  (self.giftBagList):Hide()
  ;
  (self.rechargeList):Hide()
  ;
  (UIUtil.RefreshTopResId)(nil)
  ;
  (self.refreshNode):Hide()
  ;
  (((self.ui).rectTr_shelfNode).gameObject):SetActive(false)
  local vec = ((self.ui).rectTr_shelfNode).sizeDelta
  vec.x = self.width_normalShelf
  -- DECOMPILER ERROR at PC68: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).rectTr_shelfNode).sizeDelta = vec
  ;
  ((self.ui).obj_shopTitle):SetActive(false)
  -- DECOMPILER ERROR at PC76: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).toggleGroup).allowSwitchOff = true
  local shopCfg = (ConfigData.shop)[id]
  if shopCfg.shop_type == (ShopEnum.eShopType).MonthCard then
    ((self.ui).uI_ShopNormal):SetActive(true)
    ;
    (self.monthCardNode):Show()
    ;
    (self.monthCardNode):InitMonthCard()
    ;
    (self.monthCardNode):RefreshSpecailReddot(id)
  else
    if shopCfg.shop_type == (ShopEnum.eShopType).Recommend then
      (self.recommeShopNode):Show()
      local shopPages = {}
      for i,v in ipairs(shopCfg.shop_para) do
        local pageCfg = (ConfigData.shop_page)[v]
        if pageCfg ~= nil or pageCfg.imgs ~= nil then
          local valid = self:_CheckRecommendValid(pageCfg)
          if valid then
            (table.insert)(shopPages, v)
          end
        end
      end
      local needShelf = #shopPages > 1
      ;
      (((self.ui).rectTr_shelfNode).gameObject):SetActive(needShelf)
      ;
      ((self.ui).obj_shopTitle):SetActive(not needShelf)
      local vec = ((self.ui).rectTr_shelfNode).sizeDelta
      vec.x = (self.ui).width_recommeShelf
      -- DECOMPILER ERROR at PC158: Confused about usage of register: R7 in 'UnsetPending'

      ;
      ((self.ui).rectTr_shelfNode).sizeDelta = vec
      if #shopPages == 1 then
        self:RefreshRecomeNode(shopPages[1])
      else
        (self.shelfTypeTogPool):HideAll()
        local selectIndex = 1
        for i,pageId in ipairs(shopPages) do
          local item = (self.shelfTypeTogPool):GetOne(true)
          item:InitShelfTog(nil, pageId, id, self._RefreshRecomeNode)
          item:SetSelected(false)
          if self.autoJumpPageId == pageId then
            selectIndex = i
          end
        end
        local firstPageTog = ((self.shelfTypeTogPool).listItem)[selectIndex]
        firstPageTog:SetSelected(true)
      end
    elseif shopCfg.shop_type == (ShopEnum.eShopType).PayGift then
      ((self.ui).uI_ShopNormal):SetActive(true)
      local selectPageId = 0
      local payGiftCtrl = ControllerManager:GetController(ControllerTypeId.PayGift, true)
      local pageDic = {}
      for k,v in pairs(payGiftCtrl.dataDic) do
        if pageDic[(v.groupCfg).inPage] == nil and v:IsUnlock() and (v.needRefresh or not v:IsSoldOut()) then
          pageDic[(v.groupCfg).inPage] = true
        end
        if (v.groupCfg).id == self.autoJumpShopDataId then
          selectPageId = (v.groupCfg).inPage
        end
      end
      ;
      (((self.ui).rectTr_shelfNode).gameObject):SetActive(true)
      ;
      (self.shelfTypeTogPool):HideAll()
      local pageList = {}
      for pageId,_ in pairs(pageDic) do
        (table.insert)(pageList, pageId)
      end
      ;
      (table.sort)(pageList, function(a, b)
    -- function num : 0_6_0
    do return a < b end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
      local autoSelectitem = nil
      for _,pageId in ipairs(pageList) do
        local item = (self.shelfTypeTogPool):GetOne()
        item:InitShelfTog(nil, pageId, id, self._RefreshGoodsNode)
        if pageId == selectPageId then
          autoSelectitem = item
        end
      end
      for _,pageId in ipairs(shopCfg.shop_para) do
        local item = (self.shelfTypeTogPool):GetOne()
        item:InitShelfTog(nil, pageId, id, self._RefreshGoodsNode)
        if autoSelectitem == nil and pageId == self.autoJumpPageId then
          autoSelectitem = item
        end
      end
      if autoSelectitem == nil then
        autoSelectitem = ((self.shelfTypeTogPool).listItem)[1]
      end
      autoSelectitem:SetSelected(true)
    else
      ((self.ui).uI_ShopNormal):SetActive(true)
      ;
      (self.ctrl):GetShopData(id, function(shopData)
    -- function num : 0_6_1 , upvalues : self, _ENV, id, ShopEnum
    if self.transform == nil then
      return 
    end
    self:RefreshShelfTogList(shopData)
    self:RefreshShopRefreshNode(shopData)
    if not shopData.isHavePages then
      self:RefreshGoodsNode(shopData, nil)
    else
      local pageId = nil
      if self.autoJumpShopDataId ~= nil then
        for _,goodsData in pairs(shopData.shopGoodsDic) do
          if goodsData.shelfId == self.autoJumpShopDataId then
            pageId = goodsData.pageId
            break
          end
        end
      else
        do
          pageId = self.autoJumpPageId
          local pageTog = nil
          if pageId ~= nil then
            for _,shelfTypeTog in ipairs((self.shelfTypeTogPool).listItem) do
              if shelfTypeTog.pageId == pageId then
                pageTog = shelfTypeTog
                break
              end
            end
          else
            do
              do
                pageTog = ((self.shelfTypeTogPool).listItem)[1]
                if pageTog ~= nil then
                  pageTog:SetSelected(true)
                end
                self:MinRedDotNum(id)
                ;
                (self.ctrl):StartOneShopRedDot(shopData)
                if shopData.shopType == (ShopEnum.eShopType).Recharge then
                  (((self.ui).rectTr_shelfNode).gameObject):SetActive(false)
                  ;
                  ((self.ui).obj_shopTitle):SetActive(false)
                else
                  local chouldHideTop = false
                  if not shopData.isHavePages or (table.count)(shopData.shopPagesDic) == 1 then
                    chouldHideTop = true
                  end
                  ;
                  (((self.ui).rectTr_shelfNode).gameObject):SetActive(not chouldHideTop)
                  ;
                  ((self.ui).obj_shopTitle):SetActive(chouldHideTop)
                  -- DECOMPILER ERROR at PC115: Confused about usage of register: R2 in 'UnsetPending'

                  ;
                  ((self.ui).tex_title).text = tostring(shopData.shopName)
                end
              end
            end
          end
        end
      end
    end
  end
)
    end
  end
  -- DECOMPILER ERROR at PC337: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).toggleGroup).allowSwitchOff = false
  ;
  ((self.ui).pageHolderFade):DOKill(true)
  -- DECOMPILER ERROR at PC345: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).pageHolderFade).alpha = 0.2
  ;
  ((self.ui).pageHolderFade):DOFade(1, 0.45)
  -- DECOMPILER ERROR: 13 unprocessed JMP targets
end

UIShopMain.RefreshShelfTogList = function(self, shopData)
  -- function num : 0_7 , upvalues : _ENV
  (self.shelfTypeTogPool):HideAll()
  if shopData.isHavePages then
    for pageId,_ in pairs(shopData.shopPagesDic) do
      local item = (self.shelfTypeTogPool):GetOne()
      item:InitShelfTog(shopData, pageId, shopData.shopId, self._RefreshGoodsNode)
      item:SetSelected(false)
    end
  end
end

UIShopMain.RefreshShopRefreshNode = function(self, shopData)
  -- function num : 0_8
  if shopData:GetIsRefreshShop() then
    (self.refreshNode):Show()
    ;
    (self.refreshNode):InitRefreshNode(shopData)
  else
    ;
    (self.refreshNode):Hide()
  end
end

UIShopMain.RefreshGoodsNode = function(self, shopData, pageId)
  -- function num : 0_9 , upvalues : _ENV, ShopEnum
  local shopCfg = (ConfigData.shop)[self.seletecShopId]
  do
    if shopCfg.shop_type == (ShopEnum.eShopType).PayGift then
      local pageCfg = (ConfigData.shop_page)[pageId]
      if pageCfg.mark == (ShopEnum.ePageMarkType).MonthCard then
        (self.giftBagList):Hide()
        ;
        (self.monthCardNode):Show()
        ;
        (self.monthCardNode):InitMonthCard()
        ;
        (self.monthCardNode):RefreshSpecailReddot(self.seletecShopId, pageId)
      else
        ;
        (self.monthCardNode):Hide()
        ;
        (self.giftBagList):Show()
        ;
        (self.giftBagList):InitGiftList(pageId, (self.ui).quickPurchaseRoot, self.autoJumpShopDataId)
      end
      ;
      (UIUtil.RefreshTopResId)({ConstGlobalItem.PaidItem})
      self.autoJumpShopDataId = nil
      self.autoJumpPageId = nil
      return 
    end
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
      if shopData.shopType == (ShopEnum.eShopType).Recharge then
        (UIUtil.RefreshTopResId)({ConstGlobalItem.PaidItem})
      else
        self:SetResourceDisplay(shopData, shopGoodsDic)
      end
      if shopData.shopType == (ShopEnum.eShopType).Skin then
        (self.HeroGoodsList):Show()
        ;
        (self.HeroGoodsList):RefreshShelfItems(shopGoodsDic, self.autoJumpShopDataId)
      else
        if shopData.shopType == (ShopEnum.eShopType).Recharge then
          (self.rechargeList):Show()
          ;
          (self.rechargeList):InitRechargeList(shopGoodsDic)
        else
          ;
          (self.NormalGoodsList):Show()
          ;
          (self.NormalGoodsList):RefreshShelfItems(shopGoodsDic, (self.ui).quickPurchaseRoot, self.autoJumpShopDataId)
        end
      end
      self.autoJumpShopDataId = nil
      self.autoJumpPageId = nil
    end
  end
end

UIShopMain.RefreshRecomeNode = function(self, shopData, pageId)
  -- function num : 0_10
  (self.recommeShopNode):InitRecomme(pageId)
end

UIShopMain.OnClickRecomeShop = function(self)
  -- function num : 0_11 , upvalues : _ENV, ShopEnum
  local shopCfg = ConfigData.shop
  local shopId = nil
  for k,v in pairs(shopCfg) do
    if v.shop_type == (ShopEnum.eShopType).Recommend then
      shopId = k
      break
    end
  end
  do
    if shopId ~= nil and shopId > 0 then
      self:OpenShop(shopId)
    end
  end
end

UIShopMain.SetResourceDisplay = function(self, shopData, shopGoodsDic)
  -- function num : 0_12 , upvalues : _ENV
  local idDic = {}
  for _,goodsData in pairs(shopGoodsDic) do
    idDic[goodsData.currencyId] = true
  end
  if shopData:GetIsRefreshShop() and shopData.couldFresh then
    idDic[(shopData.refreshCost).costId] = true
  end
  if idDic[ConstGlobalItem.PaidSubItem] then
    idDic[ConstGlobalItem.PaidItem] = true
  end
  local ids = {}
  for id,_ in pairs(idDic) do
    (table.insert)(ids, id)
  end
  ;
  (table.sort)(ids, function(a, b)
    -- function num : 0_12_0
    do return a < b end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (UIUtil.RefreshTopResId)(ids)
end

UIShopMain.MinRedDotNum = function(self, shopId)
  -- function num : 0_13
  (self.ctrl):SetShopMinRed(shopId)
end

UIShopMain.OnReturnClicked = function(self)
  -- function num : 0_14
  self:OnCloseWin()
  self:Delete()
end

UIShopMain.OnShopReddotRefresh = function(self, node)
  -- function num : 0_15 , upvalues : _ENV
  local tempNode = node
  for _,leftPage in ipairs((self.leftPagePool).listItem) do
    leftPage:RefreshRedDotState()
  end
  for _,leftPage in ipairs((self.leftPageWithSubPool).listItem) do
    leftPage:RefreshRedDotState()
  end
end

UIShopMain.OnDelete = function(self)
  -- function num : 0_16 , upvalues : _ENV, CS_Input, base
  RedDotController:RemoveListener(RedDotDynPath.ShopPath, self.__RedDotEvent)
  if self._closeFunc ~= nil then
    (self._closeFunc)()
  end
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
  if self.atlasResloader ~= nil then
    (self.atlasResloader):Put2Pool()
    self.atlasResloader = nil
  end
  CS_Input.multiTouchEnabled = self.__multiTouchEnabledBeforeOpen
  local win = UIManager:GetWindow(UIWindowTypeID.QuickBuy)
  if win ~= nil then
    win:Delete()
  end
  ;
  (self.refreshNode):Delete()
  ;
  (self.NormalGoodsList):Delete()
  ;
  (self.HeroGoodsList):Delete()
  ;
  (self.monthCardNode):Delete()
  ;
  (self.recommeShopNode):Delete()
  ;
  (self.giftBagList):Delete()
  ;
  (self.rechargeList):Delete()
  ;
  (self.leftPagePool):DeleteAll()
  ;
  (self.leftPageWithSubPool):DeleteAll()
  ;
  (self.shelfTypeTogPool):DeleteAll()
  ;
  ((self.ui).pageHolderFade):DOKill()
  ;
  (base.OnDelete)(self)
end

return UIShopMain

