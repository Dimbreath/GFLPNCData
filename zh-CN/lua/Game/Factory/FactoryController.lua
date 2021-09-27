local FactoryController = class("FactoryController", ControllerBase)
local base = ControllerBase
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local FactoryEnum = require("Game.Factory.FactoryEnum")
local FactoryRoomEntity = require("Game.Factory.Entity.FactoryRoomEntity")
local UIN3DFactoryCanvas = require("Game.Factory.UI3D.UIN3DFactoryCanvas")
local FactoryOrderData = require("Game.Factory.Data.FactoryOrderData")
local JumpManager = require("Game.Jump.JumpManager")
local NoticeData = require("Game.Notice.NoticeData")
local FactoryProcessingData = require("Game.Factory.Data.FactoryProcessingData")
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
  self.ProcessingOrders = {}
  self.OrderDataListDic = nil
  self.cameraDefaultPos = nil
  self.digOrderIds = nil
  self.produceOrderIds = nil
  self.roomEntityDic = nil
  self.roomBind = nil
  self.factoryMainUI = nil
  self.ui3DCanvas = nil
  self.resloader = nil
  self.Order4SendData = nil
  self.productOrderAddDic = nil
  self:InitAllData(function()
    -- function num : 0_0_0 , upvalues : self
    self:AddNoticePreconditionData()
  end
)
  self.m_OnUpdateARG = BindCallback(self, self.OnUpdateARG)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.m_OnUpdateARG)
end

FactoryController.FadeFactory = function(self)
  -- function num : 0_1
  ((self.roomBind).factoryToHome):Play()
end

