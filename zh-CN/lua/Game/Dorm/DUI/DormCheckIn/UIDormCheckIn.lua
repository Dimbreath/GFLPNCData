local UIDormCheckIn = class("UIDormCheckIn", UIBaseWindow)
local base = UIBaseWindow
local DormUtil = require("Game.Dorm.DormUtil")
local UIDormListItem = require("Game.Dorm.DUI.DormCheckIn.UIDormListItem")
local UIDormDetailItem1 = require("Game.Dorm.DUI.DormCheckIn.UIDormDetailIconBtnItem1")
local UIDormDetailItem2 = require("Game.Dorm.DUI.DormCheckIn.UIDormDetailIconBtnItem2")
UIDormCheckIn.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._OnClickIconBtnCallback = BindCallback(self, self.OnClickIconBtnCallback)
end

UIDormCheckIn.InitByParam = function(self, param)
  -- function num : 0_1 , upvalues : _ENV, DormUtil, UIDormDetailItem1, UIDormListItem
  self.herodic = PlayerDataCenter.heroDic
  self.dormCtrl = ControllerManager:GetController(ControllerTypeId.Dorm)
  self.DormHouseCtr = (ControllerManager:GetController(ControllerTypeId.Dorm)).houseCtrl
  self.DormHouseData = (self.DormHouseCtr).curHouse
  self.CurRoomIndex = 0
  self.param = param
  if param ~= nil then
    UIManager:HideWindow(UIWindowTypeID.DormInput)
    UIManager:HideWindow(UIWindowTypeID.DormRoom)
    UIManager:HideWindow(UIWindowTypeID.DormInteract)
  else
    UIManager:HideWindow(UIWindowTypeID.TopStatus)
    UIManager:HideWindow(UIWindowTypeID.DormMain)
  end
  self.hasbindherodic = {}
  self.sendmsgdic = {}
  self.localmsglist = {}
  self.IconItemDic = {}
  self.RomList = {}
  local roomcount = (self.DormHouseData):GetRoomCount()
  for i = 1, roomcount do
    local DataList = {}
    for j = 1, #(((self.DormHouseData).roomList)[i]).BindFndDatList do
      local dat = {}
      if ((((self.DormHouseData).roomList)[i]).BindFndDatList)[j] ~= -1 then
        dat.param = (((((self.DormHouseData).roomList)[i]).BindFndDatList)[j]).param
        dat.fntindex = (((self.DormHouseData).roomList)[i]):GetFntDataIndex(((((self.DormHouseData).roomList)[i]).BindFndDatList)[j])
        -- DECOMPILER ERROR at PC106: Confused about usage of register: R13 in 'UnsetPending'

        if dat.param ~= 0 then
          (self.hasbindherodic)[dat.param] = 1
        end
      else
        dat.param = -1
      end
      ;
      (table.insert)(DataList, dat)
    end
    local x, y = (DormUtil.RoomCoordToXY)((((self.DormHouseData).roomList)[i]).spos)
    DataList.RoomIndex = (DormUtil.GetRoomIndexByRoomposToxy)(x, y)
    DataList.RoomName = (((self.DormHouseData).roomList)[i]):GetName()
    DataList.RoomPos = (((self.DormHouseData).roomList)[i]).spos
    DataList.RoomBindCount = #(((self.DormHouseData).roomList)[i]):GetRoomBindList()
    DataList.RoomMaxBindCount = (((self.DormHouseData).roomList)[i]):GetRoomCanBindFntCount()
    DataList.Houseid = (self.DormHouseData).id
    DataList.Sort = DataList.RoomIndex
    DataList.IsOnSelect = false
    DataList.EnableUnbind = (((self.DormHouseData).roomList)[i]):GetEnableUnbind()
    ;
    (table.insert)(self.RomList, DataList)
  end
  ;
  (table.sort)(self.RomList, function(a, b)
    -- function num : 0_1_0
    do return a.Sort < b.Sort end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  if param ~= nil then
    local x, y = (DormUtil.RoomCoordToXY)(param)
    self.index = (DormUtil.GetRoomIndexByRoomposToxy)(x, y)
    for k,roomData in pairs(self.RomList) do
      -- DECOMPILER ERROR at PC193: Confused about usage of register: R10 in 'UnsetPending'

      if roomData.RoomIndex == self.index then
        ((self.RomList)[k]).IsOnSelect = true
        break
      end
    end
  end
  do
    ;
    (UIUtil.AddButtonListener)((self.ui).Btn_Close, self, self.OnCloseBtn)
    ;
    (UIUtil.AddButtonListener)((self.ui).btn_Last, self, self.OnClickLastRoom)
    ;
    (UIUtil.AddButtonListener)((self.ui).btn_Next, self, self.OnClickNextRoom)
    ;
    (UIUtil.AddButtonListener)((self.ui).btn_Info, self, self.OnClickInfo)
    ;
    (UIUtil.AddButtonListener)((self.ui).btn_InfoBgClose, self, self.OnClickInfoBG)
    ;
    (UIUtil.AddButtonListener)((self.ui).btn_Confirm, self, self.OnClickConfirm)
    ;
    ((self.ui).obj_detailitem1):SetActive(false)
    ;
    ((self.ui).RoomItem):SetActive(false)
    self.detailitem1Pool = (UIItemPool.New)(UIDormDetailItem1, (self.ui).obj_detailitem1)
    self.ListItemPool = (UIItemPool.New)(UIDormListItem, (self.ui).RoomItem)
    self:InitInfo()
    -- DECOMPILER ERROR at PC271: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).IconLoopList).onInstantiateItem = BindCallback(self, self.OnInstantiateItem)
    -- DECOMPILER ERROR at PC278: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).IconLoopList).onChangeItem = BindCallback(self, self.OnChangeItem)
  end
