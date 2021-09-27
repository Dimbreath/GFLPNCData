local UIChatSystem = class("UIChatSystem", UIBaseWindow)
local base = UIBaseWindow
local emptyStr = ""
local HomeChatData = require("Game.Chat.HomeChatData")
local UINChatElement = require("Game.Chat.UI.UINChatElement")
local UINChatElementMyItem = require("Game.Chat.UI.UINChatElementMyItem")
local UINChatElementOtherItem = require("Game.Chat.UI.UINChatElementOtherItem")
UIChatSystem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINChatElementMyItem, UINChatElementOtherItem
  self.firstChatItem = nil
  self.latestChatItem = nil
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_background, self, self.Delete)
  self.myItemPool = (UIItemPool.New)(UINChatElementMyItem, (self.ui).obj_myItem)
  self.otherItemPool = (UIItemPool.New)(UINChatElementOtherItem, (self.ui).obj_guestItem)
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).loop_scroll).onInstantiateItem = BindCallback(self, self.m_OnNewItem)
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).loop_scroll).onChangeItem = BindCallback(self, self.m_OnChangeItem)
  -- DECOMPILER ERROR at PC43: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).loop_scroll).onReturnItem = BindCallback(self, self.__OnReturnItem)
  ;
  (((self.ui).loop_scroll).onValueChanged):AddListener(BindCallback(self, self.__OnValueChanged))
  self.__RefreshSendCD = BindCallback(self, self.RefreshSendCD)
  self.__OnNewChatDataComes = BindCallback(self, self.OnNewChatDataComes)
  MsgCenter:AddListener(eMsgEventId.OnNewWordChatDataCome, self.__OnNewChatDataComes)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_HasNewChat, self, self.Roll2NewChart)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Return, self, self.Delete)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Send, self, self.__OnClickSend)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).tog_Emoji, self, self.__OnemojiTogValueChange)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).inputField, self, self.__OnInputValueChange)
end

UIChatSystem.InitChatSystem = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self.chatItemDic = {}
  self.homeChatDataCenter = PlayerDataCenter.homeChatDataCenter
  self.isNeedRefresh2New = true
  ;
  (self.homeChatDataCenter):AddOnSendCdChangeCallback(self.__RefreshSendCD)
  self:TryRecorverLastInput()
  self:OnNewChatDataComes(0)
  self:RefreshSendCD((self.homeChatDataCenter):GetSendCd())
end

UIChatSystem.TryRecorverLastInput = function(self)
  -- function num : 0_2
  local lastInput = (self.homeChatDataCenter):GetLastInputMsg()
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  if lastInput ~= nil then
    ((self.ui).inputField).text = lastInput
  end
end

UIChatSystem.OnNewChatDataComes = function(self, removeNum, roll2new)
  -- function num : 0_3 , upvalues : _ENV
  ((self.ui).noMessage):SetActive((self.homeChatDataCenter):GetCurDataCount() <= 0)
  local refillFromeStart = function()
    -- function num : 0_3_0 , upvalues : self
    self:BeforeRefreshClean()
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((self.ui).loop_scroll).totalCount = (self.homeChatDataCenter):GetCurDataCount()
    ;
    ((self.ui).loop_scroll):RefillCells()
    ;
    (((self.ui).btn_HasNewChat).gameObject):SetActive(true)
  end

  local refillFromeEnd = function()
    -- function num : 0_3_1 , upvalues : self
    self:BeforeRefreshClean()
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((self.ui).loop_scroll).totalCount = (self.homeChatDataCenter):GetCurDataCount()
    ;
    ((self.ui).loop_scroll):RefillCellsFromEnd()
    ;
    (((self.ui).btn_HasNewChat).gameObject):SetActive(false)
  end

  if ((self.ui).loop_scroll).totalCount == 0 then
    refillFromeEnd()
    ;
    (self.homeChatDataCenter):CleanNewChatNum()
    return 
  end
  if roll2new or self:IsChatItemVisiable(self.latestChatItem) then
    refillFromeEnd()
    ;
    (self.homeChatDataCenter):CleanNewChatNum()
  elseif removeNum > 0 and self:IsChatItemVisiable(self.firstChatItem) then
    refillFromeStart()
  else
    if removeNum > 0 then
      local startindex, endindex = ((self.ui).loop_scroll):SetOffest2Index(-removeNum)
      if startindex <= 0 then
        refillFromeStart()
      elseif ((self.ui).loop_scroll).totalCount <= endindex then
        refillFromeEnd()
        ;
        (self.homeChatDataCenter):CleanNewChatNum()
      else
        ((self.ui).loop_scroll):RefreshCells()
      end
    else
      -- DECOMPILER ERROR at PC80: Confused about usage of register: R5 in 'UnsetPending'

      ((self.ui).loop_scroll).totalCount = (self.homeChatDataCenter):GetCurDataCount()
      ;
      ((self.ui).loop_scroll):RefreshCells()
    end
    ;
    (((self.ui).btn_HasNewChat).gameObject):SetActive(true)
  end
  do
    if (((self.ui).btn_HasNewChat).gameObject).activeInHierarchy then
      local chatNum = (self.homeChatDataCenter):GetNewChatNum()
      if chatNum > 99 then
        chatNum = "99+"
      end
      ;
      ((self.ui).tex_NewChatCount):SetIndex(0, tostring(chatNum))
    end
    local homeWin = UIManager:GetWindow(UIWindowTypeID.Home)
    if homeWin ~= nil then
      (homeWin.homeLeftNode):RefreshWorldChatNewMessage(removeNum, true)
    end
    -- DECOMPILER ERROR: 13 unprocessed JMP targets
  end
