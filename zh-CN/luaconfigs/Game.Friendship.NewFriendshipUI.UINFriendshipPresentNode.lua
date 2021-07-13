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
  local like = ((ConfigData.friendship_hero)[self.targetHeroID]).likeGifts
  local dislike = ((ConfigData.friendship_hero)[self.targetHeroID]).dislikeGifts
  for key,value in pairs(ConfigData.friendship_gift) do
    local giftData = {giftCfg = value, id = value.id, isLike = like[value.id], isDislike = dislike[value.id]}
    ;
    (table.insert)(giftList, giftData)
  end
  ;
  (table.sort)(giftList, Bind(self, self.SortGifts))
  for _,giftData in ipairs(giftList) do
    local gitfItem = (self.giftPool):GetOne(true)
    gitfItem:InitGiftItem(self.targetHeroID, self.resloader, giftData.id, self.addExpCallback, self.minExpCallback, self.__ChangeSelect)
  end
end

UINFriendshipPresentNode.SortGifts = function(self, giftA, giftB)
  -- function num : 0_4 , upvalues : _ENV
  local isLikeA = giftA.isLike
  local isLikeB = giftB.isLike
  local isDislikeA = giftA.isDislike
  local isDislikeB = giftB.isDislike
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
  local tweenDiffData = (self.friendshipLevelUI).tweenDiffData
  self.lastLevel = (PlayerDataCenter.allFriendshipData):GetLevel(self.targetHeroID)
  ;
  (self.networkCtrl):CS_INTIMACY_Presentation(self.targetHeroID, self.selectedGifts, function()
    -- function num : 0_7_0 , upvalues : _ENV, self, tweenDiffData
    local level = (PlayerDataCenter.allFriendshipData):GetLevel(self.targetHeroID)
    if level ~= self.lastLevel then
      (UIManager:ShowWindow(UIWindowTypeID.HeroLevelUpSuccess)):FriendShipLevelUp(self.lastLevel, level)
    end
    self.lastLevel = nil
    for _,item in ipairs((self.giftPool).listItem) do
      item:Claer()
    end
    local win = UIManager:GetWindow(UIWindowTypeID.FriendShip)
    if win ~= nil then
      (win.friendshipLevelUI):ShowExpBarTween(tweenDiffData)
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

