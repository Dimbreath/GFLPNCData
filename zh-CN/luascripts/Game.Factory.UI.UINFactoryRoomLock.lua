-- params : ...
-- function num : 0 , upvalues : _ENV
local UINFactoryRoomLock = class("UINFactoryRoomLock", UIBaseNode)
local base = UIBaseNode
local OFFSET = (Vector3.New)(0, 1, 0)
UINFactoryRoomLock.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINFactoryRoomLock.InitLock = function(self, roomEntity)
  -- function num : 0_1 , upvalues : _ENV
  self.roomEntity = roomEntity
  if roomEntity.unlockLevel ~= 0 then
    (((self.ui).tex_Condition).gameObject):SetActive(true)
    ;
    ((self.ui).tex_Condition):SetIndex(0, tostring(roomEntity.unlockLevel))
  else
    ;
    (((self.ui).tex_Condition).gameObject):SetActive(false)
  end
  self:Set2RoomPos()
end

UINFactoryRoomLock.Set2RoomPos = function(self)
  -- function num : 0_2 , upvalues : _ENV, OFFSET
  local UIPos = UIManager:World2UIPosition(((self.roomEntity).transform).position + OFFSET)
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self.transform).localPosition = (Vector2.New)(UIPos.x, UIPos.y)
end

UINFactoryRoomLock.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UINFactoryRoomLock

