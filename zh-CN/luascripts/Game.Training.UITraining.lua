-- params : ...
-- function num : 0 , upvalues : _ENV
local UITraining = class("UITraining", UIBaseWindow)
local base = UIBaseWindow
local SlotData = require("Game.Training.Data.TrainingSlotData")
local SlotItem = require("Game.Training.UINode.UITrainingSlot")
local HeroEnterSlot = require("Game.HeroEnter.UINHeroEnterSlotItem")
local UIHeroEnterSelect = require("Game.HeroEnter.UIHeroEnterSelect")
local HeroEnterDataUtil = require("Game.HeroEnter.HeroEnterDataUtil")
local UINHeroEnterBuildingBuffInfo = require("Game.HeroEnter.UINHeroEnterBuildingBuffInfo")
local TrainEnum = require("Game.Training.TrainEnum")
local cs_MessageCommon = CS.MessageCommon
local cs_ResLoader = CS.ResLoader
UITraining.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, cs_ResLoader
  self.__trainingCfg = ConfigData.training
  local topStatus = UIManager:ShowWindow(UIWindowTypeID.TopStatus)
  topStatus:AddReturnEvent(BindCallback(self, self.__OnClickClose))
  self.networkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Training)
  self.__resloader = (cs_ResLoader.Create)()
  ;
  ((self.ui).slot_Item):SetActive(false)
  self:InitSlots()
  self:Update()
  self.__timer = (TimerManager:GetTimer(1, function()
    -- function num : 0_0_0 , upvalues : self
    self:Update()
  end
)):Start()
  self:UpdateTrainingUI()
  self.__onUpdateItem = BindCallback(self, self.OnUpdateItem)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__onUpdateItem)
  local funcUnLockCrtl = ControllerManager:GetController(ControllerTypeId.FunctionUnlock, true)
  local isStaffInfoUnlock = not funcUnLockCrtl:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter) or (((PlayerDataCenter.AllBuildingData).oasisBuilt)[eBuildingId.OasisTrainingBuilding] ~= nil and (((PlayerDataCenter.AllBuildingData).oasisBuilt)[eBuildingId.OasisTrainingBuilding]).state ~= proto_object_BuildingState.BuildingStateCreate)
  self:OnStaffInfoUnlock(isStaffInfoUnlock)
  self.__UpdateStaffInfo = BindCallback(self, self.UpdateStaffInfo)
  MsgCenter:AddListener(eMsgEventId.OnHeroEnterDataUpdate, self.__UpdateStaffInfo)
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UITraining.InitSlots = function(self)
  -- function num : 0_1 , upvalues : _ENV, SlotItem
  self.slotDatas = PlayerDataCenter.trainingSlotDatas
  self.slotItems = {}
  for k,v in ipairs(self.slotDatas) do
    local slotData = v
    local go = ((self.ui).slot_Item):Instantiate()
    go:SetActive(true)
    local slotItem = (SlotItem.New)()
    slotItem:Init(go)
    slotItem:InitTrainingSlot(slotData, self.__resloader)
    slotItem.OnSlotHeroEvent = BindCallback(self, self.__SelectSlotHero)
    slotItem.OnSettleEvent = BindCallback(self, self.__StartSettle)
    -- DECOMPILER ERROR at PC37: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (self.slotItems)[k] = slotItem
  end
end

UITraining.OnUpdateItem = function(self, itemUpdate)
  -- function num : 0_2 , upvalues : _ENV
  if itemUpdate[(ConfigData.game_config).globalExpItemId] ~= nil then
    self:UpdateGlobalExpUI()
  end
end

UITraining.Update = function(self)
  -- function num : 0_3 , upvalues : _ENV
  self.__timestamp = PlayerDataCenter.timestamp
  for k,v in ipairs(self.slotItems) do
    v:Update(self.__timestamp)
  end
end

UITraining.UpdateTrainingUI = function(self)
  -- function num : 0_4 , upvalues : _ENV
  for k,v in ipairs(self.slotItems) do
    v:UpdateSlot()
  end
  self:UpdateGlobalExpUI()
end

