local util = require("XLua.Common.xlua_util")
local DormFightConst = require("Game.Fight.DormFightConst")
local DormFightController = class("DormFightController", ControllerBase)
local DormFightSceneCtrl = require("Game.Fight.Ctrl.DormFightSceneCtrl")
local DormFightCharacterCtrl = require("Game.Fight.Ctrl.DormFightCharacterCtrl")
local DormFightSceneUiCtrl = require("Game.Fight.Ctrl.DormFightSceneUiCtrl")
local DormFightRuleCtrl = require("Game.Fight.Ctrl.DormFightRuleCtrl")
DormFightController.OnInit = function(self)
  -- function num : 0_0 , upvalues : DormFightSceneCtrl, DormFightCharacterCtrl, DormFightSceneUiCtrl, DormFightRuleCtrl
  self.ctrls = {}
  self._myUserInfo = nil
  self._opUserInfo = nil
  self._countdownTimer = nil
  self._dormStartWindow = nil
  self._updateHandler = nil
  self._sceneCtrl = (DormFightSceneCtrl.New)(self)
  self._characterCtrl = (DormFightCharacterCtrl.New)(self)
  self._sceneUiCtrl = (DormFightSceneUiCtrl.New)(self)
  self._ruleCtrl = (DormFightRuleCtrl.New)(self)
  self:OnChildCtrlInit()
end

DormFightController.EnterScene = function(self, myUserInfo, opUserInfo)
  -- function num : 0_1 , upvalues : _ENV, util
  self._myUserInfo = myUserInfo
  self._opUserInfo = opUserInfo
  UIManager:DeleteAllWindow()
  local preLoadFunc = function()
    -- function num : 0_1_0 , upvalues : _ENV, self
    UIManager:ShowWindowAsync(UIWindowTypeID.FightStart)
    repeat
      (coroutine.yield)(nil)
      self._dormStartWindow = UIManager:GetWindow(UIWindowTypeID.FightStart)
    until self._dormStartWindow
  end

  ;
  ((CS.GSceneManager).Instance):LoadSceneAsyncByAB((Consts.SceneName).Fight, function()
    -- function num : 0_1_1 , upvalues : self
    if self._dormStartWindow ~= nil then
      (self._dormStartWindow):Refresh(self._myUserInfo, self._opUserInfo)
    end
    self:OnChildCtrlEnterScene()
  end
, (util.cs_generator)(preLoadFunc))
end

DormFightController.InitComp = function(self)
  -- function num : 0_2 , upvalues : DormFightConst, _ENV
  if self._myUserInfo ~= nil then
    (self._ruleCtrl):AddComp((DormFightConst.DormFightComp).Myself)
    local myName = (self._myUserInfo):GetUserName()
    local characterId = (self._myUserInfo):GetSex() and DormFightConst.FemaleProfessorIdDefine or DormFightConst.MaleProfessorIdDefine
    ;
    (self._characterCtrl):AddCharacter(characterId, (DormFightConst.CharacterType).Player, true, myName, (DormFightConst.DormFightComp).Myself, (DormFightConst.BornPositions)[1], (Quaternion.LookRotation)((DormFightConst.BornPositions)[3] - (DormFightConst.BornPositions)[1], Vector3.up))
    ;
    (self._characterCtrl):AddCharacter((self._myUserInfo):GetShowGirlId(), (DormFightConst.CharacterType).Npc, false, myName, (DormFightConst.DormFightComp).Myself, (DormFightConst.BornPositions)[2], (Quaternion.LookRotation)((DormFightConst.BornPositions)[4] - (DormFightConst.BornPositions)[2], Vector3.up))
  end
  do
    if self._opUserInfo ~= nil then
      (self._ruleCtrl):AddComp((DormFightConst.DormFightComp).Enemy)
      local opName = (self._opUserInfo):GetUserName()
      local characterId = (self._opUserInfo):GetSex() and DormFightConst.FemaleProfessorIdDefine or DormFightConst.MaleProfessorIdDefine
      ;
      (self._characterCtrl):AddCharacter(characterId, (DormFightConst.CharacterType).Npc, true, opName, (DormFightConst.DormFightComp).Enemy, (DormFightConst.BornPositions)[3], (Quaternion.LookRotation)((DormFightConst.BornPositions)[1] - (DormFightConst.BornPositions)[3], Vector3.up))
      ;
      (self._characterCtrl):AddCharacter((self._opUserInfo):GetShowGirlId(), (DormFightConst.CharacterType).Npc, false, opName, (DormFightConst.DormFightComp).Enemy, (DormFightConst.BornPositions)[4], (Quaternion.LookRotation)((DormFightConst.BornPositions)[2] - (DormFightConst.BornPositions)[4], Vector3.up))
    end
  end
end

DormFightController.GetCharacterCtrl = function(self)
  -- function num : 0_3
  return self._characterCtrl
end

DormFightController.GetSceneCtrl = function(self)
  -- function num : 0_4
  return self._sceneCtrl
end

DormFightController.GetSceneUiCtrl = function(self)
  -- function num : 0_5
  return self._sceneUiCtrl
end

DormFightController.GetRuleCtrl = function(self)
  -- function num : 0_6
  return self._ruleCtrl
end

