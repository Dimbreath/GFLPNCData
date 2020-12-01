-- params : ...
-- function num : 0 , upvalues : _ENV
local DormAIStateBase = require("Game.Dorm.Character.AI.DormAIStateBase")
local DormAIStandState = class("DormAIStandState", DormAIStateBase)
DormAIStandState.ctor = function(self, aiCtrl, actionCfg, exitAction)
  -- function num : 0_0
  self.time = 0
  self.aiCtrl = aiCtrl
  self.actionCfg = actionCfg
  self.charEntity = aiCtrl.charEntity
  self.exitAction = exitAction
end

DormAIStandState.StartState = function(self)
  -- function num : 0_1 , upvalues : _ENV, DormAIStateBase
  print("stand")
  self.exeState = (DormAIStateBase.AIExecuteState).Runnig
  ;
  (self.charEntity):AnimatorCrossFade((self.actionCfg).action_name, (self.actionCfg).trans_time)
end

DormAIStandState.OnUpdate = function(self)
  -- function num : 0_2 , upvalues : DormAIStateBase, _ENV
  if self.exeState == (DormAIStateBase.AIExecuteState).End then
    return 
  end
  self.time = self.time + Time.deltaTime
  if self.duration <= self.time then
    self:OnExit()
  end
end

DormAIStandState.InterruptState = function(self)
  -- function num : 0_3
end

DormAIStandState.OnExit = function(self)
  -- function num : 0_4 , upvalues : DormAIStateBase
  (DormAIStateBase.OnExit)(self)
  if self.exitAction ~= nil then
    (self.exitAction)(self)
  end
end

return DormAIStandState

-- params : ...
-- function num : 0 , upvalues : _ENV
local DormAIStateBase = require("Game.Dorm.Character.AI.DormAIStateBase")
local DormAIStandState = class("DormAIStandState", DormAIStateBase)
DormAIStandState.ctor = function(self, aiCtrl, actionCfg, exitAction)
    -- function num : 0_0
    self.time = 0
    self.aiCtrl = aiCtrl
    self.actionCfg = actionCfg
    self.charEntity = aiCtrl.charEntity
    self.exitAction = exitAction
end

DormAIStandState.StartState = function(self)
    -- function num : 0_1 , upvalues : _ENV, DormAIStateBase
    print("stand")
    self.exeState = (DormAIStateBase.AIExecuteState).Runnig;
    (self.charEntity):AnimatorCrossFade((self.actionCfg).action_name,
                                        (self.actionCfg).trans_time)
end

DormAIStandState.OnUpdate = function(self)
    -- function num : 0_2 , upvalues : DormAIStateBase, _ENV
    if self.exeState == (DormAIStateBase.AIExecuteState).End then return end
    self.time = self.time + Time.deltaTime
    if self.duration <= self.time then self:OnExit() end
end

DormAIStandState.InterruptState = function(self)
    -- function num : 0_3
end

DormAIStandState.OnExit = function(self)
    -- function num : 0_4 , upvalues : DormAIStateBase
    (DormAIStateBase.OnExit)(self)
    if self.exitAction ~= nil then (self.exitAction)(self) end
end

return DormAIStandState