UITraining.UpdateGlobalExpUI = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local globalExp = PlayerDataCenter:GetItemCount((ConfigData.game_config).globalExpItemId)
  local globalExpCeiling = (PlayerDataCenter.playerBonus):GetGlobalExpCeiling()
  if globalExpCeiling ~= 0 or not 0 then
    local progress = globalExp / globalExpCeiling
  end
  ;
  ((self.ui).tex_EXP):SetIndex(0, tostring(globalExp), tostring(globalExpCeiling))
  ;
  ((self.ui).tex_EpxProcess):SetIndex(0, tostring((math.floor)(progress * 100)))
  -- DECOMPILER ERROR at PC40: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).img_Process).fillAmount = progress
end

UITraining.__SelectSlotHero = function(self, slotIndex)
  -- function num : 0_6 , upvalues : _ENV, TrainEnum
  self.__selectSlotIndex = slotIndex
  local window = UIManager:ShowWindow(UIWindowTypeID.TrainingHeroList)
  window:InitHeroList(self.__resloader, (self.__trainingCfg)[(TrainEnum.eTrainingDataType).Efficiency])
  window.OnTrainingHeroEvent = BindCallback(self, self.__SendSlotHero)
end

UITraining.__SendSlotHero = function(self, heroId, trainingTimeCfgId, costExp)
  -- function num : 0_7 , upvalues : _ENV, cs_MessageCommon
  local heroCard = (PlayerDataCenter.heroDic)[heroId]
  if heroCard == nil then
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Train_HeroNotExist))
    return 
  end
  for k,v in ipairs(self.slotDatas) do
    if k ~= self.__selectSlotIndex and v.heroId == heroId then
      (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Train_HeroIsTraining))
      return 
    end
  end
  if heroCard:IsFullLevel() then
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Train_HeroLevelFull))
    return 
  end
  local levelCeiling = self:__GetTrainingLevelCeiling()
  if levelCeiling <= heroCard.level then
    (cs_MessageCommon.ShowMessageTips)((string.format)(ConfigData:GetTipContent(TipContent.Train_HeroReachTheMaxTrainLevel), tostring(heroCard.level), tostring(levelCeiling)))
    return 
  end
  if PlayerDataCenter:GetItemCount((ConfigData.game_config).globalExpItemId) < costExp then
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Train_GlobleEXPNotEnough))
    return 
  end
  ;
  (self.networkCtrl):SendSlotHero(heroId, self.__selectSlotIndex, ((ConfigData.game_config).trainingTimeCfg)[trainingTimeCfgId])
end

UITraining.OnSlotHeroComplete = function(self, slotIndex)
  -- function num : 0_8 , upvalues : _ENV
  self.__selectSlotIndex = nil
  UIManager:DeleteWindow(UIWindowTypeID.TrainingHeroList)
  local item = (self.slotItems)[slotIndex]
  item:UpdateSlot()
end

UITraining.__StartSettle = function(self, slotIndex, complete)
  -- function num : 0_9 , upvalues : _ENV, TrainEnum
  local window = UIManager:ShowWindow(UIWindowTypeID.TrainingState)
  local slotData = (self.slotDatas)[slotIndex]
  local heroCard = (PlayerDataCenter.heroDic)[slotData.heroId]
  if heroCard ~= nil then
    local efficiencyCfg = (self.__trainingCfg)[(TrainEnum.eTrainingDataType).Efficiency]
    window:InitState(slotData, heroCard, self.__timestamp, efficiencyCfg)
    window.OnSettleEvent = BindCallback(self, self.__SendSlotSettle)
  else
    do
      error("找不到角色，id=" .. tostring(slotData.heroId))
    end
  end
end

UITraining.__SendSlotSettle = function(self, slotIndex, complete)
  -- function num : 0_10 , upvalues : TrainEnum, _ENV
  if ((self.__trainingCfg)[(TrainEnum.eTrainingDataType).Slot])[slotIndex] == nil then
    error("没有该槽位，index=" .. tostring(slotIndex))
    return 
  end
  ;
  (self.networkCtrl):SendTrainingSettle(slotIndex)
end

UITraining.OnSlotSettleComplete = function(self, slotIndex)
  -- function num : 0_11
  local item = (self.slotItems)[slotIndex]
  item:UpdateSlot()
end

UITraining.__GetTrainingLevelCeiling = function(self)
  -- function num : 0_12 , upvalues : TrainEnum, _ENV
  local levelCeilingCfg = (self.__trainingCfg)[(TrainEnum.eTrainingDataType).LevelCeiling]
  for i = #levelCeilingCfg, 1, -1 do
    local cfg = levelCeilingCfg[i]
    if (CheckCondition.CheckLua)(cfg.pre_condition, cfg.pre_para1, cfg.pre_para2) then
      return cfg.training_para
    end
  end
  error("没有符合的训练等级上限")
