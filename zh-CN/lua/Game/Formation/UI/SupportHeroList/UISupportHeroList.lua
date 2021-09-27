local UISupportHeroList = class("UISupportHeroList", UIBaseWindow)
local base = UIBaseWindow
local CS_ResLoader = CS.ResLoader
local UserInfoData = require("Game.User.UserInfoData")
local FriendSupportHeroData = require("Game.Formation.Data.FriendSupportHeroData")
local UINSupportHeroItem = require("Game.Formation.UI.SupportHeroList.UINSupportHeroItem")
local UINSupportPageBtn = require("Game.Formation.UI.SupportHeroList.UINSupportPageBtn")
UISupportHeroList.OnInit = function(self)
  -- function num : 0_0 , upvalues : CS_ResLoader, _ENV, UINSupportPageBtn
  self.resloader = (CS_ResLoader.Create)()
  self.friendDataCenter = PlayerDataCenter.friendDataCenter
  self.objNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Object)
  self.fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation)
  self.nextFreshTm = nil
  self.userInfoDic = {}
  self.supporHeroList = {}
  self.allSupportHeroDataDic = {}
  self.itemDic = {}
  self.friendsBanData = nil
  self.typeBtnPool = (UIItemPool.New)(UINSupportPageBtn, (self.ui).btn_Page_pre)
  ;
  ((self.ui).btn_Page_pre):SetActive(false)
  -- DECOMPILER ERROR at PC46: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).loopscroll).onInstantiateItem = BindCallback(self, self.__OnNewItem)
  -- DECOMPILER ERROR at PC53: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).loopscroll).onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.__OnClickUseCard = BindCallback(self, self.OnClickUseCard)
  self.__OnClickTypeBtn = BindCallback(self, self.OnClickTypeBtn)
  ;
  (UIUtil.SetTopStatus)(self, self.Delete)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).tog_JustShowFriend, self, self.OnOnlyShowFriendValueChange)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_RefreshList, self, self.OnClickRefreshBtn)
  self._OnFriendListChange = BindCallback(self, self.OnClickRefreshBtn)
  MsgCenter:AddListener(eMsgEventId.OnUserFriendListChange, self._OnFriendListChange)
end

