-- params : ...
-- function num : 0 , upvalues : _ENV
local FactoryController = class("FactoryController", ControllerBase)
local base = ControllerBase
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local FactoryEnum = require("Game.Factory.FactoryEnum")
local FactoryRoomEntity = require("Game.Factory.Entity.FactoryRoomEntity")
local UIN3DFactoryCanvas = require("Game.Factory.UI3D.UIN3DFactoryCanvas")
local MAX_ROOM_INDEX = 7
FactoryController.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.networkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Factory)
  self.unlockedRoom = {}
  self.unlockedCondicton = {}
  self.enteredHero = {}
  self.factoryEnterArgs = (ConfigData.game_config).FactoryEnterArgs
  self.roomType = {}
  self.cameraDefaultPos = nil
  self.OrderDataDic = nil
  self.digOrderIds = nil
  self.produceOrderIds = nil
  self.roomEntityList = nil
  self.roomBind = nil
  self.factoryMainUI = nil
  self.uiCanvas = nil
  self.resloader = nil
  self.updateEnergyTimer = nil
  self.orderData = nil
  self.productOrderAddDic = nil
  self:InitAllData()
  self.m_CheckUnlockCondiction = BindCallback(self, self.CheckUnlockCondiction)
  MsgCenter:AddListener(eMsgEventId.BuildingUpgradeComplete, self.m_CheckUnlockCondiction)
  self.m_OnHeroDataChange = BindCallback(self, self.OnHeroDataChange)
  MsgCenter:AddListener(eMsgEventId.UpdateHero, self.m_OnHeroDataChange)
  self.m_OnUpdateARG = BindCallback(self, self.OnUpdateARG)
  MsgCenter:AddListener(eMsgEventId.UpdateARGItem, self.m_OnUpdateARG)
end

FactoryController.FadeFactory = function(self)
  -- function num : 0_1
  ((self.roomBind).factoryToHome):Play()
end

FactoryController.OpenFactory = function(self)
  -- function num : 0_2 , upvalues : _ENV, eDynConfigData
  UIManager:DeleteAllWindow()
  ;
  ((CS.GSceneManager).Instance):LoadSceneByAB((Consts.SceneName).Factory, function()
    -- function num : 0_2_0 , upvalues : _ENV, eDynConfigData, self
    ConfigData:LoadDynCfg(eDynConfigData.factory_order)
    self.resloader = ((CS.ResLoader).Create)()
    self:CheckUnlockCondiction()
    UIManager:ShowWindowAsync(UIWindowTypeID.Factory, function(win)
      -- function num : 0_2_0_0 , upvalues : self
      self.factoryMainUI = win
      self:InitBindingData()
      self:InitRoomEntities()
    end
)
  end
)
end

FactoryController.CloseFactory = function(self)
  -- function num : 0_3 , upvalues : _ENV, eDynConfigData
  (self.uiCanvas):Delete()
  self.uiCanvas = nil
  ;
  (self.factoryMainUI):Delete()
  self.factoryMainUI = nil
  UIManager:DeleteAllWindow()
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
  self.OrderDataDic = nil
  ConfigData:ReleaseDynCfg(eDynConfigData.factory_order)
  ;
  ((CS.GSceneManager).Instance):LoadSceneByAB((Consts.SceneName).Main, function()
    -- function num : 0_3_0 , upvalues : _ENV
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
    UIManager:ShowWindowAsync(UIWindowTypeID.Home, function(window)
      -- function num : 0_3_0_0 , upvalues : _ENV
      if window == nil then
        return 
      end
      window:SetFrom(AreaConst.FactoryDorm)
    end
)
  end
)
end

FactoryController.InitAllData = function(self)
  -- function num : 0_4
  self:CheckUnlockCondiction()
  self:SetDefaultCommonLogic()
  ;
  (self.networkCtrl):CS_FACTORY_Detail()
end

FactoryController.SetDefaultCommonLogic = function(self)
  -- function num : 0_5 , upvalues : _ENV
  for lineId,cfg in pairs(ConfigData.factory) do
    for index,logic in ipairs(cfg.logic) do
      (PlayerDataCenter.playerBonus):InstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_Factory, lineId, logic, (cfg.para1)[index], (cfg.para2)[index], (cfg.para3)[index])
    end
  end
  ;
  (PlayerDataCenter.playerBonus):CheckPlayerBonusBroadcast()
end

