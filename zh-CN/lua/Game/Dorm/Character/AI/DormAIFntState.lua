local DormAIStateBase = require("Game.Dorm.Character.AI.DormAIStateBase")
local DormAIFntState = class("DormAIFntState", DormAIStateBase)
local DormUtil = require("Game.Dorm.DormUtil")
local DormEnum = require("Game.Dorm.DormEnum")
local FntStageType = {Initial = 0, MoveToInteract = 1, PlayStartAnimation = 2, LoopRunning = 3, PlayEndAnimation = 4, MoveToEmptyArea = 5, AllEnd = 6}
local LogicInterval = 1
local failRetryCount = 3
DormAIFntState.ctor = function(self, aiCtrl, actionCfg, exitAction)
  -- function num : 0_0 , upvalues : FntStageType
  self.time = 0
  self.__fntStateType = FntStageType.Initial
  self.__autoExit = false
  self.__noExitWalk = false
end

DormAIFntState.GetStateName = function(self)
  -- function num : 0_1
  return "fnt"
end

DormAIFntState.StartState = function(self)
  -- function num : 0_2 , upvalues : DormAIStateBase, _ENV, LogicInterval, failRetryCount
  self.exeState = (DormAIStateBase.AIExecuteState).Runnig
  local point = self:RandOneInterPoint()
  if point == nil then
    self.exeState = (DormAIStateBase.AIExecuteState).Fail
    return 
  end
  self.interPoint = point.interPoint
  if not (self.interPoint):GetPointActive() then
    self:OnExit()
    return 
  end
  self.fntData = (self.interPoint).fntData
  self.fntEntity = ((self.charEntity):GetBelongRoomEntity()):GetFntByData(self.fntData)
  self.__interStartPos = point.pos
  self.__interDestPos = ((self.fntEntity).transform):TransformPoint((self.interPoint):GetInterOffsetCoord())
  do
    if not (self.charEntity):TargetPosPossible(self.__interStartPos) then
      local count = 0
      do
        self.__retryTimerId = TimerManager:StartTimer(LogicInterval, function()
    -- function num : 0_2_0 , upvalues : count, self, _ENV, failRetryCount
    count = count + 1
    if (self.charEntity):TargetPosPossible(self.__interStartPos) then
      TimerManager:StopTimer(self.__retryTimerId)
      self:MoveToInterStartPoint()
      return 
    end
    if failRetryCount <= count then
      self:OnExit()
    end
  end
, nil, false, false, true)
        return 
      end
    end
    self:MoveToInterStartPoint()
  end
end

DormAIFntState.StateStateByInterPoint = function(self, interPoint, setPos)
  -- function num : 0_3 , upvalues : DormAIStateBase, _ENV, DormUtil
  self.exeState = (DormAIStateBase.AIExecuteState).Runnig
  self.interPoint = interPoint
  if not (self.interPoint):GetPointActive() then
    self:OnExit()
    return 
  end
  local fntEntity = ((self.charEntity):GetBelongRoomEntity()):GetFntByData(interPoint.fntData)
  local offsetWorld = (fntEntity.transform):TransformPoint(interPoint:GetInterStartCoord())
  self.fntData = (self.interPoint).fntData
  self.fntEntity = fntEntity
  self.__interStartPos = offsetWorld
  self.__interDestPos = (fntEntity.transform):TransformPoint(interPoint:GetInterOffsetCoord())
  if setPos then
    (self.charEntity):SetUnityWorldPos(offsetWorld)
    local rot = (Quaternion.Euler)(0, (self.interPoint):GetInterAngle() + (self.fntData).r, 0)
    -- DECOMPILER ERROR at PC53: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.charEntity).transform).rotation = rot
  else
    do
      ;
      (self.charEntity):SetNavmeshCutActive(false)
      self.__interStartPos = ((self.charEntity).transform).position
      if not (DormUtil.IsPositionOnNavmesh)(self.__interStartPos) then
        self.__fixPosTimer = TimerManager:StartTimer(1, function()
    -- function num : 0_3_0 , upvalues : DormUtil, self, _ENV
    local newPos = (DormUtil.FindNearestActivePoint)(self.__interStartPos)
    if (Vector3.Distance)(self.__interStartPos, newPos) <= 0.3 then
      self.__interStartPos = newPos
    end
  end
, nil, true, true)
      end
      self:StartInteractFnt()
    end
  end
end

