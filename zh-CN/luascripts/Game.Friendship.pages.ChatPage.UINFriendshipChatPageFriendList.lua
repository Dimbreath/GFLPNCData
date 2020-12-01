-- params : ...
-- function num : 0 , upvalues : _ENV
local UINFriendshipChatPageFriendList = class("UINFriendshipChatPageFriendList", UIBaseNode)
local base = UIBaseNode
local UINFriendshipChatPageFriendItem = require("Game.Friendship.pages.ChatPage.UINFriendshipChatPageFriendItem")
local UINFriendshipSortKindItem = require("Game.Friendship.pages.ChatPage.UINFriendshipSortKindItem")
local SortFuncs = {defult = function(heroA, heroB)
  -- function num : 0_0
  do return (heroA.heroCfg).id < (heroB.heroCfg).id end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end
}
local getShiftFuncs = {camp = function(campId)
  -- function num : 0_1
  return function(heroData)
    -- function num : 0_1_0 , upvalues : campId
    do return (heroData.heroCfg).camp == campId end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end

end
}
UINFriendshipChatPageFriendList.OnInit = function(self)
  -- function num : 0_2 , upvalues : _ENV, UINFriendshipSortKindItem
  self.itemDic = {}
  self.curList = {}
  self.selectedHeroData = nil
  self.clickEvent = nil
  self.isSortPanelOpen = false
  self.shiftFuncList = {}
  self.resloader = nil
  self.selectHeroCallback = nil
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).scrollView_FriendList).onInstantiateItem = BindCallback(self, self.__InitItem)
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).scrollView_FriendList).onChangeItem = BindCallback(self, self.__OnItemChange)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Sort, self, self.OnClikSortBtn)
  self.appTogglePool = (UIItemPool.New)(UINFriendshipSortKindItem, (self.ui).obj_sortKindItem)
  ;
  ((self.ui).obj_sortKindItem):SetActive(false)
  self.__RefreshTotalLevel = BindCallback(self, self.RefreshTotalLevel)
  MsgCenter:AddListener(eMsgEventId.OnHeroFriendshipDataChange, self.__RefreshTotalLevel)
end

UINFriendshipChatPageFriendList.InitFriendList = function(self, resloader, selectHeroCallback)
  -- function num : 0_3 , upvalues : SortFuncs
  self.resloader = resloader
  self.selectHeroCallback = selectHeroCallback
  self:__InitOriginHeroList()
  self:RefrshChatList(nil, SortFuncs.defult, nil)
end

UINFriendshipChatPageFriendList.__InitOriginHeroList = function(self, slotId)
  -- function num : 0_4 , upvalues : _ENV
  self.origintChatListItemList = PlayerDataCenter.heroDic
end

UINFriendshipChatPageFriendList.OnClikSortBtn = function(self)
  -- function num : 0_5 , upvalues : _ENV, getShiftFuncs, SortFuncs
  self.isSortPanelOpen = not self.isSortPanelOpen
  ;
  ((self.ui).obj_sortConditionNode):SetActive(self.isSortPanelOpen)
  ;
  ((self.ui).tex_Type):SetIndex(0)
  ;
  (self.appTogglePool):HideAll()
  for _,campCfg in pairs(ConfigData.camp) do
    do
      local item = (self.appTogglePool):GetOne(true)
      item:InitSortItem((LanguageUtil.GetLocaleText)(campCfg.name), function(bool_useThisShift)
    -- function num : 0_5_0 , upvalues : self, campCfg, getShiftFuncs, _ENV, SortFuncs
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

    if bool_useThisShift then
      (self.shiftFuncList)[campCfg.name] = (getShiftFuncs.camp)(campCfg.id)
    else
      -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

      ;
      (self.shiftFuncList)[campCfg.name] = nil
    end
    local theShiftFunc = function(heroData)
      -- function num : 0_5_0_0 , upvalues : _ENV, self
      if (table.count)(self.shiftFuncList) == 0 then
        return true
      end
      for _,func in pairs(self.shiftFuncList) do
        if func(heroData) then
          return true
        end
      end
      return false
    end

    self:RefrshChatList(theShiftFunc, SortFuncs.defult, nil)
  end
)
    end
  end
end