end

UIDormCheckIn.InitInfo = function(self)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ((self.ui).Text_Title).text = ConfigData:GetTipContent(2014)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).Text_HasCheckin).text = ConfigData:GetTipContent(2015)
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).Text_LastRoom).text = ConfigData:GetTipContent(2020)
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).Text_NextRoom).text = ConfigData:GetTipContent(2021)
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).Text_Info).text = ConfigData:GetTipContent(2019)
  -- DECOMPILER ERROR at PC41: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).Text_InfoTitle).text = ConfigData:GetTipContent(2018)
  self:UpdateOverViewInfo()
end

UIDormCheckIn.OnCloseBtn = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if ((self.ui).obj_detail).activeSelf then
    ((self.ui).obj_detail):SetActive(false)
    ;
    ((self.ui).obj_overView):SetActive(true)
    self:RebackData()
    return 
  end
  local opDic = {}
  for _,cRoomData in pairs(self.RomList) do
    local roomData = (((self.DormHouseCtr).curHouse).roomDic)[cRoomData.RoomPos]
    if roomData:GetEnableUnbind() ~= cRoomData.EnableUnbind then
      opDic[cRoomData.RoomPos] = cRoomData.EnableUnbind
      roomData:SetEnableUnbind(cRoomData.EnableUnbind)
    end
  end
  if (table.count)(opDic) > 0 then
    ((self.dormCtrl).dormNetwork):CS_DORM_HouseRoomBindUnbind(((self.DormHouseCtr).curHouse).id, opDic)
    MsgCenter:Broadcast(eMsgEventId.DormUnbindSwitchChanged, opDic)
  end
  if self.param ~= nil then
    UIManager:ShowWindow(UIWindowTypeID.DormInput)
    UIManager:ShowWindow(UIWindowTypeID.DormRoom)
    UIManager:ShowWindow(UIWindowTypeID.DormInteract)
  else
    UIManager:ShowWindow(UIWindowTypeID.TopStatus)
    UIManager:ShowWindowOnly(UIWindowTypeID.DormMain)
  end
  self:Delete()
end