FactoryController.CheckUnlockCondiction = function(self, buildingId)
  -- function num : 0_6 , upvalues : _ENV, MAX_ROOM_INDEX
  if buildingId ~= nil and buildingId ~= eBuildingId.OasisFactory then
    return 
  end
  self.unlockedRoom = {}
  self.unlockedCondicton = {}
  local factoryBuildingData = ((PlayerDataCenter.AllBuildingData).built)[eBuildingId.OasisFactory]
  if factoryBuildingData == nil then
    return 
  end
  local levelConfig = factoryBuildingData.levelConfig
  local curLevel = factoryBuildingData.level
  local maxUnlocNum = 0
  for index,logic in ipairs((levelConfig[curLevel]).logic) do
    if logic == eLogicType.FactoryPipelie then
      maxUnlocNum = (math.max)(((levelConfig[curLevel]).para1)[index], maxUnlocNum)
    end
  end
  for i = 1, maxUnlocNum do
    -- DECOMPILER ERROR at PC47: Confused about usage of register: R10 in 'UnsetPending'

    (self.unlockedRoom)[i] = true
  end
  if maxUnlocNum < MAX_ROOM_INDEX then
    for index = maxUnlocNum + 1, MAX_ROOM_INDEX do
      -- DECOMPILER ERROR at PC57: Confused about usage of register: R10 in 'UnsetPending'

      (self.unlockedCondicton)[index] = 0
    end
  end
  do
    for level = curLevel + 1, #levelConfig do
      local cfg = levelConfig[level]
      for index,logic in ipairs(cfg.logic) do
        -- DECOMPILER ERROR at PC90: Confused about usage of register: R16 in 'UnsetPending'

        if logic == eLogicType.FactoryPipelie and (cfg.para1)[index] <= MAX_ROOM_INDEX and maxUnlocNum < (cfg.para1)[index] and (self.unlockedCondicton)[(cfg.para1)[index]] == 0 then
          (self.unlockedCondicton)[(cfg.para1)[index]] = level
        end
      end
    end
  end
end

FactoryController.GetAllRoomEnegey = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local data = {}
  for roomIndex,_ in pairs(self.unlockedRoom) do
    local value, ceiling, speed = self:GetRoomEnegeyByIndex(roomIndex)
    data[roomIndex] = {value = value, ceiling = ceiling, speed = speed}
  end
  return data
end

FactoryController.GetRoomEnegeyByIndex = function(self, index)
  -- function num : 0_8 , upvalues : _ENV
  local itemId = ((ConfigData.factory)[index]).cost_item
  local value, nextGenTime = (PlayerDataCenter.allEffectorData):GetCurrentARGNum(itemId)
  local ceiling = (PlayerDataCenter.allEffectorData):GetCurrentARGCeiling(itemId)
  local speed = (PlayerDataCenter.allEffectorData):GetCurrentARGSpeed(itemId)
  return value, ceiling, speed
end

FactoryController.GetRoomEnegeyBaseSpeedByIndex = function(self, index)
  -- function num : 0_9 , upvalues : _ENV
  local itemId = ((ConfigData.factory)[index]).cost_item
  local speed = (PlayerDataCenter.allEffectorData):GetCurrentARGSpeed(itemId, true)
  return speed
end

FactoryController.OnRecRoomHeroList = function(self, linesInfo)
  -- function num : 0_10 , upvalues : _ENV
  for roomIndex,value in pairs(linesInfo) do
    -- DECOMPILER ERROR at PC6: Confused about usage of register: R7 in 'UnsetPending'

    (self.enteredHero)[roomIndex] = {}
    for heroId,_ in pairs(value.heroIds) do
      (table.insert)((self.enteredHero)[roomIndex], heroId)
    end
  end
  for roomIndex,heroIdList in pairs(self.enteredHero) do
    self:ChangeEnergyGenSpeed(roomIndex, heroIdList)
  end
  ;
  (PlayerDataCenter.allEffectorData):OnUpdateItemGenerateSpeed()
  self:OnUpdateARG()
end

