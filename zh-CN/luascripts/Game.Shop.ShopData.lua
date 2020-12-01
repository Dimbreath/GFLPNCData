-- params : ...
-- function num : 0 , upvalues : _ENV
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
  if self.shopType == (ShopEnum.eShopType).Normal then
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
              -- DECOMPILER ERROR at PC54: Confused about usage of register: R9 in 'UnsetPending'

              ;
              (self.shopPagesDic)[goodData.pageId] = {}
              -- DECOMPILER ERROR at PC58: Confused about usage of register: R9 in 'UnsetPending'

              ;
              ((self.shopPagesDic)[goodData.pageId]).name = name
              -- DECOMPILER ERROR at PC63: Confused about usage of register: R9 in 'UnsetPending'

              ;
              ((self.shopPagesDic)[goodData.pageId]).shelfIds = {}
            end
            ;
            (table.insert)(((self.shopPagesDic)[goodData.pageId]).shelfIds, shelfId)
            if goodData.itemNum == 1 then
              shopItemIdGoodDic[goodData.itemId] = goodData
            end
            -- DECOMPILER ERROR at PC77: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC77: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC77: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  else
    do
      if self.shopType == (ShopEnum.eShopType).Random then
        self.isRefreshShop = true
        self.couldFresh = false
        self.freshCount = shopData.freshCount
        self.freeFreshTm = shopData.freeFreshTm
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
      else
        do
          if self.shopType == (ShopEnum.eShopType).Resource then
            local resourceShopCfg = (ConfigData.shop_resource)[self.shopId]
            if resourceShopCfg == nil then
              error("resourceShop cfg is null,ID:" .. tostring(self.shopId))
              return 
            end
            for shelfId,data in pairs(resourceShopCfg) do
              if (CheckCondition.CheckLua)(data.pre_condition, data.pre_para1, data.pre_para2) then
                if shopData ~= nil then
                  local serverData = (shopData.data)[shelfId]
                  -- DECOMPILER ERROR at PC175: Confused about usage of register: R9 in 'UnsetPending'

                  if serverData ~= nil then
                    (self.shopGoodsDic)[shelfId] = (ShopGoodData.CreateNewShopGoodData)(data, self.shopType, self.shopId, serverData.purchases)
                  else
                    -- DECOMPILER ERROR at PC184: Confused about usage of register: R9 in 'UnsetPending'

                    ;
                    (self.shopGoodsDic)[shelfId] = (ShopGoodData.CreateNewShopGoodData)(data, self.shopType, self.shopId, 0)
                  end
                else
                  do
                    do
                      -- DECOMPILER ERROR at PC193: Confused about usage of register: R8 in 'UnsetPending'

                      ;
                      (self.shopGoodsDic)[shelfId] = (ShopGoodData.CreateNewShopGoodData)(data, self.shopType, self.shopId, 0)
                      -- DECOMPILER ERROR at PC194: LeaveBlock: unexpected jumping out DO_STMT

                      -- DECOMPILER ERROR at PC194: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                      -- DECOMPILER ERROR at PC194: LeaveBlock: unexpected jumping out IF_STMT

                      -- DECOMPILER ERROR at PC194: LeaveBlock: unexpected jumping out IF_THEN_STMT

                      -- DECOMPILER ERROR at PC194: LeaveBlock: unexpected jumping out IF_STMT

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
                      -- DECOMPILER ERROR at PC245: Confused about usage of register: R9 in 'UnsetPending'

                      if serverData ~= nil then
                        (self.shopGoodsDic)[shelfId] = (ShopGoodData.CreateNewShopGoodData)(data, self.shopType, self.shopId, serverData.purchases)
                      else
                        -- DECOMPILER ERROR at PC254: Confused about usage of register: R9 in 'UnsetPending'

                        ;
                        (self.shopGoodsDic)[shelfId] = (ShopGoodData.CreateNewShopGoodData)(data, self.shopType, self.shopId, 0)
                      end
                    else
                      do
                        -- DECOMPILER ERROR at PC263: Confused about usage of register: R8 in 'UnsetPending'

                        ;
                        (self.shopGoodsDic)[shelfId] = (ShopGoodData.CreateNewShopGoodData)(data, self.shopType, self.shopId, 0)
                        do
                          do
                            if (self.shopPagesDic)[data.page] == nil then
                              local name = nil
                              if (ConfigData.shop_page)[data.page] == nil or ((ConfigData.shop_page)[data.page]).page == nil then
                                name = ""
                              else
                                name = ((ConfigData.shop_page)[data.page]).page
                              end
                              -- DECOMPILER ERROR at PC293: Confused about usage of register: R9 in 'UnsetPending'

                              ;
                              (self.shopPagesDic)[data.page] = {}
                              -- DECOMPILER ERROR at PC297: Confused about usage of register: R9 in 'UnsetPending'

                              ;
                              ((self.shopPagesDic)[data.page]).name = name
                              -- DECOMPILER ERROR at PC302: Confused about usage of register: R9 in 'UnsetPending'

                              ;
                              ((self.shopPagesDic)[data.page]).shelfIds = {}
                            end
                            ;
                            (table.insert)(((self.shopPagesDic)[data.page]).shelfIds, shelfId)
                            -- DECOMPILER ERROR at PC311: LeaveBlock: unexpected jumping out DO_STMT

                            -- DECOMPILER ERROR at PC311: LeaveBlock: unexpected jumping out DO_STMT

                            -- DECOMPILER ERROR at PC311: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                            -- DECOMPILER ERROR at PC311: LeaveBlock: unexpected jumping out IF_STMT

                            -- DECOMPILER ERROR at PC311: LeaveBlock: unexpected jumping out IF_THEN_STMT

                            -- DECOMPILER ERROR at PC311: LeaveBlock: unexpected jumping out IF_STMT

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
end

