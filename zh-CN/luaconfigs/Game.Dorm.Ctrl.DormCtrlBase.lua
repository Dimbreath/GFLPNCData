-- params : ...
-- function num : 0 , upvalues : _ENV
local DormCtrlBase = class("ExplorationCtrlBase")
DormCtrlBase.ctor = function(self, dormCtrl)
  -- function num : 0_0 , upvalues : _ENV
  self.dormCtrl = dormCtrl
  ;
  (table.insert)((self.dormCtrl).ctrls, self)
end

DormCtrlBase.OnEnterDormScene = function(self)
  -- function num : 0_1
end

DormCtrlBase.OnEnterDormHouse = function(self)
  -- function num : 0_2
end

DormCtrlBase.OnEnterDormHouseEditMode = function(self)
  -- function num : 0_3
end

DormCtrlBase.OnExitDormHouseEditMode = function(self, success)
  -- function num : 0_4
end

DormCtrlBase.OnEnterDormRoomEditMode = function(self, roomEntity)
  -- function num : 0_5
end

DormCtrlBase.OnExitDormRoomEditMode = function(self, roomEntity, success)
  -- function num : 0_6
end

DormCtrlBase.OnEnterDormRoom = function(self, roomEntity)
  -- function num : 0_7
end

DormCtrlBase.OnExitDormRoom = function(self, roomEntity)
  -- function num : 0_8
end

DormCtrlBase.GetDormState = function(self)
  -- function num : 0_9
  return (self.dormCtrl).state
end

DormCtrlBase.OnDelete = function(self)
  -- function num : 0_10
end

return DormCtrlBase