UIDormCheckIn.UpdateOverViewInfo = function(self)
  -- function num : 0_4
  self.CurRoomIndex = 0
  local checkincount = self:GetHouseCheckInCount()
  local maxcheckincount = (self.DormHouseData):GetHouseCanBindFntCount()
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).Text_CheckInTotalCount).text = checkincount .. "/" .. maxcheckincount
  ;
  (self.ListItemPool):HideAll()
  local count = #self.RomList
  for i = 1, count do
    local item = (self.ListItemPool):GetOne()
    item:InitListItem(self._OnClickIconBtnCallback, (self.RomList)[i])
    if i == self.index and self.param ~= nil then
      (item.transform):SetAsFirstSibling()
    end
  end
end

UIDormCheckIn.GetHouseCheckInCount = function(self)
  -- function num : 0_5 , upvalues : DormUtil, _ENV
  local count = 0
  local paramdic = {}
  for i = 1, #self.RomList do
    local list = {}
    for j = 1, DormUtil:GetBedCount() do
      (table.insert)(list, ((self.RomList)[i])[j])
    end
    paramdic[((self.RomList)[i]).RoomPos] = list
  end
  for key,value in pairs(paramdic) do
    for k,v in pairs(value) do
      if v.param > 0 then
        count = count + 1
      end
    end
  end
  return count
end

UIDormCheckIn.RebackData = function(self)
  -- function num : 0_6 , upvalues : _ENV, DormUtil
  self.CurRoomIndex = 0
  self.sendmsgdic = {}
  self.localmsglist = {}
  self.RomList = {}
  local roomcount = (self.DormHouseData):GetRoomCount()
  for i = 1, roomcount do
    local DataList = {}
    for j = 1, #(((self.DormHouseData).roomList)[i]).BindFndDatList do
      local dat = {}
      if ((((self.DormHouseData).roomList)[i]).BindFndDatList)[j] ~= -1 then
        dat.param = (((((self.DormHouseData).roomList)[i]).BindFndDatList)[j]).param
        dat.fntindex = (((self.DormHouseData).roomList)[i]):GetFntDataIndex(((((self.DormHouseData).roomList)[i]).BindFndDatList)[j])
      else
        dat.param = -1
      end
      ;
      (table.insert)(DataList, dat)
    end
    local x, y = (DormUtil.RoomCoordToXY)((((self.DormHouseData).roomList)[i]).spos)
    DataList.RoomIndex = (DormUtil.GetRoomIndexByRoomposToxy)(x, y)
    DataList.RoomName = (((self.DormHouseData).roomList)[i]):GetName()
    DataList.RoomPos = (((self.DormHouseData).roomList)[i]).spos
    DataList.RoomBindCount = #(((self.DormHouseData).roomList)[i]):GetRoomBindList()
    DataList.RoomMaxBindCount = (((self.DormHouseData).roomList)[i]):GetRoomCanBindFntCount()
    DataList.Houseid = (self.DormHouseData).id
    DataList.Sort = DataList.RoomIndex
    DataList.IsOnSelect = false
    ;
    (table.insert)(self.RomList, DataList)
  end
  ;
  (table.sort)(self.RomList, function(a, b)
    -- function num : 0_6_0
    do return a.Sort < b.Sort end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  if self.param ~= nil then
    local x, y = (DormUtil.RoomCoordToXY)(self.param)
    self.index = (DormUtil.GetRoomIndexByRoomposToxy)(x, y)
    for k,roomData in pairs(self.RomList) do
      -- DECOMPILER ERROR at PC130: Confused about usage of register: R9 in 'UnsetPending'

      if roomData.RoomIndex == self.index then
        ((self.RomList)[k]).IsOnSelect = true
        break
      end
    end
  end
  do
    self:UpdateOverViewInfo()
  end
end

UIDormCheckIn.OnClickLastRoom = function(self)
  -- function num : 0_7
  self.CurRoomIndex = self.CurRoomIndex - 1
  if self.CurRoomIndex <= 0 then
    self.CurRoomIndex = #(self.DormHouseData).roomList
  end
  self:UpdateDetailInfo((self.RomList)[self.CurRoomIndex], true)
end

UIDormCheckIn.OnClickNextRoom = function(self)
  -- function num : 0_8
  self.CurRoomIndex = self.CurRoomIndex + 1
  if #(self.DormHouseData).roomList + 1 <= self.CurRoomIndex then
    self.CurRoomIndex = 1
  end
  self:UpdateDetailInfo((self.RomList)[self.CurRoomIndex], true)
end

UIDormCheckIn.OnClickInfo = function(self)
  -- function num : 0_9 , upvalues : _ENV
  ((self.ui).obj_intro):SetActive(true)
  ;
  ((self.ui).obj_overView):SetActive(false)
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).Text_Title).text = ConfigData:GetTipContent(2018)
end

