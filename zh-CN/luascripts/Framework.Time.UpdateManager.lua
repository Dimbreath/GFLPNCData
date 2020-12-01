-- params : ...
-- function num : 0 , upvalues : _ENV
local Messenger = require("Framework.Common.Messenger")
local UpdateManager = class("UpdateManager")
local UpdateMsgID = 1
local LateUpdateMsgID = 2
local FixedUpdateMsgID = 3
UpdateManager.ctor = function(self)
  -- function num : 0_0 , upvalues : Messenger
  self.ui_message = (Messenger.New)()
  self.__update_handle = nil
  self.__lateupdate_handle = nil
  self.__fixedupdate_handle = nil
  self.started = false
end

local UpdateHandle = function(self)
  -- function num : 0_1 , upvalues : UpdateMsgID
  (self.ui_message):Broadcast(UpdateMsgID)
end

local LateUpdateHandle = function(self)
  -- function num : 0_2 , upvalues : LateUpdateMsgID
  (self.ui_message):Broadcast(LateUpdateMsgID)
end

local FixedUpdateHandle = function(self)
  -- function num : 0_3 , upvalues : FixedUpdateMsgID
  (self.ui_message):Broadcast(FixedUpdateMsgID)
end

UpdateManager.Start = function(self)
  -- function num : 0_4 , upvalues : _ENV, UpdateHandle, LateUpdateHandle, FixedUpdateHandle
  if self.started then
    return 
  end
  self.started = true
  self.__update_handle = UpdateBeat:CreateListener(UpdateHandle, self)
  self.__lateupdate_handle = LateUpdateBeat:CreateListener(LateUpdateHandle, self)
  self.__fixedupdate_handle = FixedUpdateBeat:CreateListener(FixedUpdateHandle, self)
  UpdateBeat:AddListener(self.__update_handle)
  LateUpdateBeat:AddListener(self.__lateupdate_handle)
  FixedUpdateBeat:AddListener(self.__fixedupdate_handle)
end

UpdateManager.Stop = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if not self.started then
    return 
  end
  self.started = false
  if self.__update_handle ~= nil then
    UpdateBeat:RemoveListener(self.__update_handle)
    self.__update_handle = nil
  end
  if self.__lateupdate_handle ~= nil then
    LateUpdateBeat:RemoveListener(self.__lateupdate_handle)
    self.__lateupdate_handle = nil
  end
  if self.__fixedupdate_handle ~= nil then
    FixedUpdateBeat:RemoveListener(self.__fixedupdate_handle)
    self.__fixedupdate_handle = nil
  end
  ;
  (self.ui_message):Clear()
end

UpdateManager.AddUpdate = function(self, listener)
  -- function num : 0_6 , upvalues : UpdateMsgID
  (self.ui_message):AddListener(UpdateMsgID, listener)
end

UpdateManager.AddLateUpdate = function(self, listener)
  -- function num : 0_7 , upvalues : LateUpdateMsgID
  (self.ui_message):AddListener(LateUpdateMsgID, listener)
end

UpdateManager.AddFixedUpdate = function(self, listener)
  -- function num : 0_8 , upvalues : FixedUpdateMsgID
  (self.ui_message):AddListener(FixedUpdateMsgID, listener)
end

UpdateManager.RemoveUpdate = function(self, listener)
  -- function num : 0_9 , upvalues : UpdateMsgID
  (self.ui_message):RemoveListener(UpdateMsgID, listener)
end

UpdateManager.RemoveLateUpdate = function(self, listener)
  -- function num : 0_10 , upvalues : LateUpdateMsgID
  (self.ui_message):RemoveListener(LateUpdateMsgID, listener)
end

UpdateManager.RemoveFixedUpdate = function(self, listener)
  -- function num : 0_11 , upvalues : FixedUpdateMsgID
  (self.ui_message):RemoveListener(FixedUpdateMsgID, listener)
end

return UpdateManager

-- params : ...
-- function num : 0 , upvalues : _ENV
local Messenger = require("Framework.Common.Messenger")
local UpdateManager = class("UpdateManager")
local UpdateMsgID = 1
local LateUpdateMsgID = 2
local FixedUpdateMsgID = 3
UpdateManager.ctor = function(self)
    -- function num : 0_0 , upvalues : Messenger
    self.ui_message = (Messenger.New)()
    self.__update_handle = nil
    self.__lateupdate_handle = nil
    self.__fixedupdate_handle = nil
    self.started = false
end

local UpdateHandle = function(self)
    -- function num : 0_1 , upvalues : UpdateMsgID
    (self.ui_message):Broadcast(UpdateMsgID)
end

local LateUpdateHandle = function(self)
    -- function num : 0_2 , upvalues : LateUpdateMsgID
    (self.ui_message):Broadcast(LateUpdateMsgID)
end

local FixedUpdateHandle = function(self)
    -- function num : 0_3 , upvalues : FixedUpdateMsgID
    (self.ui_message):Broadcast(FixedUpdateMsgID)
end

UpdateManager.Start = function(self)
    -- function num : 0_4 , upvalues : _ENV, UpdateHandle, LateUpdateHandle, FixedUpdateHandle
    if self.started then return end
    self.started = true
    self.__update_handle = UpdateBeat:CreateListener(UpdateHandle, self)
    self.__lateupdate_handle = LateUpdateBeat:CreateListener(LateUpdateHandle,
                                                             self)
    self.__fixedupdate_handle = FixedUpdateBeat:CreateListener(
                                    FixedUpdateHandle, self)
    UpdateBeat:AddListener(self.__update_handle)
    LateUpdateBeat:AddListener(self.__lateupdate_handle)
    FixedUpdateBeat:AddListener(self.__fixedupdate_handle)
end

UpdateManager.Stop = function(self)
    -- function num : 0_5 , upvalues : _ENV
    if not self.started then return end
    self.started = false
    if self.__update_handle ~= nil then
        UpdateBeat:RemoveListener(self.__update_handle)
        self.__update_handle = nil
    end
    if self.__lateupdate_handle ~= nil then
        LateUpdateBeat:RemoveListener(self.__lateupdate_handle)
        self.__lateupdate_handle = nil
    end
    if self.__fixedupdate_handle ~= nil then
        FixedUpdateBeat:RemoveListener(self.__fixedupdate_handle)
        self.__fixedupdate_handle = nil
    end
    (self.ui_message):Clear()
end

UpdateManager.AddUpdate = function(self, listener)
    -- function num : 0_6 , upvalues : UpdateMsgID
    (self.ui_message):AddListener(UpdateMsgID, listener)
end

UpdateManager.AddLateUpdate = function(self, listener)
    -- function num : 0_7 , upvalues : LateUpdateMsgID
    (self.ui_message):AddListener(LateUpdateMsgID, listener)
end

UpdateManager.AddFixedUpdate = function(self, listener)
    -- function num : 0_8 , upvalues : FixedUpdateMsgID
    (self.ui_message):AddListener(FixedUpdateMsgID, listener)
end

UpdateManager.RemoveUpdate = function(self, listener)
    -- function num : 0_9 , upvalues : UpdateMsgID
    (self.ui_message):RemoveListener(UpdateMsgID, listener)
end

UpdateManager.RemoveLateUpdate = function(self, listener)
    -- function num : 0_10 , upvalues : LateUpdateMsgID
    (self.ui_message):RemoveListener(LateUpdateMsgID, listener)
end

UpdateManager.RemoveFixedUpdate = function(self, listener)
    -- function num : 0_11 , upvalues : FixedUpdateMsgID
    (self.ui_message):RemoveListener(FixedUpdateMsgID, listener)
end

return UpdateManager

