-- params : ...
-- function num : 0 , upvalues : _ENV
local FactoryController = class("FactoryController", ControllerBase)
local base = ControllerBase
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local FactoryEnum = require("Game.Factory.FactoryEnum")
local FactoryRoomEntity = require("Game.Factory.Entity.FactoryRoomEntity")
local UIN3DFactoryCanvas = require("Game.Factory.UI3D.UIN3DFactoryCanvas")
local FactoryOrderData = require("Game.Factory.Data.FactoryOrderData")
FactoryController.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.networkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Factory)
  self.unlockedRoom = {}
  self.unlockedCondicton = {}
  self.notOpenedRoom = {}
  self.enteredHero = {}
  self.factoryEnterArgs = (ConfigData.game_config).FactoryEnterArgs
  self.roomType = {}
  self.OrderDataDic = nil
  self.OrderDataListDic = nil
  self.cameraDefaultPos = nil
  self.digOrderIds = nil
  self.produceOrderIds = nil
  self.roomEntityDic = nil
  self.roomBind = nil
  self.factoryMainUI = nil
  self.ui3DCanvas = nil
  self.resloader = nil
  self.updateEnergyTimer = nil
  self.Order4SendData = nil
  self.productOrderAddDic = nil
  self:InitAllData()
  self.m_OnUpdateARG = BindCallback(self, self.OnUpdateARG)
  MsgCenter:AddListener(eMsgEventId.UpdateARGItem, self.m_OnUpdateARG)
end

FactoryController.FadeFactory = function(self)
  -- function num : 0_1
  ((self.roomBind).factoryToHome):Play()
end

