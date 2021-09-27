local DormFightConst = require("Game.Fight.DormFightConst")
local CS_UnityEngine_Camera = (CS.UnityEngine).Camera
local DormFightCtrlBase = require("Game.Fight.Ctrl.DormFightCtrlBase")
local DormFightSceneUiCtrl = class("DormFightSceneUiCtrl", DormFightCtrlBase)
DormFightSceneUiCtrl.ctor = function(self)
  -- function num : 0_0
  self._sceneUiRoot = nil
  self._sceneCamera = nil
end

DormFightSceneUiCtrl.OnInit = function(self)
  -- function num : 0_1 , upvalues : _ENV
  local dormCtrl = ControllerManager:GetController(ControllerTypeId.DormFight)
  local ruleCtrl = dormCtrl:GetRuleCtrl()
  if ruleCtrl ~= nil then
    ruleCtrl:SetCountDownChangedDelegate(BindCallback(self, self.OnCountDownChanged))
    ruleCtrl:SetScoreChangedDelegate(BindCallback(self, self.OnScoreChanged))
  end
end

DormFightSceneUiCtrl.OnEnterFightScene = function(self)
  -- function num : 0_2 , upvalues : CS_UnityEngine_Camera
  self._sceneCamera = CS_UnityEngine_Camera.main
end

DormFightSceneUiCtrl.OnFightStart = function(self)
  -- function num : 0_3 , upvalues : _ENV
  self._sceneUiRoot = UIManager:ShowWindow(UIWindowTypeID.FightScene)
  if isGameDev then
    UIManager:ShowWindow(UIWindowTypeID.FightDebug)
  end
end

DormFightSceneUiCtrl.OnFightEnd = function(self)
  -- function num : 0_4 , upvalues : _ENV
  UIManager:HideWindow(UIWindowTypeID.FightScene)
end

DormFightSceneUiCtrl.OnExitFightScene = function(self)
  -- function num : 0_5
  self._sceneUiRoot = nil
end

DormFightSceneUiCtrl.OnCountDownChanged = function(self, countdown)
  -- function num : 0_6
  self:SetCountdown(countdown)
end

DormFightSceneUiCtrl.OnScoreChanged = function(self, comp, score, scoreMax)
  -- function num : 0_7
  self:SetScore(comp, score, scoreMax)
end

DormFightSceneUiCtrl.CreateSceneUi = function(self, sceneUiType)
  -- function num : 0_8
  return self._sceneUiRoot ~= nil and (self._sceneUiRoot):CreateSceneUi(sceneUiType) or -1
end

DormFightSceneUiCtrl.ClearAllSceneUi = function(self)
  -- function num : 0_9
  if self._sceneUiRoot ~= nil then
    (self._sceneUiRoot):ClearAllSceneUi()
  end
end

DormFightSceneUiCtrl.UpdatePosition = function(self, index, position)
  -- function num : 0_10
  if self._sceneUiRoot == nil then
    return 
  end
  local screenPos = (self._sceneCamera):WorldToScreenPoint(position)
  ;
  (self._sceneUiRoot):UpdatePosition(index, screenPos)
end

DormFightSceneUiCtrl.SetName = function(self, index, name)
  -- function num : 0_11
  if self._sceneUiRoot == nil then
    return 
  end
  ;
  (self._sceneUiRoot):SetName(index, name)
end

DormFightSceneUiCtrl.SetNamePlateStyle = function(self, index, isSelf)
  -- function num : 0_12
  if self._sceneUiRoot == nil then
    return 
  end
  ;
  (self._sceneUiRoot):SetNamePlateStyle(index, isSelf)
end

DormFightSceneUiCtrl.SetVitalityRatio = function(self, index, ratio)
  -- function num : 0_13
  if self._sceneUiRoot == nil then
    return 
  end
  ;
  (self._sceneUiRoot):SetVitalityRatio(index, ratio)
end

DormFightSceneUiCtrl.ShowVitalityNode = function(self, index)
  -- function num : 0_14
  if self._sceneUiRoot == nil then
    return 
  end
  ;
  (self._sceneUiRoot):ShowVitalityNode(index)
end

DormFightSceneUiCtrl.ShowStartCountDown = function(self, countdown)
  -- function num : 0_15
  if self._sceneUiRoot == nil then
    return 
  end
  ;
  (self._sceneUiRoot):ShowStartCountDown(countdown)
end

DormFightSceneUiCtrl.SetUserInfo = function(self, comp, userInfo)
  -- function num : 0_16
  if self._sceneUiRoot == nil then
    return 
  end
  ;
  (self._sceneUiRoot):SetUserInfo(comp, userInfo)
end

DormFightSceneUiCtrl.SetScore = function(self, comp, score, scoreMax)
  -- function num : 0_17
  if self._sceneUiRoot == nil then
    return 
  end
  ;
  (self._sceneUiRoot):SetScore(comp, score, scoreMax)
end

DormFightSceneUiCtrl.SetCountdown = function(self, countdown)
  -- function num : 0_18
  if self._sceneUiRoot == nil then
    return 
  end
  ;
  (self._sceneUiRoot):SetCountdown(countdown)
end

DormFightSceneUiCtrl.SetCountdownVisible = function(self, visible)
  -- function num : 0_19
  if self._sceneUiRoot == nil then
    return 
  end
  ;
  (self._sceneUiRoot):SetCountdownVisible(visible)
end

DormFightSceneUiCtrl.UpdateDisplay = function(self)
  -- function num : 0_20 , upvalues : _ENV, DormFightConst
  local dormCtrl = ControllerManager:GetController(ControllerTypeId.DormFight)
  local ruleCtrl = dormCtrl:GetRuleCtrl()
  if ruleCtrl == nil then
    return 
  end
  self:SetCountdown(ruleCtrl:GetCountdown())
  self:SetScore((DormFightConst.DormFightComp).Myself, ruleCtrl:GetScore((DormFightConst.DormFightComp).Myself), ruleCtrl:GetScoreMax((DormFightConst.DormFightComp).Myself))
  self:SetScore((DormFightConst.DormFightComp).Enemy, ruleCtrl:GetScore((DormFightConst.DormFightComp).Enemy), ruleCtrl:GetScoreMax((DormFightConst.DormFightComp).Enemy))
end

DormFightSceneUiCtrl.ShowResultView = function(self, userInfo, resultType)
  -- function num : 0_21 , upvalues : _ENV
  local resultView = UIManager:ShowWindow(UIWindowTypeID.FightResult)
  if resultView ~= nil then
    resultView:SetResult(userInfo, resultType)
  end
end

return DormFightSceneUiCtrl