FactoryController.OpenFactory = function(self)
  -- function num : 0_2 , upvalues : _ENV
  UIManager:DeleteAllWindow()
  ;
  (UIUtil.AddOneCover)("openFactory", SafePack(nil, nil, nil, Color.black, false))
  self:InitAllData()
  ;
  ((CS.GSceneManager).Instance):LoadSceneByAB((Consts.SceneName).Factory, function()
    -- function num : 0_2_0 , upvalues : _ENV, self
    (UIUtil.CloseOneCover)("openFactory")
    AudioManager:PlayAudioById(3003)
    AudioManager:PlayAudioById(1088)
    self.resloader = ((CS.ResLoader).Create)()
    self:CheckUnlockCondiction()
    UIManager:ShowWindowAsync(UIWindowTypeID.Factory, function(win)
      -- function num : 0_2_0_0 , upvalues : self
      self.factoryMainUI = win
      self:InitBindingData()
      self:InitRoomEntities()
      self:OnUpdateProduceLineTime()
    end
)
    self.lineTimerId = TimerManager:StartTimer(1, self.OnUpdateProduceLineTime, self, false, nil, true)
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
  if self.lineTimerId ~= nil then
    TimerManager:StopTimer(self.lineTimerId)
    self.lineTimerId = nil
  end
  AudioManager:RemoveAllVoice()
  ;
  ((CS.GSceneManager).Instance):LoadSceneByAB((Consts.SceneName).Main, function()
    -- function num : 0_3_0 , upvalues : _ENV
    (ControllerManager:GetController(ControllerTypeId.HomeController, true)):OnEnterHome()
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
    UIManager:CreateWindowAsync(UIWindowTypeID.Home, function(window)
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

FactoryController.InitAllData = function(self, callback)
  -- function num : 0_4
  (self.networkCtrl):CS_FACTORY_Detail(function()
    -- function num : 0_4_0 , upvalues : self, callback
    self:CheckUnlockCondiction()
    self.OrderDataDic = {}
    self.OrderDataListDic = {}
    self:InitOrderDatas()
    if callback ~= nil then
      callback()
    end
  end
)
end

local ROOM_SLOT_NUM = 7
FactoryController.CheckUnlockCondiction = function(self)
  -- function num : 0_5 , upvalues : _ENV, ROOM_SLOT_NUM
  self.unlockedRoom = {}
  self.unlockedCondicton = {}
  self.notOpenedRoom = {}
  local factoryCfgs = ConfigData.factory
  for roomId,factoryCfg in pairs(factoryCfgs) do
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R7 in 'UnsetPending'

    if factoryCfg.is_open == 0 then
      (self.notOpenedRoom)[roomId] = true
    else
      local isUnlcok = (CheckCondition.CheckLua)(factoryCfg.pre_condition, factoryCfg.pre_para1, factoryCfg.pre_para2)
      -- DECOMPILER ERROR at PC27: Confused about usage of register: R8 in 'UnsetPending'

      if isUnlcok then
        (self.unlockedRoom)[roomId] = isUnlcok
      else
        -- DECOMPILER ERROR at PC36: Confused about usage of register: R8 in 'UnsetPending'

        ;
        (self.unlockedCondicton)[roomId] = (CheckCondition.GetUnlockInfoLua)(factoryCfg.pre_condition, factoryCfg.pre_para1, factoryCfg.pre_para2)
      end
    end
  end
  for roomId = 1, ROOM_SLOT_NUM do
    -- DECOMPILER ERROR at PC52: Confused about usage of register: R6 in 'UnsetPending'

    if (self.unlockedRoom)[roomId] == nil and (self.unlockedCondicton)[roomId] == nil then
      (self.notOpenedRoom)[roomId] = true
    end
  end
end

FactoryController.AddNoticePreconditionData = function(self)
  -- function num : 0_6 , upvalues : _ENV, NoticeData, JumpManager
  local factoryCfgs = ConfigData.factory
  for index,_ in pairs(self.unlockedCondicton) do
    local factoryCfg = factoryCfgs[index]
    do
      for index,pre_conditionId in ipairs(factoryCfg.pre_condition) do
        local pre_para1 = (factoryCfg.pre_para1)[index]
        local pre_para2 = (factoryCfg.pre_para2)[index]
        NoticeManager:Add2PreConditionDic(pre_conditionId, pre_para1, pre_para2, function()
    -- function num : 0_6_0 , upvalues : _ENV, factoryCfg, NoticeData, JumpManager
    if (CheckCondition.CheckLua)(factoryCfg.pre_condition, factoryCfg.pre_para1, factoryCfg.pre_para2) then
      NoticeManager:AddNotice((NoticeData.CreateNoticeData)(PlayerDataCenter.timestamp, (NoticeManager.eNoticeType).FactoryUnlockNewFactory, {jumpType = (JumpManager.eJumpTarget).Factory, argList = nil}, {(LanguageUtil.GetLocaleText)(factoryCfg.name)}, {id = factoryCfg.id}))
      return true
    end
  end
)
      end
    end
  end
  for orderId,factoryOrderData in pairs(self.OrderDataDic) do
    if not factoryOrderData.isUnlock then
      local orderCfg = factoryOrderData:GetOrderCfg()
      for index,pre_conditionId in ipairs(orderCfg.pre_condition) do
        local pre_para1 = (orderCfg.pre_para1)[index]
        local pre_para2 = (orderCfg.pre_para2)[index]
        NoticeManager:Add2PreConditionDic(pre_conditionId, pre_para1, pre_para2, function()
    -- function num : 0_6_1 , upvalues : _ENV, orderCfg, NoticeData, JumpManager
    if (CheckCondition.CheckLua)(orderCfg.pre_condition, orderCfg.pre_para1, orderCfg.pre_para2) then
      NoticeManager:AddNotice((NoticeData.CreateNoticeData)(PlayerDataCenter.timestamp, (NoticeManager.eNoticeType).FactoryUnlockNewOrder, {jumpType = (JumpManager.eJumpTarget).Factory, argList = nil}, {(LanguageUtil.GetLocaleText)(orderCfg.name)}, nil))
      return true
    end
  end
)
      end
    end
  end
end

FactoryController.GetRoomEnegeyByIndex = function(self, index)
  -- function num : 0_7 , upvalues : _ENV
  local factoryEnergyItemId = (ConfigData.game_config).factoryEnergyItemId
  local totalCeiling = (PlayerDataCenter.playerBonus):GetWarehouseCapcity(factoryEnergyItemId)
  local totalValue = PlayerDataCenter:GetItemCount(factoryEnergyItemId)
  return totalValue, totalCeiling
end

FactoryController.GetRoomEnegeyBaseSpeedByIndex = function(self, index)
  -- function num : 0_8 , upvalues : _ENV
  local factoryEnergyItemId = (ConfigData.game_config).factoryEnergyItemId
  local speed = (PlayerDataCenter.allEffectorData):GetCurrentARGSpeed(factoryEnergyItemId, true)
  return speed
end

FactoryController.OnRecRoomHeroList = function(self, linesInfo)
  -- function num : 0_9 , upvalues : _ENV, FactoryProcessingData
  for roomIndex,workshopGroup in pairs(linesInfo) do
    -- DECOMPILER ERROR at PC6: Confused about usage of register: R7 in 'UnsetPending'

    (self.enteredHero)[roomIndex] = {}
    if workshopGroup.heroIds ~= nil then
      for heroId,_ in pairs(workshopGroup.heroIds) do
        (table.insert)((self.enteredHero)[roomIndex], heroId)
      end
    end
    do
      -- DECOMPILER ERROR at PC24: Confused about usage of register: R7 in 'UnsetPending'

      ;
      (self.ProcessingOrders)[roomIndex] = {}
      if workshopGroup.process ~= nil then
        for uid,processOrderMsg in pairs(workshopGroup.process) do
          local factoryProcessData = (FactoryProcessingData.CreateProcessOrderData)(roomIndex, uid, processOrderMsg)
          -- DECOMPILER ERROR at PC39: Confused about usage of register: R13 in 'UnsetPending'

          ;
          ((self.ProcessingOrders)[roomIndex])[uid] = factoryProcessData
        end
      end
      do
        -- DECOMPILER ERROR at PC42: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  for roomIndex,heroIdList in pairs(self.enteredHero) do
    self:ChangeEnergyGenSpeed(roomIndex, heroIdList)
  end
  ;
  (PlayerDataCenter.allEffectorData):OnUpdateItemGenerateSpeed()
  self:OnUpdateARG()
  self:OnUpdateProduceLine()
end

FactoryController.HandleFactoryDiff = function(self, diffMsg)
  -- function num : 0_10 , upvalues : _ENV, FactoryProcessingData
  if diffMsg.update ~= nil then
    for mixId,workshopGroup in pairs(diffMsg.update) do
      local roomIndex = mixId >> 32
      local uid = mixId & CommonUtil.UInt32Max
      -- DECOMPILER ERROR at PC17: Confused about usage of register: R9 in 'UnsetPending'

      if (self.ProcessingOrders)[roomIndex] == nil then
        (self.ProcessingOrders)[roomIndex] = {}
      end
      if workshopGroup.process ~= nil then
        for uid,processOrderMsg in pairs(workshopGroup.process) do
          local factoryProcessData = (FactoryProcessingData.CreateProcessOrderData)(roomIndex, uid, processOrderMsg)
          -- DECOMPILER ERROR at PC32: Confused about usage of register: R15 in 'UnsetPending'

          ;
          ((self.ProcessingOrders)[roomIndex])[uid] = factoryProcessData
        end
      end
    end
  end
  do
    if diffMsg.delete ~= nil then
      for mixId,_ in pairs(diffMsg.delete) do
        local roomIndex = mixId >> 32
        local uid = mixId & CommonUtil.UInt32Max
        -- DECOMPILER ERROR at PC50: Confused about usage of register: R9 in 'UnsetPending'

        ;
        ((self.ProcessingOrders)[roomIndex])[uid] = nil
      end
    end
    do
      self:OnUpdateProduceLine()
    end
  end
end

FactoryController.SetRoomHeroList = function(self, lineId, heroList, callBack)
  -- function num : 0_11 , upvalues : _ENV
  (self.networkCtrl):CS_FACTORY_DispatchHero(lineId, heroList, function()
    -- function num : 0_11_0 , upvalues : heroList, _ENV, lineId, self, callBack
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
  -- function num : 0_15
end

FactoryController.OnHeroDataChange = function(self)
  -- function num : 0_16
end

FactoryController.InitBindingData = function(self)
  -- function num : 0_17 , upvalues : _ENV, UIN3DFactoryCanvas
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

FactoryController.RefreshFactoryEnergyRedDot = function(self)
  -- function num : 0_18 , upvalues : _ENV
  local factoryEnergyItemId = (ConfigData.game_config).factoryEnergyItemId
  local totalCeiling = (PlayerDataCenter.playerBonus):GetWarehouseCapcity(factoryEnergyItemId)
  local totalValue = PlayerDataCenter:GetItemCount(factoryEnergyItemId)
  local ok, factoryNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Factory, RedDotStaticTypeId.FactoryEnerage)
  if ok then
    if totalCeiling <= totalValue then
      factoryNode:SetRedDotCount(1)
    else
      factoryNode:SetRedDotCount(0)
    end
  end
end

FactoryController.OnUpdateARG = function(self, changedItemNumDic)
  -- function num : 0_19 , upvalues : _ENV
  if changedItemNumDic ~= nil and changedItemNumDic[(ConfigData.game_config).factoryEnergyItemId] ~= nil then
    self:RefreshFactoryEnergyRedDot()
    if self.factoryMainUI ~= nil then
      (self.factoryMainUI):UpdateEnergy()
    end
    local lineWin = UIManager:GetWindow(UIWindowTypeID.FactoryProduceLine)
    if lineWin ~= nil then
      lineWin:RefreshEnergey()
    end
  end
end

FactoryController.OnUpdateProduceLine = function(self)
  -- function num : 0_20 , upvalues : _ENV
  if self.ui3DCanvas ~= nil then
    (self.ui3DCanvas):RefreshProcessLines(self.ProcessingOrders)
  end
  local productLineWin = UIManager:GetWindow(UIWindowTypeID.FactoryProduceLine)
  if productLineWin ~= nil then
    productLineWin:InitAllLines()
  end
  if self.factoryMainUI ~= nil then
    (self.factoryMainUI):RefreshProduceLineInfo()
  end
end

FactoryController.OnUpdateProduceLineTime = function(self)
  -- function num : 0_21 , upvalues : _ENV
  if self.ui3DCanvas ~= nil then
    (self.ui3DCanvas):RefreshProcessLines(self.ProcessingOrders)
  end
  local productLineWin = UIManager:GetWindow(UIWindowTypeID.FactoryProduceLine)
  if productLineWin ~= nil then
    productLineWin:OnTimeRefresh()
  end
  if self.factoryMainUI ~= nil then
    (self.factoryMainUI):RefreshProduceLineInfo()
  end
  self:RefreshFactoryRedDot()
end

FactoryController.RefreshFactoryRedDot = function(self)
  -- function num : 0_22 , upvalues : _ENV
  local finishedOrderNum = 0
  for roomIndex,processingDataDic in pairs(self.ProcessingOrders) do
    for uid,processingData in pairs(processingDataDic) do
      if processingData:GetIsFinish() then
        finishedOrderNum = finishedOrderNum + 1
      end
    end
  end
  local nodeOk, heroNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Factory, RedDotStaticTypeId.FactoryProcessLine)
  if nodeOk then
    heroNode:SetRedDotCount(finishedOrderNum)
  end
end

FactoryController.InitOrderDatas = function(self)
  -- function num : 0_23 , upvalues : _ENV, FactoryOrderData
  for _,orderCfg in pairs(ConfigData.factory_order) do
    local isRoomUnlock = (self.unlockedRoom)[orderCfg.type]
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self.OrderDataDic)[orderCfg.id] = (FactoryOrderData.CreateOrderData)(orderCfg, isRoomUnlock)
  end
end

FactoryController.GetOrders = function(self, roomIndex)
  -- function num : 0_24 , upvalues : _ENV
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
    -- function num : 0_24_0
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
  -- function num : 0_25 , upvalues : _ENV, FactoryRoomEntity, FactoryEnum
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
    -- function num : 0_25_0 , upvalues : _ENV, index, self, FactoryRoomEntity, m_OnClickRoom, FactoryEnum, unlcokDes
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
    -- function num : 0_25_1 , upvalues : self, index, _ENV, FactoryRoomEntity, m_OnClickRoom, FactoryEnum
    local obj = prefab:Instantiate((self.roomBind).rooms)
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (obj.transform).position = ((((self.roomBind).rooms_normal)[index]).transform).position
    do
      if (CS.ClientConsts).IsAudit then
        local meshRender = obj:FindComponent(eUnityComponentID.MeshRenderer)
        meshRender.reflectionProbeUsage = (((CS.UnityEngine).Rendering).ReflectionProbeUsage).Off
        return 
      end
      local roomEntity = (FactoryRoomEntity.New)()
      roomEntity:InitRoomObject(obj, m_OnClickRoom, (FactoryEnum.eRoomType).notOpen, index)
      -- DECOMPILER ERROR at PC39: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (self.roomEntityDic)[index] = roomEntity
    end
  end
)
  end
