local FriendDataCenter = class("FriendDataCenter")
local UserInfoData = require("Game.User.UserInfoData")
FriendDataCenter.ctor = function(self)
  -- function num : 0_0
  self.__IsFriendDataReceived = false
  self.friendDic = nil
  self.friendList = nil
  self.friendApplyDic = {}
  self.friendApplicationList = {}
  self.balckList = nil
  self.__lastFriendDataUpdateTm = nil
end

FriendDataCenter.IsFriendDataCenterInited = function(self)
  -- function num : 0_1
  return self.__IsFriendDataReceived
end

FriendDataCenter.OnReceiveFriendInitData = function(self, msg)
  -- function num : 0_2 , upvalues : _ENV, UserInfoData
  self.__IsFriendDataReceived = true
  if msg ~= nil then
    if msg.friend ~= nil then
      self.friendList = {}
      self.friendDic = {}
      for uid,avatarMsg in pairs(msg.friend) do
        local friendData = (UserInfoData.CreateFriendDataWithAvatarMsg)(avatarMsg)
        ;
        (table.insert)(self.friendList, friendData)
        -- DECOMPILER ERROR at PC25: Confused about usage of register: R8 in 'UnsetPending'

        ;
        (self.friendDic)[friendData:GetUserUID()] = friendData
      end
      self:SortFriendList()
    end
    local isReceiveApp = (PersistentManager:GetDataModel((PersistentConfig.ePackage).UserData)):ReadIsReceiveFriendApplication()
    if msg.apply ~= nil and isReceiveApp then
      self.friendApplicationList = {}
      self.friendApplyDic = {}
      for uid,avatarMsg in pairs(msg.apply) do
        local friendData = (UserInfoData.CreateStrangerDataWithAvatarMsg)(avatarMsg)
        ;
        (table.insert)(self.friendApplicationList, friendData)
        -- DECOMPILER ERROR at PC62: Confused about usage of register: R9 in 'UnsetPending'

        ;
        (self.friendApplyDic)[friendData:GetUserUID()] = friendData
      end
      self:UpdateFriendApplyReddotNum()
    end
    if msg.black ~= nil then
      self.balckList = {}
      for uid,avatarMsg in pairs(msg.black) do
        local friendData = (UserInfoData.CreateStrangerDataWithAvatarMsg)(avatarMsg)
        ;
        (table.insert)(self.balckList, friendData)
      end
    end
    do
      do
        if msg.applyBrief ~= nil and (msg.applyBrief).apply ~= nil and isReceiveApp then
          for _,applyElem in pairs((msg.applyBrief).apply) do
            local friendData = (self.friendApplyDic)[applyElem.uid]
            if friendData ~= nil then
              friendData:SetApplyTimestamp(applyElem.ts)
            end
          end
          ;
          (table.sort)(self.friendApplicationList, function(a, b)
    -- function num : 0_2_0
    if b.__applyTimestamp >= a.__applyTimestamp then
      do return a.__applyTimestamp == b.__applyTimestamp end
      do return b:GetUserUID() < a:GetUserUID() end
      -- DECOMPILER ERROR: 3 unprocessed JMP targets
    end
  end
)
        end
        self.__lastFriendDataUpdateTm = PlayerDataCenter.timestamp
        local ok, userFriendNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.UserFriend)
        if ok then
          local applyNode = userFriendNode:AddChild(RedDotStaticTypeId.UserFriendApplyPath)
          applyNode:SetRedDotCount(#self.friendApplicationList)
        end
      end
    end
  end
end

FriendDataCenter.SortFriendList = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (table.sort)(self.friendList, function(a, b)
    -- function num : 0_3_0 , upvalues : _ENV
    local aTs = a:GetOnlineState()
    local bTs = b:GetOnlineState()
    if aTs == 0 then
      aTs = math.maxinteger
    end
    if bTs == 0 then
      bTs = math.maxinteger
    end
    if bTs >= aTs then
      do return aTs == bTs end
      do return b:GetUserUID() < a:GetUserUID() end
      -- DECOMPILER ERROR: 3 unprocessed JMP targets
    end
  end
)
end

FriendDataCenter.UpadteFrendList = function(self, dataDic, isDelete)
  -- function num : 0_4 , upvalues : _ENV, UserInfoData
  for uid,avatarMsg in pairs(dataDic) do
    if not isDelete then
      local friendData = (UserInfoData.CreateFriendDataWithAvatarMsg)(avatarMsg)
      ;
      (table.insert)(self.friendList, friendData)
      -- DECOMPILER ERROR at PC17: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (self.friendDic)[friendData:GetUserUID()] = friendData
      do
        do
          if (self.friendApplyDic)[uid] ~= nil then
            local friendData = (self.friendApplyDic)[uid]
            ;
            (table.removebyvalue)(self.friendApplicationList, friendData)
            -- DECOMPILER ERROR at PC30: Confused about usage of register: R10 in 'UnsetPending'

            ;
            (self.friendApplyDic)[uid] = nil
            self:UpdateFriendApplyReddotNum()
          end
          self:SortFriendList()
          -- DECOMPILER ERROR at PC37: Confused about usage of register: R8 in 'UnsetPending'

          ;
          (self.friendDic)[uid] = nil
          for index,friendData in ipairs(self.friendList) do
            if friendData:GetUserUID() == uid then
              (table.remove)(self.friendList, index)
              break
            end
          end
          do
            -- DECOMPILER ERROR at PC54: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC54: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC54: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC54: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
  self:RefreshFriendUI()
  MsgCenter:Broadcast(eMsgEventId.OnUserFriendListChange)
end

FriendDataCenter.UpdateFriendBlackList = function(self, dataDic, isDelete)
  -- function num : 0_5 , upvalues : _ENV, UserInfoData
  for uid,avatarMsg in pairs(dataDic) do
    if not isDelete then
      local friendData = (UserInfoData.CreateFriendDataWithAvatarMsg)(avatarMsg)
      ;
      (table.insert)(self.balckList, friendData)
    else
      do
        for index,friendData in ipairs(self.balckList) do
          if friendData:GetUserUID() == uid then
            (table.remove)(self.balckList, index)
            break
          end
        end
        do
          -- DECOMPILER ERROR at PC31: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC31: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC31: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  self:RefreshFriendUI()
end

FriendDataCenter.OnGetNewApplyNotice = function(self, msg)
  -- function num : 0_6 , upvalues : _ENV, UserInfoData
  local isReceiveApp = (PersistentManager:GetDataModel((PersistentConfig.ePackage).UserData)):ReadIsReceiveFriendApplication()
  if msg ~= nil then
    if isReceiveApp then
      if msg.applyAvatar == nil or ((msg.applyAvatar).biref).uid == nil then
        return 
      end
      local friendData = (self.friendApplyDic)[((msg.applyAvatar).biref).uid]
      if friendData == nil then
        friendData = (UserInfoData.CreateStrangerDataWithAvatarMsg)(msg.applyAvatar)
        ;
        (table.insert)(self.friendApplicationList, 1, friendData)
        -- DECOMPILER ERROR at PC41: Confused about usage of register: R4 in 'UnsetPending'

        ;
        (self.friendApplyDic)[friendData:GetUserUID()] = friendData
        if (ConfigData.game_config).friendApplicationListLimitNum < #self.friendApplicationList then
          local removeFriendData = (table.remove)(self.friendApplicationList, 1)
          -- DECOMPILER ERROR at PC57: Confused about usage of register: R5 in 'UnsetPending'

          ;
          (self.friendApplyDic)[removeFriendData:GetUserUID()] = nil
        end
      end
      do
        do
          friendData:SetApplyTimestamp(msg.ts)
          self:UpdateFriendApplyReddotNum()
          self:RefreshFriendUI()
          if msg.applyAvatar == nil or ((msg.applyAvatar).biref).uid == nil then
            return 
          end
          if self.friendNetworkCtrl == nil then
            self.friendNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Friend)
          end
          ;
          (self.friendNetworkCtrl):CS_FRIEND_IgnoreApply(((msg.applyAvatar).biref).uid)
        end
      end
    end
  end