DormFightController.StartFight = function(self)
  -- function num : 0_7 , upvalues : DormFightConst, _ENV
  self:OnChildCtrlStartFight()
  self:InitComp()
  ;
  (self._sceneUiCtrl):UpdateDisplay()
  ;
  (self._sceneUiCtrl):SetUserInfo((DormFightConst.DormFightComp).Myself, self._myUserInfo)
  ;
  (self._sceneUiCtrl):SetUserInfo((DormFightConst.DormFightComp).Enemy, self._opUserInfo)
  self:StopStartCountDown()
  ;
  (self._sceneUiCtrl):ShowStartCountDown(DormFightConst.StartCountdown)
  ;
  (self._sceneUiCtrl):SetCountdownVisible(false)
  self._countdownTimer = TimerManager:StartTimer(DormFightConst.StartCountdown, self.TrueStartFight, self, true, false, false)
end

DormFightController.TrueStartFight = function(self)
  -- function num : 0_8 , upvalues : _ENV
  self:StartUpdate()
  ;
  (self._sceneUiCtrl):SetCountdownVisible(true)
  ;
  (self._ruleCtrl):SetFightResultDelegate(BindCallback(self, self.OnFightResult))
end

DormFightController.DebugRestartDoubleMode = function(self)
  -- function num : 0_9
  self:StopUpdate()
  self:OnChildCtrlEndFight()
  ;
  (self._characterCtrl):DestroyAllCharacter()
  ;
  (self._sceneUiCtrl):ClearAllSceneUi()
  self:OnChildCtrlStartFight()
  self:InitComp()
  self:TrueStartFight()
end

DormFightController.DebugRestartSingleMode = function(self)
  -- function num : 0_10 , upvalues : DormFightConst, _ENV
  self:StopUpdate()
  self:OnChildCtrlEndFight()
  ;
  (self._characterCtrl):DestroyAllCharacter()
  ;
  (self._sceneUiCtrl):ClearAllSceneUi()
  self:OnChildCtrlStartFight()
  if self._myUserInfo ~= nil then
    (self._ruleCtrl):AddComp((DormFightConst.DormFightComp).Myself)
    local myName = (self._myUserInfo):GetUserName()
    local characterId = (self._myUserInfo):GetSex() and DormFightConst.FemaleProfessorIdDefine or DormFightConst.MaleProfessorIdDefine
    ;
    (self._characterCtrl):AddCharacter(characterId, (DormFightConst.CharacterType).Player, true, myName, (DormFightConst.DormFightComp).Myself, (DormFightConst.BornPositions)[1], Quaternion.identity)
    self:TrueStartFight()
  end
end

DormFightController.StopStartCountDown = function(self)
  -- function num : 0_11 , upvalues : _ENV
  if self._countdownTimer ~= nil then
    TimerManager:StopTimer(self._countdownTimer)
    self._countdownTimer = nil
  end
end

DormFightController.OnFightResult = function(self, resultType)
  -- function num : 0_12
  self:StopUpdate()
  self:OnChildCtrlEndFight()
  ;
  (self._sceneUiCtrl):ShowResultView(self._myUserInfo, resultType)
end

DormFightController.ExitScene = function(self)
  -- function num : 0_13 , upvalues : _ENV
  self:StopUpdate()
  self:StopStartCountDown()
  UIManager:DeleteAllWindow()
  self:OnChildCtrlExitScene()
  ;
  ((CS.GSceneManager).Instance):LoadSceneAsyncByAB((Consts.SceneName).Main, function(ok)
    -- function num : 0_13_0 , upvalues : _ENV
    (ControllerManager:GetController(ControllerTypeId.HomeController, true)):OnEnterHome()
    UIManager:ShowWindowAsync(UIWindowTypeID.Home, function(window)
      -- function num : 0_13_0_0 , upvalues : _ENV
      if window == nil then
        return 
      end
      window:SetFrom2Home(AreaConst.FactoryDorm, true)
    end
)
  end
)
end

DormFightController.StartUpdate = function(self)
  -- function num : 0_14 , upvalues : _ENV
  self:StopUpdate()
  self._updateHandler = TimerManager:StartTimer(1, self.Update, self, false, true, false)
end

DormFightController.StopUpdate = function(self)
  -- function num : 0_15 , upvalues : _ENV
  if self._updateHandler ~= nil then
    TimerManager:StopTimer(self._updateHandler)
    self._updateHandler = nil
  end
end

DormFightController.Update = function(self)
  -- function num : 0_16 , upvalues : _ENV
  for _,ctrl in ipairs(self.ctrls) do
    ctrl:OnUpdate(Time.deltaTime)
  end
end

DormFightController.OnChildCtrlInit = function(self)
  -- function num : 0_17 , upvalues : _ENV
  for _,ctrl in ipairs(self.ctrls) do
    ctrl:OnInit()
  end
end

DormFightController.OnChildCtrlStartFight = function(self)
  -- function num : 0_18 , upvalues : _ENV
  for _,ctrl in ipairs(self.ctrls) do
    ctrl:OnFightStart()
  end
end

DormFightController.OnChildCtrlEndFight = function(self)
  -- function num : 0_19 , upvalues : _ENV
  for _,ctrl in ipairs(self.ctrls) do
    ctrl:OnFightEnd()
  end
end

DormFightController.OnChildCtrlEnterScene = function(self)
  -- function num : 0_20 , upvalues : _ENV
  for _,ctrl in ipairs(self.ctrls) do
    ctrl:OnEnterFightScene()
  end
end

DormFightController.OnChildCtrlExitScene = function(self)
  -- function num : 0_21 , upvalues : _ENV
  for _,ctrl in ipairs(self.ctrls) do
    ctrl:OnExitFightScene()
  end
end

DormFightController.OnDelete = function(self)
  -- function num : 0_22
  self:StopUpdate()
  self:StopStartCountDown()
end

return DormFightController