end

FactoryController.ChangeRoomModelGo = function(self, index, type)
  -- function num : 0_26
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
  -- function num : 0_27 , upvalues : FactoryEnum, _ENV
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
  -- function num : 0_28
  return self.Order4SendData
end

FactoryController.ClearOrder = function(self)
  -- function num : 0_29
  self.Order4SendData = nil
  self.productOrderAddDic = nil
end

local MAX_TIME_COST = (ConfigData.game_config).factoryTimeCostLimit
FactoryController.TryAddOneOrder = function(self, lindIndex, orderData)
  -- function num : 0_30 , upvalues : _ENV, FactoryEnum, MAX_TIME_COST
  local orderCfg = orderData:GetOrderCfg()
  local orderId = orderCfg.id
  if self.Order4SendData ~= nil and ((self.Order4SendData).lineIndex ~= lindIndex or (self.Order4SendData).curOrderId ~= orderId) then
    error("doesn\'t clean old orderData")
    return false
  end
  if orderData:GetOrderType() == (FactoryEnum.eOrderType).dig then
    if self.Order4SendData == nil then
      local warehouseNotFull = orderData:GetIsWhareHouseNotFull(0)
      local couldAdd = MAX_TIME_COST / orderData:GetTimeCost() >= 1
      if couldAdd then
        if not warehouseNotFull then
          return false, (FactoryEnum.eCannotAddReason).warehouseFull
        end
        self.Order4SendData = {orderType = (FactoryEnum.eOrderType).dig, curOrderId = orderId, curOrderNum = 1, lineIndex = lindIndex, usedTime = orderData:GetTimeCost()}
        return true
      else
        return false, (FactoryEnum.eCannotAddReason).timeBeyountLimit
      end
    else
      local warehouseNotFull = orderData:GetIsWhareHouseNotFull((self.Order4SendData).curOrderNum)
      local couldAdd = (MAX_TIME_COST - (self.Order4SendData).usedTime) / orderData:GetTimeCost() >= 1
      if couldAdd then
        if not warehouseNotFull then
          return false, (FactoryEnum.eCannotAddReason).warehouseFull
        end
        -- DECOMPILER ERROR at PC93: Confused about usage of register: R7 in 'UnsetPending'

        ;
        (self.Order4SendData).curOrderNum = (self.Order4SendData).curOrderNum + 1
        -- DECOMPILER ERROR at PC100: Confused about usage of register: R7 in 'UnsetPending'

        ;
        (self.Order4SendData).usedTime = orderData:GetTimeCost() * (self.Order4SendData).curOrderNum
        return true
      else
        return false, (FactoryEnum.eCannotAddReason).timeBeyountLimit
      end
    end
  elseif orderData:GetOrderType() == (FactoryEnum.eOrderType).product then
    if self.Order4SendData == nil then
      self.productOrderAddDic = {}
      local usedMat = {}
      local subDic = {}
      local couldAdd, arg2 = self:CheckOrderResource(orderData, 1, usedMat, subDic, MAX_TIME_COST)
      if couldAdd then
        if not orderData:GetIsWhareHouseNotFull(0) then
          return false, (FactoryEnum.eCannotAddReason).warehouseFull
        end
        self.Order4SendData = {orderType = (FactoryEnum.eOrderType).product, curOrderId = orderId, curOrderNum = 1, lineIndex = lindIndex, assistOrderDic = subDic, usedTime = MAX_TIME_COST - arg2, usedMat = usedMat}
        if (table.count)(subDic) > 0 then
          if self.productOrderAddDic == nil then
            self.productOrderAddDic = {}
          end
          -- DECOMPILER ERROR at PC171: Confused about usage of register: R9 in 'UnsetPending'

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
      local nowLeftTime = MAX_TIME_COST - (self.Order4SendData).usedTime
      local couldAdd, arg2 = self:CheckOrderResource(orderData, 1, usedMat, subDic, nowLeftTime)
      if couldAdd then
        if not orderData:GetIsWhareHouseNotFull((self.Order4SendData).curOrderNum) then
          return false, (FactoryEnum.eCannotAddReason).warehouseFull
        end
        -- DECOMPILER ERROR at PC216: Confused about usage of register: R10 in 'UnsetPending'

        ;
        (self.Order4SendData).curOrderNum = (self.Order4SendData).curOrderNum + 1
        -- DECOMPILER ERROR at PC218: Confused about usage of register: R10 in 'UnsetPending'

        ;
        (self.Order4SendData).usedMat = usedMat
        -- DECOMPILER ERROR at PC220: Confused about usage of register: R10 in 'UnsetPending'

        ;
        (self.Order4SendData).assistOrderDic = subDic
        -- DECOMPILER ERROR at PC224: Confused about usage of register: R10 in 'UnsetPending'

        ;
        (self.Order4SendData).usedTime = MAX_TIME_COST - arg2
        if (table.count)(subDic) > 0 then
          if self.productOrderAddDic == nil then
            self.productOrderAddDic = {}
          end
          -- DECOMPILER ERROR at PC243: Confused about usage of register: R10 in 'UnsetPending'

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
  -- function num : 0_31 , upvalues : _ENV, FactoryEnum
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
      (self.Order4SendData).usedTime = orderData:GetTimeCost() * (self.Order4SendData).curOrderNum
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
          (self.Order4SendData).usedTime = orderData:GetTimeCost() * (self.Order4SendData).curOrderNum
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
  -- function num : 0_32 , upvalues : _ENV, FactoryEnum, MAX_TIME_COST
  local orderCfg = orderData:GetOrderCfg()
  local orderId = orderCfg.id
  if self.Order4SendData ~= nil and ((self.Order4SendData).lineIndex ~= lindIndex or (self.Order4SendData).curOrderId ~= orderId) then
    error("doesn\'t clean old orderData")
    return false
  end
  if orderData:GetOrderType() == (FactoryEnum.eOrderType).dig then
    local couldAddNum = MAX_TIME_COST // orderData:GetTimeCost()
    local warehouseCapacity = (PlayerDataCenter.playerBonus):GetWarehouseCapcity(orderCfg.outPutItemId)
    do
      if warehouseCapacity == 0 then
        local itemCfg = (ConfigData.item)[orderCfg.outPutItemId]
        if itemCfg == nil or itemCfg.holdlimit == nil then
          error("can\'t read itemCfg/itemCfg.holdlimit with id = " .. tostring(orderCfg.outPutItemId))
        else
          warehouseCapacity = itemCfg.holdlimit
        end
      end
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
            self.Order4SendData = {orderType = (FactoryEnum.eOrderType).dig, curOrderId = orderId, curOrderNum = couldAddNum, lineIndex = lindIndex, usedTime = orderData:GetTimeCost() * couldAddNum}
            return true
          else
            return false
          end
          do
            if orderData:GetOrderType() == (FactoryEnum.eOrderType).product then
              local couldAdd = true
              while couldAdd do
                couldAdd = self:TryAddOneOrder(lindIndex, orderData)
              end
              if self.Order4SendData == nil then
                return false
              end
              return (self.Order4SendData).curOrderNum > 0
            end
            -- DECOMPILER ERROR: 2 unprocessed JMP targets
          end
        end
      end
    end
  end
