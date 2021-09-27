local UIUserFriend = class("UIUserFriend", UIBaseWindow)
local base = UIBaseWindow
local cs_MessageCommon = CS.MessageCommon
local cs_ResLoader = CS.ResLoader
local UINUserFrienItem = require("Game.Friend.UI.UINUserFrienItem")
local UINUserInfoNode = require("Game.User.UINUserInfoNode")
local UINUserFriendOperateBar = require("Game.Friend.UI.UINUserFriendOperateBar")
local eFriendEnum = require("Game.Friend.eFriendEnum")
local eFriendUIState = eFriendEnum.eFriendUIState
UIUserFriend.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, cs_ResLoader, UINUserInfoNode, UINUserFriendOperateBar, UINUserFrienItem
  self.friendNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Friend)
  self.resLoader = (cs_ResLoader.Create)()
  self.eFriendUIState = nil
  self.userInfoNode = (UINUserInfoNode.New)()
  ;
  (self.userInfoNode):Init((self.ui).uINUserInfoNode)
  self.operateBar = (UINUserFriendOperateBar.New)(self.friendNetworkCtrl)
  ;
  (self.operateBar):Init((self.ui).operateBar)
  ;
  (UIUtil.SetTopStatus)(self, self.OnUserInfoReturnClick)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).tog_Friend, self, self.OnFriendTogChange)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).tog_Recommend, self, self.OnFriendApplicationTogChange)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_findeUID, self, self.OnClickSearch)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_CopyUID, self, self.OnClickCopyUID)
  self.__OnClickFriendItem = BindCallback(self, self.OnClickFriendItem)
  self.friendItemPool = (UIItemPool.New)(UINUserFrienItem, (self.ui).friendItem)
  ;
  ((self.ui).friendItem):SetActive(false)
  ;
  ((self.ui).img_OnSelect):SetActive(false)
end

UIUserFriend.InitUserFriend = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self.friendDataCenter = PlayerDataCenter.friendDataCenter
  self:TryUpdateAllFriendData()
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tog_Friend).isOn = true
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tex_UserUid).text = (PlayerDataCenter.inforData):GetUserUID()
  self:__AddRedDot2Listerner()
end

UIUserFriend.OnFriendTogChange = function(self, bool, selectUID)
  -- function num : 0_2 , upvalues : _ENV, eFriendUIState
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  if bool then
    ((self.ui).img_tog_Friend).color = (self.ui).color_gray
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).text_tog_friend).color = Color.black
    self.eFriendUIState = eFriendUIState.friendList
    self:RefreshFriendList((self.friendDataCenter):GetFreindList(), selectUID)
  else
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).img_tog_Friend).color = (self.ui).color_black
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).text_tog_friend).color = Color.white
  end
end

UIUserFriend.OnFriendApplicationTogChange = function(self, bool)
  -- function num : 0_3 , upvalues : _ENV, eFriendUIState
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  if bool then
    ((self.ui).img_tog_Recommend).color = (self.ui).color_gray
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).text_tog_Recommend).color = Color.black
    self.eFriendUIState = eFriendUIState.friendApplication
    self:RefreshFriendList((self.friendDataCenter):GetFriendApplicationList())
  else
    -- DECOMPILER ERROR at PC24: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).img_tog_Recommend).color = (self.ui).color_black
    -- DECOMPILER ERROR at PC29: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).text_tog_Recommend).color = Color.white
  end
end