end

UIChatSystem.m_OnNewItem = function(self, go)
  -- function num : 0_4 , upvalues : UINChatElement
  local chatItem = (UINChatElement.New)()
  chatItem:Init(go)
  chatItem:InitChatElement(self.myItemPool, self.otherItemPool)
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.chatItemDic)[go] = chatItem
end

UIChatSystem.m_OnChangeItem = function(self, go, index)
  -- function num : 0_5 , upvalues : _ENV
  local chatItem = (self.chatItemDic)[go]
  if chatItem == nil then
    error("Can\'t find chatItem by gameObject")
    return 
  end
  local chatData = (self.homeChatDataCenter):GetChatDataAtIndex(index + 1)
  if chatData == nil then
    error("Can\'t find chatData by index, index = " .. tonumber(index))
  end
  chatItem:RefreshChatItem(chatData, index)
  ;
  ((((CS.UnityEngine).UI).LayoutRebuilder).ForceRebuildLayoutImmediate)(((self.ui).loop_scroll).transform)
  if index == 0 then
    self.firstChatItem = chatItem
  end
  if index == ((self.ui).loop_scroll).totalCount - 1 then
    self.latestChatItem = chatItem
  end
end

UIChatSystem.__OnReturnItem = function(self, go)
  -- function num : 0_6 , upvalues : _ENV
  local chatItem = (self.chatItemDic)[go]
  if chatItem == nil then
    error("Can\'t find chatItem by gameObject")
    return 
  end
  chatItem:OnRecycle()
  if chatItem.indexInList == 0 then
    self.firstChatItem = nil
  end
  if chatItem.indexInList == ((self.ui).loop_scroll).totalCount - 1 then
    self.latestChatItem = nil
  end
end

UIChatSystem.__OnValueChanged = function(self, pos)
  -- function num : 0_7
  if (((self.ui).btn_HasNewChat).gameObject).activeInHierarchy and self:IsChatItemVisiable(self.latestChatItem) then
    (((self.ui).btn_HasNewChat).gameObject):SetActive(false)
  end
end

UIChatSystem.IsChatItemVisiable = function(self, chatItem)
  -- function num : 0_8
  if chatItem == nil then
    return false
  end
  return ((self.ui).loop_scroll):IsItemVisiable(chatItem.transform)
end

UIChatSystem.BeforeRefreshClean = function(self)
  -- function num : 0_9
  self.firstChatItem = nil
  self.latestChatItem = nil
end

UIChatSystem.Roll2NewChart = function(self)
  -- function num : 0_10
  self:OnNewChatDataComes(0, true)
end

UIChatSystem.__OnInputValueChange = function(self, value)
  -- function num : 0_11
  local _, str = (self.homeChatDataCenter):ValidInputChange(value)
  ;
  (self.homeChatDataCenter):SetLastInputMsg(str)
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).inputField).text = str
end

UIChatSystem.__OnemojiTogValueChange = function(self, isOpenSendemoji)
  -- function num : 0_12
  if isOpenSendemoji then
  end
end

UIChatSystem.__OnClickSend = function(self)
  -- function num : 0_13 , upvalues : _ENV, HomeChatData, emptyStr
  local sendString = ((self.ui).inputField).text
  if (self.homeChatDataCenter):ValidSendChat(sendString) then
    local couldSend = (self.homeChatDataCenter):ValidSendTime()
  end
  if couldSend then
    (PlayerDataCenter.homeChatDataCenter):AddNewChatData((HomeChatData.CreateChatData)(true, false, sendString, nil))
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).inputField).text = emptyStr
    ;
    (self.homeChatDataCenter):SetLastInputMsg(nil)
    self:RefreshSendCD((self.homeChatDataCenter):GetSendCd())
  end
end

UIChatSystem.RefreshSendCD = function(self, cd)
  -- function num : 0_14 , upvalues : _ENV
  if cd > 0 then
    ((self.ui).textInfo_SendBtn):SetIndex(1, tostring(cd))
  else
    ;
    ((self.ui).textInfo_SendBtn):SetIndex(0)
  end
end

UIChatSystem.OnDelete = function(self)
  -- function num : 0_15 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.OnNewWordChatDataCome, self.__OnNewChatDataComes)
  ;
  (self.homeChatDataCenter):RemoveOnSendCdChangeCallback(self.__RefreshSendCD)
  ;
  (base.OnDelete)(self)
end

return UIChatSystem