end

FactoryController.SendOrder = function(self, callback, isUseTime)
  -- function num : 0_33
  if self.Order4SendData == nil or (self.Order4SendData).curOrderNum < 1 then
    return 
  end
  if isUseTime then
    (self.networkCtrl):CS_FACTORY_ConsumeTimeProduct(self.Order4SendData, function()
    -- function num : 0_33_0 , upvalues : callback
    callback()
  end
)
  else
    ;
    (self.networkCtrl):CS_FACTORY_WorkshopProduct(self.Order4SendData, function()
    -- function num : 0_33_1 , upvalues : callback
    callback()
  end
)
  end
end

FactoryController.CancleOrder = function(self, processingData)
  -- function num : 0_34
  local roomIndex, uid = processingData:GetIndexAndUid()
  ;
  (self.networkCtrl):CS_FACTORY_CancelOrder(roomIndex, uid, function()
    -- function num : 0_34_0 , upvalues : self, roomIndex, uid
    -- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

    ((self.ProcessingOrders)[roomIndex])[uid] = nil
    self:OnUpdateProduceLine()
  end
)
end

FactoryController.QuickFinishOrder = function(self, processingData)
  -- function num : 0_35 , upvalues : _ENV
  local roomIndex, uid = processingData:GetIndexAndUid()
  ;
  (self.networkCtrl):CS_FACTORY_ImmediatelyComplete(roomIndex, uid, function()
    -- function num : 0_35_0 , upvalues : self, roomIndex, uid, _ENV
    local processingOrderData = ((self.ProcessingOrders)[roomIndex])[uid]
    local rewardIds = {(processingOrderData:GetOutputItemCfg()).id}
    local rewardNums = {processingOrderData:GetOutputItemProduceNum()}
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ProcessingOrders)[roomIndex])[uid] = nil
    self:OnUpdateProduceLine()
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      -- function num : 0_35_0_0 , upvalues : rewardIds, rewardNums
      if window == nil then
        return 
      end
      window:AddNext2ShowReward(rewardIds, rewardNums)
    end
)
  end
)
end