FactoryController.SetRoomHeroList = function(self, lineId, helpList, callBack)
  -- function num : 0_11 , upvalues : _ENV
  (self.networkCtrl):CS_FACTORY_DispatchHero(lineId, helpList, function()
    -- function num : 0_11_0 , upvalues : lineId, _ENV, self, helpList, callBack
    local needRefreshRoomDic = {}
    needRefreshRoomDic[lineId] = true
    for lineId,heroIds in pairs(self.enteredHero) do
      for i = #heroIds, 1, -1 do
        local heroId = heroIds[i]
        if (table.contain)(helpList, heroId) then
          (table.remove)(heroIds, i)
          needRefreshRoomDic[lineId] = true
        end
      end
    end
    -- DECOMPILER ERROR at PC31: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (self.enteredHero)[lineId] = helpList
    for roomIndex,heroIdList in pairs(self.enteredHero) do
      self:ChangeEnergyGenSpeed(roomIndex, heroIdList)
    end
    ;
    (PlayerDataCenter.allEffectorData):OnUpdateItemGenerateSpeed()
    self:OnUpdateARG()
    if callBack ~= nil then
      callBack()
    end
    for roomIndex,_ in pairs(needRefreshRoomDic) do
      (self.uiCanvas):RefreshRoomEnterHero(roomIndex)
    end
  end
)
end

FactoryController.GetRoomHeroList = function(self)
  -- function num : 0_12
  return self.enteredHero
end

FactoryController.GetHeroEnterAccrate = function(self, roomIndex, heroIdList)
  -- function num : 0_13 , upvalues : _ENV
  local accRate = 0
  local _, _, baseSpeed = self:GetRoomEnegeyByIndex(roomIndex)
  for _,heroId in ipairs(heroIdList) do
    local heroData = (PlayerDataCenter.heroDic)[heroId]
    local level = heroData.level
    local rank = heroData.rank
    local starScore = ((ConfigData.star_score)[rank]).score
    local FriendShiplevel = (PlayerDataCenter.allFriendshipData):GetLevel(heroId)
    accRate = accRate + (starScore + level * (self.factoryEnterArgs)[1] + FriendShiplevel * (self.factoryEnterArgs)[2]) / ((self.factoryEnterArgs)[3] * 1000)
  end
  return accRate
end

FactoryController.GetOneHeroAccrateDetail = function(self, roomIndex, heroId)
  -- function num : 0_14 , upvalues : _ENV
  local levelRate = 0
  local friendshipRate = 0
  local RankRate = 0
  local dliverNum = (self.factoryEnterArgs)[3] * 1000
  local heroData = (PlayerDataCenter.heroDic)[heroId]
  local level = heroData.level
  local rank = heroData.rank
  local starScore = ((ConfigData.star_score)[rank]).score
  local FriendShiplevel = (PlayerDataCenter.allFriendshipData):GetLevel(heroId)
  levelRate = level * (self.factoryEnterArgs)[1] / dliverNum
  friendshipRate = FriendShiplevel * (self.factoryEnterArgs)[2] / dliverNum
  RankRate = starScore / dliverNum
  return levelRate, friendshipRate, RankRate
end

FactoryController.ChangeEnergyGenSpeed = function(self, roomIndex, heroIdList)
  -- function num : 0_15 , upvalues : _ENV
  local accRate = self:GetHeroEnterAccrate(roomIndex, heroIdList)
  local itemId = ((ConfigData.factory)[roomIndex]).cost_item
  ;
  (PlayerDataCenter.allEffectorData):SetAccRacte(itemId, accRate)
end

FactoryController.OnHeroDataChange = function(self)
  -- function num : 0_16 , upvalues : _ENV
  for roomIndex,heroIdList in pairs(self.enteredHero) do
    self:ChangeEnergyGenSpeed(roomIndex, heroIdList)
  end
  ;
  (PlayerDataCenter.allEffectorData):OnUpdateItemGenerateSpeed()
  self:OnUpdateARG()
end

FactoryController.InitBindingData = function(self)
  -- function num : 0_17 , upvalues : _ENV, UIN3DFactoryCanvas
  self.OrderDataDic = {}
  self:InitOrderUnlcok()
  self.roomEntityList = {}
  self.roomBind = {}
  local cameraRoot = ((((CS.UnityEngine).GameObject).Find)("CameraRoot")).transform
  ;
  (UIUtil.LuaUIBindingTable)(cameraRoot, self.roomBind)
  self.cameraDefaultPos = (((self.roomBind).camera).transform).position
  self.uiCanvas = (UIN3DFactoryCanvas.New)()
  ;
  (self.uiCanvas):Init((self.roomBind).uICanvas)
  ;
  (self.uiCanvas):SetClickBackgroundCallback((self.factoryMainUI).m_OnClick3DBG)
  self.__CloseFactory = BindCallback(self, self.CloseFactory)
  ;
  ((self.roomBind).factoryToHome):stopped("+", self.__CloseFactory)
  for roomIndex,_ in pairs(self.unlockedRoom) do
    local value, ceiling, speed = self:GetRoomEnegeyByIndex(roomIndex)
    local factoryNode = RedDotController:AddRedDotNodeWithPath(RedDotDynPath.FactoryLine, RedDotStaticTypeId.Main, RedDotStaticTypeId.Factory, roomIndex)
    if ceiling <= value then
      factoryNode:SetRedDotCount(1)
    else
      factoryNode:SetRedDotCount(0)
    end
  end
