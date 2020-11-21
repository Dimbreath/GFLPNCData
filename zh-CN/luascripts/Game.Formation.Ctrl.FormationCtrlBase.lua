-- params : ...
-- function num : 0 , upvalues : _ENV
local FormationCtrlBase = class("FormationCtrlBase")
FormationCtrlBase.ctor = function(self, fmtCtrl)
    -- function num : 0_0 , upvalues : _ENV
    self.fmtCtrl = fmtCtrl;
    (table.insert)((self.fmtCtrl).ctrls, self)
end

FormationCtrlBase.OnDelete = function(self)
    -- function num : 0_1
end

return FormationCtrlBase