FactoryController.PickOrderReward = function(self, processingData)
  -- function num : 0_36 , upvalues : _ENV
  local roomIndex, uid = processingData:GetIndexAndUid()
  ;
  (self.networkCtrl):CS_FACTORY_Collect(roomIndex, uid, function()
    -- function num : 0_36_0 , upvalues : self, roomIndex, uid, _ENV
    local processingOrderData = ((self.ProcessingOrders)[roomIndex])[uid]
    local rewardIds = {(processingOrderData:GetOutputItemCfg()).id}
    local rewardNums = {processingOrderData:GetOutputItemProduceNum()}
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ProcessingOrders)[roomIndex])[uid] = nil
    self:OnUpdateProduceLine()
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      -- function num : 0_36_0_0 , upvalues : rewardIds, rewardNums
      if window == nil then
        return 
      end
      window:AddNext2ShowReward(rewardIds, rewardNums)
    end
)
  end
)
end

FactoryController.CheckOrderResource = function(self, orderData, needNum, usedMat, subDic, nowLeftTime)
  -- function num : 0_37 , upvalues : FactoryEnum, _ENV
  local orderCfg = orderData:GetOrderCfg()
  if orderData:GetTimeCost() * needNum <= nowLeftTime then
    nowLeftTime = nowLeftTime - orderData:GetTimeCost() * needNum
  else
    return false, (FactoryEnum.eCannotAddReason).timeBeyountLimit
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
          local couldSub, arg2 = self:CheckOrderResource((self.OrderDataDic)[subOrderCfg.id], needNum, usedMat, subDic, nowLeftTime)
          if not couldSub then
            return false, arg2
          else
            subDic[subOrderCfg.id] = (subDic[subOrderCfg.id] or 0) + needNum
            usedMat[itemId] = (usedMat[itemId] or 0) + nowCount - remainNum
            nowLeftTime = arg2
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
  return true, nowLeftTime
