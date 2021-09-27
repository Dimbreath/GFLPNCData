local CS_UnityEngine_Camera = (CS.UnityEngine).Camera
local DormFightConst = require("Game.Fight.DormFightConst")
local DormFightCharacterFeatureBase = require("Game.Fight.Character.Feature.DormFightCharacterFeatureBase")
local DormFightInputController = class("DormFightInputController", DormFightCharacterFeatureBase)
DormFightInputController.ctor = function(self)
  -- function num : 0_0
  self._isInputRunning = false
  self._modelCtrl = nil
  self._cameraTrans = nil
end

DormFightInputController.OnInit = function(self)
  -- function num : 0_1 , upvalues : DormFightConst, CS_UnityEngine_Camera, _ENV
  self._modelCtrl = self:GetFeature((DormFightConst.FeatureEnum).ModelController)
  self._cameraTrans = (CS_UnityEngine_Camera.main).transform
  local fightUi = UIManager:GetWindow(UIWindowTypeID.FightScene)
  local moveCb = BindCallback(self, self.OnMoveUpdate)
  local runPressDownCb = BindCallback(self, self.OnRunningBegin)
  local runPressUpCb = BindCallback(self, self.OnRunningEnd)
  local attackCb = BindCallback(self, self.OnAttackInput)
  fightUi:Bind(moveCb, runPressDownCb, runPressUpCb, attackCb)
end

DormFightInputController.OnMoveUpdate = function(self, axisH, axisV)
  -- function num : 0_2 , upvalues : _ENV, DormFightConst
  if (math.abs)(axisH) <= 1e-05 and (math.abs)(axisV) <= 1e-05 then
    (self._modelCtrl):PostEvent((DormFightConst.EventEnum).StopMoving)
    return 
  end
  local cameraDir = (Quaternion.Euler)(0, (((self._cameraTrans).rotation).eulerAngles).y, 0)
  local target = Vector3(axisH, 0, axisV)
  ;
  (Vector3.Normalize)(target)
  local targetDir = target
  -- DECOMPILER ERROR at PC38: Overwrote pending register: R6 in 'AssignReg'

  if cameraDir then
    (self._modelCtrl):PostEvent((DormFightConst.EventEnum).Run, targetDir)
  else
    ;
    (self._modelCtrl):PostEvent((DormFightConst.EventEnum).Move, targetDir)
  end
end

DormFightInputController.OnRunningBegin = function(self)
  -- function num : 0_3
  self._isInputRunning = true
end

DormFightInputController.OnRunningEnd = function(self)
  -- function num : 0_4
  self._isInputRunning = false
end

DormFightInputController.OnAttackInput = function(self)
  -- function num : 0_5 , upvalues : DormFightConst
  (self._modelCtrl):PostEvent((DormFightConst.EventEnum).Attack)
end

return DormFightInputController

