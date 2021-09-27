local SectorCtrlBase = class("SectorCtrlBase")
SectorCtrlBase.ctor = function(self, sectorCtrl)
  -- function num : 0_0 , upvalues : _ENV
  self.sctCtrl = sectorCtrl
  ;
  (table.insert)((self.sctCtrl).ctrls, self)
end

SectorCtrlBase.OnDelete = function(self)
  -- function num : 0_1
end

return SectorCtrlBase