UIUserFriend.RefreshFriendList = function(self, list, selectUID)
  -- function num : 0_4 , upvalues : _ENV, eFriendUIState
  (self.friendItemPool):HideAll()
  ;
  ((self.ui).img_OnSelect):SetActive(false)
  local listNum = nil
  if list == nil then
    listNum = 0
  else
    listNum = #list
  end
  ;
  ((self.ui).tex_limitCount):SetIndex(0, tostring((self.friendDataCenter):GetFreindNum()), tostring((ConfigData.game_config).friendListLimitNum))
  if listNum <= 0 then
    ((self.ui).friendList_empty):SetActive(true)
    ;
    ((self.ui).friendInfo_empty):SetActive(true)
    ;
    (self.userInfoNode):Hide()
    ;
    (self.operateBar):Hide()
    if self.eFriendUIState == eFriendUIState.friendList then
      (((self.ui).emptyText).gameObject):SetActive(true)
      ;
      ((self.ui).emptyText):SetIndex(0)
    else
      if self.eFriendUIState == eFriendUIState.friendApplication then
        (((self.ui).emptyText).gameObject):SetActive(true)
        ;
        ((self.ui).emptyText):SetIndex(1)
      else
        ;
        (((self.ui).emptyText).gameObject):SetActive(false)
      end
    end
    return 
  else
    ;
    ((self.ui).friendList_empty):SetActive(false)
    ;
    ((self.ui).friendInfo_empty):SetActive(false)
    ;
    (self.userInfoNode):Show()
    ;
    (self.operateBar):Show()
  end
  for index,friendData in ipairs(list) do
    local item = (self.friendItemPool):GetOne()
    item:InitWithFriendData(friendData, self.__OnClickFriendItem, self.resLoader)
    -- DECOMPILER ERROR at PC121: Unhandled construct in 'MakeBoolean' P1

    if selectUID == nil and index == 1 then
      self:OnClickFriendItem(item)
    end
    if selectUID == friendData:GetUserUID() then
      self:OnClickFriendItem(item)
    end
  end
end

UIUserFriend.OnClickFriendItem = function(self, item)
  -- function num : 0_5 , upvalues : _ENV
  (((self.ui).img_OnSelect).transform):SetParent(item.transform)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((self.ui).img_OnSelect).transform).localPosition = Vector3.zero
  ;
  ((self.ui).img_OnSelect):SetActive(true)
  PlayerDataCenter:GetUserInfoByUID((item.friendData):GetUserUID(), function(userInfoData)
    -- function num : 0_5_0 , upvalues : item, self
    item:FrienItemRefreshUI()
    ;
    (self.userInfoNode):RefershInfoNode(userInfoData, nil, self.resLoader, false)
    ;
    (self.operateBar):RefreshFriendBar(self.eFriendUIState, userInfoData)
  end
)
end

UIUserFriend.OnClickSearch = function(self, searchUID)
  -- function num : 0_6 , upvalues : _ENV, cs_MessageCommon, eFriendUIState
  if not searchUID then
    local inputUID = tonumber(((self.ui).iF_FindUID).text)
    if inputUID == nil or not (string.isNumber)(inputUID) then
      (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.Friend_SearchFail))
      return 
    end
    local curFriend = (self.friendDataCenter):TryGetFriendData(inputUID)
    -- DECOMPILER ERROR at PC31: Confused about usage of register: R4 in 'UnsetPending'

    if curFriend ~= nil then
      ((self.ui).tog_Friend).isOn = true
      -- DECOMPILER ERROR at PC34: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((self.ui).tog_Recommend).isOn = false
      self:OnFriendTogChange(true, inputUID)
      self:OnFriendApplicationTogChange(false)
      return 
    end
    do
      if inputUID == (PlayerDataCenter.inforData):GetUserUID() then
        local list = {PlayerDataCenter.inforData}
        -- DECOMPILER ERROR at PC55: Confused about usage of register: R5 in 'UnsetPending'

        ;
        ((self.ui).tog_Friend).isOn = false
        -- DECOMPILER ERROR at PC58: Confused about usage of register: R5 in 'UnsetPending'

        ;
        ((self.ui).tog_Recommend).isOn = false
        self:OnFriendTogChange(false)
        self:OnFriendApplicationTogChange(false)
        self.eFriendUIState = eFriendUIState.searchSelf
        self:RefreshFriendList(list)
        return 
      end
      PlayerDataCenter:GetUserInfoByUID(inputUID, function(userInfoData)
    -- function num : 0_6_0 , upvalues : self, inputUID, cs_MessageCommon, _ENV, eFriendUIState
    self.__serchingUserId = inputUID
    if userInfoData == nil then
      (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Friend_SearchFail))
      return 
    end
    local list = {userInfoData}
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).tog_Friend).isOn = false
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).tog_Recommend).isOn = false
    self:OnFriendTogChange(false)
    self:OnFriendApplicationTogChange(false)
    self.eFriendUIState = eFriendUIState.searchResult
    self:RefreshFriendList(list)
  end
)
    end
  end
