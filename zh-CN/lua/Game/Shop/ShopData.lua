local ShopData = class("ShopData")
local ShopEnum = require("Game.Shop.ShopEnum")
local ShopGoodData = require("Game.Shop.ShopGoodData")
ShopData.CreateShopData = function(shopData, shopId)
  -- function num : 0_0 , upvalues : ShopData
  local ShopData = (ShopData.New)()
  if shopId ~= nil then
    ShopData:InitNewShopData(shopData, shopId)
  else
    ShopData:InitShopData(shopData)
  end
  return ShopData
end

ShopData.ctor = function(self)
  -- function num : 0_1
  self.shopId = nil
  self.shopType = nil
  self.shopName = nil
  self.shopName_EN = nil
  self.shopGoodsDic = {}
  self.isRefreshShop = false
  self.couldFresh = false
  self.couldFreshCount = nil
  self.freshCount = nil
  self.freeFreshTm = nil
  self.refreshCost = {}
  self.isHavePages = false
  self.shopPagesDic = nil
  self.isHeroTypeShop = false
end

ShopData.InitShopData = function(self, shopData)
  -- function num : 0_2 , upvalues : _ENV, ShopGoodData
  self.shopId = shopData.storeId
  local shopCfg = (ConfigData.shop)[self.shopId]
  if shopCfg == nil then
    error("shop cfg is null,ID:" .. tostring(self.shopId))
    return 
  end
  self.shopCfg = shopCfg
  self.shopType = shopCfg.shop_type
  self.shopName = (LanguageUtil.GetLocaleText)(shopCfg.name)
  self.shopName_EN = (LanguageUtil.GetLocaleText)(shopCfg.name_en)
  for _,data in pairs(shopData.data) do
    -- DECOMPILER ERROR at PC40: Confused about usage of register: R8 in 'UnsetPending'

    (self.shopGoodsDic)[data.shelfId] = (ShopGoodData.CreateShopGoodData)(data, self.shopType, self.shopId)
  end
  self:HadleDiffShop(shopData)
end

ShopData.InitNewShopData = function(self, shopData, shopId)
  -- function num : 0_3 , upvalues : _ENV
  self.shopId = shopId
  local shopCfg = (ConfigData.shop)[self.shopId]
  if shopCfg == nil then
    error("shop cfg is null,ID:" .. tostring(self.shopId))
    return 
  end
  self.shopCfg = shopCfg
  self.shopType = shopCfg.shop_type
  self.shopName = (LanguageUtil.GetLocaleText)(shopCfg.name)
  self.shopName_EN = (LanguageUtil.GetLocaleText)(shopCfg.name_en)
  self:HadleDiffShop(shopData)
end