end

UITraining.__OnClickClose = function(self)
  -- function num : 0_13 , upvalues : _ENV
  UIManager:DeleteWindow(UIWindowTypeID.Training)
end

UITraining.OnStaffInfoUnlock = function(self, active)
  -- function num : 0_14 , upvalues : _ENV, HeroEnterSlot, UINHeroEnterBuildingBuffInfo, UIHeroEnterSelect
  ((self.ui).staffInfo):SetActive(active)
  self.HeroEnterSlotPool = (UIItemPool.New)(HeroEnterSlot, (self.ui).HeroEnterSlot)
  ;
  ((self.ui).HeroEnterSlot):SetActive(false)
  self.buildingBuffPool = (UIItemPool.New)(UINHeroEnterBuildingBuffInfo, (self.ui).Item_buffItem)
  ;
  ((self.ui).Item_buffItem):SetActive(false)
  self.buildingBuffList = {}
  if active then
    (UIHeroEnterSelect.CreateBuffItems)(self, eBuildingId.OasisTrainingBuilding)
    self:UpdateStaffInfo()
  end
end

UITraining.UpdateStaffInfo = function(self)
  -- function num : 0_15 , upvalues : _ENV, HeroEnterDataUtil
  (self.HeroEnterSlotPool):HideAll()
  local slotList = {}
  local buildingData = ((PlayerDataCenter.AllBuildingData).built)[eBuildingId.OasisTrainingBuilding]
  if buildingData == nil then
    error("无建筑数据" .. eBuildingId.OasisFactory)
    return 
  end
  local allEnterData = PlayerDataCenter.allEnterData
  local level = buildingData.level
  local UnlockedSlotNum = ((buildingData.levelConfig)[level]).hero_job_slot
  local heroScoreRate = 0
  for i = 1, UnlockedSlotNum do
    do
      do
        local enterSlot = (self.HeroEnterSlotPool):GetOne(true)
        enterSlot:SetSlotClickEvent(function(isUnlock, heroId)
    -- function num : 0_15_0 , upvalues : _ENV, slotList, i
    if isUnlock then
      UIManager:ShowWindowAsync(UIWindowTypeID.HeroEnter, function(window)
      -- function num : 0_15_0_0 , upvalues : _ENV, slotList, i
      window:InitHeroEnterSelect(nil, eBuildingId.OasisTrainingBuilding, slotList, i)
    end
)
    end
  end
)
        if allEnterData[eBuildingId.OasisTrainingBuilding] ~= nil then
          local heros = (table.keys)((allEnterData[eBuildingId.OasisTrainingBuilding]).data)
          heroScoreRate = heroScoreRate + HeroEnterDataUtil:CalRateById(heros[i])
          enterSlot:InitHeroEnterSlot(self.__resloader, true, heros[i])
          ;
          (table.insert)(slotList, {isUnlock = true, heroID = heros[i]})
        else
          do
            enterSlot:InitHeroEnterSlot(self.__resloader, true)
            ;
            (table.insert)(slotList, {isUnlock = true})
          end
        end
        -- DECOMPILER ERROR at PC79: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  for _,Item in ipairs(self.buildingBuffList) do
    Item:SetValue(heroScoreRate)
  end
end

UITraining.OnDelete = function(self)
  -- function num : 0_16 , upvalues : _ENV, base
  UIManager:HideWindow(UIWindowTypeID.TopStatus)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__onUpdateItem)
  MsgCenter:RemoveListener(eMsgEventId.OnHeroEnterDataUpdate, self.__UpdateStaffInfo)
  ;
  (self.networkCtrl):UpdateRedDotCompleteSlot()
  ;
  (self.__timer):Stop()
  self.__timer = nil
  ;
  (base.OnDelete)(self)
end

return UITraining

-- params : ...
-- function num : 0 , upvalues : _ENV
local UITraining = class("UITraining", UIBaseWindow)
local base = UIBaseWindow
local SlotData = require("Game.Training.Data.TrainingSlotData")
local SlotItem = require("Game.Training.UINode.UITrainingSlot")
local HeroEnterSlot = require("Game.HeroEnter.UINHeroEnterSlotItem")
local UIHeroEnterSelect = require("Game.HeroEnter.UIHeroEnterSelect")
local HeroEnterDataUtil = require("Game.HeroEnter.HeroEnterDataUtil")
local UINHeroEnterBuildingBuffInfo = require(
                                         "Game.HeroEnter.UINHeroEnterBuildingBuffInfo")
