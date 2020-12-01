-- params : ...
-- function num : 0 , upvalues : _ENV
local DormAIStateBase = class("DormAIStateBase")
DormAIStateBase.AIExecuteState = {Init = 0, Runnig = 1, Fail = 2, End = 3}
DormAIStateBase.ctor = function(self)
  -- function num : 0_0 , upvalues : DormAIStateBase
  self.duration = 0
  self.exeState = (DormAIStateBase.AIExecuteState).Init
end

DormAIStateBase.SetStateDuration = function(self, duration)
  -- function num : 0_1
  self.duration = duration
end

DormAIStateBase.StartState = function(self)
  -- function num : 0_2
end

DormAIStateBase.InterruptState = function(self)
  -- function num : 0_3
end

DormAIStateBase.QuickExit = function(self)
  -- function num : 0_4
end

DormAIStateBase.OnExit = function(self)
  -- function num : 0_5 , upvalues : DormAIStateBase
  self.exeState = (DormAIStateBase.AIExecuteState).End
end

DormAIStateBase.OnUpdate = function(self)
  -- function num : 0_6
end

return DormAIStateBase

-- params : ...
-- function num : 0 , upvalues : _ENV
local DormAIStateBase = class("DormAIStateBase")
DormAIStateBase.AIExecuteState = {Init = 0, Runnig = 1, Fail = 2, End = 3}
DormAIStateBase.ctor = function(self)
    -- function num : 0_0 , upvalues : DormAIStateBase
    self.duration = 0
    self.exeState = (DormAIStateBase.AIExecuteState).Init
end

DormAIStateBase.SetStateDuration = function(self, duration)
    -- function num : 0_1
    self.duration = duration
end

DormAIStateBase.StartState = function(self)
    -- function num : 0_2
end

DormAIStateBase.InterruptState = function(self)
    -- function num : 0_3
end

DormAIStateBase.QuickExit = function(self)
    -- function num : 0_4
end

DormAIStateBase.OnExit = function(self)
    -- function num : 0_5 , upvalues : DormAIStateBase
    self.exeState = (DormAIStateBase.AIExecuteState).End
end

DormAIStateBase.OnUpdate = function(self)
    -- function num : 0_6
end

return DormAIStateBase