end

FactoryController.OnUpdateARG = function(self, changedItemNumDic)
  -- function num : 0_18 , upvalues : _ENV
  if self.factoryMainUI ~= nil then
    (self.factoryMainUI):UpdateEnergy()
    for roomIndex,_ in pairs(self.unlockedRoom) do
      local itemId = ((ConfigData.factory)[roomIndex]).cost_item
      if changedItemNumDic == nil or changedItemNumDic[itemId] ~= nil then
        local value, ceiling, speed = self:GetRoomEnegeyByIndex(roomIndex)
        ;
        (self.uiCanvas):RefreshRoomEnergy(roomIndex, value, ceiling, speed)
        local ok, factoryNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Factory, roomIndex)
        if ok then
          if ceiling <= value then
            factoryNode:SetRedDotCount(1)
          else
            factoryNode:SetRedDotCount(0)
          end
        end
      end
    end
  end
end

FactoryController.InitOrderUnlcok = function(self)
  -- function num : 0_19 , upvalues : _ENV
  for _,orderCfg in pairs(ConfigData.factory_order) do
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R6 in 'UnsetPending'

    if (self.OrderDataDic)[orderCfg.id] == nil then
      (self.OrderDataDic)[orderCfg.id] = {isUnlock = (CheckCondition.CheckLua)(orderCfg.pre_condition, orderCfg.pre_para1, orderCfg.pre_para2)}
    else
      -- DECOMPILER ERROR at PC31: Confused about usage of register: R6 in 'UnsetPending'

      ;
      ((self.OrderDataDic)[orderCfg.id]).isUnlock = (CheckCondition.CheckLua)(orderCfg.pre_condition, orderCfg.pre_para1, orderCfg.pre_para2)
    end
  end
end

FactoryController.GetOrders = function(self, type)
  -- function num : 0_20 , upvalues : _ENV
  local orders = {}
  for _,cfg in pairs(ConfigData.factory_order) do
    if cfg.type == type then
      local efficiencyEnhance = (PlayerDataCenter.playerBonus):GetFactoryEfficiency(cfg.id)
      -- DECOMPILER ERROR at PC32: Confused about usage of register: R9 in 'UnsetPending'

      if (self.OrderDataDic)[cfg.id] == nil then
        (self.OrderDataDic)[cfg.id] = {cfg = cfg, efficiencyEnhance = efficiencyEnhance, energyCost = (math.ceil)(cfg.energy_cost * (1 - efficiencyEnhance / 1000))}
      else
        -- DECOMPILER ERROR at PC37: Confused about usage of register: R9 in 'UnsetPending'

        ;
        ((self.OrderDataDic)[cfg.id]).cfg = cfg
        -- DECOMPILER ERROR at PC41: Confused about usage of register: R9 in 'UnsetPending'

        ;
        ((self.OrderDataDic)[cfg.id]).efficiencyEnhance = efficiencyEnhance
        -- DECOMPILER ERROR at PC52: Confused about usage of register: R9 in 'UnsetPending'

        ;
        ((self.OrderDataDic)[cfg.id]).energyCost = (math.ceil)(cfg.energy_cost * (1 - efficiencyEnhance / 1000))
      end
      ;
      (table.insert)(orders, (self.OrderDataDic)[cfg.id])
    end
  end
  ;
  (table.sort)(orders, function(a, b)
    -- function num : 0_20_0
    if (a.cfg).id >= (b.cfg).id then
      do return a.isUnlock ~= b.isUnlock end
      do return a.isUnlock end
      -- DECOMPILER ERROR: 3 unprocessed JMP targets
    end
  end
)
  return orders
end

