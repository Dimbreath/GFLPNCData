local BattleDungeonCtrlBase = class("BattleDungeonCtrlBase")
BattleDungeonCtrlBase.ctor = function(self, bdCtrl)
  -- function num : 0_0 , upvalues : _ENV
  self.bdCtrl = bdCtrl
  ;
  (table.insert)((self.bdCtrl).ctrls, self)
end

BattleDungeonCtrlBase.OnDelete = function(self)
  -- function num : 0_1
end

return BattleDungeonCtrlBase

