-- params : ...
-- function num : 0 , upvalues : _ENV
local UIDorm = class("UIDorm", UIBaseWindow)
local base = UIBaseWindow
local UINDormListItem = require("Game.Dorm.UI.UINDormListItem")
local UINDormComfort = require("Game.Dorm.UI.UINDormComfort")
local UINDormHeroSlotItem = require("Game.Dorm.UI.UINDormHeroSlotItem")
local eDormState = require("Game.Dorm.Enum.eDormState")
local CS_MessageCommon = CS.MessageCommon
UIDorm.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINDormListItem, UINDormHeroSlotItem, UINDormComfort
  (UIUtil.AddButtonListener)((self.ui).btn_Return, self, self.OnBtnReturnClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_RoomList, self, self.OnBtnRoomListClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Overview, self, self.OnDormOverviewClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Edit, self, self.OnDormEditorClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_HideUI, self, self.OnDormHideUIClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Buy, self, self.OnDormBuyClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Warehouse, self, self.OnWarehouseClicked)
  self.__onDormListItemClicked = BindCallback(self, self.__OnDormListItemClicked)
  self.__showHeroEnter = BindCallback(self, self.ShowHeroEnter)
  self.__changeDormBind = BindCallback(self, self.ChangeDormBind)
  ;
  ((self.ui).roomItem):SetActive(false)
  self.poolDormList = (UIItemPool.New)(UINDormListItem, (self.ui).roomItem)
  ;
  ((self.ui).roomListNode):SetActive(false)
  ;
  ((self.ui).heroIconItem):SetActive(false)
  self.heroSlotPool = (UIItemPool.New)(UINDormHeroSlotItem, (self.ui).heroIconItem)
  self.dormCtrl = ControllerManager:GetController(ControllerTypeId.Dorm)
  self.comfortNode = (UINDormComfort.New)()
  ;
  (self.comfortNode):Init((self.ui).roomComfortNode)
  self.resloader = ((CS.ResLoader).Create)()
end

UIDorm.InitDormUIData = function(self)
  -- function num : 0_1
  if (self.dormCtrl):GetCurHouse() == nil then
    return 
  end
  self.allDormData = (self.dormCtrl).allDormData
  self:RefreshDormUIState()
  self:RefreshDormHeroList()
end

UIDorm.RefreshDormWindow = function(self)
  -- function num : 0_2
  self:RefreshDormUIState()
  self:RefreshRoomList()
  self:RefreshDormHeroList()
end

UIDorm.RefreshDormUIState = function(self)
  -- function num : 0_3 , upvalues : eDormState
  if (self.dormCtrl).state == eDormState.House then
    local curHouse = (self.dormCtrl):GetCurHouse()
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).tex_RoomName).text = curHouse:GetName()
  else
    do
      do
        if (self.dormCtrl).state == eDormState.Room then
          local curRoom = (self.dormCtrl):GetCurRoom()
          -- DECOMPILER ERROR at PC26: Confused about usage of register: R2 in 'UnsetPending'

          ;
          ((self.ui).tex_RoomName).text = curRoom:GetName()
        end
        local comfort = ((self.dormCtrl):GetCurHouse()):GetComfort()
        local comfortLimit = ((self.dormCtrl):GetCurHouse()):GetComfortLimit()
        ;
        (self.comfortNode):InitDormComfort(comfort, comfortLimit)
      end
    end
  end
end

UIDorm.OnBtnReturnClicked = function(self)
  -- function num : 0_4 , upvalues : eDormState
  local state = (self.dormCtrl).state
  if state == eDormState.House then
    (self.dormCtrl):ExitDorm()
  else
    if state == eDormState.Room then
      ((self.dormCtrl).houseCtrl):ExitRoom()
    end
  end
end

UIDorm.OnBtnRoomListClicked = function(self)
  -- function num : 0_5
  if ((self.ui).roomListNode).activeSelf then
    ((self.ui).roomListNode):SetActive(false)
    return 
  end
  ;
  ((self.ui).roomListNode):SetActive(true)
  self:RefreshRoomList()