local TrainEnum = require("Game.Training.TrainEnum")
local cs_MessageCommon = CS.MessageCommon
local cs_ResLoader = CS.ResLoader
UITraining.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, cs_ResLoader
    self.__trainingCfg = ConfigData.training
    local topStatus = UIManager:ShowWindow(UIWindowTypeID.TopStatus)
    topStatus:AddReturnEvent(BindCallback(self, self.__OnClickClose))
    self.networkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Training)
    self.__resloader = (cs_ResLoader.Create)();
    ((self.ui).slot_Item):SetActive(false)
    self:InitSlots()
    self:Update()
    self.__timer = (TimerManager:GetTimer(1, function()
        -- function num : 0_0_0 , upvalues : self
        self:Update()
    end)):Start()
    self:UpdateTrainingUI()
    self.__onUpdateItem = BindCallback(self, self.OnUpdateItem)
    MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__onUpdateItem)
    local funcUnLockCrtl = ControllerManager:GetController(
                               ControllerTypeId.FunctionUnlock, true)
    local isStaffInfoUnlock = not funcUnLockCrtl:ValidateUnlock(
                                  proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter) or
                                  (((PlayerDataCenter.AllBuildingData).oasisBuilt)[eBuildingId.OasisTrainingBuilding] ~=
                                      nil and
                                      (((PlayerDataCenter.AllBuildingData).oasisBuilt)[eBuildingId.OasisTrainingBuilding]).state ~=
                                      proto_object_BuildingState.BuildingStateCreate)
    self:OnStaffInfoUnlock(isStaffInfoUnlock)
    self.__UpdateStaffInfo = BindCallback(self, self.UpdateStaffInfo)
    MsgCenter:AddListener(eMsgEventId.OnHeroEnterDataUpdate,
                          self.__UpdateStaffInfo)
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UITraining.InitSlots = function(self)
    -- function num : 0_1 , upvalues : _ENV, SlotItem
    self.slotDatas = PlayerDataCenter.trainingSlotDatas
    self.slotItems = {}
    for k, v in ipairs(self.slotDatas) do
        local slotData = v
        local go = ((self.ui).slot_Item):Instantiate()
        go:SetActive(true)
        local slotItem = (SlotItem.New)()
        slotItem:Init(go)
        slotItem:InitTrainingSlot(slotData, self.__resloader)
        slotItem.OnSlotHeroEvent = BindCallback(self, self.__SelectSlotHero)
        slotItem.OnSettleEvent = BindCallback(self, self.__StartSettle) -- DECOMPILER ERROR at PC37: Confused about usage of register: R9 in 'UnsetPending'
        ;
        (self.slotItems)[k] = slotItem
    end
end

UITraining.OnUpdateItem = function(self, itemUpdate)
    -- function num : 0_2 , upvalues : _ENV
    if itemUpdate[(ConfigData.game_config).globalExpItemId] ~= nil then
        self:UpdateGlobalExpUI()
    end
end

UITraining.Update = function(self)
    -- function num : 0_3 , upvalues : _ENV
    self.__timestamp = PlayerDataCenter.timestamp
    for k, v in ipairs(self.slotItems) do v:Update(self.__timestamp) end
end

UITraining.UpdateTrainingUI = function(self)
    -- function num : 0_4 , upvalues : _ENV
    for k, v in ipairs(self.slotItems) do v:UpdateSlot() end
    self:UpdateGlobalExpUI()
end

UITraining.UpdateGlobalExpUI = function(self)
    -- function num : 0_5 , upvalues : _ENV
    local globalExp = PlayerDataCenter:GetItemCount(
                          (ConfigData.game_config).globalExpItemId)
    local globalExpCeiling =
        (PlayerDataCenter.playerBonus):GetGlobalExpCeiling()
    if globalExpCeiling ~= 0 or not 0 then
        local progress = globalExp / globalExpCeiling
    end
    ((self.ui).tex_EXP):SetIndex(0, tostring(globalExp),
                                 tostring(globalExpCeiling));
    ((self.ui).tex_EpxProcess):SetIndex(0,
                                        tostring((math.floor)(progress * 100))) -- DECOMPILER ERROR at PC40: Confused about usage of register: R4 in 'UnsetPending'
    ;
    ((self.ui).img_Process).fillAmount = progress