UISupportHeroList.InitSelectSupportHeroList = function(self, selectCallback, defaultSelectedIndex, fomationData, isRefresh)
  -- function num : 0_1 , upvalues : _ENV, UserInfoData, FriendSupportHeroData
  self.selectCallback = selectCallback
  self.fomationData = fomationData
  self.normalHeroDic = {}
  for index,heroId in pairs((self.fomationData):GetFormationHeroList(true)) do
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R10 in 'UnsetPending'

    (self.normalHeroDic)[heroId] = true
  end
  local fixCfg = ((PlayerDataCenter.supportHeroData):GetCurFormationLevelEffectByAllHero(PlayerDataCenter.heroDic))
  local defaultTypeBtnItem = nil
  if not defaultSelectedIndex then
    defaultSelectedIndex = 0
  end
  ;
  (self.typeBtnPool):HideAll()
  for index = 0, (ConfigData.game_config).heroMaxCareer do
    local typeBtnItem = (self.typeBtnPool):GetOne()
    typeBtnItem:InitSupportPageBtn(index, self.__OnClickTypeBtn)
    if index == defaultSelectedIndex then
      defaultTypeBtnItem = typeBtnItem
    end
  end
  local afterReceiveSupportMsg = function()
    -- function num : 0_1_0 , upvalues : defaultTypeBtnItem, self, _ENV
    if defaultTypeBtnItem ~= nil then
      self._notClickTog = true
      defaultTypeBtnItem:OnClickSupportPageBtn()
      self._notClickTog = false
    end
    self:RefreshRefreshBtn()
    if self.tiemerId ~= nil then
      TimerManager:StopTimer(self.tiemerId)
      self.tiemerId = nil
    end
    self.tiemerId = TimerManager:StartTimer(1, self.RefreshRefreshBtn, self, false, false, true)
  end

  local oldSupportHeroDic, nextRefreshTm, friendsBanData, userInfoDic = (self.fmtCtrl):GetStrangerSupportHeroDic()
  if oldSupportHeroDic == nil or isRefresh then
    (self.objNetworkCtrl):CS_ASSISTANT_FetchStranger(function(args)
    -- function num : 0_1_1 , upvalues : self, _ENV, UserInfoData, FriendSupportHeroData, fixCfg, afterReceiveSupportMsg
    self.allSupportHeroDataDic = {}
    local fetchStrangerMsg = nil
    if args ~= nil and args.Count > 0 then
      fetchStrangerMsg = args[0]
    else
      return 
    end
    for userUID,avatarMsg in pairs(fetchStrangerMsg.avatar) do
      local userInfoData = (UserInfoData.CreateStrangerDataWithAvatarMsg)(avatarMsg)
      -- DECOMPILER ERROR at PC19: Confused about usage of register: R8 in 'UnsetPending'

      ;
      (self.userInfoDic)[userUID] = userInfoData
      for _,value in pairs(userInfoData:GetSupportHoreInfoList()) do
        -- DECOMPILER ERROR at PC37: Confused about usage of register: R13 in 'UnsetPending'

        if value ~= false and (value.assistsBrief).id ~= 0 then
          if (self.allSupportHeroDataDic)[userUID] == nil then
            (self.allSupportHeroDataDic)[userUID] = {}
          end
          local supportHeroData = (FriendSupportHeroData.GenSupportHeroData)(userInfoData, (value.assistsBrief).id, fixCfg)
          -- DECOMPILER ERROR at PC48: Confused about usage of register: R14 in 'UnsetPending'

          ;
          ((self.allSupportHeroDataDic)[userUID])[(value.assistsBrief).id] = supportHeroData
        end
      end
    end
    for _,userInfoData in pairs((self.friendDataCenter):GetFreindList()) do
      local userUID = userInfoData:GetUserUID()
      -- DECOMPILER ERROR at PC67: Confused about usage of register: R8 in 'UnsetPending'

      if (self.allSupportHeroDataDic)[userUID] == nil then
        (self.allSupportHeroDataDic)[userUID] = {}
      end
      for _,value in pairs(userInfoData:GetSupportHoreInfoList()) do
        if value ~= false and (value.assistsBrief).id ~= 0 then
          local supportHeroData = (FriendSupportHeroData.GenSupportHeroData)(userInfoData, (value.assistsBrief).id, fixCfg)
          -- DECOMPILER ERROR at PC89: Confused about usage of register: R14 in 'UnsetPending'

          ;
          ((self.allSupportHeroDataDic)[userUID])[(value.assistsBrief).id] = supportHeroData
        end
      end
    end
    self.friendsBanData = fetchStrangerMsg.friendsBan
    self.nextFreshTm = fetchStrangerMsg.nextFreshTm
    ;
    (self.fmtCtrl):CacheStrangerSupportHeroDic(self.allSupportHeroDataDic, self.nextFreshTm, self.friendsBanData, self.userInfoDic)
    afterReceiveSupportMsg()
  end
)
  else
    for _,supportHeroDatas in pairs(oldSupportHeroDic) do
      for key,supportHeroData in pairs(supportHeroDatas) do
        supportHeroData:UseFixCfg2ChangeSupportorAttr(fixCfg)
      end
    end
    self.friendsBanData = friendsBanData
    self.allSupportHeroDataDic = oldSupportHeroDic
    self.nextFreshTm = nextRefreshTm
    self.userInfoDic = userInfoDic
    for UID,userInfoData in pairs(self.userInfoDic) do
      -- DECOMPILER ERROR at PC88: Confused about usage of register: R17 in 'UnsetPending'

      if (self.friendDataCenter):TryGetFriendData(UID) ~= nil then
        (self.userInfoDic)[UID] = nil
      end
    end
    for _,userInfoData in pairs((self.friendDataCenter):GetFreindList()) do
      local userUID = userInfoData:GetUserUID()
      -- DECOMPILER ERROR at PC101: Confused about usage of register: R18 in 'UnsetPending'

      ;
      (self.allSupportHeroDataDic)[userUID] = {}
      for _,value in pairs(userInfoData:GetSupportHoreInfoList()) do
        if value ~= false and (value.assistsBrief).id ~= 0 then
          local supportHeroData = (FriendSupportHeroData.GenSupportHeroData)(userInfoData, (value.assistsBrief).id, fixCfg)
          -- DECOMPILER ERROR at PC123: Confused about usage of register: R24 in 'UnsetPending'

          ;
          ((self.allSupportHeroDataDic)[userUID])[(value.assistsBrief).id] = supportHeroData
        end
      end
    end
    afterReceiveSupportMsg()
  end
  self:RfreshSupportTimeLimit()
