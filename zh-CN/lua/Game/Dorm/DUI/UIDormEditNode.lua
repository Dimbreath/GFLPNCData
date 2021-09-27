local UIDormEditNode = class("UIDormEditNode", UIBaseNode)
local base = UIBaseNode
local JumpManager = require("Game.Jump.JumpManager")
local ShopEnum = require("Game.Shop.ShopEnum")
UIDormEditNode.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Name, self, self.OnRoomRenameClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_DressUp, self, self.OnDressUpClicked)
  ;
  ((self.ui).selectCanvas):SetActive(false)
  self:__InitEditRoomDragUI()
end

UIDormEditNode.__InitEditRoomDragUI = function(self)
  -- function num : 0_1 , upvalues : _ENV
  local cs_EventTrigger = CS.EventTriggerListener
  local eventTrigger = (cs_EventTrigger.Get)((self.ui).btn_Drop)
  self.__OnRoomDragStart = BindCallback(self, self.OnRoomDragStart)
  self.__OnRoomDragging = BindCallback(self, self.OnRoomDragging)
  self.__OnRoomDragEnd = BindCallback(self, self.OnRoomDragEnd)
  eventTrigger:onBeginDrag("+", self.__OnRoomDragStart)
  eventTrigger:onDrag("+", self.__OnRoomDragging)
  eventTrigger:onEndDrag("+", self.__OnRoomDragEnd)
end

UIDormEditNode.SelectEditRoom = function(self, roomEntity)
  -- function num : 0_2 , upvalues : _ENV
  if roomEntity == nil then
    return 
  end
  self.__centerPos = roomEntity:GetDormRoomCenterPos()
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).roomControl).localPosition = self.__centerPos
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = (roomEntity.roomData):GetName()
  ;
  ((self.ui).selectCanvas):SetActive(true)
  ;
  ((self.ui).roomMove):SetActive(false)
  self.__selectRoomEntity = roomEntity
  AudioManager:PlayAudioById(1122)
end

UIDormEditNode.BindRoomMoveAction = function(self, selectStartAction, selectDragAction, selectEndAction)
  -- function num : 0_3
  self.__selectStartAction = selectStartAction
  self.__selectEndAction = selectEndAction
  self.__selectDragAction = selectDragAction
end

UIDormEditNode.UnSelectEditRoom = function(self)
  -- function num : 0_4
  ((self.ui).selectCanvas):SetActive(false)
  self.__selectEndAction = nil
  self.__selectRoomEntity = nil
  self:ResetMoveRoomUI()
end

UIDormEditNode.ResetMoveRoomUI = function(self)
  -- function num : 0_5 , upvalues : _ENV
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  ((self.ui).img_Drop).localPosition = Vector3.zero
  ;
  ((self.ui).roomMove):SetActive(false)
  ;
  ((self.ui).changeNode):SetActive(true)
end

UIDormEditNode.OnHide = function(self)
  -- function num : 0_6 , upvalues : base
  self:UnSelectEditRoom()
  ;
  (base.OnHide)(self)
end

UIDormEditNode.OnRoomDragStart = function(self, go, eventData)
  -- function num : 0_7
  ((self.ui).changeNode):SetActive(false)
  ;
  ((self.ui).roomMove):SetActive(true)
  if self.__selectStartAction ~= nil then
    (self.__selectStartAction)()
  end
end

UIDormEditNode.OnRoomDragging = function(self, go, eventData)
  -- function num : 0_8 , upvalues : _ENV
  local obj = eventData.pointerEnter
  local uiPos = UIManager:Screen2UIPosition(eventData.position)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).img_Drop).localPosition = (Vector3.New)(uiPos.x, uiPos.y, 0) - self.__centerPos
  if self.__selectDragAction ~= nil then
    (self.__selectDragAction)(obj)
  end
end

UIDormEditNode.OnRoomDragEnd = function(self, go, eventData)
  -- function num : 0_9
  local obj = eventData.pointerEnter
  if self.__selectEndAction ~= nil then
    (self.__selectEndAction)(obj)
  end
end

UIDormEditNode.OnRoomRenameClicked = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local dormCtrl = ControllerManager:GetController(ControllerTypeId.Dorm)
  ;
  (dormCtrl.houseCtrl):RequestCurRoomRename(function()
    -- function num : 0_10_0 , upvalues : self
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R0 in 'UnsetPending'

    if self.__selectRoomEntity ~= nil then
      ((self.ui).tex_Name).text = ((self.__selectRoomEntity).roomData):GetName()
    end
  end
)
end

UIDormEditNode.OnDressUpClicked = function(self)
  -- function num : 0_11 , upvalues : _ENV
  local roomEntity = self.__selectRoomEntity
  if roomEntity == nil then
    return 
  end
  ;
  (UIUtil.OnClickBack)()
  local dormCtrl = ControllerManager:GetController(ControllerTypeId.Dorm)
  ;
  (dormCtrl.houseCtrl):OnHouseClicked(roomEntity, true)
end

UIDormEditNode.OnDelete = function(self)
  -- function num : 0_12 , upvalues : base
  (base.OnDelete)(self)
end

return UIDormEditNode