UINFriendshipChatPageFriendList.RefrshChatList = function(self, funcSift, funcSort, customList)
  -- function num : 0_6 , upvalues : _ENV
  if not customList then
    local heroList = self.origintChatListItemList
  end
  local curSelectChatListItem = nil
  self.curList = {}
  for k,heroData in pairs(heroList) do
    if funcSift == nil then
      (table.insert)(self.curList, heroData)
    else
      if funcSift(heroData) then
        (table.insert)(self.curList, heroData)
      end
    end
    if heroData == self.selectedHeroData then
      curSelectChatListItem = heroData
    end
  end
  if funcSort ~= nil then
    (table.sort)(self.curList, funcSort)
  end
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).scrollView_FriendList).totalCount = #self.curList
  ;
  ((self.ui).scrollView_FriendList):RefillCells()
  self:__SetSelect(curSelectChatListItem)
  if curSelectChatListItem == nil then
    self:OnItemClicked((self.curList)[1])
  end
end

UINFriendshipChatPageFriendList.__InitItem = function(self, go)
  -- function num : 0_7 , upvalues : UINFriendshipChatPageFriendItem
  local chatListItem = (UINFriendshipChatPageFriendItem.New)()
  chatListItem:Init(go)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.itemDic)[go] = chatListItem
end

UINFriendshipChatPageFriendList.__OnItemChange = function(self, go, index)
  -- function num : 0_8 , upvalues : _ENV
  local Item = (self.itemDic)[go]
  if Item == nil then
    error("Can\'t find Item by gameObject")
    return 
  end
  local heroData = (self.curList)[index + 1]
  if heroData == nil then
    error("Can\'t find heroData by index, index = " .. tonumber(index))
  end
  Item:InitHeroInfo(heroData, BindCallback(self, self.OnItemClicked), self.resloader)
  local isSelect = self.selectedHeroData == heroData
  Item:SelectThis(isSelect)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UINFriendshipChatPageFriendList.OnItemClicked = function(self, heroData)
  -- function num : 0_9
  if self.selectHeroCallback ~= nil then
    (self.selectHeroCallback)(heroData)
  end
  self:__SetSelect(heroData)
end

UINFriendshipChatPageFriendList.__SetSelect = function(self, heroData)
  -- function num : 0_10
  do
    if self.selectedHeroData ~= nil then
      local lastItem = self:__GetItemByData(self.selectedHeroData)
      if lastItem ~= nil then
        lastItem:SelectThis(false)
      end
      self.selectedHeroData = nil
    end
    if heroData ~= nil then
      local Item = self:__GetItemByData(heroData)
      if Item ~= nil then
        Item:SelectThis(true)
      end
      self.selectedHeroData = heroData
    end
  end
end

UINFriendshipChatPageFriendList.__GetItemByData = function(self, heroData)
  -- function num : 0_11 , upvalues : _ENV
  for k,v in ipairs(self.curList) do
    if v == heroData then
      local index = k - 1
      return self:__GetItemGoByIndex(index)
    end
  end
end

UINFriendshipChatPageFriendList.__GetItemGoByIndex = function(self, index)
  -- function num : 0_12
  local go = ((self.ui).scrollView_FriendList):GetCellByIndex(index)
  do
    if go ~= nil then
      local heroChatListItem = (self.itemDic)[go]
      return heroChatListItem
    end
    return nil
  end
end

UINFriendshipChatPageFriendList.RefreshTotalLevel = function(self)
  -- function num : 0_13 , upvalues : _ENV
  local totalLevel = (PlayerDataCenter.allFriendshipData):GetTotalLevel() or 0
  ;
  ((self.ui).tex_TotalfavorLevel):SetIndex(0, tostring(totalLevel))
end

UINFriendshipChatPageFriendList.OnDelete = function(self)
  -- function num : 0_14 , upvalues : _ENV, base
  (self.appTogglePool):DeleteAll()
  for key,value in pairs(self.itemDic) do
    value:Delete()
  end
  MsgCenter:RemoveListener(eMsgEventId.OnHeroFriendshipDataChange, self.__RefreshTotalLevel)
  ;
  (base.OnDelete)(self)
end

return UINFriendshipChatPageFriendList

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINFriendshipChatPageFriendList = class("UINFriendshipChatPageFriendList",
                                              UIBaseNode)
local base = UIBaseNode
local UINFriendshipChatPageFriendItem = require(
                                            "Game.Friendship.pages.ChatPage.UINFriendshipChatPageFriendItem")