UIDormCheckIn.OnClickInfoBG = function(self)
  -- function num : 0_10 , upvalues : _ENV
  ((self.ui).obj_intro):SetActive(false)
  ;
  ((self.ui).obj_overView):SetActive(true)
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).Text_Title).text = ConfigData:GetTipContent(2014)
end

UIDormCheckIn.UpdateDetailInfo = function(self, roomdata, IsUseRealData, fakedata)
  -- function num : 0_11
  if IsUseRealData ~= nil then
    self:UpdateDetailInfoByRealData(roomdata)
  else
    self:UpdateDetailInfoByFakeData(roomdata, fakedata)
  end
end

UIDormCheckIn.UpdateDetailInfoByRealData = function(self, roomdata)
  -- function num : 0_12 , upvalues : DormUtil, _ENV
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).Text_DetailRoomName).text = roomdata.RoomName
  ;
  (self.detailitem1Pool):HideAll()
  local paramlist = {}
  for i = 1, DormUtil:GetBedCount() do
    (table.insert)(paramlist, roomdata[i])
  end
  local count = #paramlist
  for i = 1, count do
    local item = (self.detailitem1Pool):GetOne()
    item:InitIconBtnItem(paramlist[i], roomdata)
  end
  self.sortlist = {}
  self.temproomdata = roomdata
  self.tempparamlist = paramlist
  for key,value in pairs(self.herodic) do
    local data = {}
    data.heroId = value.dataId
    if self:IsHeroBindOnElseRoom(data.heroId, roomdata) == false and self:IsBindONThisRoom(data.heroId, roomdata) == false then
      data.sort = 3
      data.state = 1
    else
      if self:IsHeroBindOnElseRoom(data.heroId, roomdata) then
        data.sort = 2
        data.state = 2
      else
      end
    end
    if not self:IsBindONThisRoom(data.heroId, roomdata) then
      (table.insert)(self.sortlist, data)
    end
  end
  ;
  (table.sort)(self.sortlist, function(a, b)
    -- function num : 0_12_0
    if a.heroId >= b.heroId then
      do return a.sort ~= b.sort end
      do return b.sort < a.sort end
      -- DECOMPILER ERROR: 3 unprocessed JMP targets
    end
  end
)
  -- DECOMPILER ERROR at PC90: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).IconLoopList).totalCount = #self.sortlist
  ;
  ((self.ui).IconLoopList):RefillCells()
end

UIDormCheckIn.IsBindONThisRoom = function(self, HeroId, roomdata)
  -- function num : 0_13 , upvalues : DormUtil, _ENV
  local paramlist = {}
  local a = self.RomList
  for i = 1, DormUtil:GetBedCount() do
    (table.insert)(paramlist, roomdata[i])
  end
  for key,value in pairs(paramlist) do
    if value.param == HeroId then
      return true
    end
  end
  return false
end

UIDormCheckIn.IsHeroBindOnElseRoom = function(self, HeroId, roomdata)
  -- function num : 0_14 , upvalues : _ENV, DormUtil
  for k,v in pairs(self.RomList) do
    if v.RoomIndex ~= roomdata.RoomIndex then
      local temproomdata = (self.RomList)[k]
      local paramlist = {}
      for i = 1, DormUtil:GetBedCount() do
        (table.insert)(paramlist, temproomdata[i])
      end
      for key,value in pairs(paramlist) do
        if value.param == HeroId then
          return true
        end
      end
    end
  end
  return false
end