end

UIUserFriend.OnClickCopyUID = function(self)
  -- function num : 0_7 , upvalues : _ENV
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  ((CS.UnityEngine).GUIUtility).systemCopyBuffer = (PlayerDataCenter.inforData):GetUserUID()
  ;
  ((CS.MessageCommon).ShowMessageTips)(ConfigData:GetTipContent(TipContent.UserInfo_CopyUIDDone))
  AudioManager:PlayAudioById(1124)
end

UIUserFriend.OnFriendListRefresh = function(self)
  -- function num : 0_8 , upvalues : eFriendUIState
  if self.eFriendUIState == eFriendUIState.friendList then
    self:RefreshFriendList((self.friendDataCenter):GetFreindList())
  else
    if self.eFriendUIState == eFriendUIState.friendApplication then
      self:RefreshFriendList((self.friendDataCenter):GetFriendApplicationList())
    else
      if self.eFriendUIState == eFriendUIState.searchResult and (self.friendDataCenter):TryGetFriendData(self.__serchingUserId) ~= nil then
        self:OnClickSearch(self.__serchingUserId)
      end
    end
  end
end

UIUserFriend.TryUpdateAllFriendData = function(self)
  -- function num : 0_9 , upvalues : _ENV
  local lastUpdateTm = (self.friendDataCenter):GetLastFriendDataUpdateTm()
  if lastUpdateTm == nil or (ConfigData.game_config).userInfoRefreshTime < PlayerDataCenter.timestamp - lastUpdateTm then
    (self.friendNetworkCtrl):CS_FRIEND_RefreshFriend()
  end
end

UIUserFriend.UpdateHeroList = function(self)
  -- function num : 0_10 , upvalues : eFriendUIState, _ENV
  if self.eFriendUIState == eFriendUIState.friendList then
    for _,item in pairs((self.friendItemPool).listItem) do
      item:FrienItemRefreshUI()
    end
    ;
    (self.userInfoNode):UpdateInfoNode()
  end
end

UIUserFriend.OnBlackListRefresh = function(self)
  -- function num : 0_11 , upvalues : eFriendUIState, _ENV
  if self.eFriendUIState == eFriendUIState.blacklist then
    error("目前没有黑名单的UI呢")
  end
end

UIUserFriend.__AddRedDot2Listerner = function(self)
  -- function num : 0_12 , upvalues : _ENV
  local ok, applyNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.UserFriend, RedDotStaticTypeId.UserFriendApplyPath)
  if applyNode:GetRedDotCount() <= 0 then
    ((self.ui).obj_redDotApply):SetActive(not ok)
    self.__RefreshRedDot = function(node)
    -- function num : 0_12_0 , upvalues : self
    ((self.ui).obj_redDotApply):SetActive(node:GetRedDotCount() > 0)
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end

    RedDotController:AddListener(applyNode.nodePath, self.__RefreshRedDot)
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

UIUserFriend.OnUserInfoReturnClick = function(self)
  -- function num : 0_13
  self:OnCloseWin()
  self:Delete()
end

UIUserFriend.OnDelete = function(self)
  -- function num : 0_14 , upvalues : _ENV, base
  if self.resLoader ~= nil then
    (self.resLoader):Put2Pool()
    self.resLoader = nil
  end
  ;
  (self.userInfoNode):Delete()
  ;
  (self.operateBar):Delete()
  local ok, applyNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.UserFriend, RedDotStaticTypeId.UserFriendApplyPath)
  if ok then
    RedDotController:RemoveListener(applyNode.nodePath, self.__RefreshRedDot)
  end
  ;
  (base.OnDelete)(self)
end

return UIUserFriend