local UINFriendshipSortKindItem = require(
                                      "Game.Friendship.pages.ChatPage.UINFriendshipSortKindItem")
local SortFuncs = {
    defult = function(heroA, heroB)
        -- function num : 0_0
        do return (heroA.heroCfg).id < (heroB.heroCfg).id end
        -- DECOMPILER ERROR: 1 unprocessed JMP targets
    end
}
local getShiftFuncs = {
    camp = function(campId)
        -- function num : 0_1
        return function(heroData)
            -- function num : 0_1_0 , upvalues : campId
            do return (heroData.heroCfg).camp == campId end
            -- DECOMPILER ERROR: 1 unprocessed JMP targets
        end

    end
}
UINFriendshipChatPageFriendList.OnInit =
    function(self)
        -- function num : 0_2 , upvalues : _ENV, UINFriendshipSortKindItem
        self.itemDic = {}
        self.curList = {}
        self.selectedHeroData = nil
        self.clickEvent = nil
        self.isSortPanelOpen = false
        self.shiftFuncList = {}
        self.resloader = nil
        self.selectHeroCallback = nil;
        (UIUtil.LuaUIBindingTable)(self.transform, self.ui) -- DECOMPILER ERROR at PC22: Confused about usage of register: R1 in 'UnsetPending'
        ;
        ((self.ui).scrollView_FriendList).onInstantiateItem =
            BindCallback(self, self.__InitItem) -- DECOMPILER ERROR at PC29: Confused about usage of register: R1 in 'UnsetPending'
        ;
        ((self.ui).scrollView_FriendList).onChangeItem =
            BindCallback(self, self.__OnItemChange);
        (UIUtil.AddButtonListener)((self.ui).btn_Sort, self, self.OnClikSortBtn)
        self.appTogglePool = (UIItemPool.New)(UINFriendshipSortKindItem,
                                              (self.ui).obj_sortKindItem);
        ((self.ui).obj_sortKindItem):SetActive(false)
        self.__RefreshTotalLevel = BindCallback(self, self.RefreshTotalLevel)
        MsgCenter:AddListener(eMsgEventId.OnHeroFriendshipDataChange,
                              self.__RefreshTotalLevel)
    end

UINFriendshipChatPageFriendList.InitFriendList =
    function(self, resloader, selectHeroCallback)
        -- function num : 0_3 , upvalues : SortFuncs
        self.resloader = resloader
        self.selectHeroCallback = selectHeroCallback
        self:__InitOriginHeroList()
        self:RefrshChatList(nil, SortFuncs.defult, nil)
    end

UINFriendshipChatPageFriendList.__InitOriginHeroList =
    function(self, slotId)
        -- function num : 0_4 , upvalues : _ENV
        self.origintChatListItemList = PlayerDataCenter.heroDic
    end

UINFriendshipChatPageFriendList.OnClikSortBtn =
    function(self)
        -- function num : 0_5 , upvalues : _ENV, getShiftFuncs, SortFuncs
        self.isSortPanelOpen = not self.isSortPanelOpen;
        ((self.ui).obj_sortConditionNode):SetActive(self.isSortPanelOpen);
        ((self.ui).tex_Type):SetIndex(0);
        (self.appTogglePool):HideAll()
        for _, campCfg in pairs(ConfigData.camp) do
            do
                local item = (self.appTogglePool):GetOne(true)
                item:InitSortItem((LanguageUtil.GetLocaleText)(campCfg.name),
                                  function(bool_useThisShift)
                    -- function num : 0_5_0 , upvalues : self, campCfg, getShiftFuncs, _ENV, SortFuncs
                    -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

                    if bool_useThisShift then
                        (self.shiftFuncList)[campCfg.name] =
                            (getShiftFuncs.camp)(campCfg.id)
                    else
                        -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'


                        (self.shiftFuncList)[campCfg.name] = nil
                    end
                    local theShiftFunc =
                        function(heroData)
                            -- function num : 0_5_0_0 , upvalues : _ENV, self
                            if (table.count)(self.shiftFuncList) == 0 then
                                return true
                            end
                            for _, func in pairs(self.shiftFuncList) do
                                if func(heroData) then
                                    return true
                                end
                            end
                            return false
                        end

                    self:RefrshChatList(theShiftFunc, SortFuncs.defult, nil)
                end)
            end
        end
    end