end

UITraining.__SelectSlotHero = function(self, slotIndex)
    -- function num : 0_6 , upvalues : _ENV, TrainEnum
    self.__selectSlotIndex = slotIndex
    local window = UIManager:ShowWindow(UIWindowTypeID.TrainingHeroList)
    window:InitHeroList(self.__resloader,
                        (self.__trainingCfg)[(TrainEnum.eTrainingDataType).Efficiency])
    window.OnTrainingHeroEvent = BindCallback(self, self.__SendSlotHero)
end

UITraining.__SendSlotHero = function(self, heroId, trainingTimeCfgId, costExp)
    -- function num : 0_7 , upvalues : _ENV, cs_MessageCommon
    local heroCard = (PlayerDataCenter.heroDic)[heroId]
    if heroCard == nil then
        (cs_MessageCommon.ShowMessageTips)(
            ConfigData:GetTipContent(TipContent.Train_HeroNotExist))
        return
    end
    for k, v in ipairs(self.slotDatas) do
        if k ~= self.__selectSlotIndex and v.heroId == heroId then
            (cs_MessageCommon.ShowMessageTips)(
                ConfigData:GetTipContent(TipContent.Train_HeroIsTraining))
            return
        end
    end
    if heroCard:IsFullLevel() then
        (cs_MessageCommon.ShowMessageTips)(
            ConfigData:GetTipContent(TipContent.Train_HeroLevelFull))
        return
    end
    local levelCeiling = self:__GetTrainingLevelCeiling()
    if levelCeiling <= heroCard.level then
        (cs_MessageCommon.ShowMessageTips)(
            (string.format)(ConfigData:GetTipContent(
                                TipContent.Train_HeroReachTheMaxTrainLevel),
                            tostring(heroCard.level), tostring(levelCeiling)))
        return
    end
    if PlayerDataCenter:GetItemCount((ConfigData.game_config).globalExpItemId) <
        costExp then
        (cs_MessageCommon.ShowMessageTips)(
            ConfigData:GetTipContent(TipContent.Train_GlobleEXPNotEnough))
        return
    end
    (self.networkCtrl):SendSlotHero(heroId, self.__selectSlotIndex,
                                    ((ConfigData.game_config).trainingTimeCfg)[trainingTimeCfgId])
end

UITraining.OnSlotHeroComplete = function(self, slotIndex)
    -- function num : 0_8 , upvalues : _ENV
    self.__selectSlotIndex = nil
    UIManager:DeleteWindow(UIWindowTypeID.TrainingHeroList)
    local item = (self.slotItems)[slotIndex]
    item:UpdateSlot()
end

UITraining.__StartSettle = function(self, slotIndex, complete)
    -- function num : 0_9 , upvalues : _ENV, TrainEnum
    local window = UIManager:ShowWindow(UIWindowTypeID.TrainingState)
    local slotData = (self.slotDatas)[slotIndex]
    local heroCard = (PlayerDataCenter.heroDic)[slotData.heroId]
    if heroCard ~= nil then
        local efficiencyCfg =
            (self.__trainingCfg)[(TrainEnum.eTrainingDataType).Efficiency]
        window:InitState(slotData, heroCard, self.__timestamp, efficiencyCfg)
        window.OnSettleEvent = BindCallback(self, self.__SendSlotSettle)
    else
        do error("找不到角色，id=" .. tostring(slotData.heroId)) end
    end
end

UITraining.__SendSlotSettle = function(self, slotIndex, complete)
    -- function num : 0_10 , upvalues : TrainEnum, _ENV
    if ((self.__trainingCfg)[(TrainEnum.eTrainingDataType).Slot])[slotIndex] ==
        nil then
        error("没有该槽位，index=" .. tostring(slotIndex))
        return
    end
    (self.networkCtrl):SendTrainingSettle(slotIndex)
end

UITraining.OnSlotSettleComplete = function(self, slotIndex)
    -- function num : 0_11
    local item = (self.slotItems)[slotIndex]
    item:UpdateSlot()
end

