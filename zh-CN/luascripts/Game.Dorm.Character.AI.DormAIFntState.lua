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

DormAIFntState.StartState = function(self)
  -- function num : 0_1 , upvalues : _ENV, DormAIStateBase
  print("fnt")
  self.exeState = (DormAIStateBase.AIExecuteState).Runnig
  self.isFailToEnd = false
  local point = self:RandOneInterPoint()
  if point == nil then
    (self.charEntity):AnimatorStand()
    self.exeState = (DormAIStateBase.AIExecuteState).Fail
    return 
  end
  self.interPoint = point.interPoint
  self.logicX = point.logicX
  self.logicY = point.logicY
  self:MoveToPointLogicPoint()
end

DormAIFntState.StateStateByInterPoint = function(self, interPoint)
  -- function num : 0_2 , upvalues : DormAIStateBase, _ENV, DormUtil
  self.exeState = (DormAIStateBase.AIExecuteState).Runnig
  self.interPoint = interPoint
  self.isFailToEnd = true
  for k,v in pairs(interPoint.logicpoint) do
    local logicPointX, logicPointY = (DormUtil.GetFntOffsetCoord)((interPoint.fntData).x, (interPoint.fntData).y, (interPoint.fntData).r, v[1], v[2])
    self.logicX = logicPointX
    self.logicY = logicPointY
    if (DormUtil.IsFntCoordLegal)(logicPointX, logicPointY) then
      self.isFailToEnd = false
      break
    end
  end
  do
    self.fntData = (self.interPoint).fntData
    self.fntEntity = ((self.charEntity).roomEntity):GetFntByData(self.fntData)
    local offsetWorld = ((self.fntEntity).transform):TransformPoint((self.interPoint):GetInterOffsetCoord())
    local unityPos = (((self.charEntity).roomEntity).fntHolder):InverseTransformPoint(offsetWorld)
    ;
    (self.charEntity):SetUnityPos(unityPos)
    self:StartInteractFnt()
  end
end

DormAIFntState.RandOneInterPoint = function(self)
  -- function num : 0_3 , upvalues : _ENV, DormUtil, DormAIStateBase
  local roomData = (self.charEntity).roomData
  local pointRandList = {}
  for k,v in ipairs(roomData.interpoint) do
    if v:GetPointActive() and v:GetInterPointType() == (self.actionCfg).interact_point_type then
      for k1,v1 in pairs(v.logicpoint) do
        local logicPointX, logicPointY = (DormUtil.GetFntOffsetCoord)((v.fntData).x, (v.fntData).y, (v.fntData).r, v1[1], v1[2])
        if (DormUtil.IsFntCoordLegal)(logicPointX, logicPointY) then
          local point = {logicX = logicPointX, logicY = logicPointY, interPoint = v}
          ;
          (table.insert)(pointRandList, point)
        end
      end
    end
  end
  if #pointRandList == 0 then
    self.exeState = (DormAIStateBase.AIExecuteState).Fail
    ;
    (self.charEntity):AnimatorStand()
    return nil
  end
  local index = (math.random)(#pointRandList)
  local interPoint = pointRandList[index]
  return interPoint
end

DormAIFntState.MoveToPointLogicPoint = function(self)
  -- function num : 0_4 , upvalues : DormUtil, _ENV, DormAIStateBase
  local pos = (DormUtil.XYCoord2Fnt)(self.logicX, self.logicY)
  local success = (self.charEntity):DoMoveLogic(pos, BindCallback(self, self.MoveToInterPoint))
  if success then
    (self.charEntity):AnimatorWalk1()
  else
    self.exeState = (DormAIStateBase.AIExecuteState).Fail
    ;
    (self.charEntity):AnimatorStand()
  end
end

DormAIFntState.MoveToInterPoint = function(self)
  -- function num : 0_5 , upvalues : DormAIStateBase, _ENV
  self.fntData = (self.interPoint).fntData
  self.fntEntity = ((self.charEntity).roomEntity):GetFntByData(self.fntData)
  local offsetWorld = ((self.fntEntity).transform):TransformPoint((self.interPoint):GetInterOffsetCoord())
  local unityPos = (((self.charEntity).roomEntity).fntHolder):InverseTransformPoint(offsetWorld)
  if not (self.interPoint):GetPointActive() then
    self.exeState = (DormAIStateBase.AIExecuteState).Fail
    ;
    (self.charEntity):AnimatorStand()
    return 
  end
  ;
  (self.interPoint):BindInterPoint(self.charEntity)
  ;
  (self.charEntity):DoMoveUnityPos(unityPos, BindCallback(self, self.StartInteractFnt))
end

DormAIFntState.StartInteractFnt = function(self)
  -- function num : 0_6 , upvalues : _ENV
  self.time = 0
  ;
  (self.charEntity):AnimatorCrossFade((self.actionCfg).action_name, (self.actionCfg).trans_time)
  local angle = (Vector3.New)(0, (self.interPoint):GetInterAngle() + (self.fntData).r, 0)
  ;
  (self.charEntity):SetLocalRotation(angle)
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
  -- function num : 0_8 , upvalues : DormAIStateBase, DormUtil
  self.exeState = (DormAIStateBase.AIExecuteState).End
  if not (DormUtil.IsFntCoordLegal)(self.logicX, self.logicX) then
    return 
  end
  local pos = (DormUtil.XYCoord2Fnt)(self.logicX, self.logicY)
  ;
  (self.charEntity):AnimatorWalk1()
  ;
  (self.charEntity):DoMoveDirectLogicPos(pos, function()
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
end

DormAIFntState.QuickExit = function(self)
  -- function num : 0_11
  self:UnBindFntInterPoint()
  self:ExitFntState()
end

DormAIFntState.OnExit = function(self)
  -- function num : 0_12 , upvalues : DormAIStateBase
  self:UnBindFntInterPoint()
  ;
  (DormAIStateBase.OnExit)(self)
  if self.exitAction ~= nil then
    (self.exitAction)(self)
  end
end

return DormAIFntState