DormAIFntState.RandOneInterPoint = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local roomData = (self.charEntity).roomData
  local pointRandList = {}
  for _,interPoint in pairs(roomData.interpoint) do
    if interPoint:GetPointActive() and interPoint:GetInterPointType() == (self.actionCfg).interact_point_type then
      local fntEntity = ((self.charEntity):GetBelongRoomEntity()):GetFntByData(interPoint.fntData)
      local offsetWorld = (fntEntity.transform):TransformPoint(interPoint:GetInterStartCoord())
      if (self.charEntity):TargetPosPossible(offsetWorld) then
        local point = {pos = offsetWorld, interPoint = interPoint}
        ;
        (table.insert)(pointRandList, point)
      end
    end
  end
  if #pointRandList == 0 then
    return nil
  end
  local interPoint = pointRandList[(math.random)(#pointRandList)]
  return interPoint
end

DormAIFntState.MoveToInterStartPoint = function(self)
  -- function num : 0_5 , upvalues : _ENV, FntStageType, DormAIStateBase
  if not (self.interPoint):GetPointActive() then
    self:OnExit()
    return 
  end
  local success = (self.charEntity):DoMoveAStar(self.__interStartPos, BindCallback(self, self.StartInteractFnt), 0, true)
  if success then
    self.__fntStateType = FntStageType.MoveToInteract
    ;
    (self.interPoint):BindInterPoint(self.charEntity)
  else
    self.exeState = (DormAIStateBase.AIExecuteState).Fail
  end
end

DormAIFntState.StartInteractFnt = function(self)
  -- function num : 0_6 , upvalues : FntStageType, DormEnum, _ENV, DormUtil, LogicInterval
  (self.interPoint):BindInterPoint(self.charEntity)
  self.__fntStateType = FntStageType.PlayStartAnimation
  ;
  (self.aiCtrl):BroadcastForDormAI((DormEnum.CharacterAIEventId).StartFntInteract)
  self.time = 0
  local rot = (Quaternion.Euler)(0, (self.interPoint):GetInterAngle() + (self.fntData).r, 0)
  ;
  (self.charEntity):StartSmoothRotate(rot, function()
    -- function num : 0_6_0 , upvalues : self, FntStageType, DormUtil, LogicInterval
    (self.charEntity):AnimatorCrossFade((self.actionCfg).action_name, (self.actionCfg).trans_time)
    local curveId = (self.interPoint):GetInterMoveCurveId()
    if curveId > 0 then
      (self.charEntity):DoMoveInteractCurve(curveId, (self.actionCfg).interact_action_type, self.__interDestPos)
    end
    ;
    (self.charEntity):StartCheckAnimator((self.actionCfg).final_action, function()
      -- function num : 0_6_0_0 , upvalues : self, FntStageType, DormUtil, LogicInterval
      self.__fntStateType = FntStageType.LoopRunning
      if self.__autoExit then
        self.__autoExit = false
        if self.__interStartPos == nil or not (DormUtil.IsPositionOnNavmesh)(self.__interStartPos) then
          self.time = 0
          self.duration = LogicInterval
          self.__noExitWalk = false
          if self.__waitExitAction ~= nil then
            (self.__waitExitAction)(false)
          end
          return 
        end
        self:ExitFntState()
      end
    end
)
  end
)
end

DormAIFntState.OnUpdate = function(self)
  -- function num : 0_7 , upvalues : DormAIStateBase, FntStageType, _ENV, DormUtil, LogicInterval
  if self.exeState == (DormAIStateBase.AIExecuteState).End then
    return 
  end
  if self.__fntStateType == FntStageType.PlayEndAnimation or self.__fntStateType == FntStageType.MoveToEmptyArea then
    return 
  end
  self.time = self.time + Time.deltaTime
  if self.duration <= self.time then
    if self.exeState == (DormAIStateBase.AIExecuteState).Fail then
      self:OnExit()
    else
      if self.__interStartPos == nil then
        self.time = 0
        error("dorm interact start pos is null")
      else
        if (DormUtil.IsPositionOnNavmesh)(self.__interStartPos) then
          self:ExitFntState()
        else
          self.time = 0
          self.duration = LogicInterval
        end
      end
    end
  end
end

DormAIFntState.ExitFntState = function(self)
  -- function num : 0_8 , upvalues : FntStageType, _ENV, DormEnum
  self.__fntStateType = FntStageType.PlayEndAnimation
  if not (string.IsNullOrEmpty)((self.actionCfg).exit_trigger) then
    (self.charEntity):AnimatorTrigger((self.actionCfg).exit_trigger)
  end
  local curveId = (self.interPoint):GetInterExitCurveId()
  if curveId > 0 then
    (self.charEntity):DoMoveInteractCurve(curveId, (self.actionCfg).interact_action_type, self.__interStartPos)
  end
  ;
  (self.charEntity):StartCheckAnimator(DormEnum.DormAnimatorNormalName, function()
    -- function num : 0_8_0 , upvalues : self
    if self.__noExitWalk then
      self:OnExit()
    else
      self:ExitFntToEmptyArea()
    end
  end
)
end

DormAIFntState.ExitFntToEmptyArea = function(self)
  -- function num : 0_9 , upvalues : DormEnum, FntStageType, DormAIStateBase, _ENV
  (self.aiCtrl):BroadcastForDormAI((DormEnum.CharacterAIEventId).ExitFntInteract)
  self.__fntStateType = FntStageType.MoveToEmptyArea
  self.exeState = (DormAIStateBase.AIExecuteState).End
  local ok, pos = (self.charEntity):GetRandomBFSPoint()
  if not ok then
    self:OnExit()
    return 
  end
  local success = (self.charEntity):DoMoveAStar(pos, function(success)
    -- function num : 0_9_0 , upvalues : self
    if not success then
      (self.charEntity):DormForceStopMove()
    end
    self:OnExit()
  end
, (ConfigData.buildinConfig).DormMoveFailTimeout, true)
  if not success then
    self:OnExit()
    return 
  end
end

DormAIFntState.UnBindFntInterPoint = function(self)
  -- function num : 0_10
  if self.interPoint == nil then
    return 
  end
  if (self.interPoint):GetBindCharacter() == self.charEntity then
    (self.interPoint):UnBindInterPoint()
  end
end

DormAIFntState.InterruptState = function(self, gotoNext)
  -- function num : 0_11 , upvalues : DormAIStateBase, _ENV, DormUtil
  if self.exeState == (DormAIStateBase.AIExecuteState).End then
    return 
  end
  TimerManager:StopTimer(self.__retryTimerId)
  self:UnBindFntInterPoint()
  ;
  (self.charEntity):DormForceStopMove()
  ;
  (self.charEntity):StopCheckAnimator()
  if gotoNext then
    if (DormUtil.IsPositionOnNavmesh)(self.__interStartPos) then
      (self.charEntity):SetUnityWorldPos(self.__interStartPos)
    else
      local newActivePos = (DormUtil.FindNearestActivePoint)(self.__interStartPos)
      ;
      (self.charEntity):SetUnityWorldPos(newActivePos)
    end
    do
      ;
      (self.charEntity):AnimatorStand()
      self:ExitFntToEmptyArea()
      do return  end
      ;
      ((self.charEntity).transform):SetLocalY(0)
    end
  end
end

DormAIStateBase.StartExitWait = function(self, action, noExitWalk)
  -- function num : 0_12 , upvalues : DormAIStateBase, _ENV, FntStageType, DormUtil
  if self.exeState == (DormAIStateBase.AIExecuteState).End then
    if action ~= nil then
      action(false)
    end
    return 
  end
  TimerManager:StopTimer(self.__retryTimerId)
  self.__waitExitAction = action
  self.__noExitWalk = noExitWalk or false
  if self.__fntStateType == FntStageType.PlayStartAnimation then
    self.__autoExit = true
  else
    if self.__fntStateType == FntStageType.LoopRunning then
      if self.__interStartPos == nil or not (DormUtil.IsPositionOnNavmesh)(self.__interStartPos) then
        self.__noExitWalk = false
        if self.__waitExitAction ~= nil then
          (self.__waitExitAction)(false)
        end
        return 
      end
      self:ExitFntState()
    else
    end
  end
  if self.__fntStateType == FntStageType.PlayEndAnimation then
    (self.charEntity):DormForceStopMove()
    self:OnExit()
  end
end

DormAIFntState.OnExit = function(self)
  -- function num : 0_13 , upvalues : _ENV, FntStageType, DormAIStateBase
  TimerManager:StopTimer(self.__retryTimerId)
  TimerManager:StopTimer(self.__fixPosTimer)
  self.__fntStateType = FntStageType.AllEnd
  self.exeState = (DormAIStateBase.AIExecuteState).End
  self:UnBindFntInterPoint()
  ;
  (DormAIStateBase.OnExit)(self)
  self:ExitByWaitAction(self.__waitExitAction)
end

return DormAIFntState

