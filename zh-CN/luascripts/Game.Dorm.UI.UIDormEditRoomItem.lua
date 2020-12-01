-- params : ...
-- function num : 0 , upvalues : _ENV
local UIDormEditRoomItem = class("UIDormEditRoomItem", UIBaseNode)
UIDormEditRoomItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).presetRoomItem, self, self.OnEditRoomClicked)
end

UIDormEditRoomItem.InitEditRoom = function(self, roomCfg, count, clickAction)
  -- function num : 0_1 , upvalues : _ENV
  self.isPrefab = false
  self.id = roomCfg.id
  self.clickAction = clickAction
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).img_RoomIcon).color = Color.white
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_Comfort).text = tostring(roomCfg.comfort)
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(roomCfg.name)
  self:SetEditRoomSelect(false)
  ;
  ((self.ui).roomCount):SetActive(true)
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_RoomCount).text = tostring(count)
end

UIDormEditRoomItem.InitEditPrefabRoom = function(self, roomCfg, roomData, clickAction)
  -- function num : 0_2 , upvalues : _ENV
  self.isPrefab = true
  self.id = roomCfg.id
  self.roomData = roomData
  self.clickAction = clickAction
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).img_RoomIcon).color = Color.blue
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_Comfort).text = tostring(roomData:GetComfort())
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(roomCfg.name)
  self:SetEditRoomSelect(false)
  ;
  ((self.ui).roomCount):SetActive(false)
end

UIDormEditRoomItem.SetEditRoomSelect = function(self, active)
  -- function num : 0_3
  (((self.ui).img_OnSelect).gameObject):SetActive(active)
end

UIDormEditRoomItem.OnEditRoomClicked = function(self)
  -- function num : 0_4
  if self.clickAction ~= nil then
    (self.clickAction)(self)
  end
end

return UIDormEditRoomItem

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIDormEditRoomItem = class("UIDormEditRoomItem", UIBaseNode)
UIDormEditRoomItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddButtonListener)((self.ui).presetRoomItem, self,
                               self.OnEditRoomClicked)
end

UIDormEditRoomItem.InitEditRoom = function(self, roomCfg, count, clickAction)
    -- function num : 0_1 , upvalues : _ENV
    self.isPrefab = false
    self.id = roomCfg.id
    self.clickAction = clickAction -- DECOMPILER ERROR at PC8: Confused about usage of register: R4 in 'UnsetPending'
    ;
    ((self.ui).img_RoomIcon).color = Color.white -- DECOMPILER ERROR at PC14: Confused about usage of register: R4 in 'UnsetPending'
    ;
    ((self.ui).tex_Comfort).text = tostring(roomCfg.comfort) -- DECOMPILER ERROR at PC21: Confused about usage of register: R4 in 'UnsetPending'
    ;
    ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(roomCfg.name)
    self:SetEditRoomSelect(false);
    ((self.ui).roomCount):SetActive(true) -- DECOMPILER ERROR at PC35: Confused about usage of register: R4 in 'UnsetPending'
    ;
    ((self.ui).tex_RoomCount).text = tostring(count)
end

UIDormEditRoomItem.InitEditPrefabRoom = function(self, roomCfg, roomData,
                                                 clickAction)
    -- function num : 0_2 , upvalues : _ENV
    self.isPrefab = true
    self.id = roomCfg.id
    self.roomData = roomData
    self.clickAction = clickAction -- DECOMPILER ERROR at PC9: Confused about usage of register: R4 in 'UnsetPending'
    ;
    ((self.ui).img_RoomIcon).color = Color.blue -- DECOMPILER ERROR at PC16: Confused about usage of register: R4 in 'UnsetPending'
    ;
    ((self.ui).tex_Comfort).text = tostring(roomData:GetComfort()) -- DECOMPILER ERROR at PC23: Confused about usage of register: R4 in 'UnsetPending'
    ;
    ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(roomCfg.name)
    self:SetEditRoomSelect(false);
    ((self.ui).roomCount):SetActive(false)
end

UIDormEditRoomItem.SetEditRoomSelect = function(self, active)
    -- function num : 0_3
    (((self.ui).img_OnSelect).gameObject):SetActive(active)
end

UIDormEditRoomItem.OnEditRoomClicked = function(self)
    -- function num : 0_4
    if self.clickAction ~= nil then (self.clickAction)(self) end
end

return UIDormEditRoomItem