end

UISupportHeroList.RefreshLoopList = function(self, selectCareer)
  -- function num : 0_2 , upvalues : _ENV
  self.supporHeroList = {}
  local expireIgnore = false
  local expiredHeroDic = {}
  if (self.friendsBanData).expiredTm or self.friendsBanData == nil or 0 < PlayerDataCenter.timestamp then
    expireIgnore = true
  end
  if not expireIgnore then
    local len = (table.length)((self.friendsBanData).banFriends)
    for index,friendUID in pairs((self.friendsBanData).banFriends) do
      if friendUID ~= 0 then
        expiredHeroDic[friendUID] = {nextUseTurn = (ConfigData.game_config).supportFriendCDTurn - len + index}
      end
    end
  end
  do
    local couldUseDic = {}
    if not self.__isOnlyShowFriend then
      local MAX_RANDOM_FRIEND_NUM = (ConfigData.game_config).supportLisrMaxRandomNum
      local couldUseList = {}
      for userUID,friendList in pairs(self.allSupportHeroDataDic) do
        local userInfoData = (self.friendDataCenter):TryGetFriendData(userUID)
        if userInfoData ~= nil and expiredHeroDic[userUID] == nil then
          (table.insert)(couldUseList, userUID)
        end
      end
      if MAX_RANDOM_FRIEND_NUM < #couldUseList then
        (math.randomseed)(PlayerDataCenter.timestamp)
        while MAX_RANDOM_FRIEND_NUM < #couldUseList do
          local removeRandom = (math.random)(#couldUseList)
          ;
          (table.remove)(couldUseList, removeRandom)
        end
      end
      do
        for index,userUID in ipairs(couldUseList) do
          couldUseDic[userUID] = true
        end
        do
          for userUID,friendList in pairs(self.allSupportHeroDataDic) do
            if self.__isOnlyShowFriend or (self.userInfoDic)[userUID] ~= nil or couldUseDic[userUID] then
              for briefId,supportHeroData in pairs(R11_PC113) do
                if expiredHeroDic[userUID] ~= nil then
                  supportHeroData.expiredSupport = expiredHeroDic[userUID]
                else
                  supportHeroData.expiredSupport = nil
                end
                if (selectCareer == nil or supportHeroData.career == selectCareer) and (not self.__isOnlyShowFriend or (supportHeroData:GetUserInfo()):GetIsFriend()) then
                  (table.insert)(self.supporHeroList, {userUID = userUID, briefId = briefId})
                end
              end
            end
          end
          ;
          (table.sort)(self.supporHeroList, function(a, b)
    -- function num : 0_2_0 , upvalues : self
    local supportHeroDataA = ((self.allSupportHeroDataDic)[a.userUID])[a.briefId]
    local supportHeroDataB = ((self.allSupportHeroDataDic)[b.userUID])[b.briefId]
    local isExpiredSupportA = supportHeroDataA.expiredSupport ~= nil
    local isExpiredSupportB = supportHeroDataB.expiredSupport ~= nil
    if isExpiredSupportA ~= isExpiredSupportB then
      return not isExpiredSupportA
    end
    if supportHeroDataB.star >= supportHeroDataA.star then
      do return supportHeroDataA.star == supportHeroDataB.star end
      if supportHeroDataB:GetSupporterPow() >= supportHeroDataA:GetSupporterPow() then
        do return supportHeroDataA:GetSupporterPow() == supportHeroDataB:GetSupporterPow() end
        if supportHeroDataB.dataId >= supportHeroDataA.dataId then
          do return supportHeroDataA.dataId == supportHeroDataB.dataId end
          do return (supportHeroDataB:GetUserInfo()):GetUserUID() < (supportHeroDataA:GetUserInfo()):GetUserUID() end
          -- DECOMPILER ERROR: 11 unprocessed JMP targets
        end
      end
    end
  end
)
          ;
          ((self.ui).obj_emptyList):SetActive(#self.supporHeroList == 0)
          -- DECOMPILER ERROR at PC166: Confused about usage of register: R5 in 'UnsetPending'

          ;
          ((self.ui).loopscroll).totalCount = #self.supporHeroList
          ;
          ((self.ui).loopscroll):RefillCells()
          -- DECOMPILER ERROR: 1 unprocessed JMP targets
        end
      end
    end
  end
end

UISupportHeroList.__OnNewItem = function(self, go)
  -- function num : 0_3 , upvalues : UINSupportHeroItem
  local heroCardItem = (UINSupportHeroItem.New)()
  heroCardItem:Init(go)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.itemDic)[go] = heroCardItem
end

UISupportHeroList.__OnChangeItem = function(self, go, index)
  -- function num : 0_4 , upvalues : _ENV
  local heroCardItem = (self.itemDic)[go]
  if heroCardItem == nil then
    error("Can\'t find heroCardItem by gameObject")
    return 
  end
  local idTable = (self.supporHeroList)[index + 1]
  if idTable == nil then
    error("Can\'t find idTable by index, index = " .. tonumber(index))
    return 
  end
  local supportHeroData = ((self.allSupportHeroDataDic)[idTable.userUID])[idTable.briefId]
  heroCardItem:InitSupportHeroCard(supportHeroData, self.__OnClickUseCard, self.resloader, self.normalHeroDic)
end

UISupportHeroList.OnClickTypeBtn = function(self, index)
  -- function num : 0_5 , upvalues : _ENV
  if index == 0 then
    self:RefreshLoopList()
    self.selectCareer = nil
  else
    self:RefreshLoopList(index)
    self.selectCareer = index
  end
  if not self._notClickTog then
    if index == 0 then
      AudioManager:PlayAudioById(4100)
    else
      local careerCfg = (ConfigData.career)[index]
      AudioManager:PlayAudioById(careerCfg.click_audio)
    end
  end
  do
    for _,typeBtnItem in pairs((self.typeBtnPool).listItem) do
      typeBtnItem:SetSelectState(typeBtnItem.index == index)
    end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

UISupportHeroList.OnOnlyShowFriendValueChange = function(self, value)
  -- function num : 0_6
  self.__isOnlyShowFriend = value
  if value then
    ((self.ui).img_Select):SetIndex(1)
  else
    ;
    ((self.ui).img_Select):SetIndex(0)
  end
  self:RefreshLoopList(self.selectCareer)
end

UISupportHeroList.RefreshRefreshBtn = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local leftRefreshTime = (math.floor)(self.nextFreshTm - PlayerDataCenter.timestamp)
  if leftRefreshTime > 0 then
    ((self.ui).tex_nextRefreshTime):SetIndex(1, tostring(leftRefreshTime))
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).btn_RefreshList).interactable = false
  else
    ;
    ((self.ui).tex_nextRefreshTime):SetIndex(0)
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).btn_RefreshList).interactable = true
  end