UIDormCheckIn.GetElseRoomData = function(self, roomdata, heroid)
  -- function num : 0_15 , upvalues : _ENV, DormUtil
  for key,value in pairs(self.RomList) do
    if value.RoomIndex ~= roomdata.RoomIndex then
      local temproomdata = (self.RomList)[value.RoomIndex]
      local paramlist = {}
      for i = 1, DormUtil:GetBedCount() do
        (table.insert)(paramlist, temproomdata[i])
      end
      for key,value in pairs(paramlist) do
        if value.param == heroid then
          return temproomdata
        end
      end
    end
  end
end

UIDormCheckIn.UpdateDetailInfoByFakeData = function(self, roomdata, fakedata)
  -- function num : 0_16 , upvalues : DormUtil, _ENV
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R3 in 'UnsetPending'

  ((self.ui).Text_DetailRoomName).text = roomdata.RoomName
  ;
  (self.detailitem1Pool):HideAll()
  local paramlist = {}
  for i = 1, DormUtil:GetBedCount() do
    (table.insert)(paramlist, roomdata[i])
  end
  if fakedata.bind == false then
    for k,v in pairs(paramlist) do
      if fakedata.heroid == v.param then
        local data = {}
        v.param = 0
        roomdata.RoomBindCount = roomdata.RoomBindCount - 1
        data.heroId = fakedata.heroid
        data.bindHero = false
        data.houseId = roomdata.Houseid
        data.roomPos = roomdata.RoomPos
        data.elemIdx = v.fntindex
        -- DECOMPILER ERROR at PC47: Confused about usage of register: R10 in 'UnsetPending'

        ;
        (self.sendmsgdic)[fakedata.heroid] = data
        ;
        (table.insert)(self.localmsglist, data)
        break
      end
    end
  else
    do
      for k,v in pairs(paramlist) do
        if v.param == 0 then
          local data = {}
          v.param = fakedata.heroid
          roomdata.RoomBindCount = roomdata.RoomBindCount + 1
          data.heroId = fakedata.heroid
          data.bindHero = true
          data.houseId = roomdata.Houseid
          data.roomPos = roomdata.RoomPos
          data.elemIdx = v.fntindex
          -- DECOMPILER ERROR at PC81: Confused about usage of register: R10 in 'UnsetPending'

          ;
          (self.sendmsgdic)[fakedata.heroid] = data
          ;
          (table.insert)(self.localmsglist, data)
          break
        end
      end
      do
        self.sortlist = {}
        self.temproomdata = roomdata
        self.tempparamlist = paramlist
        local count = #paramlist
        for i = 1, count do
          local item = (self.detailitem1Pool):GetOne()
          item:InitIconBtnItem(paramlist[i], roomdata)
        end
        for key,value in pairs(self.herodic) do
          local data = {}
          data.heroId = key
          if self:IsHeroBindOnElseRoom(data.heroId, roomdata) == false and self:IsBindONThisRoom(data.heroId, roomdata) == false then
            data.sort = 3
            data.state = 1
          else
            if self:IsHeroBindOnElseRoom(data.heroId, roomdata) then
              data.sort = 2
              data.state = 2
            else
            end
          end
          if not self:IsBindONThisRoom(data.heroId, roomdata) then
            (table.insert)(self.sortlist, data)
          end
        end
        ;
        (table.sort)(self.sortlist, function(a, b)
    -- function num : 0_16_0
    if a.heroId >= b.heroId then
      do return a.sort ~= b.sort end
      do return b.sort < a.sort end
      -- DECOMPILER ERROR: 3 unprocessed JMP targets
    end
  end
)
        -- DECOMPILER ERROR at PC159: Confused about usage of register: R5 in 'UnsetPending'

        ;
        ((self.ui).IconLoopList).totalCount = #self.sortlist
        ;
        ((self.ui).IconLoopList):RefillCells()
      end
    end
  end
end