FactoryController.InitRoomEntities = function(self)
  -- function num : 0_21 , upvalues : _ENV, FactoryEnum, FactoryRoomEntity
  local m_OnClickRoom = (self.factoryMainUI).m_OnClickRoom
  for index,_ in ipairs(self.unlockedRoom) do
    do
      local obj = nil
      if (self.roomType)[index] == nil or (self.roomType)[index] == (FactoryEnum.eRoomType).dig then
        obj = ((self.roomBind).rooms_dig)[index]
      else
        obj = ((self.roomBind).rooms_normal)[index]
      end
      local roomEntity = (FactoryRoomEntity.New)()
      roomEntity:InitRoomObject(obj, m_OnClickRoom, (FactoryEnum.eRoomType).dig, index, nil)
      -- DECOMPILER ERROR at PC35: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (self.roomEntityList)[index] = roomEntity
    end
  end
  for index,unlockLevel in pairs(self.unlockedCondicton) do
    local roomPath = PathConsts:GetFactoryPath("FactoryRoom_empty")
    ;
    (self.resloader):LoadABAssetAsync(roomPath, function(prefab)
    -- function num : 0_21_0 , upvalues : self, index, FactoryRoomEntity, m_OnClickRoom, FactoryEnum, unlockLevel
    local obj = prefab:Instantiate((self.roomBind).rooms)
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (obj.transform).position = ((((self.roomBind).rooms_normal)[index]).transform).position
    local roomEntity = (FactoryRoomEntity.New)()
    roomEntity:InitRoomObject(obj, m_OnClickRoom, (FactoryEnum.eRoomType).locked, index, unlockLevel)
    -- DECOMPILER ERROR at PC24: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self.roomEntityList)[index] = roomEntity
  end
)
  end
  ;
  (self.uiCanvas):RefreshAllRoomEnterHero()
end

FactoryController.ChangeRoomModelGo = function(self, index, type)
  -- function num : 0_22
  local entity = (self.roomEntityList)[index]
  if entity.type == type then
    return 
  end
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.roomType)[index] = type
  local go = self:GetRoomModelGo(index, type)
  if go ~= nil then
    entity:ChangeRoomModelGo(go, type)
  end
end

FactoryController.GetRoomModelGo = function(self, index, type)
  -- function num : 0_23 , upvalues : FactoryEnum, _ENV
  if type == (FactoryEnum.eRoomType).normal then
    return ((self.roomBind).rooms_normal)[index]
  else
    if type == (FactoryEnum.eRoomType).dig then
      return ((self.roomBind).rooms_dig)[index]
    else
      if type == (FactoryEnum.eRoomType).locked then
        error("commonly a unlocked room can\'t switch to lock")
      end
    end
  end
end

FactoryController.GetOrder = function(self)
  -- function num : 0_24
  return self.orderData
end

FactoryController.ClearOrder = function(self)
  -- function num : 0_25
  self.orderData = nil
  self.productOrderAddDic = nil
end

