local ExplorationCtrlBase = class("ExplorationCtrlBase")
ExplorationCtrlBase.ctor = function(self, epCtrl)
  -- function num : 0_0 , upvalues : _ENV
  self.epCtrl = epCtrl
  ;
  (table.insert)((self.epCtrl).ctrls, self)
end

ExplorationCtrlBase.OnDelete = function(self)
  -- function num : 0_1
end

return ExplorationCtrlBase

