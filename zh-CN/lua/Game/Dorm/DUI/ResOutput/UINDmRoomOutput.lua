local UINDmRoomOutput = class("UINDmRoomOutput", UIBaseNode)
local base = UIBaseNode
local UINDmRoomResHolder = require("Game.Dorm.DUI.ResOutput.UINDmRoomResHolder")
local UINDmRoomOutputItem = require("Game.Dorm.DUI.ResOutput.UINDmRoomOutputItem")
UINDmRoomOutput.ctor = function(self, dormMain)
  -- function num : 0_0
  self.dormMain = dormMain
end

UINDmRoomOutput.OnInit = function(self)
  -- function num : 0_1 , upvalues : _ENV, UINDmRoomOutputItem, UINDmRoomResHolder
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_GetRes, self, self._OnclickGetRes)
  ;
  (((self.ui).btn_GetRes).gameObject):SetActive(false)
  ;
  ((self.ui).roomResOutput):SetActive(false)
  ;
  ((self.ui).resHolder):SetActive(false)
  self.resOutputItemPool = (UIItemPool.New)(UINDmRoomOutputItem, (self.ui).roomResOutput)
  self.resHolderPool = (UIItemPool.New)(UINDmRoomResHolder, (self.ui).resHolder)
  self._OnClickResFunc = BindCallback(self, self._OnClickRes)
  self._onTimePassFunc = BindCallback(self, self._onTimePass)
  MsgCenter:AddListener(eMsgEventId.TimingProductOutOfDate, self._onTimePassFunc)
  MsgCenter:AddListener(eMsgEventId.TimingProductRefresh, self._onTimePassFunc)
end

UINDmRoomOutput.InitDmRoomOutput = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local tmProductGroupDic = (PlayerDataCenter.allTimingProduct):GetTimingProductDataGroupItemId(proto_csmsg_SystemFunctionID.SystemFunctionID_Dorm)
  self:_UpdGetAllResBtn()
  local curHouseData = ((self.dormMain).dormCtrl):GetCurHouse()
  local roomNum = curHouseData:GetRoomCount()
  ;
  (self.resOutputItemPool):HideAll()
  ;
  (self.resHolderPool):HideAll()
  if curHouseData.id ~= 1 then
    return 
  end
  local itemIdList = (PlayerDataCenter.allTimingProduct):GetTmProductItemIdList(proto_csmsg_SystemFunctionID.SystemFunctionID_Dorm)
  ;
  (table.sort)(itemIdList)
  local roomIdPoolList = {}
  for i = 1, roomNum do
    (table.insert)(roomIdPoolList, i)
  end
  local roomIdList = {}
  local counterData = (ControllerManager:GetController(ControllerTypeId.TimePass)):getCounterElemData(proto_object_CounterModule.CounterModuleDormFixedRewardFresh, 0)
  local nextExpiredTm = counterData and counterData.nextExpiredTm or 0
  if counterData == nil then
    error("UINDmRoomOutput : counterData is nil")
  end
  ;
  (math.randomseed)((TimestampToDate(nextExpiredTm)).day)
  local showItemNum = #itemIdList
  if roomNum < showItemNum then
    showItemNum = roomNum
  end
  for i = 1, showItemNum do
    local randomIdx = (math.random)(1, #roomIdPoolList)
    local roomIdx = (table.remove)(roomIdPoolList, randomIdx)
    ;
    (table.insert)(roomIdList, roomIdx)
  end
  for k,v in ipairs(roomIdList) do
    local itemId = itemIdList[k]
    local roomData = (curHouseData.roomList)[v]
    if not tmProductGroupDic[itemId] then
      local tmProductDic = table.emptytable
    end
    if (table.count)(tmProductDic) ~= 0 then
      local roomEntity = (((self.dormMain).dormCtrl).houseCtrl):GetDmRoomEntityByPos(roomData.spos)
      if roomEntity ~= nil then
        local posx, posy = UIManager:World2UIPositionOut(roomEntity.transform)
        local anchorPos = (Vector2.New)(posx, posy)
        local holderItem = (self.resHolderPool):GetOne()
        -- DECOMPILER ERROR at PC137: Confused about usage of register: R23 in 'UnsetPending'

        ;
        (holderItem.transform).anchoredPosition = anchorPos
        for productId,tmProductData in pairs(tmProductDic) do
          local resItem = (self.resOutputItemPool):GetOne()
          ;
          (resItem.transform):SetParent(holderItem.transform)
          resItem:InitUINDmRoomOutputItem(tmProductData, self._OnClickResFunc)
        end
      end
    end
  end
end

UINDmRoomOutput._OnClickRes = function(self, tmProductData, resItem)
  -- function num : 0_3 , upvalues : _ENV
  if not self._OnPickResOneFunc then
    self._OnPickResOneFunc = BindCallback(self, self._OnPickResOne)
    ;
    ((self.dormMain).dormCtrl):ReqDormTimingProductPick(tmProductData, self._OnPickResOneFunc)
  end
end

UINDmRoomOutput._OnPickResOne = function(self)
  -- function num : 0_4
  self:InitDmRoomOutput()
end

UINDmRoomOutput._OnclickGetRes = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if not self._OnGetResAllFunc then
    self._OnGetResAllFunc = BindCallback(self, self._OnGetResAll)
    ;
    ((self.dormMain).dormCtrl):ReqDormTimingProductPickAll(self._OnGetResAllFunc)
  end
end

UINDmRoomOutput._OnGetResAll = function(self)
  -- function num : 0_6
  self:InitDmRoomOutput()
end

UINDmRoomOutput._UpdGetAllResBtn = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local canPick = (PlayerDataCenter.allTimingProduct):CanPickTimingProduct(proto_csmsg_SystemFunctionID.SystemFunctionID_Dorm)
  ;
  (((self.ui).btn_GetRes).gameObject):SetActive(canPick)
end

UINDmRoomOutput._onTimePass = function(self)
  -- function num : 0_8
  if self.active then
    self:InitDmRoomOutput()
  else
    self._nextShowInit = true
  end
end

UINDmRoomOutput.OnShow = function(self)
  -- function num : 0_9 , upvalues : base
  (base.OnShow)(self)
  if self._nextShowInit then
    self:InitDmRoomOutput()
    self._nextShowInit = false
  end
end

UINDmRoomOutput.OnDelete = function(self)
  -- function num : 0_10 , upvalues : _ENV, base
  (self.resOutputItemPool):DeleteAll()
  ;
  (self.resHolderPool):DeleteAll()
  MsgCenter:RemoveListener(eMsgEventId.TimingProductOutOfDate, self._onTimePassFunc)
  MsgCenter:RemoveListener(eMsgEventId.TimingProductRefresh, self._onTimePassFunc)
  ;
  (base.OnDelete)(self)
end

return UINDmRoomOutput