FactoryController.TryAddOneOrder = function(self, lindIndex, orderData)
  -- function num : 0_26 , upvalues : _ENV, FactoryEnum
  local orderCfg = orderData.cfg
  local orderId = orderCfg.id
  local lineEnergy = self:GetRoomEnegeyByIndex(lindIndex)
  if self.orderData ~= nil and ((self.orderData).lineIndex ~= lindIndex or (self.orderData).curOrderId ~= orderId) then
    error("doesn\'t clean old orderData")
    return false
  end
  if orderCfg.type == (FactoryEnum.eOrderType).dig then
    if self.orderData == nil then
      local warehouseCapacity = (PlayerDataCenter.playerBonus):GetWarehouseCapcity((orderData.cfg).outPutItemId)
      local curwarehouseNum = PlayerDataCenter:GetItemCount((orderData.cfg).outPutItemId, false)
      local warehouseNotFull = warehouseCapacity == 0 or (orderData.cfg).outPutItemNum <= warehouseCapacity - curwarehouseNum
      local couldAdd = lineEnergy / orderData.energyCost >= 1
      if couldAdd then
        if not warehouseNotFull then
          return false, (FactoryEnum.eCannotAddReason).warehouseFull
        end
        self.orderData = {orderType = (FactoryEnum.eOrderType).dig, curOrderId = orderId, curOrderNum = 1, lineIndex = lindIndex, usedEnergy = orderData.energyCost}
        return true
      else
        return false, (FactoryEnum.eCannotAddReason).energyInsufficeient
      end
    else
      local warehouseCapacity = (PlayerDataCenter.playerBonus):GetWarehouseCapcity((orderData.cfg).outPutItemId)
      local curwarehouseNum = PlayerDataCenter:GetItemCount((orderData.cfg).outPutItemId, false)
      local warehouseNotFull = warehouseCapacity == 0 or ((self.orderData).curOrderNum + 1) * (orderData.cfg).outPutItemNum <= warehouseCapacity - curwarehouseNum
      local couldAdd = (lineEnergy - (self.orderData).usedEnergy) / orderData.energyCost >= 1
      if couldAdd then
        if not warehouseNotFull then
          return false, (FactoryEnum.eCannotAddReason).warehouseFull
        end
        -- DECOMPILER ERROR at PC128: Confused about usage of register: R10 in 'UnsetPending'

        ;
        (self.orderData).curOrderNum = (self.orderData).curOrderNum + 1
        -- DECOMPILER ERROR at PC134: Confused about usage of register: R10 in 'UnsetPending'

        ;
        (self.orderData).usedEnergy = orderData.energyCost * (self.orderData).curOrderNum
        return true
      else
        return false, (FactoryEnum.eCannotAddReason).energyInsufficeient
      end
    end
  elseif orderCfg.type == (FactoryEnum.eOrderType).produce then
    if self.orderData == nil then
      self.productOrderAddDic = {}
      local usedMat = {}
      local subDic = {}
      local nowEnergy = self:GetRoomEnegeyByIndex(lindIndex)
      local couldAdd, arg2 = self:CheckOrderResource(orderData, 1, usedMat, subDic, nowEnergy)
      if couldAdd then
        self.orderData = {orderType = (FactoryEnum.eOrderType).produce, curOrderId = orderId, curOrderNum = 1, lineIndex = lindIndex, assistOrderDic = subDic, usedEnergy = nowEnergy - arg2, usedMat = usedMat}
        if (table.count)(subDic) > 0 then
          if self.productOrderAddDic == nil then
            self.productOrderAddDic = {}
          end
          -- DECOMPILER ERROR at PC197: Confused about usage of register: R11 in 'UnsetPending'

          ;
          (self.productOrderAddDic)[(self.orderData).curOrderNum] = (table.deepCopy)(self.orderData)
        end
        return true
      else
        return false, arg2
      end
    else
      local usedMat = (table.deepCopy)((self.orderData).usedMat)
      local subDic = (table.deepCopy)((self.orderData).assistOrderDic)
      local realEnergy = self:GetRoomEnegeyByIndex(lindIndex)
      local nowEnergy = realEnergy - (self.orderData).usedEnergy
      local couldAdd, arg2 = self:CheckOrderResource(orderData, 1, usedMat, subDic, nowEnergy)
      -- DECOMPILER ERROR at PC234: Confused about usage of register: R12 in 'UnsetPending'

      if couldAdd then
        (self.orderData).curOrderNum = (self.orderData).curOrderNum + 1
        -- DECOMPILER ERROR at PC236: Confused about usage of register: R12 in 'UnsetPending'

        ;
        (self.orderData).usedMat = usedMat
        -- DECOMPILER ERROR at PC238: Confused about usage of register: R12 in 'UnsetPending'

        ;
        (self.orderData).assistOrderDic = subDic
        -- DECOMPILER ERROR at PC241: Confused about usage of register: R12 in 'UnsetPending'

        ;
        (self.orderData).usedEnergy = realEnergy - arg2
        if (table.count)(subDic) > 0 then
          if self.productOrderAddDic == nil then
            self.productOrderAddDic = {}
          end
          -- DECOMPILER ERROR at PC260: Confused about usage of register: R12 in 'UnsetPending'

          ;
          (self.productOrderAddDic)[(self.orderData).curOrderNum] = (table.deepCopy)(self.orderData)
        end
        return true
      else
        return false, arg2
      end
    end
  end
  -- DECOMPILER ERROR: 18 unprocessed JMP targets
end

