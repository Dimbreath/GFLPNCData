-- params : ...
-- function num : 0 , upvalues : _ENV
local UINFriendshipPresentNode = class("UINFriendshipPresentNode", UIBaseNode)
local base = UIBaseNode
local UINFriendshipPresentNodeGiftItem = require("Game.Friendship.NewFriendshipUI.UINFriendshipPresentNodeGiftItem")
UINFriendshipPresentNode.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINFriendshipPresentNodeGiftItem
  self.networkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Friendship)
  self.resloader = nil
  self.targetHeroID = nil
  self.selectedGifts = {}
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_ClearSelect, self, self.OnReset)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Give, self, self.Send)
  self.__RegenerateGifts = BindCallback(self, self.RegenerateGifts)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__RegenerateGifts)
  self.giftPool = (UIItemPool.New)(UINFriendshipPresentNodeGiftItem, (self.ui).obj_presentItem)
  ;
  ((self.ui).obj_presentItem):SetActive(false)
  self.__ChangeSelect = Bind(self, self.ChangeSelect)
end

UINFriendshipPresentNode.InitResloader = function(self, resloader, addExpCallback, minExpCallback, friendshipLevelUI)
  -- function num : 0_1
  self.resloader = resloader
  self.addExpCallback = addExpCallback
  self.minExpCallback = minExpCallback
  self.friendshipLevelUI = friendshipLevelUI
end

UINFriendshipPresentNode.InitSendGift = function(self, heroID)
  -- function num : 0_2
  self.targetHeroID = heroID
  self.sendNum = {}
  self:RegenerateGifts()
end

UINFriendshipPresentNode.RegenerateGifts = function(self)
  -- function num : 0_3 , upvalues : _ENV
  for _,item in ipairs((self.giftPool).listItem) do
    item:Claer()
  end
  ;
  (self.giftPool):HideAll()
  self.selectedGiftId = {}
  self.selectedGitfNums = {}
  local giftList = {}
  for key,value in pairs(ConfigData.friendship_gift) do
    (table.insert)(giftList, value)
  end
  ;
  (table.sort)(giftList, Bind(self, self.SortGifts))
  for _,gift in ipairs(giftList) do
    local gitfItem = (self.giftPool):GetOne(true)
    gitfItem:InitGiftItem(self.targetHeroID, self.resloader, gift.id, self.addExpCallback, self.minExpCallback, self.__ChangeSelect)
  end
end

UINFriendshipPresentNode.SortGifts = function(self, giftA, giftB)
  -- function num : 0_4 , upvalues : _ENV
  local like = ((ConfigData.friendship_hero)[self.targetHeroID]).gift_id_1
  local dislike = ((ConfigData.friendship_hero)[self.targetHeroID]).gift_id_2
  local isLikeA = (table.contain)(like, giftA.id)
  local isLikeB = (table.contain)(like, giftB.id)
  local isDislikeA = (table.contain)(dislike, giftA.id)
  local isDislikeB = (table.contain)(dislike, giftB.id)
  if giftB.id >= giftA.id then
    do return (PlayerDataCenter:GetItemCount(giftA.id) > 0 or PlayerDataCenter:GetItemCount(giftB.id) <= 0) and isLikeA ~= isLikeB ~= isDislikeA ~= isDislikeB end
    do return PlayerDataCenter:GetItemCount(giftA.id) > 0 end
    do return not isDislikeA end
    do return isLikeA end
    -- DECOMPILER ERROR: 8 unprocessed JMP targets
  end
end

UINFriendshipPresentNode.ChangeSelect = function(self, itemId, itemNum)
  -- function num : 0_5
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R3 in 'UnsetPending'

  -- DECOMPILER ERROR at PC7: Unhandled construct in 'MakeBoolean' P1

  if itemNum == 0 and (self.selectedGifts)[itemId] ~= nil then
    (self.selectedGifts)[itemId] = nil
  end
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.selectedGifts)[itemId] = itemNum
  self:RefreshPresentConfirmBtn()
end

UINFriendshipPresentNode.OnReset = function(self)
  -- function num : 0_6 , upvalues : _ENV
  for _,item in ipairs((self.giftPool).listItem) do
    item:Claer()
  end
end

UINFriendshipPresentNode.Send = function(self)
  -- function num : 0_7 , upvalues : _ENV
  if (table.count)(self.selectedGifts) < 1 then
    return 
  end
  local data = (self.friendshipLevelUI).whenAddData
  self.lastLevel = (PlayerDataCenter.allFriendshipData):GetLevel(self.targetHeroID)
  ;
  (self.networkCtrl):CS_INTIMACY_Presentation(self.targetHeroID, self.selectedGifts, function()
    -- function num : 0_7_0 , upvalues : _ENV, self
    local level = (PlayerDataCenter.allFriendshipData):GetLevel(self.targetHeroID)
    if level ~= self.lastLevel then
      (UIManager:ShowWindow(UIWindowTypeID.HeroLevelUpSuccess)):FriendShipLevelUp(self.lastLevel, level)
    end
    self.lastLevel = nil
    for _,item in ipairs((self.giftPool).listItem) do
      item:Claer()
    end
  end
, data.level, data.exp)
end

UINFriendshipPresentNode.OnClose = function(self)
  -- function num : 0_8 , upvalues : _ENV
  self.sendNum = 0
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tex_Count).text = tostring(self.sendNum)
end

UINFriendshipPresentNode.RefreshPresentConfirmBtn = function(self)
  -- function num : 0_9 , upvalues : _ENV
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  ((self.ui).img_Give).color = (self.ui).color_gray
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).btn_Give).interactable = false
  ;
  (((self.ui).btn_ClearSelect).gameObject):SetActive(false)
  if (PlayerDataCenter.allFriendshipData):IsFriendShipMaxLevel(self.targetHeroID) then
    return 
  end
  local isSelect = false
  if (table.count)(self.selectedGifts) ~= 0 then
    for itemId,num in pairs(self.selectedGifts) do
      if num > 0 then
        isSelect = true
      end
    end
  end
  do
    -- DECOMPILER ERROR at PC44: Confused about usage of register: R2 in 'UnsetPending'

    if isSelect then
      ((self.ui).img_Give).color = (self.ui).color_orange
      -- DECOMPILER ERROR at PC47: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((self.ui).btn_Give).interactable = true
      ;
      (((self.ui).btn_ClearSelect).gameObject):SetActive(true)
    end
  end
end

UINFriendshipPresentNode.OnDelete = function(self)
  -- function num : 0_10 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__RegenerateGifts)
  ;
  (base.OnDelete)(self)
end

return UINFriendshipPresentNode

