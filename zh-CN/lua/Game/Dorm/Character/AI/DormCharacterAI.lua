local DormCharacterAI = class("DormCharacterAI")
local DormAIStateConfig = require("Game.Dorm.Character.AI.DormAIStateConfig")
local DormUtil = require("Game.Dorm.DormUtil")
local DormEnum = require("Game.Dorm.DormEnum")
local Messenger = require("Framework.Common.Messenger")
DormCharacterAI.ctor = function(self, aiCfg, charEntity, autoNextState)
  -- function num : 0_0 , upvalues : Messenger, _ENV
  self.aiCfg = aiCfg
  self.charEntity = charEntity
  self.__dormAIMsg = (Messenger.New)()
  self.__OnCurStateExit = BindCallback(self, self.OnCurStateExit)
  self.__randNextOnExit = autoNextState
  self:InitAIData()
end

DormCharacterAI.InitAIData = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self.desires = {}
  for k,v in ipairs((self.aiCfg).desire_init) do
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R6 in 'UnsetPending'

    (self.desires)[k] = v
  end
  self.desireOpen = {}
  for i = 1, #self.desires do
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R5 in 'UnsetPending'

    (self.desireOpen)[i] = true
  end
  self.state = nil
end

DormCharacterAI.GetCurAIState = function(self)
  -- function num : 0_2
  return self.state
end

DormCharacterAI.RefreshDesireOpen = function(self)
  -- function num : 0_3 , upvalues : _ENV, DormAIStateConfig
  local roomData = (self.charEntity).roomData
  if roomData == nil then
    return 
  end
  self.weightSum = 0
  for index,actionId in ipairs((self.aiCfg).actions) do
    local actionCfg = (ConfigData.dorm_action)[actionId]
    local ableOpen = false
    if actionCfg ~= nil then
      if actionCfg.type == (DormAIStateConfig.eDormActionType).Fnt then
        for k,v in ipairs(roomData.interpoint) do
          if v:GetPointActive() and v:GetInterPointType() == actionCfg.interact_point_type then
            ableOpen = true
            break
          end
        end
      else
        do
          do
            if actionCfg.type == (DormAIStateConfig.eDormActionType).Visit then
              ableOpen = ((self.charEntity).roomCharCtrl):HaveOtherNoFullRoom()
            else
              ableOpen = true
            end
            -- DECOMPILER ERROR at PC55: Confused about usage of register: R9 in 'UnsetPending'

            if ableOpen then
              (self.desireOpen)[index] = true
              self.weightSum = self.weightSum + (self.desires)[index]
            else
              -- DECOMPILER ERROR at PC63: Confused about usage of register: R9 in 'UnsetPending'

              ;
              (self.desireOpen)[index] = false
            end
            -- DECOMPILER ERROR at PC64: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC64: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC64: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC64: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC64: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
end

DormCharacterAI.RandNewAction = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if (self.charEntity):IsDormUnBindTimeout() and self:UnBindCharacterStartExit() and isEditorMode then
    warn("非绑定角色换人:" .. ((self.charEntity).heroData):GetName())
  end
  do return  end
  self:RefreshDesireOpen()
  local roomData = (self.charEntity).roomData
  if roomData == nil then
    return 
  end
  local rangValue = (math.random)(self.weightSum)
  local weightCount = 0
  for index,v in pairs(self.desireOpen) do
    if v then
      weightCount = weightCount + (self.desires)[index]
      if rangValue <= weightCount then
        self:SetCurState(index)
        break
      end
    end
  end
end

DormCharacterAI.SetCurState = function(self, index)
  -- function num : 0_5 , upvalues : _ENV, DormAIStateConfig
  local actionId = ((self.aiCfg).actions)[index]
  local actionCfg = (ConfigData.dorm_action)[actionId]
  if actionCfg == nil then
    return 
  end
  local state = (((DormAIStateConfig.GetState)(actionCfg.type)).New)(self, actionCfg, self.__OnCurStateExit)
  self.state = state
  self.stateType = actionCfg.type
  local duration = self:CalAIStateDuration(index)
  ;
  (self.state):SetStateDuration(duration)
  ;
  (self.state):StartState()
  if isEditorMode then
    warn(((self.charEntity).heroData):GetName() .. (self.state):GetStateName())
  end
  self:ReassignDesires(index)
end