FactoryController.TryMinOneOrder = function(self, lindIndex, orderData)
  -- function num : 0_27 , upvalues : _ENV, FactoryEnum
  local orderCfg = orderData.cfg
  local orderId = orderCfg.id
  if self.orderData ~= nil and ((self.orderData).lineIndex ~= lindIndex or (self.orderData).curOrderId ~= orderId) then
    error("doesn\'t clean old orderData")
    return false
  end
  if orderCfg.type == (FactoryEnum.eOrderType).dig then
    if self.orderData == nil or (self.orderData).curOrderNum < 1 then
      return false
    else
      -- DECOMPILER ERROR at PC37: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (self.orderData).curOrderNum = (self.orderData).curOrderNum - 1
      -- DECOMPILER ERROR at PC43: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (self.orderData).usedEnergy = orderData.energyCost * (self.orderData).curOrderNum
      return true
    end
  else
    if orderCfg.type == (FactoryEnum.eOrderType).produce then
      if self.orderData == nil or (self.orderData).curOrderNum < 1 then
        return false
      end
      local curNum = (self.orderData).curOrderNum
      if self.productOrderAddDic ~= nil and (self.productOrderAddDic)[curNum - 1] ~= nil then
        self.orderData = (table.deepCopy)((self.productOrderAddDic)[curNum - 1])
        return true
      else
        -- DECOMPILER ERROR at PC87: Confused about usage of register: R6 in 'UnsetPending'

        if curNum > 0 then
          (self.orderData).curOrderNum = (self.orderData).curOrderNum - 1
          -- DECOMPILER ERROR at PC93: Confused about usage of register: R6 in 'UnsetPending'

          ;
          (self.orderData).usedEnergy = orderData.energyCost * (self.orderData).curOrderNum
          local usedMat = {}
          for itemId,cost in pairs(orderCfg.raw_material) do
            usedMat[itemId] = cost * (self.orderData).curOrderNum
          end
          -- DECOMPILER ERROR at PC107: Confused about usage of register: R7 in 'UnsetPending'

          ;
          (self.orderData).assistOrderDic = {}
          -- DECOMPILER ERROR at PC109: Confused about usage of register: R7 in 'UnsetPending'

          ;
          (self.orderData).usedMat = usedMat
          return true
        end
        do
          do return false end
        end
      end
    end
  end
end

FactoryController.TryAddMaxOrder = function(self, lindIndex, orderData)
  -- function num : 0_28 , upvalues : _ENV, FactoryEnum
  local orderCfg = orderData.cfg
  local orderId = orderCfg.id
  local lineEnergy = self:GetRoomEnegeyByIndex(lindIndex)
  if self.orderData ~= nil and ((self.orderData).lineIndex ~= lindIndex or (self.orderData).curOrderId ~= orderId) then
    error("doesn\'t clean old orderData")
    return false
  end
  if orderCfg.type == (FactoryEnum.eOrderType).dig then
    local couldAddNum = lineEnergy // orderData.energyCost
    local warehouseCapacity = (PlayerDataCenter.playerBonus):GetWarehouseCapcity((orderData.cfg).outPutItemId)
    local curwarehouseNum = PlayerDataCenter:GetItemCount((orderData.cfg).outPutItemId, false)
    do
      do
        if warehouseCapacity ~= 0 then
          local num = (warehouseCapacity - curwarehouseNum) // (orderData.cfg).outPutItemNum
          if num <= 0 then
            couldAddNum = 0
          else
            couldAddNum = (math.min)(couldAddNum, num)
          end
        end
        if couldAddNum > 0 then
          self.orderData = {orderType = (FactoryEnum.eOrderType).dig, curOrderId = orderId, curOrderNum = couldAddNum, lineIndex = lindIndex, usedEnergy = orderData.energyCost * couldAddNum}
          return true
        else
          return false
        end
        if orderCfg.type == (FactoryEnum.eOrderType).produce then
          local couldAddNum = self:GenMaxOrder4Product(orderData, lineEnergy)
          local usedMat = {}
          if couldAddNum > 0 then
            if self.orderData ~= nil and couldAddNum <= (self.orderData).curOrderNum then
              return false
            end
            for itemId,cost in pairs(orderCfg.raw_material) do
              usedMat[itemId] = cost * couldAddNum
            end
            self.orderData = {orderType = (FactoryEnum.eOrderType).produce, curOrderId = orderId, curOrderNum = couldAddNum, lineIndex = lindIndex, usedEnergy = orderData.energyCost * couldAddNum, 
assistOrderDic = {}
, usedMat = usedMat}
            return true
          else
            return false
          end
        end
      end
    end
  end
end

FactoryController.SendOrder = function(self, callback)
  -- function num : 0_29
  if self.orderData == nil or (self.orderData).curOrderNum < 1 then
    return 
  end
  ;
  (self.networkCtrl):CS_FACTORY_LinePlaceOrder(self.orderData, callback)
end

