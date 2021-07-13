-- params : ...
-- function num : 0 , upvalues : _ENV
local DormAIStateBase = require("Game.Dorm.Character.AI.DormAIStateBase")
local DormAIFntState = class("DormAIFntState", DormAIStateBase)
local DormUtil = require("Game.Dorm.DormUtil")
local eFntAIStateType = {Init = 0, Run = 1, Fail = 2, End = 3}
DormAIFntState.ctor = function(self, aiCtrl, actionCfg, exitAction)
  -- function num : 0_0 , upvalues : eFntAIStateType
  self.time = 0
  self.aiCtrl = aiCtrl
  self.actionCfg = actionCfg
  self.charEntity = aiCtrl.charEntity
  self.exitAction = exitAction
  self.stateType = eFntAIStateType.Init
  self.roomCtrl = (self.charEntity).roomCharCtrl
  self.isFailToEnd = false
end

DormAIFntState.GetStateName = function(self)
  -- function num : 0_1
  return "fnt"
end

DormAIFntState.StartState = function(self)
  -- function num : 0_2 , upvalues : DormAIStateBase
  self.exeState = (DormAIStateBase.AIExecuteState).Runnig
  self.isFailToEnd = false
  local point = self:RandOneInterPoint()
  if point == nil then
    (self.charEntity):AnimatorStand()
    self.exeState = (DormAIStateBase.AIExecuteState).Fail
    return 
  end
  self.interPoint = point.interPoint
  self.fntData = (self.interPoint).fntData
  self.fntEntity = ((self.charEntity).roomEntity):GetFntByData(self.fntData)
  self.__interStartPos = point.pos
  self.__interDestPos = ((self.fntEntity).transform):TransformPoint((self.interPoint):GetInterOffsetCoord())
  self:MoveToInterStartPoint()
end

DormAIFntState.StateStateByInterPoint = function(self, interPoint)
  -- function num : 0_3 , upvalues : DormAIStateBase
  self.exeState = (DormAIStateBase.AIExecuteState).Runnig
  self.interPoint = interPoint
  self.isFailToEnd = true
  local fntEntity = ((self.charEntity).roomEntity):GetFntByData(interPoint.fntData)
  local offsetWorld = (fntEntity.transform):TransformPoint(interPoint:GetInterStartCoord())
  if not (self.charEntity):TargetPosPossible(offsetWorld) then
    self.isFailToEnd = false
  end
  self.fntData = (self.interPoint).fntData
  self.fntEntity = fntEntity
  self.__interStartPos = offsetWorld
  self.__interDestPos = (fntEntity.transform):TransformPoint(interPoint:GetInterOffsetCoord())
  ;
  (self.charEntity):SetUnityWorldPos(offsetWorld)
  self:StartInteractFnt()
end

DormAIFntState.RandOneInterPoint = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local roomData = (self.charEntity).roomData
  local pointRandList = {}
  for _,interPoint in pairs(roomData.interpoint) do
    if interPoint:GetPointActive() and interPoint:GetInterPointType() == (self.actionCfg).interact_point_type then
      local fntEntity = ((self.charEntity).roomEntity):GetFntByData(interPoint.fntData)
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
  -- function num : 0_5 , upvalues : _ENV, DormAIStateBase
  local success = (self.charEntity):DoMoveAStar(self.__interStartPos, BindCallback(self, self.StartInteractFnt))
  if success then
    (self.charEntity):AnimatorWalk1()
  else
    self.exeState = (DormAIStateBase.AIExecuteState).Fail
    ;
    (self.charEntity):AnimatorStand()
  end
end

DormAIFntState.StartInteractFnt = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if not (self.interPoint):GetPointActive() then
    (self.charEntity):AnimatorStand()
    self:OnExit()
    return 
  end
  ;
  (self.interPoint):BindInterPoint(self.charEntity)
  self.time = 0
  ;
  (self.charEntity):AnimatorCrossFade((self.actionCfg).action_name, (self.actionCfg).trans_time)
  local angle = (Vector3.New)(0, (self.interPoint):GetInterAngle() + (self.fntData).r, 0)
  ;
  (self.charEntity):SetLocalRotation(angle)
  local curveId = (self.interPoint):GetInterMoveCurveId()
  if curveId > 0 then
    (self.charEntity):DoMoveInteractCurve(curveId, self.__interDestPos)
  end
end

DormAIFntState.OnUpdate = function(self)
  -- function num : 0_7 , upvalues : DormAIStateBase, _ENV
  if self.isFailToEnd then
    return 
  end
  if self.exeState == (DormAIStateBase.AIExecuteState).End then
    return 
  end
  self.time = self.time + Time.deltaTime
  if self.duration <= self.time then
    if self.exeState == (DormAIStateBase.AIExecuteState).Fail then
      self:OnExit()
    else
      self:ExitFntState()
    end
  end
end

DormAIFntState.ExitFntState = function(self)
  -- function num : 0_8 , upvalues : DormAIStateBase
  self.exeState = (DormAIStateBase.AIExecuteState).End
  if not (self.charEntity):TargetPosPossible(self.__interStartPos) then
    return 
  end
  local unityPos = (((self.charEntity).roomEntity).fntHolder):InverseTransformPoint(self.__interStartPos)
  ;
  ((self.charEntity).transform):SetLocalY(0)
  ;
  (self.charEntity):AnimatorWalk1()
  ;
  (self.charEntity):DoMoveUnityPos(unityPos, function()
    -- function num : 0_8_0 , upvalues : self
    self:OnExit()
  end
)
end

DormAIFntState.UnBindFntInterPoint = function(self)
  -- function num : 0_9
  if self.interPoint == nil then
    return 
  end
  if (self.interPoint):GetBindCharacter() == self.charEntity then
    (self.interPoint):UnBindInterPoint()
  end
end

DormAIFntState.InterruptState = function(self)
  -- function num : 0_10
  self:UnBindFntInterPoint()
  ;
  ((self.charEntity).transform):SetLocalY(0)
end

DormAIFntState.QuickExit = function(self)
  -- function num : 0_11
  self:UnBindFntInterPoint()
  self:ExitFntState()
end

DormAIFntState.OnExit = function(self)
  -- function num : 0_12 , upvalues : DormAIStateBase
  self.exeState = (DormAIStateBase.AIExecuteState).End
  self:UnBindFntInterPoint()
  ;
  (DormAIStateBase.OnExit)(self)
  if self.exitAction ~= nil then
    (self.exitAction)(self)
  end
end

return DormAIFntState