DormCharacterAI.CalAIStateDuration = function(self, index)
  -- function num : 0_6 , upvalues : _ENV
  local mintime = ((self.aiCfg).min_time)[index]
  local maxTime = ((self.aiCfg).max_time)[index]
  local time = mintime + (math.random)(maxTime - mintime + 1) - 1
  do
    if #self.desires > 1 then
      local otherUpRateSum = 0
      for curindex,v in pairs((self.aiCfg).desire_up_rate) do
        if curindex ~= index then
          otherUpRateSum = otherUpRateSum + v
        end
      end
      time = time + ((self.aiCfg).time_weight)[index] * ((self.desires)[index] // (otherUpRateSum))
    end
    return time
  end
end

DormCharacterAI.ReassignDesires = function(self, index)
  -- function num : 0_7 , upvalues : _ENV
  if #self.desires <= 1 then
    return 
  end
  local otherUpRateSum = 0
  for curindex,v in ipairs(self.desireOpen) do
    if v then
      otherUpRateSum = otherUpRateSum + ((self.aiCfg).desire_up_rate)[curindex]
    end
  end
  local currentDesireNewValue = (self.desires)[index] % (otherUpRateSum)
  local currentDesireConsumption = (self.desires)[index] - currentDesireNewValue
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.desires)[index] = currentDesireNewValue
  if currentDesireConsumption <= 0 then
    return 
  end
  while currentDesireConsumption > 0 do
    for curindex,v in ipairs(self.desireOpen) do
      -- DECOMPILER ERROR at PC44: Confused about usage of register: R10 in 'UnsetPending'

      if v then
        (self.desires)[curindex] = (self.desires)[curindex] + ((self.aiCfg).desire_up_rate)[curindex]
        currentDesireConsumption = currentDesireConsumption - ((self.aiCfg).desire_up_rate)[curindex]
      end
    end
  end
end

DormCharacterAI.AIInterruptCurrState = function(self, gotoNext)
  -- function num : 0_8
  if self.state ~= nil then
    (self.state):InterruptState(gotoNext)
  end
  self.state = nil
end

DormCharacterAI.AIStartExitWait = function(self, action, ...)
  -- function num : 0_9
  if self.state == nil then
    if action ~= nil then
      action(false)
    end
    return 
  end
  ;
  (self.state):StartExitWait(action, ...)
end

DormCharacterAI.EnableExitCurrentState = function(self)
  -- function num : 0_10
  if self.state == nil then
    return true
  end
  return (self.state):EnableExitState()
end

DormCharacterAI.StartFntInterPointState = function(self, interPoint, setPos)
  -- function num : 0_11 , upvalues : _ENV, DormAIStateConfig
  for index,actionId in ipairs((self.aiCfg).actions) do
    local actionCfg = (ConfigData.dorm_action)[actionId]
    if actionCfg ~= nil and actionCfg.type == (DormAIStateConfig.eDormActionType).Fnt and actionCfg.interact_point_type == interPoint:GetInterPointType() then
      local state = (((DormAIStateConfig.GetState)(actionCfg.type)).New)(self, actionCfg, self.__OnCurStateExit)
      self.state = state
      self.stateType = actionCfg.type
      local duration = self:CalAIStateDuration(index)
      ;
      (self.state):SetStateDuration(duration)
      ;
      (self.state):StateStateByInterPoint(interPoint, setPos)
      self:ReassignDesires(index)
      return 
    end
  end
  if isEditorMode then
    warn("角色[" .. tostring(((self.charEntity).heroData).dataId) .. "]没有找到家具交互点类型:" .. tostring(interPoint:GetInterPointType()))
  end
end

DormCharacterAI.StartVisitOtherRoom = function(self, action)
  -- function num : 0_12 , upvalues : DormAIStateConfig
  local state = (((DormAIStateConfig.GetDormVisitState)()).New)(self, nil, self.__OnCurStateExit)
  self.state = state
  self.stateType = 0
  state:DirectExitRoom(action)
end

DormCharacterAI.UnBindCharacterStartExit = function(self)
  -- function num : 0_13 , upvalues : DormAIStateConfig
  local state = (((DormAIStateConfig.GetDormUnbindExitState)()).New)(self, nil, self.__OnCurStateExit)
  self.state = state
  self.stateType = 0
  return state:StartState()
end

DormCharacterAI.RandToRoomOnePoint = function(self)
  -- function num : 0_14 , upvalues : DormAIStateConfig
  local state = (((DormAIStateConfig.GetDormIdleState)()).New)(self, nil, self.__OnCurStateExit)
  self.state = state
  self.stateType = 0
  return state:StartRandToRoomOnePoint()
end

DormCharacterAI.OnUpdate = function(self)
  -- function num : 0_15
  if self.state ~= nil then
    (self.state):OnUpdate()
  end
end

DormCharacterAI.OnCurStateExit = function(self, state, enterNext)
  -- function num : 0_16 , upvalues : DormEnum
  local stateType = self.stateType
  self.state = nil
  self.stateType = 0
  self:BroadcastForDormAI((DormEnum.CharacterAIEventId).ExitState, stateType)
  if self.__randNextOnExit and enterNext then
    self:RandNewAction()
  end
end

DormCharacterAI.BroadcastForDormAI = function(self, eventId, ...)
  -- function num : 0_17
  (self.__dormAIMsg):Broadcast(eventId, ...)
end

DormCharacterAI.AddListenerForDormAI = function(self, eventId, func)
  -- function num : 0_18
  (self.__dormAIMsg):AddListener(eventId, func)
end

DormCharacterAI.RemoveListenerForDormAI = function(self, eventId, func)
  -- function num : 0_19
  (self.__dormAIMsg):RemoveListener(eventId, func)
end

return DormCharacterAI