FactoryController.CheckOrderResource = function(self, orderData, needNum, usedMat, subDic, nowEnergy)
  -- function num : 0_30 , upvalues : FactoryEnum, _ENV
  local orderCfg = orderData.cfg
  if orderData.energyCost * needNum <= nowEnergy then
    nowEnergy = nowEnergy - orderData.energyCost * needNum
  else
    return false, (FactoryEnum.eCannotAddReason).energyInsufficeient
  end
  for itemId,cost in pairs(orderCfg.raw_material) do
    local nowCount = PlayerDataCenter:GetItemCount(itemId) - (usedMat[itemId] or 0)
    local nowCost = cost * needNum
    if nowCount < nowCost then
      local subOrderCfg = nil
      for _,orderId in ipairs((((ConfigData.factory_order).orderMap)[orderCfg.id]).sudOrderListIds) do
        if ((ConfigData.factory_order)[orderId]).outPutItemId == itemId and ((self.OrderDataDic)[orderId]).isUnlock then
          subOrderCfg = (ConfigData.factory_order)[orderId]
          break
        end
      end
      do
        if subOrderCfg ~= nil then
          local needNum = (math.ceil)((nowCost - nowCount) / subOrderCfg.outPutItemNum)
          local remainNum = needNum * subOrderCfg.outPutItemNum - (nowCost - nowCount)
          local couldSub, arg2 = self:CheckOrderResource((self.OrderDataDic)[subOrderCfg.id], needNum, usedMat, subDic, nowEnergy)
          if not couldSub then
            return false, arg2
          else
            subDic[subOrderCfg.id] = (subDic[subOrderCfg.id] or 0) + needNum
            usedMat[itemId] = (usedMat[itemId] or 0) + nowCount - remainNum
            nowEnergy = arg2
          end
        else
          do
            do
              do
                do return false, (FactoryEnum.eCannotAddReason).matInsufficeient end
                usedMat[itemId] = (usedMat[itemId] or 0) + nowCost
                -- DECOMPILER ERROR at PC111: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC111: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC111: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                -- DECOMPILER ERROR at PC111: LeaveBlock: unexpected jumping out IF_STMT

                -- DECOMPILER ERROR at PC111: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC111: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC111: LeaveBlock: unexpected jumping out IF_STMT

              end
            end
          end
        end
      end
    end
  end
  return true, nowEnergy
end

FactoryController.GenMaxOrder4Product = function(self, orderData, energy)
  -- function num : 0_31 , upvalues : _ENV
  local orderCfg = orderData.cfg
  local limit = energy // orderData.energyCost
  if limit < 1 then
    return 0
  end
  for itemId,cost in pairs(orderCfg.raw_material) do
    local nowCount = PlayerDataCenter:GetItemCount(itemId)
    limit = (math.min)(nowCount // cost, limit)
  end
  if limit < 1 then
    return 0
  else
    return limit
  end
end

local COS_45 = (math.cos)(45)
FactoryController.StartMoveRoomToLeftMin = function(self, orderUI, roomIndex)
  -- function num : 0_32 , upvalues : _ENV, COS_45
  local cam = (self.roomBind).camera
  local L1x = ((UIManager.UICamera):WorldToScreenPoint((orderUI.transform).position)).x
  local roomEntity = (self.roomEntityList)[roomIndex]
  local L2 = cam:WorldToScreenPoint((roomEntity.transform).position)
  local targetWPos = cam:ScreenToWorldPoint((Vector3.New)(L1x / 2, L2.y, 5))
  local cX = targetWPos.x * COS_45 - targetWPos.z * COS_45 - (((roomEntity.transform).position).x * COS_45 - ((roomEntity.transform).position).z * COS_45)
  self.cameraTargetPos = self.cameraDefaultPos + (Vector3.New)(-cX / (COS_45 * 2), 0, cX / (COS_45 * 2))
end

FactoryController.OnMoveRoomToLeftMin = function(self, onMoveCallback, playrate)
  -- function num : 0_33 , upvalues : _ENV
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'

  (((self.roomBind).camera).transform).position = (Vector3.Lerp)(self.cameraDefaultPos, self.cameraTargetPos, playrate)
  if onMoveCallback ~= nil then
    onMoveCallback()
  end
end

FactoryController.ForceMoveToLeft = function(self, onMoveCallback)
  -- function num : 0_34
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  (((self.roomBind).camera).transform).position = self.cameraTargetPos
  if onMoveCallback ~= nil then
    onMoveCallback()
  end
end

FactoryController.MoveRoomToMid = function(self, onMoveCallback)
  -- function num : 0_35
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  (((self.roomBind).camera).transform).position = self.cameraDefaultPos
  if onMoveCallback ~= nil then
    onMoveCallback()
  end
end

FactoryController.OnDelete = function(self)
  -- function num : 0_36 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.UpdateHero, self.m_OnHeroDataChange)
  MsgCenter:RemoveListener(eMsgEventId.BuildingUpgradeComplete, self.m_CheckUnlockCondiction)
  MsgCenter:RemoveListener(eMsgEventId.UpdateARGItem, self.m_OnUpdateARG)
  ;
  (base.OnDelete)(self)
end

return FactoryController