ShopData.HadleDiffShop = function(self, shopData)
  -- function num : 0_4 , upvalues : ShopEnum, _ENV, ShopGoodData
  self:__UpdateRefreshConfigDeal(shopData)
  if self.shopType == (ShopEnum.eShopType).Normal or self.shopType == (ShopEnum.eShopType).Skin then
    self.isHavePages = true
    self.shopPagesDic = {}
    local shopItemIdGoodDic = {}
    self.shopItemIdGoodDic = shopItemIdGoodDic
    for shelfId,goodData in pairs(self.shopGoodsDic) do
      if goodData.pageId == nil then
        error("normal shop doog don\'t have page shelfId=" .. tostring(shelfId))
      else
        do
          do
            if (self.shopPagesDic)[goodData.pageId] == nil then
              local name = nil
              if (ConfigData.shop_page)[goodData.pageId] == nil or ((ConfigData.shop_page)[goodData.pageId]).page == nil then
                name = ""
              else
                name = ((ConfigData.shop_page)[goodData.pageId]).page
              end
              -- DECOMPILER ERROR at PC62: Confused about usage of register: R9 in 'UnsetPending'

              ;
              (self.shopPagesDic)[goodData.pageId] = {}
              -- DECOMPILER ERROR at PC66: Confused about usage of register: R9 in 'UnsetPending'

              ;
              ((self.shopPagesDic)[goodData.pageId]).name = name
              -- DECOMPILER ERROR at PC71: Confused about usage of register: R9 in 'UnsetPending'

              ;
              ((self.shopPagesDic)[goodData.pageId]).shelfIds = {}
            end
            ;
            (table.insert)(((self.shopPagesDic)[goodData.pageId]).shelfIds, shelfId)
            if goodData.itemNum == 1 and shopItemIdGoodDic[goodData.itemId] == nil then
              shopItemIdGoodDic[goodData.itemId] = goodData
            end
            -- DECOMPILER ERROR at PC89: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC89: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC89: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  else
  end
  do
    if (self.shopType == (ShopEnum.eShopType).Random and self.shopType == (ShopEnum.eShopType).Resource) or self.shopType == (ShopEnum.eShopType).ResourceRefresh then
      local resourceShopCfg = (ConfigData.shop_resource)[self.shopId]
      if resourceShopCfg == nil then
        error("resourceShop cfg is null,ID:" .. tostring(self.shopId))
        return 
      end
      for shelfId,data in pairs(resourceShopCfg) do
        if (CheckCondition.CheckLua)(data.pre_condition, data.pre_para1, data.pre_para2) then
          local purchases = 0
          do
            do
              if shopData ~= nil then
                local serverData = (shopData.data)[shelfId]
                if serverData ~= nil then
                  purchases = serverData.purchases
                end
              end
              -- DECOMPILER ERROR at PC149: Confused about usage of register: R9 in 'UnsetPending'

              ;
              (self.shopGoodsDic)[shelfId] = (ShopGoodData.CreateNewShopGoodData)(data, self.shopType, self.shopId, purchases)
              -- DECOMPILER ERROR at PC150: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC150: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC150: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
    else
      do
        if self.shopType == (ShopEnum.eShopType).Recharge then
          local rechargeShopCfg = (ConfigData.shop_recharge)[self.shopId]
          if rechargeShopCfg == nil then
            error("Cant get rechargeShopCfg, shopId = " .. tostring(self.shopId))
            return 
          end
          for shelfId,data in pairs(rechargeShopCfg) do
            if (CheckCondition.CheckLua)(data.pre_condition, data.pre_para1, data.pre_para2) then
              if shopData ~= nil then
                local serverData = (shopData.data)[shelfId]
                -- DECOMPILER ERROR at PC198: Confused about usage of register: R9 in 'UnsetPending'

                if serverData ~= nil then
                  (self.shopGoodsDic)[shelfId] = (ShopGoodData.CreateNewShopGoodData)(data, self.shopType, self.shopId, serverData.purchases, serverData.hasDouble)
                else
                  -- DECOMPILER ERROR at PC207: Confused about usage of register: R9 in 'UnsetPending'

                  ;
                  (self.shopGoodsDic)[shelfId] = (ShopGoodData.CreateNewShopGoodData)(data, self.shopType, self.shopId, 0)
                end
              else
                do
                  do
                    -- DECOMPILER ERROR at PC217: Confused about usage of register: R8 in 'UnsetPending'

                    ;
                    (self.shopGoodsDic)[shelfId] = (ShopGoodData.CreateNewShopGoodData)(data, self.shopType, self.shopId, 0, true)
                    -- DECOMPILER ERROR at PC218: LeaveBlock: unexpected jumping out DO_STMT

                    -- DECOMPILER ERROR at PC218: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                    -- DECOMPILER ERROR at PC218: LeaveBlock: unexpected jumping out IF_STMT

                    -- DECOMPILER ERROR at PC218: LeaveBlock: unexpected jumping out IF_THEN_STMT

                    -- DECOMPILER ERROR at PC218: LeaveBlock: unexpected jumping out IF_STMT

                  end
                end
              end
            end
          end
        else
          do
            if self.shopType == (ShopEnum.eShopType).Charcter then
              self.isHeroTypeShop = true
              self.isHavePages = true
              self.shopPagesDic = {}
              local heroShopCfg = (ConfigData.shop_hero)[self.shopId]
              if heroShopCfg == nil then
                error("heroShop cfg is null,ID:" .. tostring(self.shopId))
                return 
              end
              for shelfId,data in pairs(heroShopCfg) do
                if (CheckCondition.CheckLua)(data.pre_condition, data.pre_para1, data.pre_para2) then
                  if shopData ~= nil then
                    local serverData = (shopData.data)[shelfId]
                    -- DECOMPILER ERROR at PC269: Confused about usage of register: R9 in 'UnsetPending'

                    if serverData ~= nil then
                      (self.shopGoodsDic)[shelfId] = (ShopGoodData.CreateNewShopGoodData)(data, self.shopType, self.shopId, serverData.purchases)
                    else
                      -- DECOMPILER ERROR at PC278: Confused about usage of register: R9 in 'UnsetPending'

                      ;
                      (self.shopGoodsDic)[shelfId] = (ShopGoodData.CreateNewShopGoodData)(data, self.shopType, self.shopId, 0)
                    end
                  else
                    do
                      -- DECOMPILER ERROR at PC287: Confused about usage of register: R8 in 'UnsetPending'

                      ;
                      (self.shopGoodsDic)[shelfId] = (ShopGoodData.CreateNewShopGoodData)(data, self.shopType, self.shopId, 0)
                      if (self.shopPagesDic)[data.page] == nil then
                        local pageCfg = (ConfigData.shop_page)[data.page]
                        local name = pageCfg ~= nil and pageCfg.page or ""
                        -- DECOMPILER ERROR at PC306: Confused about usage of register: R10 in 'UnsetPending'

                        ;
                        (self.shopPagesDic)[data.page] = {}
                        -- DECOMPILER ERROR at PC310: Confused about usage of register: R10 in 'UnsetPending'

                        ;
                        ((self.shopPagesDic)[data.page]).name = name
                        -- DECOMPILER ERROR at PC315: Confused about usage of register: R10 in 'UnsetPending'

                        ;
                        ((self.shopPagesDic)[data.page]).shelfIds = {}
                      end
                      do
                        do
                          ;
                          (table.insert)(((self.shopPagesDic)[data.page]).shelfIds, shelfId)
                          -- DECOMPILER ERROR at PC324: LeaveBlock: unexpected jumping out DO_STMT

                          -- DECOMPILER ERROR at PC324: LeaveBlock: unexpected jumping out DO_STMT

                          -- DECOMPILER ERROR at PC324: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                          -- DECOMPILER ERROR at PC324: LeaveBlock: unexpected jumping out IF_STMT

                          -- DECOMPILER ERROR at PC324: LeaveBlock: unexpected jumping out IF_THEN_STMT

                          -- DECOMPILER ERROR at PC324: LeaveBlock: unexpected jumping out IF_STMT

                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

