-- params : ...
-- function num : 0 , upvalues : _ENV
local UINFriendshipSendGift = class("UINFriendshipSendGift", UIBaseNode)
local base = UIBaseNode
local UINFriendshipGiftItem = require("Game.Friendship.pages.ChatPage.UINFriendshipGiftItem")
UINFriendshipSendGift.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINFriendshipGiftItem
  self.networkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Friendship)
  self.resloader = nil
  self.targetHeroID = nil
  self.sendNum = 0
  self.selectedGiftId = nil
  self.selectedGitfNum = 0
  self.selectedGitfMaxSendNum = 0
  self.selectedGitgIntimacyValue = 0
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Add, self, self.AddOne)
  ;
  (((self.ui).btn_Add).onPress):AddListener(BindCallback(self, self.AccelerateAddOne))
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Sub, self, self.SubOne)
  ;
  (((self.ui).btn_Sub).onPress):AddListener(BindCallback(self, self.SubOne))
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Max, self, self.OnMax)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Reset, self, self.OnReset)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_GiveGift, self, self.Send)
  self.__RegenerateGifts = BindCallback(self, self.RegenerateGifts)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__RegenerateGifts)
  self.giftPool = (UIItemPool.New)(UINFriendshipGiftItem, (self.ui).giftItem)
  ;
  ((self.ui).giftItem):SetActive(false)
  -- DECOMPILER ERROR at PC99: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tex_Count).text = tostring(self.sendNum)
end

UINFriendshipSendGift.InitResloader = function(self, resloader)
  -- function num : 0_1
  self.resloader = resloader
end

UINFriendshipSendGift.InitSendGift = function(self, heroID, refreshIntimacyBarCallBack)
  -- function num : 0_2 , upvalues : _ENV
  self.targetHeroID = heroID
  self.refreshIntimacyBarCallBack = refreshIntimacyBarCallBack
  self.sendNum = 0
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Count).text = tostring(self.sendNum)
  self:RegenerateGifts()
end

UINFriendshipSendGift.RegenerateGifts = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (self.giftPool):HideAll()
  self.selectedGiftId = nil
  local giftList = {}
  for key,value in pairs(ConfigData.friendship_gift) do
    do
      (table.insert)(giftList, value)
    end
  end
  ;
  (table.sort)(giftList, Bind(self, self.SortGifts))
  for _,gift in ipairs(giftList) do
    local gitfItem = (self.giftPool):GetOne(true)
    local itemNum = PlayerDataCenter:GetItemCount(gift.id)
    gitfItem:InitGiftItem(self.targetHeroID, self.resloader, gift.id, itemNum, function()
    -- function num : 0_3_0 , upvalues : self, gift, _ENV, itemNum, gitfItem
    if self.selectedGiftId == gift.id then
      return 
    end
    self.selectedGiftId = gift.id
    self.sendNum = 0
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((self.ui).tex_Count).text = tostring(self.sendNum)
    self.selectedGitfNum = itemNum
    self.selectedGitgIntimacyValue = gitfItem:GetIntimacyAddNum()
    self.selectedGitfMaxSendNum = (math.ceil)(self:GetMaxAddableEXP() / self.selectedGitgIntimacyValue)
    ;
    (self.refreshIntimacyBarCallBack)()
  end
, function()
    -- function num : 0_3_1 , upvalues : self, _ENV
    self.selectedGiftId = nil
    self.sendNum = 0
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((self.ui).tex_Count).text = tostring(self.sendNum)
    self.selectedGitfNum = 0
    ;
    (self.refreshIntimacyBarCallBack)()
  end
)
  end
end

UINFriendshipSendGift.SortGifts = function(self, giftA, giftB)
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

UINFriendshipSendGift.AddOne = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if self.selectedGitfNum < self.sendNum + 1 or self.selectedGitfMaxSendNum < self.sendNum + 1 then
    return 
  end
  self.sendNum = self.sendNum + 1
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tex_Count).text = tostring(self.sendNum)
  ;
  (self.refreshIntimacyBarCallBack)(self.sendNum * self.selectedGitgIntimacyValue)
end

UINFriendshipSendGift.AccelerateAddOne = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local pressedTime = ((self.ui).btn_Add):GetPressedTime()
  local addNum = (math.ceil)(pressedTime)
  do
    if self.selectedGitfNum < self.sendNum + addNum or self.selectedGitfMaxSendNum < self.sendNum + addNum then
      local newAddNum = (math.min)(self.selectedGitfNum - self.sendNum, self.selectedGitfMaxSendNum - self.sendNum)
      if newAddNum > 0 then
        addNum = newAddNum
      else
        return 
      end
    end
    self.sendNum = self.sendNum + addNum
    -- DECOMPILER ERROR at PC40: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).tex_Count).text = tostring(self.sendNum)
    ;
    (self.refreshIntimacyBarCallBack)(self.sendNum * self.selectedGitgIntimacyValue)
  end
end

UINFriendshipSendGift.SubOne = function(self)
  -- function num : 0_7 , upvalues : _ENV
  if self.sendNum > 0 then
    self.sendNum = self.sendNum - 1
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).tex_Count).text = tostring(self.sendNum)
    ;
    (self.refreshIntimacyBarCallBack)(self.sendNum * self.selectedGitgIntimacyValue)
  end
end

UINFriendshipSendGift.OnMax = function(self)
  -- function num : 0_8 , upvalues : _ENV
  if self.selectedGitfMaxSendNum <= self.selectedGitfNum then
    self.sendNum = self.selectedGitfMaxSendNum
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).tex_Count).text = tostring(self.sendNum)
    ;
    (self.refreshIntimacyBarCallBack)(self.sendNum * self.selectedGitgIntimacyValue)
  else
    self.sendNum = self.selectedGitfNum
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).tex_Count).text = tostring(self.sendNum)
    ;
    (self.refreshIntimacyBarCallBack)(self.sendNum * self.selectedGitgIntimacyValue)
  end
end

UINFriendshipSendGift.OnReset = function(self)
  -- function num : 0_9 , upvalues : _ENV
  self.sendNum = 0
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tex_Count).text = tostring(self.sendNum)
  ;
  (self.refreshIntimacyBarCallBack)()
end

UINFriendshipSendGift.Send = function(self)
  -- function num : 0_10
  if self.targetHeroID == nil or self.sendNum <= 0 or self.selectedGiftId == nil then
    return 
  end
  ;
  (self.networkCtrl):CS_INTIMACY_Presentation(self.targetHeroID, self.selectedGiftId, self.sendNum)
end

UINFriendshipSendGift.GetMaxAddableEXP = function(self)
  -- function num : 0_11 , upvalues : _ENV
  local nowLevel = (PlayerDataCenter.allFriendshipData):GetLevel(self.targetHeroID)
  local nowExp = (PlayerDataCenter.allFriendshipData):GetExp(self.targetHeroID)
  local AddableEXP = 0
  for level = nowLevel, #ConfigData.friendship_level do
    AddableEXP = AddableEXP + ((ConfigData.friendship_level)[level]).friendship
  end
  AddableEXP = AddableEXP - nowExp
  return AddableEXP
end

UINFriendshipSendGift.OnClose = function(self)
  -- function num : 0_12 , upvalues : _ENV
  self.sendNum = 0
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tex_Count).text = tostring(self.sendNum)
  ;
  (self.refreshIntimacyBarCallBack)()
end

UINFriendshipSendGift.OnDelete = function(self)
  -- function num : 0_13 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__RegenerateGifts)
  ;
  (base.OnDelete)(self)
end

return UINFriendshipSendGift

