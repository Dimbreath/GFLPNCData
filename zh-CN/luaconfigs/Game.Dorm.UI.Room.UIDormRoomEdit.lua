-- params : ...
-- function num : 0 , upvalues : _ENV
local UIDormRoomEdit = class("UIDormRoomEdit", UIBaseWindow)
local base = UIBaseWindow
local UIDormFntItem = require("Game.Dorm.UI.Room.UIDormFntItem")
local UINDormComfort = require("Game.Dorm.UI.UINDormComfort")
UIDormRoomEdit.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UIDormFntItem, UINDormComfort
  (UIUtil.AddButtonListener)((self.ui).btn_Confirm, self, self.OnConfirmClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Cancel, self, self.OnCancelClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Warehouse, self, self.OnWarehouseClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Buy, self, self.OnBuyClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_OpenFntList, self, self.ShowFtnList)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Wall1, self, self.OnWall1Clicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Wall2, self, self.OnWall2Clicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Fnt, self, self.OnFntClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Floor, self, self.OnFloorClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Clear, self, self.OnClearClicked)
  ;
  ((self.ui).furnitureItem):SetActive(false)
  self.__fntListShow = false
  self.fntItemPool = (UIItemPool.New)(UIDormFntItem, (self.ui).furnitureItem)
  self._fntItemClickEvent = BindCallback(self, self.OnFntItemClick)
  self.comfortNode = (UINDormComfort.New)()
  ;
  (self.comfortNode):Init((self.ui).roomComfortNode)
end

UIDormRoomEdit.InitDormRoomEdit = function(self, roomCtrl)
  -- function num : 0_1
  self.roomCtrl = roomCtrl
  self:ShowFtnList()
  self:RefreshRoomEditComfortUI()
end

UIDormRoomEdit.OnConfirmClicked = function(self)
  -- function num : 0_2
  (self.roomCtrl):ConfirmDormRoomEdit()
end

UIDormRoomEdit.OnCancelClicked = function(self)
  -- function num : 0_3
  (self.roomCtrl):ExitDormRoomEdit()
end

UIDormRoomEdit.OnBuyClicked = function(self)
  -- function num : 0_4
  ((self.roomCtrl).dormCtrl):OpenDormShop()
end

UIDormRoomEdit.OnWarehouseClicked = function(self)
  -- function num : 0_5
  (self.roomCtrl):ShowFntWarehouse()
end

UIDormRoomEdit.ShowFtnList = function(self)
  -- function num : 0_6
  self.__fntListShow = not self.__fntListShow
  if self.__fntListShow then
    ((self.ui).fntListTween):DOPlayForward()
    self:UpdateFntList()
  else
    ;
    ((self.ui).fntListTween):DOPlayBackwards()
  end
end

UIDormRoomEdit.UpdateFntList = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local fntObjDic = ((self.roomCtrl).roomEntity):GetFntObjDic()
  local fntEntityList = {}
  for go,fntEntity in pairs(fntObjDic) do
    (table.insert)(fntEntityList, fntEntity)
  end
  ;
  (table.sort)(fntEntityList, function(a, b)
    -- function num : 0_7_0
    do return (a.fntData).id < (b.fntData).id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (self.fntItemPool):HideAll()
  for k,fntEntity in ipairs(fntEntityList) do
    local item = (self.fntItemPool):GetOne()
    item:InitUIFntItem(fntEntity, self._fntItemClickEvent)
  end
end

UIDormRoomEdit.UpdateUIDormRoomEdit = function(self)
  -- function num : 0_8
  self:UpdateFntList()
  self:RefreshRoomEditComfortUI()
end

UIDormRoomEdit.OnFntItemClick = function(self, fntEntity)
  -- function num : 0_9
  if self.roomCtrl ~= nil then
    (self.roomCtrl):SelectFntEntity(fntEntity)
  end
end

UIDormRoomEdit.OnWall1Clicked = function(self)
  -- function num : 0_10
end

UIDormRoomEdit.OnWall2Clicked = function(self)
  -- function num : 0_11
end

UIDormRoomEdit.OnFntClicked = function(self)
  -- function num : 0_12
end

UIDormRoomEdit.OnFloorClicked = function(self)
  -- function num : 0_13
end

UIDormRoomEdit.OnClearClicked = function(self)
  -- function num : 0_14
  (self.roomCtrl):ClearAllFnt()
end

UIDormRoomEdit.RefreshRoomEditComfortUI = function(self)
  -- function num : 0_15
  local comfort = (((self.roomCtrl).dormCtrl):GetCurHouse()):GetComfort()
  local comfortLimit = (((self.roomCtrl).dormCtrl):GetCurHouse()):GetComfortLimit()
  ;
  (self.comfortNode):InitDormComfort(comfort, comfortLimit)
end

UIDormRoomEdit.OnDelete = function(self)
  -- function num : 0_16 , upvalues : base
  (self.comfortNode):Delete()
  ;
  (base.OnDelete)(self)
end

return UIDormRoomEdit