end

UIDorm.RefreshRoomList = function(self)
  -- function num : 0_6 , upvalues : eDormState, _ENV
  if not ((self.ui).roomListNode).activeSelf then
    return 
  end
  ;
  (self.poolDormList):HideAll()
  if (self.dormCtrl).state == eDormState.House then
    for _,id in ipairs((ConfigData.dorm_house).id_sort_list) do
      local houseCfg = (ConfigData.dorm_house)[id]
      local isSelf = ((self.dormCtrl):GetCurHouse()).id == id
      local isUnlock = (self.allDormData):IsHouseUnlock(id)
      local roomListItme = (self.poolDormList):GetOne()
      roomListItme:InitDormListItem(id, (LanguageUtil.GetLocaleText)(houseCfg.name), isUnlock, isSelf, self.__onDormListItemClicked)
    end
  end
  if (self.dormCtrl).state == eDormState.Room then
    -- DECOMPILER ERROR: 4 unprocessed JMP targets
  end
end

UIDorm.__OnDormListItemClicked = function(self, dormListItem)
  -- function num : 0_7 , upvalues : eDormState
  if dormListItem == nil or dormListItem.unlock == false then
    return 
  end
  if (self.dormCtrl).state == eDormState.House then
    ((self.dormCtrl).houseCtrl):EnterDormHouse(dormListItem.id)
  else
  end
  if (self.dormCtrl).state == eDormState.Room then
    self:RefreshDormUIState()
    ;
    ((self.ui).roomListNode):SetActive(false)
  end
end

UIDorm.OnDormOverviewClicked = function(self)
  -- function num : 0_8
  (self.dormCtrl):EnterDormOverview()
end

UIDorm.OnDormEditorClicked = function(self)
  -- function num : 0_9
  (self.dormCtrl):EnterDormEditor()
end

UIDorm.OnDormHideUIClicked = function(self)
  -- function num : 0_10
  self:Hide()
end

UIDorm.OnDormBuyClicked = function(self)
  -- function num : 0_11
  (self.dormCtrl):OpenDormShop()
end

UIDorm.OnWarehouseClicked = function(self)
  -- function num : 0_12
  (self.dormCtrl):OpenDormWarehouse()
end

UIDorm.RefreshDormHeroList = function(self)
  -- function num : 0_13 , upvalues : _ENV
  local bindFntDataList = (self.dormCtrl):GetBindFntDataList()
  ;
  (table.sort)(bindFntDataList, function(a, b)
    -- function num : 0_13_0
    local aBind = a:GetFntParam() ~= 0
    local bBind = b:GetFntParam() ~= 0
    if aBind ~= bBind then
      return aBind
    else
      return a.id < b.id
    end
    -- DECOMPILER ERROR: 5 unprocessed JMP targets
  end
)
  local count = 0
  ;
  (self.heroSlotPool):HideAll()
  for _,fntData in ipairs(bindFntDataList) do
    if fntData:GetFntParam() ~= 0 then
      count = count + 1
      local slotItem = (self.heroSlotPool):GetOne()
      slotItem:InitDormHeroSlotItem(fntData, self.resloader, self.__showHeroEnter)
    end
  end
  local allCount = #bindFntDataList
  do
    if count < allCount then
      local slotItem = (self.heroSlotPool):GetOne()
      slotItem:InitDormHeroSlotItem(nil, nil, self.__showHeroEnter)
    end
    ;
    ((self.ui).tex_HeroCount):SetIndex(0, tostring(count), tostring(allCount))
  end
end