UINFriendshipChatPageFriendList.RefrshChatList =
    function(self, funcSift, funcSort, customList)
        -- function num : 0_6 , upvalues : _ENV
        if not customList then
            local heroList = self.origintChatListItemList
        end
        local curSelectChatListItem = nil
        self.curList = {}
        for k, heroData in pairs(heroList) do
            if funcSift == nil then
                (table.insert)(self.curList, heroData)
            else
                if funcSift(heroData) then
                    (table.insert)(self.curList, heroData)
                end
            end
            if heroData == self.selectedHeroData then
                curSelectChatListItem = heroData
            end
        end
        if funcSort ~= nil then (table.sort)(self.curList, funcSort) end -- DECOMPILER ERROR at PC45: Confused about usage of register: R6 in 'UnsetPending'
        
        ((self.ui).scrollView_FriendList).totalCount = #self.curList;
        ((self.ui).scrollView_FriendList):RefillCells()
        self:__SetSelect(curSelectChatListItem)
        if curSelectChatListItem == nil then
            self:OnItemClicked((self.curList)[1])
        end
    end

UINFriendshipChatPageFriendList.__InitItem =
    function(self, go)
        -- function num : 0_7 , upvalues : UINFriendshipChatPageFriendItem
        local chatListItem = (UINFriendshipChatPageFriendItem.New)()
        chatListItem:Init(go) -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'
        ;
        (self.itemDic)[go] = chatListItem
    end

UINFriendshipChatPageFriendList.__OnItemChange =
    function(self, go, index)
        -- function num : 0_8 , upvalues : _ENV
        local Item = (self.itemDic)[go]
        if Item == nil then
            error("Can\'t find Item by gameObject")
            return
        end
        local heroData = (self.curList)[index + 1]
        if heroData == nil then
            error("Can\'t find heroData by index, index = " .. tonumber(index))
        end
        Item:InitHeroInfo(heroData, BindCallback(self, self.OnItemClicked),
                          self.resloader)
        local isSelect = self.selectedHeroData == heroData
        Item:SelectThis(isSelect)
        -- DECOMPILER ERROR: 1 unprocessed JMP targets
    end

UINFriendshipChatPageFriendList.OnItemClicked =
    function(self, heroData)
        -- function num : 0_9
        if self.selectHeroCallback ~= nil then
            (self.selectHeroCallback)(heroData)
        end
        self:__SetSelect(heroData)
    end

UINFriendshipChatPageFriendList.__SetSelect =
    function(self, heroData)
        -- function num : 0_10
        do
            if self.selectedHeroData ~= nil then
                local lastItem = self:__GetItemByData(self.selectedHeroData)
                if lastItem ~= nil then
                    lastItem:SelectThis(false)
                end
                self.selectedHeroData = nil
            end
            if heroData ~= nil then
                local Item = self:__GetItemByData(heroData)
                if Item ~= nil then Item:SelectThis(true) end
                self.selectedHeroData = heroData
            end
        end
    end

UINFriendshipChatPageFriendList.__GetItemByData =
    function(self, heroData)
        -- function num : 0_11 , upvalues : _ENV
        for k, v in ipairs(self.curList) do
            if v == heroData then
                local index = k - 1
                return self:__GetItemGoByIndex(index)
            end
        end
    end

UINFriendshipChatPageFriendList.__GetItemGoByIndex =
    function(self, index)
        -- function num : 0_12
        local go = ((self.ui).scrollView_FriendList):GetCellByIndex(index)
        do
            if go ~= nil then
                local heroChatListItem = (self.itemDic)[go]
                return heroChatListItem
            end
            return nil
        end
    end

UINFriendshipChatPageFriendList.RefreshTotalLevel =
    function(self)
        -- function num : 0_13 , upvalues : _ENV
        local totalLevel =
            (PlayerDataCenter.allFriendshipData):GetTotalLevel() or 0;
        ((self.ui).tex_TotalfavorLevel):SetIndex(0, tostring(totalLevel))
    end

UINFriendshipChatPageFriendList.OnDelete =
    function(self)
        -- function num : 0_14 , upvalues : _ENV, base
        (self.appTogglePool):DeleteAll()
        for key, value in pairs(self.itemDic) do value:Delete() end
        MsgCenter:RemoveListener(eMsgEventId.OnHeroFriendshipDataChange,
                                 self.__RefreshTotalLevel);
        (base.OnDelete)(self)
    end

return UINFriendshipChatPageFriendList

