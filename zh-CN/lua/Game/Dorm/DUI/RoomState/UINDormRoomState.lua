local UINDormRoomState = class("UINDormRoomState", UIBaseNode)
local base = UIBaseNode
local UINDormRoomStateItem = require("Game.Dorm.DUI.RoomState.UINDormRoomStateItem")
local DormUtil = require("Game.Dorm.DormUtil")
UINDormRoomState.ctor = function(self, dormMain)
  -- function num : 0_0
  self.dormMain = dormMain
end

UINDormRoomState.OnInit = function(self)
  -- function num : 0_1 , upvalues : _ENV, UINDormRoomStateItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  ((self.ui).stateIItem):SetActive(false)
  self.stateItemPool = (UIItemPool.New)(UINDormRoomStateItem, (self.ui).stateIItem)
end

UINDormRoomState.InitDormRoomState = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local dormCtrl = ControllerManager:GetController(ControllerTypeId.Dorm, false)
  local lockStrDic = (dormCtrl.houseCtrl):GetLockRoomDic()
  ;
  (self.stateItemPool):HideAll()
  for _,data in pairs(lockStrDic) do
    local posx, posy = UIManager:World2UIPositionOut((data.roomEntity).transform)
    local anchorPos = (Vector2.New)(posx, posy)
    local stateItem = (self.stateItemPool):GetOne()
    stateItem:InitDmRoomStateItem(anchorPos)
  end
end

UINDormRoomState.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (self.stateItemPool):DeleteAll()
  ;
  (base.OnDelete)(self)
end

return UINDormRoomState