end

UISupportHeroList.OnClickRefreshBtn = function(self)
  -- function num : 0_8
  self:InitSelectSupportHeroList(self.selectCallback, self.selectCareer, self.fomationData, true)
end

UISupportHeroList.OnClickUseCard = function(self, cardItem)
  -- function num : 0_9 , upvalues : _ENV
  if self.selectCallback ~= nil then
    (self.selectCallback)(cardItem.friednSupportHeroData)
  end
  ;
  (UIUtil.OnClickBack)()
end

UISupportHeroList.RfreshSupportTimeLimit = function(self)
  -- function num : 0_10 , upvalues : _ENV
  self.isNeedLimitSupportTime = (ControllerManager:GetController(ControllerTypeId.Formation, false)).isFriendSupportHaveTimeLimit
  ;
  ((self.ui).obj_residue):SetActive(self.isNeedLimitSupportTime)
  if not self.isNeedLimitSupportTime then
    return 
  end
  local counterElem = (ControllerManager:GetController(ControllerTypeId.TimePass)):getCounterElemData(proto_object_CounterModule.CounterMoudleSupportLimit, 0)
  local usedTimes = 0
  if counterElem ~= nil and PlayerDataCenter.timestamp < counterElem.nextExpiredTm then
    usedTimes = counterElem.times
  end
  -- DECOMPILER ERROR at PC44: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Residue).text = tostring((self.fmtCtrl):GetSupportTimeLimit() - usedTimes)
end

UISupportHeroList.OnDelete = function(self)
  -- function num : 0_11 , upvalues : _ENV, base
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
  if self.tiemerId ~= nil then
    TimerManager:StopTimer(self.tiemerId)
    self.tiemerId = nil
  end
  MsgCenter:RemoveListener(eMsgEventId.OnUserFriendListChange, self._OnFriendListChange)
  ;
  (base.OnDelete)(self)
end

return UISupportHeroList