UIDorm.ShowHeroEnter = function(self, fntData)
  -- function num : 0_14 , upvalues : _ENV, CS_MessageCommon, eDormState
  if fntData == nil then
    local houseData = (self.dormCtrl):GetCurHouse()
    local houseBindCount = houseData:GetHouseBindCount()
    local dormRoleMaxCount = (ConfigData.game_config).DormRoleMaxCount
    do
      if dormRoleMaxCount <= houseBindCount then
        local msg = (string.format)(ConfigData:GetTipContent(TipContent.Dorm_HouseBindMax), dormRoleMaxCount)
        ;
        (CS_MessageCommon.ShowMessageTips)(msg)
        return 
      end
      if (self.dormCtrl).state == eDormState.House then
        fntData = houseData:GetHouseCanBindFntData()
      else
        if (self.dormCtrl).state == eDormState.Room then
          local roomData = (self.dormCtrl):GetCurRoom()
          local roomBindCount = roomData:GetRoomBindCount()
          local roomRoleMaxCount = (ConfigData.game_config).DormRoomRoleMaxCount
          do
            do
              if roomRoleMaxCount <= roomBindCount then
                local msg = (string.format)(ConfigData:GetTipContent(TipContent.Dorm_RoomBindMax), roomRoleMaxCount)
                ;
                (CS_MessageCommon.ShowMessageTips)(msg)
                return 
              end
              fntData = roomData:GetCanBindFntData()
              if fntData == nil then
                return 
              end
              UIManager:ShowWindowAsync(UIWindowTypeID.DormHeroEnter, function(window)
    -- function num : 0_14_0 , upvalues : self, fntData
    local allBindFntData = (self.dormCtrl):GetAllBindFntData()
    window:InitDormHeroEnter(allBindFntData, fntData, self.resloader, self.__changeDormBind)
  end
)
            end
          end
        end
      end
    end
  end
end

UIDorm.ChangeDormBind = function(self, fntData, newHeroId)
  -- function num : 0_15
  (self.dormCtrl):ChangeDormBind(fntData, newHeroId)
end

UIDorm.OnDelete = function(self)
  -- function num : 0_16 , upvalues : base
  (self.comfortNode):Delete()
  ;
  (self.resloader):Put2Pool()
  self.resloader = nil
  ;
  (base.OnDelete)(self)
end

return UIDorm

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIDorm = class("UIDorm", UIBaseWindow)
local base = UIBaseWindow
local UINDormListItem = require("Game.Dorm.UI.UINDormListItem")
local UINDormComfort = require("Game.Dorm.UI.UINDormComfort")
local UINDormHeroSlotItem = require("Game.Dorm.UI.UINDormHeroSlotItem")
local eDormState = require("Game.Dorm.Enum.eDormState")
local CS_MessageCommon = CS.MessageCommon
UIDorm.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, UINDormListItem, UINDormHeroSlotItem, UINDormComfort
    (UIUtil.AddButtonListener)((self.ui).btn_Return, self,
                               self.OnBtnReturnClicked);
    (UIUtil.AddButtonListener)((self.ui).btn_RoomList, self,
                               self.OnBtnRoomListClicked);
    (UIUtil.AddButtonListener)((self.ui).btn_Overview, self,
                               self.OnDormOverviewClicked);
    (UIUtil.AddButtonListener)((self.ui).btn_Edit, self,
                               self.OnDormEditorClicked);
    (UIUtil.AddButtonListener)((self.ui).btn_HideUI, self,
                               self.OnDormHideUIClicked);
    (UIUtil.AddButtonListener)((self.ui).btn_Buy, self, self.OnDormBuyClicked);
    (UIUtil.AddButtonListener)((self.ui).btn_Warehouse, self,
                               self.OnWarehouseClicked)
    self.__onDormListItemClicked = BindCallback(self,
                                                self.__OnDormListItemClicked)
    self.__showHeroEnter = BindCallback(self, self.ShowHeroEnter)
    self.__changeDormBind = BindCallback(self, self.ChangeDormBind);
    ((self.ui).roomItem):SetActive(false)
    self.poolDormList = (UIItemPool.New)(UINDormListItem, (self.ui).roomItem);
    ((self.ui).roomListNode):SetActive(false);
    ((self.ui).heroIconItem):SetActive(false)
    self.heroSlotPool = (UIItemPool.New)(UINDormHeroSlotItem,
                                         (self.ui).heroIconItem)
    self.dormCtrl = ControllerManager:GetController(ControllerTypeId.Dorm)
    self.comfortNode = (UINDormComfort.New)();
    (self.comfortNode):Init((self.ui).roomComfortNode)
    self.resloader = ((CS.ResLoader).Create)()