UIDormCheckIn.OnClickConfirm = function(self)
  -- function num : 0_17 , upvalues : _ENV
  local msglist = {}
  local temp = self.localmsglist
  local state = -1
  for k,v in pairs(self.sendmsgdic) do
    state = -1
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R9 in 'UnsetPending'

    if not (self.hasbindherodic)[k] then
      if v.bindHero then
        do
          (self.sendmsgdic)[k] = nil
          -- DECOMPILER ERROR at PC18: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC18: LeaveBlock: unexpected jumping out IF_STMT

          -- DECOMPILER ERROR at PC18: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC18: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  for k,v in pairs(self.sendmsgdic) do
    (table.insert)(msglist, v)
  end
  self._OnSuccessClickConfirmCallback = BindCallback(self, self.OnSuccessClickConfirmCallback)
  ;
  ((self.dormCtrl).dormNetwork):CS_DORM_OneKeyBindUnbindHero(msglist, self._OnSuccessClickConfirmCallback)
end

UIDormCheckIn.OnSuccessClickConfirmCallback = function(self)
  -- function num : 0_18 , upvalues : _ENV
  for i = 1, #self.localmsglist do
    local roomdata = ((self.DormHouseData).roomDic)[((self.localmsglist)[i]).roomPos]
    local fatlist = roomdata.BindFndDatList
    for j = 1, #fatlist do
      -- DECOMPILER ERROR at PC36: Confused about usage of register: R11 in 'UnsetPending'

      if fatlist[j] ~= -1 and roomdata:GetFntDataIndex(fatlist[j]) == ((self.localmsglist)[i]).elemIdx then
        if ((self.localmsglist)[i]).bindHero then
          (fatlist[j]).param = ((self.localmsglist)[i]).heroId
          -- DECOMPILER ERROR at PC41: Confused about usage of register: R11 in 'UnsetPending'

          ;
          (self.hasbindherodic)[((self.localmsglist)[i]).heroId] = 1
        else
          -- DECOMPILER ERROR at PC46: Confused about usage of register: R11 in 'UnsetPending'

          ;
          (self.hasbindherodic)[(fatlist[j]).param] = nil
          -- DECOMPILER ERROR at PC48: Confused about usage of register: R11 in 'UnsetPending'

          ;
          (fatlist[j]).param = 0
        end
      end
    end
  end
  self.sendmsgdic = {}
  self.localmsglist = {}
  ;
  ((self.ui).obj_overView):SetActive(true)
  ;
  ((self.ui).obj_intro):SetActive(false)
  ;
  ((self.ui).obj_detail):SetActive(false)
  self:UpdateOverViewInfo()
  ;
  (self.dormCtrl):SetAllBindFntDataDirty()
  MsgCenter:Broadcast(eMsgEventId.DormBindRoleChanged)
end

UIDormCheckIn.OnClickIconBtnCallback = function(self)
  -- function num : 0_19
  ((self.ui).obj_overView):SetActive(false)
  ;
  ((self.ui).obj_intro):SetActive(false)
  ;
  ((self.ui).obj_detail):SetActive(true)
end

UIDormCheckIn.OnInstantiateItem = function(self, go)
  -- function num : 0_20 , upvalues : UIDormDetailItem2
  local item = (UIDormDetailItem2.New)()
  item:Init(go)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.IconItemDic)[go] = item
end

UIDormCheckIn.OnChangeItem = function(self, go, index)
  -- function num : 0_21 , upvalues : _ENV
  local data = (self.sortlist)[index + 1]
  local item = (self.IconItemDic)[go]
  if item == nil then
    error("Can\'t find taskItem by gameObject")
  end
  if data == nil then
    error("Can\'t find taskData by index, index = " .. tonumber(index))
  end
  item:InitIconBtnItem(data, self.temproomdata, self.tempparamlist)
end

UIDormCheckIn.SetRoomIndex = function(self, index)
  -- function num : 0_22
  self.CurRoomIndex = index
end

UIDormCheckIn.OnDelete = function(self)
  -- function num : 0_23 , upvalues : base
  (self.detailitem1Pool):DeleteAll()
  ;
  (self.ListItemPool):DeleteAll()
  ;
  (base.OnDelete)(self)
end

return UIDormCheckIn

