-- params : ...
-- function num : 0 , upvalues : _ENV
local DormCtrlBase = class("ExplorationCtrlBase")
DormCtrlBase.ctor = function(self, dormCtrl)
    -- function num : 0_0 , upvalues : _ENV
    self.dormCtrl = dormCtrl;
    (table.insert)((self.dormCtrl).ctrls, self)
end

DormCtrlBase.OnEnterDormScene = function(self)
    -- function num : 0_1
end

DormCtrlBase.OnDelete = function(self)
    -- function num : 0_2
end

return DormCtrlBase