ShopData.__UpdateRefreshConfigDeal = function(self, shopData)
  -- function num : 0_5 , upvalues : _ENV
  self.isRefreshShop = (self.shopCfg).isRefreshShop
  if not self.isRefreshShop then
    return 
  end
  self.couldFresh = false
  if shopData.freeFreshTm or shopData == nil or 0 > 0 then
    self.freeFreshTm = shopData.freeFreshTm
    self.freshCount = shopData.freshCount
  else
    local timePassCtrl = ControllerManager:GetController(ControllerTypeId.TimePass)
    local counterEltReset = timePassCtrl:getCounterElemData(proto_object_CounterModule.CounterModuleStorePurchaseResetTimes, self.shopId)
    local counterEltSys = timePassCtrl:getCounterElemData(proto_object_CounterModule.CounterModuleStoreSystemReset, self.shopId)
    if counterEltSys == nil then
      self.isRefreshShop = false
      error("Cant get refrshTm, shopId:" .. tostring(self.shopId))
      return 
    end
    if counterEltReset == nil or counterEltReset.nextExpiredTm < counterEltSys.nextExpiredTm then
      self.freshCount = 0
      self.freeFreshTm = counterEltSys.nextExpiredTm
    else
      self.freshCount = counterEltReset.times
      self.freeFreshTm = counterEltReset.nextExpiredTm
    end
  end
  do
    local refresh_times = (self.shopCfg).refresh_times
    self.couldFreshCount = 0
    if #refresh_times ~= 0 then
      for i,refreshTime in ipairs(refresh_times) do
        if refreshTime >= 0 then
          self.couldFreshCount = refreshTime
        else
          self.couldFreshCount = "∞"
        end
      end
      for i,refreshTime in ipairs(refresh_times) do
        if self.freshCount < refreshTime or refreshTime == -1 then
          local costId = (self.shopCfg).refreshCostId
          local costNum = ((self.shopCfg).refreshCostNum)[i]
          self.refreshCost = {costId = costId, costNum = costNum}
          self.couldFresh = true
          break
        end
      end
    end
  end
