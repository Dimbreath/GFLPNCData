local DormFightCtrlBase = class("DormFightCtrlBase")
DormFightCtrlBase.ctor = function(self, owner)
  -- function num : 0_0 , upvalues : _ENV
  self.owner = owner
  ;
  (table.insert)(owner.ctrls, self)
end

DormFightCtrlBase.OnInit = function(self)
  -- function num : 0_1
end

DormFightCtrlBase.OnUpdate = function(self, deltaTime)
  -- function num : 0_2
end

DormFightCtrlBase.OnEnterFightScene = function(self)
  -- function num : 0_3
end

DormFightCtrlBase.OnFightStart = function(self)
  -- function num : 0_4
end

DormFightCtrlBase.OnFightEnd = function(self)
  -- function num : 0_5
end

DormFightCtrlBase.OnExitFightScene = function(self)
  -- function num : 0_6
end

return DormFightCtrlBase

