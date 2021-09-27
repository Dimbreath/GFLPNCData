local UIDormListItem = class("UIDormListItem", UIBaseNode)
local UIDormIconBtnItem = require("Game.Dorm.DUI.DormCheckIn.UIDormIconBtnItem")
local DormUtil = require("Game.Dorm.DormUtil")
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon
UIDormListItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UIDormIconBtnItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_CheckOut, self, self.OnClickCheckOut)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).tog_canVisit, self, self.OnTogCanVisitChanged)
  self.IconBtnItemPool = (UIItemPool.New)(UIDormIconBtnItem, (self.ui).obj_RoomHeroItem)
  self._OnClickCheckOutCallBack = BindCallback(self, self.OnClickCheckOutCallBack)
end

UIDormListItem.InitListItem = function(self, callback, roomdata)
  -- function num : 0_1 , upvalues : _ENV, DormUtil
  self.iconbtnitemcallback = callback
  self.dormCtrl = ControllerManager:GetController(ControllerTypeId.Dorm)
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).text_RoomName).text = roomdata.RoomName
  if roomdata.IsOnSelect then
    (((self.ui).tran_OnSelect).gameObject):SetActive(true)
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).text_NowRoom).text = ConfigData:GetTipContent(2017)
  else
    ;
    (((self.ui).tran_OnSelect).gameObject):SetActive(false)
  end
  local imgposx, imgposy = (DormUtil.RoomCoordToXY)(roomdata.RoomPos)
  local pos = (Vector2.New)(imgposx, imgposy)
  local uipos = (DormUtil.ToRectTransformPos)(pos)
  -- DECOMPILER ERROR at PC55: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (((self.ui).img_bluepos).transform).localPosition = {0; x = uipos.x, y = uipos.y}
  -- DECOMPILER ERROR at PC62: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).text_ruzhuren).text = ConfigData:GetTipContent(2016)
  -- DECOMPILER ERROR at PC69: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).tex_CheckInCount).text = roomdata.RoomBindCount .. "/" .. roomdata.RoomMaxBindCount
  ;
  ((self.ui).tex_RoomName):SetIndex(roomdata.RoomIndex)
  ;
  ((self.ui).obj_RoomHeroItem):SetActive(false)
  self.roomdata = roomdata
  -- DECOMPILER ERROR at PC84: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).tog_canVisit).isOn = roomdata.EnableUnbind
  self.btnstate = -1
  -- DECOMPILER ERROR at PC95: Confused about usage of register: R7 in 'UnsetPending'

  if self:IsNoBedForCheckIn(roomdata) then
    ((self.ui).img_checkout).color = Color.gray
    self.btnstate = 0
  else
    -- DECOMPILER ERROR at PC102: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self.ui).img_checkout).color = Color.white
  end
  -- DECOMPILER ERROR at PC112: Confused about usage of register: R7 in 'UnsetPending'

  if self:IsOwnBedNoCheckIn(roomdata) then
    ((self.ui).img_checkout).color = Color.gray
    self.btnstate = 1
  else
    -- DECOMPILER ERROR at PC119: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self.ui).img_checkout).color = Color.white
  end
  if self:IsOwnBedAndCheckIn(roomdata) then
    self.btnstate = 2
  end
  self:UpdateIconBtnItemList(roomdata)
end

UIDormListItem.UpdateIconBtnItemList = function(self, roomdata)
  -- function num : 0_2 , upvalues : DormUtil
  (self.IconBtnItemPool):HideAll()
  for i = 1, DormUtil:GetBedCount() do
    local item = (self.IconBtnItemPool):GetOne()
    item:InitIconBtnItem(roomdata[i], roomdata, self.iconbtnitemcallback)
  end
end