UITraining.__GetTrainingLevelCeiling = function(self)
    -- function num : 0_12 , upvalues : TrainEnum, _ENV
    local levelCeilingCfg =
        (self.__trainingCfg)[(TrainEnum.eTrainingDataType).LevelCeiling]
    for i = #levelCeilingCfg, 1, -1 do
        local cfg = levelCeilingCfg[i]
        if (CheckCondition.CheckLua)(cfg.pre_condition, cfg.pre_para1,
                                     cfg.pre_para2) then
            return cfg.training_para
        end
    end
    error("没有符合的训练等级上限")
end

UITraining.__OnClickClose = function(self)
    -- function num : 0_13 , upvalues : _ENV
    UIManager:DeleteWindow(UIWindowTypeID.Training)
end

UITraining.OnStaffInfoUnlock = function(self, active)
    -- function num : 0_14 , upvalues : _ENV, HeroEnterSlot, UINHeroEnterBuildingBuffInfo, UIHeroEnterSelect
    ((self.ui).staffInfo):SetActive(active)
    self.HeroEnterSlotPool = (UIItemPool.New)(HeroEnterSlot,
                                              (self.ui).HeroEnterSlot);
    ((self.ui).HeroEnterSlot):SetActive(false)
    self.buildingBuffPool = (UIItemPool.New)(UINHeroEnterBuildingBuffInfo,
                                             (self.ui).Item_buffItem);
    ((self.ui).Item_buffItem):SetActive(false)
    self.buildingBuffList = {}
    if active then
        (UIHeroEnterSelect.CreateBuffItems)(self,
                                            eBuildingId.OasisTrainingBuilding)
        self:UpdateStaffInfo()
    end
end

UITraining.UpdateStaffInfo = function(self)
    -- function num : 0_15 , upvalues : _ENV, HeroEnterDataUtil
    (self.HeroEnterSlotPool):HideAll()
    local slotList = {}
    local buildingData =
        ((PlayerDataCenter.AllBuildingData).built)[eBuildingId.OasisTrainingBuilding]
    if buildingData == nil then
        error("无建筑数据" .. eBuildingId.OasisFactory)
        return
    end
    local allEnterData = PlayerDataCenter.allEnterData
    local level = buildingData.level
    local UnlockedSlotNum = ((buildingData.levelConfig)[level]).hero_job_slot
    local heroScoreRate = 0
    for i = 1, UnlockedSlotNum do
        do
            do
                local enterSlot = (self.HeroEnterSlotPool):GetOne(true)
                enterSlot:SetSlotClickEvent(
                    function(isUnlock, heroId)
                        -- function num : 0_15_0 , upvalues : _ENV, slotList, i
                        if isUnlock then
                            UIManager:ShowWindowAsync(UIWindowTypeID.HeroEnter,
                                                      function(window)
                                -- function num : 0_15_0_0 , upvalues : _ENV, slotList, i
                                window:InitHeroEnterSelect(nil,
                                                           eBuildingId.OasisTrainingBuilding,
                                                           slotList, i)
                            end)
                        end
                    end)
                if allEnterData[eBuildingId.OasisTrainingBuilding] ~= nil then
                    local heros = (table.keys)(
                                      (allEnterData[eBuildingId.OasisTrainingBuilding]).data)
                    heroScoreRate = heroScoreRate +
                                        HeroEnterDataUtil:CalRateById(heros[i])
                    enterSlot:InitHeroEnterSlot(self.__resloader, true, heros[i]);
                    (table.insert)(slotList,
                                   {isUnlock = true, heroID = heros[i]})
                else
                    do
                        enterSlot:InitHeroEnterSlot(self.__resloader, true);
                        (table.insert)(slotList, {isUnlock = true})
                    end
                end
                -- DECOMPILER ERROR at PC79: LeaveBlock: unexpected jumping out DO_STMT

            end
        end
    end
    for _, Item in ipairs(self.buildingBuffList) do
        Item:SetValue(heroScoreRate)
    end
end

UITraining.OnDelete = function(self)
    -- function num : 0_16 , upvalues : _ENV, base
    UIManager:HideWindow(UIWindowTypeID.TopStatus)
    MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__onUpdateItem)
    MsgCenter:RemoveListener(eMsgEventId.OnHeroEnterDataUpdate,
                             self.__UpdateStaffInfo);
    (self.networkCtrl):UpdateRedDotCompleteSlot();
    (self.__timer):Stop()
    self.__timer = nil;
    (base.OnDelete)(self)
end

return UITraining