ShopData.GetIsRefreshShop = function(self)
  -- function num : 0_5
  return self.isRefreshShop
end

ShopData.GetCouldRefresh = function(self)
  -- function num : 0_6 , upvalues : _ENV
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
  -- function num : 0_7 , upvalues : _ENV
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
  -- function num : 0_8 , upvalues : _ENV
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
  -- function num : 0_9
  if self.shopItemIdGoodDic == nil then
    return nil
  end
  return (self.shopItemIdGoodDic)[itemId]
end

ShopData.UpdateShopData = function(self)
  -- function num : 0_10
end

return ShopData

-- params : ...
-- function num : 0 , upvalues : _ENV
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
    for _, data in pairs(shopData.data) do
        -- DECOMPILER ERROR at PC40: Confused about usage of register: R8 in 'UnsetPending'

        (self.shopGoodsDic)[data.shelfId] =
            (ShopGoodData.CreateShopGoodData)(data, self.shopType, self.shopId)
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
    if self.shopType == (ShopEnum.eShopType).Normal then
        self.isHavePages = true
        self.shopPagesDic = {}
        local shopItemIdGoodDic = {}
        self.shopItemIdGoodDic = shopItemIdGoodDic
        for shelfId, goodData in pairs(self.shopGoodsDic) do
            if goodData.pageId == nil then
                error("normal shop doog don\'t have page shelfId=" ..
                          tostring(shelfId))
            else
                do
                    do
                        if (self.shopPagesDic)[goodData.pageId] == nil then
                            local name = nil
                            if (ConfigData.shop_page)[goodData.pageId] == nil or
                                ((ConfigData.shop_page)[goodData.pageId]).page ==
                                nil then
                                name = ""
                            else
                                name =
                                    ((ConfigData.shop_page)[goodData.pageId]).page
                            end -- DECOMPILER ERROR at PC54: Confused about usage of register: R9 in 'UnsetPending'
                            
                            (self.shopPagesDic)[goodData.pageId] = {} -- DECOMPILER ERROR at PC58: Confused about usage of register: R9 in 'UnsetPending'
                            ;
                            ((self.shopPagesDic)[goodData.pageId]).name = name -- DECOMPILER ERROR at PC63: Confused about usage of register: R9 in 'UnsetPending'
                            ;
                            ((self.shopPagesDic)[goodData.pageId]).shelfIds = {}
                        end
                        (table.insert)(
                            ((self.shopPagesDic)[goodData.pageId]).shelfIds,
                            shelfId)
                        if goodData.itemNum == 1 then
                            shopItemIdGoodDic[goodData.itemId] = goodData
                        end
                        -- DECOMPILER ERROR at PC77: LeaveBlock: unexpected jumping out DO_STMT

                        -- DECOMPILER ERROR at PC77: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                        -- DECOMPILER ERROR at PC77: LeaveBlock: unexpected jumping out IF_STMT

                    end
                end
            end
        end
    else
        do
            if self.shopType == (ShopEnum.eShopType).Random then
                self.isRefreshShop = true
                self.couldFresh = false
                self.freshCount = shopData.freshCount
                self.freeFreshTm = shopData.freeFreshTm
                local refresh_times = (self.shopCfg).refresh_times
                self.couldFreshCount = 0
                if #refresh_times ~= 0 then
                    for i, refreshTime in ipairs(refresh_times) do
                        if refreshTime >= 0 then
                            self.couldFreshCount = refreshTime
                        else
                            self.couldFreshCount = "∞"
                        end
                    end
                    for i, refreshTime in ipairs(refresh_times) do
                        if self.freshCount < refreshTime or refreshTime == -1 then
                            local costId = (self.shopCfg).refreshCostId
                            local costNum = ((self.shopCfg).refreshCostNum)[i]
                            self.refreshCost =
                                {costId = costId, costNum = costNum}
                            self.couldFresh = true
                            break
                        end
                    end
                end
            else
                do
                    if self.shopType == (ShopEnum.eShopType).Resource then
                        local resourceShopCfg =
                            (ConfigData.shop_resource)[self.shopId]
                        if resourceShopCfg == nil then
                            error("resourceShop cfg is null,ID:" ..
                                      tostring(self.shopId))
                            return
                        end
                        for shelfId, data in pairs(resourceShopCfg) do
                            if (CheckCondition.CheckLua)(data.pre_condition,
                                                         data.pre_para1,
                                                         data.pre_para2) then
                                if shopData ~= nil then
                                    local serverData = (shopData.data)[shelfId]
                                    -- DECOMPILER ERROR at PC175: Confused about usage of register: R9 in 'UnsetPending'

                                    if serverData ~= nil then
                                        (self.shopGoodsDic)[shelfId] =
                                            (ShopGoodData.CreateNewShopGoodData)(
                                                data, self.shopType,
                                                self.shopId,
                                                serverData.purchases)
                                    else
                                        -- DECOMPILER ERROR at PC184: Confused about usage of register: R9 in 'UnsetPending'


                                        (self.shopGoodsDic)[shelfId] =
                                            (ShopGoodData.CreateNewShopGoodData)(
                                                data, self.shopType,
                                                self.shopId, 0)
                                    end
                                else
                                    do
                                        do
                                            -- DECOMPILER ERROR at PC193: Confused about usage of register: R8 in 'UnsetPending'


                                            (self.shopGoodsDic)[shelfId] =
                                                (ShopGoodData.CreateNewShopGoodData)(
                                                    data, self.shopType,
                                                    self.shopId, 0)
                                            -- DECOMPILER ERROR at PC194: LeaveBlock: unexpected jumping out DO_STMT

                                            -- DECOMPILER ERROR at PC194: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                            -- DECOMPILER ERROR at PC194: LeaveBlock: unexpected jumping out IF_STMT

                                            -- DECOMPILER ERROR at PC194: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                            -- DECOMPILER ERROR at PC194: LeaveBlock: unexpected jumping out IF_STMT

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
                                local heroShopCfg =
                                    (ConfigData.shop_hero)[self.shopId]
                                if heroShopCfg == nil then
                                    error(
                                        "heroShop cfg is null,ID:" ..
                                            tostring(self.shopId))
                                    return
                                end
                                for shelfId, data in pairs(heroShopCfg) do
                                    if (CheckCondition.CheckLua)(
                                        data.pre_condition, data.pre_para1,
                                        data.pre_para2) then
                                        if shopData ~= nil then
                                            local serverData =
                                                (shopData.data)[shelfId]
                                            -- DECOMPILER ERROR at PC245: Confused about usage of register: R9 in 'UnsetPending'

                                            if serverData ~= nil then
                                                (self.shopGoodsDic)[shelfId] =
                                                    (ShopGoodData.CreateNewShopGoodData)(
                                                        data, self.shopType,
                                                        self.shopId,
                                                        serverData.purchases)
                                            else
                                                -- DECOMPILER ERROR at PC254: Confused about usage of register: R9 in 'UnsetPending'


                                                (self.shopGoodsDic)[shelfId] =
                                                    (ShopGoodData.CreateNewShopGoodData)(
                                                        data, self.shopType,
                                                        self.shopId, 0)
                                            end
                                        else
                                            do
                                                -- DECOMPILER ERROR at PC263: Confused about usage of register: R8 in 'UnsetPending'


                                                (self.shopGoodsDic)[shelfId] =
                                                    (ShopGoodData.CreateNewShopGoodData)(
                                                        data, self.shopType,
                                                        self.shopId, 0)
                                                do
                                                    do
                                                        if (self.shopPagesDic)[data.page] ==
                                                            nil then
                                                            local name = nil
                                                            if (ConfigData.shop_page)[data.page] ==
                                                                nil or
                                                                ((ConfigData.shop_page)[data.page]).page ==
                                                                nil then
                                                                name = ""
                                                            else
                                                                name =
                                                                    ((ConfigData.shop_page)[data.page]).page
                                                            end -- DECOMPILER ERROR at PC293: Confused about usage of register: R9 in 'UnsetPending'
                                                            
                                                            (self.shopPagesDic)[data.page] =
                                                                {} -- DECOMPILER ERROR at PC297: Confused about usage of register: R9 in 'UnsetPending'
                                                            ;
                                                            ((self.shopPagesDic)[data.page]).name =
                                                                name -- DECOMPILER ERROR at PC302: Confused about usage of register: R9 in 'UnsetPending'
                                                            ;
                                                            ((self.shopPagesDic)[data.page]).shelfIds =
                                                                {}
                                                        end
                                                        (table.insert)(
                                                            ((self.shopPagesDic)[data.page]).shelfIds,
                                                            shelfId)
                                                        -- DECOMPILER ERROR at PC311: LeaveBlock: unexpected jumping out DO_STMT

                                                        -- DECOMPILER ERROR at PC311: LeaveBlock: unexpected jumping out DO_STMT

                                                        -- DECOMPILER ERROR at PC311: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                        -- DECOMPILER ERROR at PC311: LeaveBlock: unexpected jumping out IF_STMT

                                                        -- DECOMPILER ERROR at PC311: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                        -- DECOMPILER ERROR at PC311: LeaveBlock: unexpected jumping out IF_STMT

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
end

