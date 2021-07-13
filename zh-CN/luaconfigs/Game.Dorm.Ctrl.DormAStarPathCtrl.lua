-- params : ...
-- function num : 0 , upvalues : _ENV
local DormCtrlBase = require("Game.Dorm.Ctrl.DormCtrlBase")
local DormAStarPathCtrl = class("DormAStarPathCtrl", DormCtrlBase)
DormAStarPathCtrl.ctor = function(self, dormCtrl)
  -- function num : 0_0
end

DormAStarPathCtrl.OnEnterDormRoom = function(self, roomEntity)
  -- function num : 0_1 , upvalues : _ENV
  local pos = (roomEntity.transform).position
  pos.y = pos.y + 1
  ;
  ((CS.DormAStarUtils).SetRoomAStarGraph)(pos)
end

DormAStarPathCtrl.OnExitDormRoom = function(self, roomEntity)
  -- function num : 0_2
end

DormCtrlBase.OnExitDormRoomEditMode = function(self, roomEntity, success)
  -- function num : 0_3 , upvalues : _ENV
  if not success then
    return 
  end
  ;
  ((CS.AstarPath).active):Scan()
end

return DormAStarPathCtrl