end

FriendDataCenter.UpdateHeroListData = function(self, dataDic)
  -- function num : 0_7 , upvalues : _ENV
  for uid,avatarMsg in pairs(dataDic) do
    local friendData = (self.friendDic)[uid]
    friendData:UpdateByAvatarMsg(avatarMsg)
  end
  self:SortFriendList()
  self:RefreshFriendUI()
  self.__lastFriendDataUpdateTm = PlayerDataCenter.timestamp
  MsgCenter:Broadcast(eMsgEventId.OnUserFriendListChange)
end

FriendDataCenter.DeleteApplyNotice = function(self, uid)
  -- function num : 0_8 , upvalues : _ENV
  local friendData = (self.friendApplyDic)[uid]
  if friendData ~= nil then
    (table.removebyvalue)(self.friendApplicationList, friendData)
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self.friendApplyDic)[uid] = nil
    self:UpdateFriendApplyReddotNum()
    self:RefreshFriendUI()
  end
end

FriendDataCenter.GetFreindList = function(self)
  -- function num : 0_9
  return self.friendList
end

FriendDataCenter.GetFreindNum = function(self)
  -- function num : 0_10
  return #self.friendList
end

FriendDataCenter.GetFriendApplicationList = function(self)
  -- function num : 0_11 , upvalues : _ENV
  for uid,friendData in pairs(self.friendApplyDic) do
    if friendData:GetIsApplicationTimeOut() then
      (table.removebyvalue)(self.friendApplicationList, friendData)
      -- DECOMPILER ERROR at PC14: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (self.friendApplyDic)[uid] = nil
    end
  end
  self:UpdateFriendApplyReddotNum()
  return self.friendApplicationList