FactoryController.OpenFactory = function(self)
  -- function num : 0_2 , upvalues : _ENV
  UIManager:DeleteAllWindow()
  self:InitAllData()
  ;
  ((CS.GSceneManager).Instance):LoadSceneByAB((Consts.SceneName).Factory, function()
    -- function num : 0_2_0 , upvalues : self, _ENV
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
  -- function num : 0_3 , upvalues : _ENV
  (self.ui3DCanvas):Delete()
  self.ui3DCanvas = nil
  ;
  (self.factoryMainUI):Delete()
  self.factoryMainUI = nil
  UIManager:DeleteAllWindow()
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
  AudioManager:RemoveAllVoice()
  ;
  ((CS.GSceneManager).Instance):LoadSceneByAB((Consts.SceneName).Main, function()
    -- function num : 0_3_0 , upvalues : _ENV
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
    UIManager:ShowWindowAsync(UIWindowTypeID.Home, function(window)
      -- function num : 0_3_0_0 , upvalues : _ENV
      if window == nil then
        return 
      end
      window:SetFrom2Home(AreaConst.FactoryDorm, true)
    end
)
  end
)
end

FactoryController.InitAllData = function(self)
  -- function num : 0_4
  self:CheckUnlockCondiction()
  ;
  (self.networkCtrl):CS_FACTORY_Detail()
  self.OrderDataDic = {}
  self.OrderDataListDic = {}
  self:InitOrderDatas()
end

local ROOM_SLOT_NUM = 7
FactoryController.CheckUnlockCondiction = function(self, buildingId)
  -- function num : 0_5 , upvalues : _ENV, ROOM_SLOT_NUM
  self.unlockedRoom = {}
  self.unlockedCondicton = {}
  self.notOpenedRoom = {}
  local factoryCfgs = ConfigData.factory
  for roomId,factoryCfg in pairs(factoryCfgs) do
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R8 in 'UnsetPending'

    if factoryCfg.is_open == 0 then
      (self.notOpenedRoom)[roomId] = true
    else
      local isUnlcok = (CheckCondition.CheckLua)(factoryCfg.pre_condition, factoryCfg.pre_para1, factoryCfg.pre_para2)
      -- DECOMPILER ERROR at PC27: Confused about usage of register: R9 in 'UnsetPending'

      if isUnlcok then
        (self.unlockedRoom)[roomId] = isUnlcok
      else
        -- DECOMPILER ERROR at PC36: Confused about usage of register: R9 in 'UnsetPending'

        ;
        (self.unlockedCondicton)[roomId] = (CheckCondition.GetUnlockInfoLua)(factoryCfg.pre_condition, factoryCfg.pre_para1, factoryCfg.pre_para2)
      end
    end
  end
  for roomId = 1, ROOM_SLOT_NUM do
    -- DECOMPILER ERROR at PC52: Confused about usage of register: R7 in 'UnsetPending'

    if (self.unlockedRoom)[roomId] == nil and (self.unlockedCondicton)[roomId] == nil then
      (self.notOpenedRoom)[roomId] = true
    end
  end
end

FactoryController.GetRoomEnegeyByIndex = function(self, index)
  -- function num : 0_6 , upvalues : _ENV
  local factoryEnergyItemId = (ConfigData.game_config).factoryEnergyItemId
  local value, nextGenTime = (PlayerDataCenter.allEffectorData):GetCurrentARGNum(factoryEnergyItemId)
  local ceiling = (PlayerDataCenter.allEffectorData):GetCurrentARGCeiling(factoryEnergyItemId)
  local speed = (PlayerDataCenter.allEffectorData):GetCurrentARGSpeed(factoryEnergyItemId)
  return value, ceiling, speed
end

FactoryController.GetRoomEnegeyBaseSpeedByIndex = function(self, index)
  -- function num : 0_7 , upvalues : _ENV
  local factoryEnergyItemId = (ConfigData.game_config).factoryEnergyItemId
  local speed = (PlayerDataCenter.allEffectorData):GetCurrentARGSpeed(factoryEnergyItemId, true)
  return speed
end

FactoryController.OnRecRoomHeroList = function(self, linesInfo)
  -- function num : 0_8 , upvalues : _ENV
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

FactoryController.SetRoomHeroList = function(self, lineId, heroList, callBack)
  -- function num : 0_9 , upvalues : _ENV
  (self.networkCtrl):CS_FACTORY_DispatchHero(lineId, heroList, function()
    -- function num : 0_9_0 , upvalues : heroList, _ENV, lineId, self, callBack
    if #heroList > 0 then
      local voHeroId = heroList[(math.random)(#heroList)]
      local voiceId = ConfigData:GetVoicePointRandom(6)
      local cvCtr = ControllerManager:GetController(ControllerTypeId.Cv, true)
      cvCtr:PlayCv(voHeroId, voiceId)
    end
    do
      local needRefreshRoomDic = {}
      needRefreshRoomDic[lineId] = true
      for lineId,heroIds in pairs(self.enteredHero) do
        for i = #heroIds, 1, -1 do
          local heroId = heroIds[i]
          if (table.contain)(heroList, heroId) then
            (table.remove)(heroIds, i)
            needRefreshRoomDic[lineId] = true
          end
        end
      end
      -- DECOMPILER ERROR at PC55: Confused about usage of register: R1 in 'UnsetPending'

      ;
      (self.enteredHero)[lineId] = heroList
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
      end
    end
  end
)
end

FactoryController.GetRoomHeroList = function(self)
  -- function num : 0_10
  return self.enteredHero
end

FactoryController.GetHeroEnterAccrate = function(self, roomIndex, heroIdList)
  -- function num : 0_11 , upvalues : _ENV
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
  -- function num : 0_12 , upvalues : _ENV
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
  -- function num : 0_13
end

FactoryController.OnHeroDataChange = function(self)
  -- function num : 0_14
end

FactoryController.InitBindingData = function(self)
  -- function num : 0_15 , upvalues : _ENV, UIN3DFactoryCanvas
  self.roomEntityDic = {}
  self.roomBind = {}
  local cameraRoot = ((((CS.UnityEngine).GameObject).Find)("CameraRoot")).transform
  ;
  (UIUtil.LuaUIBindingTable)(cameraRoot, self.roomBind)
  self.cameraDefaultPos = (((self.roomBind).camera).transform).position
  self.ui3DCanvas = (UIN3DFactoryCanvas.New)()
  ;
  (self.ui3DCanvas):Init((self.roomBind).uICanvas)
  ;
  (self.ui3DCanvas):SetClickBackgroundCallback((self.factoryMainUI).m_OnClick3DBGWithPop)
  self.__CloseFactory = BindCallback(self, self.CloseFactory)
  ;
  ((self.roomBind).factoryToHome):stopped("+", self.__CloseFactory)
end

FactoryController.OnUpdateARG = function(self, changedItemNumDic)
  -- function num : 0_16 , upvalues : _ENV
  if changedItemNumDic ~= nil and changedItemNumDic[(ConfigData.game_config).factoryEnergyItemId] ~= nil and self.factoryMainUI ~= nil then
    (self.factoryMainUI):UpdateEnergy()
  end
end

FactoryController.InitOrderDatas = function(self)
  -- function num : 0_17 , upvalues : _ENV, FactoryOrderData
  for _,orderCfg in pairs(ConfigData.factory_order) do
    local isRoomUnlock = (self.unlockedRoom)[orderCfg.type]
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self.OrderDataDic)[orderCfg.id] = (FactoryOrderData.CreateOrderData)(orderCfg, isRoomUnlock)
  end
end

FactoryController.GetOrders = function(self, roomIndex)
  -- function num : 0_18 , upvalues : _ENV
  do
    if (self.OrderDataListDic)[roomIndex] == nil then
      local orders = {}
      for orderId,orderData in pairs(self.OrderDataDic) do
        if orderData:GetOrderRoomIndex() == roomIndex then
          (table.insert)(orders, orderData)
        end
      end
      ;
      (table.sort)(orders, function(a, b)
    -- function num : 0_18_0
    if (a:GetOrderCfg()).id >= (b:GetOrderCfg()).id then
      do return a:GetIsUnlock() ~= b:GetIsUnlock() end
      do return a:GetIsUnlock() end
      -- DECOMPILER ERROR: 3 unprocessed JMP targets
    end
  end
)
      -- DECOMPILER ERROR at PC26: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (self.OrderDataListDic)[roomIndex] = orders
    end
    for orderId,orderData in pairs(self.OrderDataDic) do
      orderData:UpdateOrderData()
    end
    return (self.OrderDataListDic)[roomIndex]
  end
end

FactoryController.InitRoomEntities = function(self)
  -- function num : 0_19 , upvalues : _ENV, FactoryRoomEntity, FactoryEnum
  local m_OnClickRoom = (self.factoryMainUI).m_OnClickRoom
  for index,_ in pairs(self.unlockedRoom) do
    do
      local roomType = ((ConfigData.factory)[index]).model
      local obj = self:GetRoomModelGo(index, roomType)
      local roomEntity = (FactoryRoomEntity.New)()
      roomEntity:InitRoomObject(obj, m_OnClickRoom, (FactoryEnum.eRoomType).normal, index, nil)
      -- DECOMPILER ERROR at PC25: Confused about usage of register: R10 in 'UnsetPending'

      ;
      (self.roomEntityDic)[index] = roomEntity
    end
  end
  for index,unlcokDes in pairs(self.unlockedCondicton) do
    local roomPath = PathConsts:GetFactoryPath("FactoryRoom_empty")
    ;
    (self.resloader):LoadABAssetAsync(roomPath, function(prefab)
    -- function num : 0_19_0 , upvalues : _ENV, index, self, FactoryRoomEntity, m_OnClickRoom, FactoryEnum, unlcokDes
    local roomType = ((ConfigData.factory)[index]).model
    local obj = self:GetRoomModelGo(index, roomType)
    local roomEntity = (FactoryRoomEntity.New)()
    roomEntity:InitRoomObject(obj, m_OnClickRoom, (FactoryEnum.eRoomType).locked, index, unlcokDes)
    -- DECOMPILER ERROR at PC22: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (self.roomEntityDic)[index] = roomEntity
  end
)
  end
  for index,_ in pairs(self.notOpenedRoom) do
    local roomPath = PathConsts:GetFactoryPath("FactoryRoom_empty")
    ;
    (self.resloader):LoadABAssetAsync(roomPath, function(prefab)
    -- function num : 0_19_1 , upvalues : self, index, FactoryRoomEntity, m_OnClickRoom, FactoryEnum
    local obj = prefab:Instantiate((self.roomBind).rooms)
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (obj.transform).position = ((((self.roomBind).rooms_normal)[index]).transform).position
    local roomEntity = (FactoryRoomEntity.New)()
    roomEntity:InitRoomObject(obj, m_OnClickRoom, (FactoryEnum.eRoomType).notOpen, index)
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self.roomEntityDic)[index] = roomEntity
  end
)
  end
end

FactoryController.ChangeRoomModelGo = function(self, index, type)
  -- function num : 0_20
  local entity = (self.roomEntityDic)[index]
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
  -- function num : 0_21 , upvalues : FactoryEnum, _ENV
  if type == (FactoryEnum.eRoomType).normal then
    return ((self.roomBind).rooms_normal)[index]
  else
    if type == (FactoryEnum.eRoomType).dig then
      return ((self.roomBind).rooms_dig)[index]
    else
      if type == (FactoryEnum.eRoomType).present then
        return ((self.roomBind).rooms_present)[index]
      else
        if type == (FactoryEnum.eRoomType).locked then
          error("commonly a unlocked room can\'t switch to lock")
        else
          return ((self.roomBind).rooms_normal)[index]
        end
      end
    end
  end
end

FactoryController.GetOrder4Send = function(self)
  -- function num : 0_22
  return self.Order4SendData
end

FactoryController.ClearOrder = function(self)
  -- function num : 0_23
  self.Order4SendData = nil
  self.productOrderAddDic = nil
end

FactoryController.TryAddOneOrder = function(self, lindIndex, orderData)
  -- function num : 0_24 , upvalues : _ENV, FactoryEnum
  local orderCfg = orderData:GetOrderCfg()
  local orderId = orderCfg.id
  local lineEnergy = self:GetRoomEnegeyByIndex(lindIndex)
  if self.Order4SendData ~= nil and ((self.Order4SendData).lineIndex ~= lindIndex or (self.Order4SendData).curOrderId ~= orderId) then
    error("doesn\'t clean old orderData")
    return false
  end
  if orderData:GetOrderType() == (FactoryEnum.eOrderType).dig then
    if self.Order4SendData == nil then
      local warehouseNotFull = orderData:GetIsWhareHouseNotFull(0)
      local couldAdd = lineEnergy / orderData:GetEnergyCost() >= 1
      if couldAdd then
        if not warehouseNotFull then
          return false, (FactoryEnum.eCannotAddReason).warehouseFull
        end
        self.Order4SendData = {orderType = (FactoryEnum.eOrderType).dig, curOrderId = orderId, curOrderNum = 1, lineIndex = lindIndex, usedEnergy = orderData:GetEnergyCost()}
        return true
      else
        return false, (FactoryEnum.eCannotAddReason).energyInsufficeient
      end
    else
      local warehouseNotFull = orderData:GetIsWhareHouseNotFull((self.Order4SendData).curOrderNum)
      local couldAdd = (lineEnergy - (self.Order4SendData).usedEnergy) / orderData:GetEnergyCost() >= 1
      if couldAdd then
        if not warehouseNotFull then
          return false, (FactoryEnum.eCannotAddReason).warehouseFull
        end
        -- DECOMPILER ERROR at PC94: Confused about usage of register: R8 in 'UnsetPending'

        ;
        (self.Order4SendData).curOrderNum = (self.Order4SendData).curOrderNum + 1
        -- DECOMPILER ERROR at PC101: Confused about usage of register: R8 in 'UnsetPending'

        ;
        (self.Order4SendData).usedEnergy = orderData:GetEnergyCost() * (self.Order4SendData).curOrderNum
        return true
      else
        return false, (FactoryEnum.eCannotAddReason).energyInsufficeient
      end
    end
  elseif orderData:GetOrderType() == (FactoryEnum.eOrderType).product then
    if self.Order4SendData == nil then
      self.productOrderAddDic = {}
      local usedMat = {}
      local subDic = {}
      local nowEnergy = self:GetRoomEnegeyByIndex(lindIndex)
      local couldAdd, arg2 = self:CheckOrderResource(orderData, 1, usedMat, subDic, nowEnergy)
      if couldAdd then
        if not orderData:GetIsWhareHouseNotFull(0) then
          return false, (FactoryEnum.eCannotAddReason).warehouseFull
        end
        self.Order4SendData = {orderType = (FactoryEnum.eOrderType).product, curOrderId = orderId, curOrderNum = 1, lineIndex = lindIndex, assistOrderDic = subDic, usedEnergy = nowEnergy - arg2, usedMat = usedMat}
        if (table.count)(subDic) > 0 then
          if self.productOrderAddDic == nil then
            self.productOrderAddDic = {}
          end
          -- DECOMPILER ERROR at PC174: Confused about usage of register: R11 in 'UnsetPending'

          ;
          (self.productOrderAddDic)[(self.Order4SendData).curOrderNum] = (table.deepCopy)(self.Order4SendData)
        end
        return true
      else
        return false, arg2
      end
    else
      local usedMat = (table.deepCopy)((self.Order4SendData).usedMat)
      local subDic = (table.deepCopy)((self.Order4SendData).assistOrderDic)
      local realEnergy = self:GetRoomEnegeyByIndex(lindIndex)
      local nowEnergy = realEnergy - (self.Order4SendData).usedEnergy
      local couldAdd, arg2 = self:CheckOrderResource(orderData, 1, usedMat, subDic, nowEnergy)
      if couldAdd then
        if not orderData:GetIsWhareHouseNotFull((self.Order4SendData).curOrderNum) then
          return false, (FactoryEnum.eCannotAddReason).warehouseFull
        end
        -- DECOMPILER ERROR at PC221: Confused about usage of register: R12 in 'UnsetPending'

        ;
        (self.Order4SendData).curOrderNum = (self.Order4SendData).curOrderNum + 1
        -- DECOMPILER ERROR at PC223: Confused about usage of register: R12 in 'UnsetPending'

        ;
        (self.Order4SendData).usedMat = usedMat
        -- DECOMPILER ERROR at PC225: Confused about usage of register: R12 in 'UnsetPending'

        ;
        (self.Order4SendData).assistOrderDic = subDic
        -- DECOMPILER ERROR at PC228: Confused about usage of register: R12 in 'UnsetPending'

        ;
        (self.Order4SendData).usedEnergy = realEnergy - arg2
        if (table.count)(subDic) > 0 then
          if self.productOrderAddDic == nil then
            self.productOrderAddDic = {}
          end
          -- DECOMPILER ERROR at PC247: Confused about usage of register: R12 in 'UnsetPending'

          ;
          (self.productOrderAddDic)[(self.Order4SendData).curOrderNum] = (table.deepCopy)(self.Order4SendData)
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
  -- function num : 0_25 , upvalues : _ENV, FactoryEnum
  local orderCfg = orderData:GetOrderCfg()
  local orderId = orderCfg.id
  if self.Order4SendData ~= nil and ((self.Order4SendData).lineIndex ~= lindIndex or (self.Order4SendData).curOrderId ~= orderId) then
    error("doesn\'t clean old orderData")
    return false
  end
  if orderData:GetOrderType() == (FactoryEnum.eOrderType).dig then
    if self.Order4SendData == nil or (self.Order4SendData).curOrderNum < 1 then
      return false
    else
      -- DECOMPILER ERROR at PC39: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (self.Order4SendData).curOrderNum = (self.Order4SendData).curOrderNum - 1
      -- DECOMPILER ERROR at PC46: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (self.Order4SendData).usedEnergy = orderData:GetEnergyCost() * (self.Order4SendData).curOrderNum
      return true
    end
  else
    if orderData:GetOrderType() == (FactoryEnum.eOrderType).product then
      if self.Order4SendData == nil or (self.Order4SendData).curOrderNum < 1 then
        return false
      end
      local curNum = (self.Order4SendData).curOrderNum
      if self.productOrderAddDic ~= nil and (self.productOrderAddDic)[curNum - 1] ~= nil then
        self.Order4SendData = (table.deepCopy)((self.productOrderAddDic)[curNum - 1])
        return true
      else
        -- DECOMPILER ERROR at PC91: Confused about usage of register: R6 in 'UnsetPending'

        if curNum > 0 then
          (self.Order4SendData).curOrderNum = (self.Order4SendData).curOrderNum - 1
          -- DECOMPILER ERROR at PC98: Confused about usage of register: R6 in 'UnsetPending'

          ;
          (self.Order4SendData).usedEnergy = orderData:GetEnergyCost() * (self.Order4SendData).curOrderNum
          local usedMat = {}
          for itemId,cost in pairs(orderCfg.raw_material) do
            usedMat[itemId] = cost * (self.Order4SendData).curOrderNum
          end
          -- DECOMPILER ERROR at PC112: Confused about usage of register: R7 in 'UnsetPending'

          ;
          (self.Order4SendData).assistOrderDic = {}
          -- DECOMPILER ERROR at PC114: Confused about usage of register: R7 in 'UnsetPending'

          ;
          (self.Order4SendData).usedMat = usedMat
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
  -- function num : 0_26 , upvalues : _ENV, FactoryEnum
  local orderCfg = orderData:GetOrderCfg()
  local orderId = orderCfg.id
  local lineEnergy = self:GetRoomEnegeyByIndex(lindIndex)
  if self.Order4SendData ~= nil and ((self.Order4SendData).lineIndex ~= lindIndex or (self.Order4SendData).curOrderId ~= orderId) then
    error("doesn\'t clean old orderData")
    return false
  end
  if orderData:GetOrderType() == (FactoryEnum.eOrderType).dig then
    local couldAddNum = lineEnergy // orderData:GetEnergyCost()
    local warehouseCapacity = (PlayerDataCenter.playerBonus):GetWarehouseCapcity(orderCfg.outPutItemId)
    local curwarehouseNum = PlayerDataCenter:GetItemCount(orderCfg.outPutItemId, false)
    do
      do
        if warehouseCapacity ~= 0 then
          local num = (warehouseCapacity - curwarehouseNum) // orderCfg.outPutItemNum
          if num <= 0 then
            couldAddNum = 0
          else
            couldAddNum = (math.min)(couldAddNum, num)
          end
        end
        if couldAddNum > 0 then
          self.Order4SendData = {orderType = (FactoryEnum.eOrderType).dig, curOrderId = orderId, curOrderNum = couldAddNum, lineIndex = lindIndex, usedEnergy = orderData:GetEnergyCost() * couldAddNum}
          return true
        else
          return false
        end
        if orderData:GetOrderType() == (FactoryEnum.eOrderType).product then
          local couldAddNum = self:GenMaxOrder4Product(orderData, lineEnergy)
          local usedMat = {}
          if couldAddNum > 0 then
            if self.Order4SendData ~= nil and couldAddNum <= (self.Order4SendData).curOrderNum then
              return false
            end
            for itemId,cost in pairs(orderCfg.raw_material) do
              usedMat[itemId] = cost * couldAddNum
            end
            self.Order4SendData = {orderType = (FactoryEnum.eOrderType).product, curOrderId = orderId, curOrderNum = couldAddNum, lineIndex = lindIndex, usedEnergy = orderData:GetEnergyCost() * couldAddNum, 
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
  -- function num : 0_27
  if self.Order4SendData == nil or (self.Order4SendData).curOrderNum < 1 then
    return 
  end
  if self.isSending then
    return 
  end
  self.isSending = true
  ;
  (self.networkCtrl):CS_FACTORY_WorkshopProduct(self.Order4SendData, function()
    -- function num : 0_27_0 , upvalues : callback, self
    callback()
    self.isSending = false
  end
)
end

FactoryController.CheckOrderResource = function(self, orderData, needNum, usedMat, subDic, nowEnergy)
  -- function num : 0_28 , upvalues : FactoryEnum, _ENV
  local orderCfg = orderData:GetOrderCfg()
  if orderData:GetEnergyCost() * needNum <= nowEnergy then
    nowEnergy = nowEnergy - orderData:GetEnergyCost() * needNum
  else
    return false, (FactoryEnum.eCannotAddReason).energyInsufficeient
  end
  for itemId,cost in pairs(orderCfg.raw_material) do
    local nowCount = PlayerDataCenter:GetItemCount(itemId) - (usedMat[itemId] or 0)
    local nowCost = cost * needNum
    if nowCount < nowCost then
      local subOrderCfg = nil
      for _,orderId in ipairs((((ConfigData.factory_order).orderMap)[orderCfg.id]).sudOrderListIds) do
        if ((ConfigData.factory_order)[orderId]).outPutItemId == itemId and ((self.OrderDataDic)[orderId]):GetIsUnlock() then
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
                -- DECOMPILER ERROR at PC115: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC115: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC115: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                -- DECOMPILER ERROR at PC115: LeaveBlock: unexpected jumping out IF_STMT

                -- DECOMPILER ERROR at PC115: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC115: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC115: LeaveBlock: unexpected jumping out IF_STMT

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
  -- function num : 0_29 , upvalues : _ENV
  local orderCfg = orderData:GetOrderCfg()
  local limit = energy // orderData:GetEnergyCost()
  local warehouseCapacity = (PlayerDataCenter.playerBonus):GetWarehouseCapcity(orderCfg.outPutItemId)
  local curwarehouseNum = PlayerDataCenter:GetItemCount(orderCfg.outPutItemId, false)
  limit = (math.min)(limit, warehouseCapacity - curwarehouseNum)
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
local CAMERA_TARGET_POS = (Vector3.New)(47.64, 42, 52.36)
FactoryController.StartMoveRoomToLeftMin = function(self, orderUI, roomIndex, isFromOtherRoom)
  -- function num : 0_30 , upvalues : CAMERA_TARGET_POS
  self.cameraTargetPos = CAMERA_TARGET_POS
end

FactoryController.OnMoveRoomToLeftMin = function(self, onMoveCallback, playrate, isFromOtherRoom)
  -- function num : 0_31 , upvalues : _ENV
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R4 in 'UnsetPending'

  if isFromOtherRoom then
    (((self.roomBind).camera).transform).position = (Vector3.Lerp)(self.cameraPos, self.cameraTargetPos, playrate)
  else
    -- DECOMPILER ERROR at PC22: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (((self.roomBind).camera).transform).position = (Vector3.Lerp)(self.cameraDefaultPos, self.cameraTargetPos, playrate)
  end
  if onMoveCallback ~= nil then
    onMoveCallback()
  end
end

FactoryController.ForceMoveToLeft = function(self, onMoveCallback)
  -- function num : 0_32
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  (((self.roomBind).camera).transform).position = self.cameraTargetPos
  if onMoveCallback ~= nil then
    onMoveCallback()
  end
end

FactoryController.MoveRoomToMid = function(self, onMoveCallback)
  -- function num : 0_33
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  (((self.roomBind).camera).transform).position = self.cameraDefaultPos
  if onMoveCallback ~= nil then
    onMoveCallback()
  end
end

FactoryController.IsCouldOpenQuickProduceUI = function(self, itemId)
  -- function num : 0_34 , upvalues : _ENV
  if self.factoryMainUI ~= nil then
    return false
  end
  self:InitAllData()
  local targetOrderData = nil
  for orderId,orderData in pairs(self.OrderDataDic) do
    if (orderData:GetOrderCfg()).outPutItemId == itemId then
      targetOrderData = orderData
      break
    end
  end
  do
    if targetOrderData == nil then
      return false
    end
    if targetOrderData:GetIsUnlock() then
      return true, targetOrderData
    else
      return false, targetOrderData
    end
  end
end

FactoryController.OpenQuickProduceUI = function(self, targetOrderData, closeCallback)
  -- function num : 0_35 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.FactoryQuickProduce, function(win)
    -- function num : 0_35_0 , upvalues : targetOrderData, closeCallback
    win:OpenQuickProduce(targetOrderData, closeCallback)
  end
)
end

FactoryController.OnDelete = function(self)
  -- function num : 0_36 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.UpdateARGItem, self.m_OnUpdateARG)
  ;
  (base.OnDelete)(self)
end

return FactoryController