UIDormListItem.IsNoBedForCheckIn = function(self, roomdata)
  -- function num : 0_3 , upvalues : DormUtil, _ENV
  local paramlist = {}
  for i = 1, DormUtil:GetBedCount() do
    (table.insert)(paramlist, roomdata[i])
  end
  local count = 0
  for i = 1, #paramlist do
    if (paramlist[i]).param == -1 then
      count = count + 1
    end
  end
  do return count == 6 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UIDormListItem.IsOwnBedNoCheckIn = function(self, roomdata)
  -- function num : 0_4 , upvalues : DormUtil, _ENV
  local paramlist = {}
  for i = 1, DormUtil:GetBedCount() do
    (table.insert)(paramlist, roomdata[i])
  end
  local NoCheckincount = 0
  local NoBedCount = 0
  for i = 1, #paramlist do
    if (paramlist[i]).param == -1 then
      NoBedCount = NoBedCount + 1
    else
      if (paramlist[i]).param == 0 then
        NoCheckincount = NoCheckincount + 1
      end
    end
  end
  do return NoCheckincount == 6 - (NoBedCount) end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UIDormListItem.IsOwnBedAndCheckIn = function(self, roomdata)
  -- function num : 0_5 , upvalues : DormUtil, _ENV
  local paramlist = {}
  for i = 1, DormUtil:GetBedCount() do
    (table.insert)(paramlist, roomdata[i])
  end
  for i = 1, #paramlist do
    if (paramlist[i]).param > 0 then
      return true
    end
  end
  return false
end

UIDormListItem.OnTogCanVisitChanged = function(self, value)
  -- function num : 0_6
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).tog_canVisit).isOn = value
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self.roomdata).EnableUnbind = value
end

UIDormListItem.OnClickCheckOut = function(self)
  -- function num : 0_7 , upvalues : cs_MessageCommon, _ENV
  if self.btnstate == 0 then
    (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(2024))
    return 
  else
    if self.btnstate == 1 then
      (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(2024))
      return 
    else
      if self.btnstate == 2 then
        local callback = BindCallback(self, self.OnClickConfirmCallback)
        do
          local messagewin = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
          local msg = ConfigData:GetTipContent(2026)
          messagewin:ShowTextBoxWithYesAndNo(msg, callback, function()
    -- function num : 0_7_0 , upvalues : messagewin
    messagewin:Delete()
  end
)
        end
      end
    end
  end
end

UIDormListItem.OnClickConfirmCallback = function(self)
  -- function num : 0_8 , upvalues : DormUtil, _ENV
  local paramlist = {}
  local sendmsgdic = {}
  for i = 1, DormUtil:GetBedCount() do
    (table.insert)(paramlist, (self.roomdata)[i])
  end
  self.unbindcount = 0
  for k,v in pairs(paramlist) do
    local data = {}
    if v.param > 0 then
      data.heroId = v.param
      data.bindHero = false
      data.houseId = (self.roomdata).Houseid
      data.roomPos = (self.roomdata).RoomPos
      data.elemIdx = v.fntindex
      sendmsgdic[data.heroId] = data
      v.param = 0
      self.unbindcount = self.unbindcount + 1
    end
  end
  local msglist = {}
  for k,v in pairs(sendmsgdic) do
    (table.insert)(msglist, v)
  end
  ;
  ((self.dormCtrl).dormNetwork):CS_DORM_OneKeyBindUnbindHero(msglist, self._OnClickCheckOutCallBack)
end

UIDormListItem.OnClickCheckOutCallBack = function(self)
  -- function num : 0_9 , upvalues : _ENV
  local checkinWindow = UIManager:GetWindow(UIWindowTypeID.DormCheckIn)
  for key,value in pairs((((checkinWindow.DormHouseData).roomDic)[(self.roomdata).RoomPos]).BindFndDatList) do
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R7 in 'UnsetPending'

    if value ~= -1 and value.param > 0 then
      (checkinWindow.hasbindherodic)[value.param] = nil
      value.param = 0
    end
  end
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self.roomdata).RoomBindCount = (self.roomdata).RoomBindCount - self.unbindcount
  checkinWindow.sendmsgdic = {}
  checkinWindow.localmsglist = {}
  checkinWindow:UpdateOverViewInfo()
  MsgCenter:Broadcast(eMsgEventId.DormBindRoleChanged)
end

UIDormListItem.OnDelete = function(self)
  -- function num : 0_10 , upvalues : base
  (self.IconBtnItemPool):DeleteAll()
  ;
  (base.OnDelete)(self)
end

return UIDormListItem