ShopData.GetIsRefreshShop = function(self)
    -- function num : 0_5
    return self.isRefreshShop
end

ShopData.GetCouldRefresh = function(self)
    -- function num : 0_6 , upvalues : _ENV
    local isAbleRefresh = false
    local refreshCostId, refreshCostNum = nil, nil
    if #(self.shopCfg).refresh_times ~= 0 then
        for index, refreshTime in ipairs((self.shopCfg).refresh_times) do
            if self.freshCount < refreshTime or refreshTime == -1 then
                isAbleRefresh = true
                refreshCostNum = ((self.shopCfg).refreshCostNum)[index]
                refreshCostId = (self.shopCfg).refreshCostId
                break
            end
        end
    end
    do return isAbleRefresh, refreshCostId, refreshCostNum end
end

ShopData.GetRemainAutoRefreshTime = function(self, needZero)
    -- function num : 0_7 , upvalues : _ENV
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
    -- function num : 0_8 , upvalues : _ENV
    local latestRT = nil
    for _, goodData in pairs(self.shopGoodsDic) do
        if goodData.isLimit then
            if latestRT == nil then
                latestRT = goodData.freshTm
            else
                latestRT = (math.min)(goodData.freshTm, latestRT)
            end
        end
    end
    if latestRT == nil then return false end
    do return latestRT - PlayerDataCenter.timestamp <= 0 end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

ShopData.GetNormalShopGoodByItemId = function(self, itemId)
    -- function num : 0_9
    if self.shopItemIdGoodDic == nil then return nil end
    return (self.shopItemIdGoodDic)[itemId]
end

ShopData.UpdateShopData = function(self)
    -- function num : 0_10
end

return ShopData