end

FriendDataCenter.TryGetFriendData = function(self, uid)
  -- function num : 0_12
  if self.friendDic == nil then
    return nil
  end
  return (self.friendDic)[uid]
end

FriendDataCenter.TryGetFriendApplyData = function(self, uid)
  -- function num : 0_13
  return (self.friendApplyDic)[uid]
end

FriendDataCenter.GetIsFriendFull = function(self)
  -- function num : 0_14 , upvalues : _ENV
  do return (ConfigData.game_config).friendListLimitNum <= self:GetFreindNum() end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

FriendDataCenter.GetLastFriendDataUpdateTm = function(self)
  -- function num : 0_15
  return self.__lastFriendDataUpdateTm
end

FriendDataCenter.RefreshFriendUI = function(self)
  -- function num : 0_16 , upvalues : _ENV
  local friendWin = UIManager:GetWindow(UIWindowTypeID.UserFreined)
  if friendWin ~= nil then
    friendWin:OnFriendListRefresh()
  end
end

FriendDataCenter.UpdateFriendUI = function(self)
  -- function num : 0_17 , upvalues : _ENV
  local friendWin = UIManager:GetWindow(UIWindowTypeID.UserFreined)
  if friendWin ~= nil then
    friendWin:UpdateHeroList()
  end
end

FriendDataCenter.RefreshFriendApplyReddotNum = function(self)
  -- function num : 0_18 , upvalues : _ENV
  for uid,friendData in pairs(self.friendApplyDic) do
    if friendData:GetIsApplicationTimeOut() then
      (table.removebyvalue)(self.friendApplicationList, friendData)
      -- DECOMPILER ERROR at PC14: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (self.friendApplyDic)[uid] = nil
    end
  end
  self:UpdateFriendApplyReddotNum()
end

FriendDataCenter.UpdateFriendApplyReddotNum = function(self)
  -- function num : 0_19 , upvalues : _ENV
  local ok, applyNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.UserFriend, RedDotStaticTypeId.UserFriendApplyPath)
  if ok then
    applyNode:SetRedDotCount(#self.friendApplicationList)
  end
end

FriendDataCenter.Delete = function(self)
  -- function num : 0_20
end

return FriendDataCenter

