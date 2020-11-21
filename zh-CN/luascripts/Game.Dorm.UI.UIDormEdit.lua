-- params : ...
-- function num : 0 , upvalues : _ENV
local UIDormEdit = class("UIDormEdit", UIBaseWindow)
local base = UIBaseWindow
local UIDormEditRoomItem = require("Game.Dorm.UI.UIDormEditRoomItem")
local UINDormComfort = require("Game.Dorm.UI.UINDormComfort")
UIDormEdit.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, UIDormEditRoomItem, UINDormComfort
    (UIUtil.AddButtonListener)((self.ui).btn_Confirm, self,
                               self.OnConfirmClicked);
    (UIUtil.AddButtonListener)((self.ui).btn_Cancel, self, self.OnCancelClicked);
    (UIUtil.AddButtonListener)((self.ui).btn_RoomConfirm, self,
                               self.OnRoomConfirmClicked);
    (UIUtil.AddButtonListener)((self.ui).btn_RoomCancel, self,
                               self.OnRoomCancelClicked);
    (UIUtil.AddButtonListener)((self.ui).btn_Buy, self, self.OnDormBuyClicked);
    (UIUtil.AddButtonListener)((self.ui).btn_Warehouse, self,
                               self.OnWarehouseClicked);
    ((self.ui).presetRoomList):SetActive(false)
    self.__onEditRoomClicked = BindCallback(self, self.OnEditRoomClicked);
    ((self.ui).presetRoomItem):SetActive(false)
    self.poolRoomItem = (UIItemPool.New)(UIDormEditRoomItem,
                                         (self.ui).presetRoomItem)
    self.dormCtrl = ControllerManager:GetController(ControllerTypeId.Dorm)
    self.comfortNode = (UINDormComfort.New)();
    (self.comfortNode):Init((self.ui).roomComfortNode)
end

UIDormEdit.InitDormEdit = function(self)
    -- function num : 0_1
    self.allDormData = (self.dormCtrl).allDormData
    self.curHouse = (self.dormCtrl):GetCurHouse()
    self.editHouseData = ((self.dormCtrl).houseCtrl).editHouseData
    self:RefreshComfortUI()
end

UIDormEdit.RefreshComfortUI = function(self)
    -- function num : 0_2
    local comfort = (self.curHouse):GetComfort()
    local comfortLimit = (self.curHouse):GetComfortLimit();
    (self.comfortNode):InitDormComfort(comfort, comfortLimit)
end

UIDormEdit.OpenEditRoomList = function(self)
    -- function num : 0_3 , upvalues : _ENV
    if ((self.ui).presetRoomList).activeSelf then return end
    ((self.ui).presetRoomList):SetActive(true)
    self.selectRoomItem = nil;
    (self.poolRoomItem):HideAll()
    for spos, roomData in pairs((self.editHouseData).oldStoreRoom) do
        local roomCfg = (ConfigData.dorm_room)[roomData.id]
        if roomCfg == nil then
            error("dorm room cfg is null,id:" .. tostring(roomData.id))
        else
            local roomItem = (self.poolRoomItem):GetOne()
            roomItem:InitEditPrefabRoom(roomCfg, roomData,
                                        self.__onEditRoomClicked)
        end
    end
    for uid, roomData in pairs((self.allDormData).prefabDic) do
        if ((self.editHouseData).installPrefab)[uid] == nil then
            local roomCfg = (ConfigData.dorm_room)[roomData.id]
            if roomCfg == nil then
                error("dorm room cfg is null,id:" .. tostring(roomData.id))
            else
                local roomItem = (self.poolRoomItem):GetOne()
                roomItem:InitEditPrefabRoom(roomCfg, roomData,
                                            self.__onEditRoomClicked)
            end
        end
    end
    local roombpDic = PlayerDataCenter:GetItemDicByType(eItemType.DormRoom)
    for id, roombpItem in pairs(roombpDic) do
        local count = roombpItem:GetCount() -
                          (((self.editHouseData).newRoomCount)[id] or 0)
        if count > 0 then
            local roomCfg = (ConfigData.dorm_room)[id]
            if roomCfg == nil then
                error("dorm room cfg is null,id:" .. tostring(id))
            else
                local roomItem = (self.poolRoomItem):GetOne()
                roomItem:InitEditRoom(roomCfg, count, self.__onEditRoomClicked)
            end
        end
    end
end

UIDormEdit.HideEditRoomList = function(self)
    -- function num : 0_4
    ((self.ui).presetRoomList):SetActive(false)
end

UIDormEdit.OnEditRoomClicked = function(self, roomItem)
    -- function num : 0_5
    if roomItem == nil or self.selectRoomItem == roomItem then return end
    if self.selectRoomItem ~= nil then
        (self.selectRoomItem):SetEditRoomSelect(false)
    end
    self.selectRoomItem = roomItem;
    (self.selectRoomItem):SetEditRoomSelect(true)
end

UIDormEdit.OnRoomConfirmClicked = function(self)
    -- function num : 0_6 , upvalues : _ENV
    if self.selectRoomItem == nil then
        ((CS.MessageCommon).ShowMessageTips)(
            ConfigData:GetTipContent(TipContent.dorm_NotSlelctRoom))
        return
    end
    self:HideEditRoomList();
    ((self.dormCtrl).houseCtrl):ReplaceHouseRoom((self.selectRoomItem).id,
                                                 (self.selectRoomItem).roomData)
end

UIDormEdit.OnRoomCancelClicked = function(self)
    -- function num : 0_7
    self:HideEditRoomList();
    ((self.dormCtrl).houseCtrl):CancelSelectRoom()
end

UIDormEdit.OnConfirmClicked = function(self)
    -- function num : 0_8
    ((self.dormCtrl).houseCtrl):ConfirmHouseEdit()
    self:Delete()
end

UIDormEdit.OnCancelClicked = function(self)
    -- function num : 0_9
    ((self.dormCtrl).houseCtrl):CancelHouseEdit()
    self:Delete()
end

UIDormEdit.OnDormBuyClicked = function(self)
    -- function num : 0_10
    (self.dormCtrl):OpenDormShop()
end

UIDormEdit.OnWarehouseClicked = function(self)
    -- function num : 0_11
    (self.dormCtrl):OpenDormWarehouse()
end

UIDormEdit.OnDelete = function(self)
    -- function num : 0_12 , upvalues : base
    (self.comfortNode):Delete();
    (base.OnDelete)(self)
end

return UIDormEdit

