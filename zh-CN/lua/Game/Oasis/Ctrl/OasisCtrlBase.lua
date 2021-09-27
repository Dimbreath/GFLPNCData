local OasisCtrlBase = class("OasisCtrlBase")
OasisCtrlBase.ctor = function(self, oasisCtrl)
  -- function num : 0_0 , upvalues : _ENV
  self.oasisCtrl = oasisCtrl
  ;
  (table.insert)((self.oasisCtrl).ctrls, self)
end

OasisCtrlBase.OnDelete = function(self)
  -- function num : 0_1
end

return OasisCtrlBase