end

FactoryController.GetCurOrderAndMaxOrderNum = function(self)
  -- function num : 0_38 , upvalues : _ENV
  local curOrderNum = 0
  local maxOrderNum = 0
  local isHaveFinished = false
  for roomindex,isuNlock in pairs(self.unlockedRoom) do
    if isuNlock then
      maxOrderNum = maxOrderNum + 1
    end
  end
  for roomIndex,orderDic in pairs(self.ProcessingOrders) do
    for uid,processingData in pairs(orderDic) do
      curOrderNum = curOrderNum + 1
      if processingData:GetIsFinish() then
        isHaveFinished = true
      end
    end
  end
  return curOrderNum, maxOrderNum, isHaveFinished
end

local COS_45 = (math.cos)(45)
local CAMERA_TARGET_POS = (Vector3.New)(47.64, 42, 52.36)
FactoryController.StartMoveRoomToLeftMin = function(self, orderUI, roomIndex, isFromOtherRoom)
  -- function num : 0_39 , upvalues : CAMERA_TARGET_POS
  self.cameraTargetPos = CAMERA_TARGET_POS
end

FactoryController.OnMoveRoomToLeftMin = function(self, onMoveCallback, playrate, isFromOtherRoom)
  -- function num : 0_40 , upvalues : _ENV
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
  -- function num : 0_41
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  (((self.roomBind).camera).transform).position = self.cameraTargetPos
  if onMoveCallback ~= nil then
    onMoveCallback()
  end
end

FactoryController.MoveRoomToMid = function(self, onMoveCallback)
  -- function num : 0_42
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  (((self.roomBind).camera).transform).position = self.cameraDefaultPos
  if onMoveCallback ~= nil then
    onMoveCallback()
  end
end

FactoryController.IsCouldOpenQuickProduceUI = function(self, itemId)
  -- function num : 0_43 , upvalues : _ENV
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
  -- function num : 0_44 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.FactoryQuickProduce, function(win)
    -- function num : 0_44_0 , upvalues : targetOrderData, closeCallback
    if win == nil then
      return 
    end
    win:OpenQuickProduce(targetOrderData, closeCallback)
  end
)
end

FactoryController.OnDelete = function(self)
  -- function num : 0_45 , upvalues : _ENV, base
  if self.lineTimerId ~= nil then
    TimerManager:StopTimer(self.lineTimerId)
    self.lineTimerId = nil
  end
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.m_OnUpdateARG)
  ;
  (base.OnDelete)(self)
end

return FactoryController