end

UIDorm.InitDormUIData = function(self)
    -- function num : 0_1
    if (self.dormCtrl):GetCurHouse() == nil then return end
    self.allDormData = (self.dormCtrl).allDormData
    self:RefreshDormUIState()
    self:RefreshDormHeroList()
end

UIDorm.RefreshDormWindow = function(self)
    -- function num : 0_2
    self:RefreshDormUIState()
    self:RefreshRoomList()
    self:RefreshDormHeroList()
end

UIDorm.RefreshDormUIState = function(self)
    -- function num : 0_3 , upvalues : eDormState
    if (self.dormCtrl).state == eDormState.House then
        local curHouse = (self.dormCtrl):GetCurHouse() -- DECOMPILER ERROR at PC12: Confused about usage of register: R2 in 'UnsetPending'
        ;
        ((self.ui).tex_RoomName).text = curHouse:GetName()
    else
        do
            do
                if (self.dormCtrl).state == eDormState.Room then
                    local curRoom = (self.dormCtrl):GetCurRoom() -- DECOMPILER ERROR at PC26: Confused about usage of register: R2 in 'UnsetPending'
                    ;
                    ((self.ui).tex_RoomName).text = curRoom:GetName()
                end
                local comfort = ((self.dormCtrl):GetCurHouse()):GetComfort()
                local comfortLimit =
                    ((self.dormCtrl):GetCurHouse()):GetComfortLimit();
                (self.comfortNode):InitDormComfort(comfort, comfortLimit)
            end
        end
    end
end

UIDorm.OnBtnReturnClicked = function(self)
    -- function num : 0_4 , upvalues : eDormState
    local state = (self.dormCtrl).state
    if state == eDormState.House then
        (self.dormCtrl):ExitDorm()
    else
        if state == eDormState.Room then
            ((self.dormCtrl).houseCtrl):ExitRoom()
        end
    end
end

UIDorm.OnBtnRoomListClicked = function(self)
    -- function num : 0_5
    if ((self.ui).roomListNode).activeSelf then
        ((self.ui).roomListNode):SetActive(false)
        return
    end
    ((self.ui).roomListNode):SetActive(true)
    self:RefreshRoomList()
end

UIDorm.RefreshRoomList = function(self)
    -- function num : 0_6 , upvalues : eDormState, _ENV
    if not ((self.ui).roomListNode).activeSelf then return end
    (self.poolDormList):HideAll()
    if (self.dormCtrl).state == eDormState.House then
        for _, id in ipairs((ConfigData.dorm_house).id_sort_list) do
            local houseCfg = (ConfigData.dorm_house)[id]
            local isSelf = ((self.dormCtrl):GetCurHouse()).id == id
            local isUnlock = (self.allDormData):IsHouseUnlock(id)
            local roomListItme = (self.poolDormList):GetOne()
            roomListItme:InitDormListItem(id, (LanguageUtil.GetLocaleText)(
                                              houseCfg.name), isUnlock, isSelf,
                                          self.__onDormListItemClicked)
        end
    end
    if (self.dormCtrl).state == eDormState.Room then
        -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
end

UIDorm.__OnDormListItemClicked = function(self, dormListItem)
    -- function num : 0_7 , upvalues : eDormState
    if dormListItem == nil or dormListItem.unlock == false then return end
    if (self.dormCtrl).state == eDormState.House then
        ((self.dormCtrl).houseCtrl):EnterDormHouse(dormListItem.id)
    else
    end
    if (self.dormCtrl).state == eDormState.Room then
        self:RefreshDormUIState();
        ((self.ui).roomListNode):SetActive(false)
    end
end

UIDorm.OnDormOverviewClicked = function(self)
    -- function num : 0_8
    (self.dormCtrl):EnterDormOverview()
end

UIDorm.OnDormEditorClicked = function(self)
    -- function num : 0_9
    (self.dormCtrl):EnterDormEditor()
end

UIDorm.OnDormHideUIClicked = function(self)
    -- function num : 0_10
    self:Hide()