end

ShopData.GetIsRefreshShop = function(self)
  -- function num : 0_6
  return self.isRefreshShop
end

ShopData.GetCouldRefresh = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local isAbleRefresh = false
  local refreshCostId, refreshCostNum = nil, nil
  if #(self.shopCfg).refresh_times ~= 0 then
    for index,refreshTime in ipairs((self.shopCfg).refresh_times) do
      if self.freshCount < refreshTime or refreshTime == -1 then
        isAbleRefresh = true
        refreshCostNum = ((self.shopCfg).refreshCostNum)[index]
        refreshCostId = (self.shopCfg).refreshCostId
        break
      end
    end
  end
  do
    return isAbleRefresh, refreshCostId, refreshCostNum
  end
end

ShopData.GetRemainAutoRefreshTime = function(self, needZero)
  -- function num : 0_8 , upvalues : _ENV
  if self.isRefreshShop then
    if needZero then
      return (math.max)(self.freeFreshTm - PlayerDataCenter.timestamp, 0)
    end
    return self.freeFreshTm - PlayerDataCenter.timestamp
  else
    error("it\'s not a could refresh shop")
  end
end

ShopData.GetIsHaveRefreshItem = function(self)
  -- function num : 0_9 , upvalues : _ENV
  local latestRT = nil
  for _,goodData in pairs(self.shopGoodsDic) do
    if goodData.isLimit then
      if latestRT == nil then
        latestRT = goodData.freshTm
      else
        latestRT = (math.min)(goodData.freshTm, latestRT)
      end
    end
  end
  if latestRT == nil then
    return false
  end
  do return latestRT - PlayerDataCenter.timestamp <= 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

ShopData.GetNormalShopGoodByItemId = function(self, itemId)
  -- function num : 0_10
  if self.shopItemIdGoodDic == nil then
    return nil
  end
  return (self.shopItemIdGoodDic)[itemId]
end

ShopData.GetShopGoodDataByItemId = function(self, itemId, isCheckGift)
  -- function num : 0_11 , upvalues : _ENV
  if self.shopItemIdGoodDic == nil then
    return nil
  end
  if isCheckGift then
    for k,v in pairs(self.shopItemIdGoodDic) do
      if v.itemId == itemId then
        return v
      else
        local itemCfg = (ConfigData.item)[v.itemId]
        if itemCfg.type == eItemType.Package then
          for i = 1, #itemCfg.arg do
            if (itemCfg.arg)[i] == itemId then
              return v
            end
          end
        end
      end
    end
  else
    do
      for k,v in pairs(self.shopItemIdGoodDic) do
        if v.itemId == itemId then
          return v
        end
      end
    end
  end
end

ShopData.HasShopGoodsInPage = function(self, pageId)
  -- function num : 0_12 , upvalues : _ENV
  local pageData = (self.shopPagesDic)[pageId]
  if pageData == nil or pageData.shelfIds == nil then
    return false
  end
  for _,shelfId in ipairs(pageData.shelfIds) do
    local goods = (self.shopGoodsDic)[shelfId]
    if goods ~= nil then
      local hasTime, inTime = goods:GetStillTime()
      if not hasTime or inTime then
        return true
      end
    end
  end
  return false
end

ShopData.UpdateShopData = function(self)
  -- function num : 0_13
end

return ShopData

