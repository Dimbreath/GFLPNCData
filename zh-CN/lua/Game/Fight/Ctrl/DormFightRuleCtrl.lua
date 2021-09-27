local DormFightConst = require("Game.Fight.DormFightConst")
local DormFightCtrlBase = require("Game.Fight.Ctrl.DormFightCtrlBase")
local DormFightRuleCtrl = class("DormFightRuleCtrl", DormFightCtrlBase)
DormFightRuleCtrl.ctor = function(self)
  -- function num : 0_0
  self._scoreInfo = {}
  self._countdown = 0
  self._fightResultDelegate = nil
  self._countdownChangedDelegate = nil
  self._scoreChangedDelegate = nil
end

DormFightRuleCtrl.OnInit = function(self)
  -- function num : 0_1 , upvalues : _ENV
  local dormCtrl = ControllerManager:GetController(ControllerTypeId.DormFight)
  local characterCtrl = dormCtrl:GetCharacterCtrl()
  if characterCtrl ~= nil then
    characterCtrl:SetSomeoneKnockOutDelegate(BindCallback(self, self.OnSomeoneLossHp))
  end
end

DormFightRuleCtrl.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : DormFightConst
  self._countdown = self._countdown - deltaTime
  if self._countdownChangedDelegate ~= nil then
    (self._countdownChangedDelegate)(self._countdown)
  end
  if self._countdown <= 0 then
    self:PostResult((DormFightConst.DormFightResult).Tie)
  end
end

DormFightRuleCtrl.AddComp = function(self, comp)
  -- function num : 0_3 , upvalues : DormFightConst
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._scoreInfo)[comp] = DormFightConst.MaxScore
end

DormFightRuleCtrl.GetScore = function(self, comp)
  -- function num : 0_4
  return comp and (self._scoreInfo)[comp] or 0
end

DormFightRuleCtrl.GetScoreMax = function(self, comp)
  -- function num : 0_5 , upvalues : DormFightConst
  return DormFightConst.MaxScore
end

DormFightRuleCtrl.GetCountdown = function(self)
  -- function num : 0_6
  return self._countdown
end

DormFightRuleCtrl.OnFightStart = function(self)
  -- function num : 0_7 , upvalues : DormFightConst
  self._countdown = DormFightConst.FightDuration
end

DormFightRuleCtrl.OnFightEnd = function(self)
  -- function num : 0_8
  self._fightResultDelegate = nil
  self._scoreInfo = {}
end

DormFightRuleCtrl.OnSomeoneLossHp = function(self, comp)
  -- function num : 0_9 , upvalues : DormFightConst
  if comp == nil or self._scoreInfo == nil or (self._scoreInfo)[comp] == nil then
    return 
  end
  local current = (self._scoreInfo)[comp]
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._scoreInfo)[comp] = current - 1
  if self._scoreChangedDelegate ~= nil then
    (self._scoreChangedDelegate)(comp, (self._scoreInfo)[comp], self:GetScoreMax(comp))
  end
  if (self._scoreInfo)[comp] <= 0 then
    if comp ~= (DormFightConst.DormFightComp).Myself or not (DormFightConst.DormFightResult).Loss then
      local result = (DormFightConst.DormFightResult).Win
    end
    self:PostResult(result)
  end
end

DormFightRuleCtrl.PostResult = function(self, result)
  -- function num : 0_10
  if self._fightResultDelegate ~= nil then
    (self._fightResultDelegate)(result)
  end
  self._fightResultDelegate = nil
end

DormFightRuleCtrl.SetFightResultDelegate = function(self, listener)
  -- function num : 0_11
  self._fightResultDelegate = listener
end

DormFightRuleCtrl.SetCountDownChangedDelegate = function(self, listener)
  -- function num : 0_12
  self._countdownChangedDelegate = listener
end

DormFightRuleCtrl.SetScoreChangedDelegate = function(self, listener)
  -- function num : 0_13
  self._scoreChangedDelegate = listener
end

return DormFightRuleCtrl