end

UIDorm.OnDormBuyClicked = function(self)
    -- function num : 0_11
    (self.dormCtrl):OpenDormShop()
end

UIDorm.OnWarehouseClicked = function(self)
    -- function num : 0_12
    (self.dormCtrl):OpenDormWarehouse()
end

UIDorm.RefreshDormHeroList = function(self)
    -- function num : 0_13 , upvalues : _ENV
    local bindFntDataList = (self.dormCtrl):GetBindFntDataList();
    (table.sort)(bindFntDataList, function(a, b)
        -- function num : 0_13_0
        local aBind = a:GetFntParam() ~= 0
        local bBind = b:GetFntParam() ~= 0
        if aBind ~= bBind then
            return aBind
        else
            return a.id < b.id
        end
        -- DECOMPILER ERROR: 5 unprocessed JMP targets
    end)
    local count = 0;
    (self.heroSlotPool):HideAll()
    for _, fntData in ipairs(bindFntDataList) do
        if fntData:GetFntParam() ~= 0 then
            count = count + 1
            local slotItem = (self.heroSlotPool):GetOne()
            slotItem:InitDormHeroSlotItem(fntData, self.resloader,
                                          self.__showHeroEnter)
        end
    end
    local allCount = #bindFntDataList
    do
        if count < allCount then
            local slotItem = (self.heroSlotPool):GetOne()
            slotItem:InitDormHeroSlotItem(nil, nil, self.__showHeroEnter)
        end
        ((self.ui).tex_HeroCount):SetIndex(0, tostring(count),
                                           tostring(allCount))
    end
end

UIDorm.ShowHeroEnter = function(self, fntData)
    -- function num : 0_14 , upvalues : _ENV, CS_MessageCommon, eDormState
    if fntData == nil then
        local houseData = (self.dormCtrl):GetCurHouse()
        local houseBindCount = houseData:GetHouseBindCount()
        local dormRoleMaxCount = (ConfigData.game_config).DormRoleMaxCount
        do
            if dormRoleMaxCount <= houseBindCount then
                local msg = (string.format)(
                                ConfigData:GetTipContent(
                                    TipContent.Dorm_HouseBindMax),
                                dormRoleMaxCount);
                (CS_MessageCommon.ShowMessageTips)(msg)
                return
            end
            if (self.dormCtrl).state == eDormState.House then
                fntData = houseData:GetHouseCanBindFntData()
            else
                if (self.dormCtrl).state == eDormState.Room then
                    local roomData = (self.dormCtrl):GetCurRoom()
                    local roomBindCount = roomData:GetRoomBindCount()
                    local roomRoleMaxCount =
                        (ConfigData.game_config).DormRoomRoleMaxCount
                    do
                        do
                            if roomRoleMaxCount <= roomBindCount then
                                local msg =
                                    (string.format)(
                                        ConfigData:GetTipContent(
                                            TipContent.Dorm_RoomBindMax),
                                        roomRoleMaxCount);
                                (CS_MessageCommon.ShowMessageTips)(msg)
                                return
                            end
                            fntData = roomData:GetCanBindFntData()
                            if fntData == nil then
                                return
                            end
                            UIManager:ShowWindowAsync(
                                UIWindowTypeID.DormHeroEnter, function(window)
                                    -- function num : 0_14_0 , upvalues : self, fntData
                                    local allBindFntData =
                                        (self.dormCtrl):GetAllBindFntData()
                                    window:InitDormHeroEnter(allBindFntData,
                                                             fntData,
                                                             self.resloader,
                                                             self.__changeDormBind)
                                end)
                        end
                    end
                end
            end
        end
    end
end

UIDorm.ChangeDormBind = function(self, fntData, newHeroId)
    -- function num : 0_15
    (self.dormCtrl):ChangeDormBind(fntData, newHeroId)
end

UIDorm.OnDelete = function(self)
    -- function num : 0_16 , upvalues : base
    (self.comfortNode):Delete();
    (self.resloader):Put2Pool()
    self.resloader = nil;
    (base.OnDelete)(self)
end

return UIDorm

