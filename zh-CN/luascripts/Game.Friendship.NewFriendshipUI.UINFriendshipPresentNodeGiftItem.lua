-- params : ...
-- function num : 0 , upvalues : _ENV
local UINFriendshipPresentNodeGiftItem = class("UINFriendshipPresentNodeGiftItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")
local eLiskeDegree = {none = 0, like = 1, normal = 2, dislike = 3}
UINFriendshipPresentNodeGiftItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_presentItem, self, self.AddOne)
  ;
  (((self.ui).btn_presentItem).onPress):AddListener(BindCallback(self, self.PressAdd))
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Minus, self, self.MineOne)
  self.baseItem = (UINBaseItem.New)()
  ;
  (self.baseItem):Init((self.ui).uINBaseItem)
end

UINFriendshipPresentNodeGiftItem.InitGiftItem = function(self, heroId, resloader, giftItemID, addExpCallback, minExpCallback, changeSelectCallback)
  -- function num : 0_1 , upvalues : _ENV, eLiskeDegree
  self.heroId = heroId
  self.resloader = resloader
  self.giftItemID = giftItemID
  self.itemCfg = (ConfigData.item)[giftItemID]
  self.itemNum = PlayerDataCenter:GetItemCount(giftItemID)
  self.likeDegree = eLiskeDegree.none
  self.selectNum = 0
  self.addExpCallback = addExpCallback
  self.minExpCallback = minExpCallback
  self.changeSelectCallback = changeSelectCallback
  ;
  (self.baseItem):InitBaseItem(self.itemCfg)
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)((self.itemCfg).name)
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (self.gameObject).name = "gift_" .. tostring(giftItemID)
  -- DECOMPILER ERROR at PC42: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).tex_ExtrCount).text = tostring(self.itemNum)
  self:SetLikeDegree()
  -- DECOMPILER ERROR at PC50: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).tex_Count).text = tostring(self.selectNum)
  -- DECOMPILER ERROR at PC56: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).tex_Count).text = tostring(self.selectNum)
end

UINFriendshipPresentNodeGiftItem.SetLikeDegree = function(self)
  -- function num : 0_2 , upvalues : _ENV, eLiskeDegree
  if (table.contain)(((ConfigData.friendship_hero)[self.heroId]).gift_id_1, self.giftItemID) then
    self.likeDegree = eLiskeDegree.like
    ;
    ((self.ui).img_emoji):SetIndex(0)
  else
    if (table.contain)(((ConfigData.friendship_hero)[self.heroId]).gift_id_2, self.giftItemID) then
      self.likeDegree = eLiskeDegree.dislike
      ;
      ((self.ui).img_emoji):SetIndex(2)
    else
      self.likeDegree = eLiskeDegree.normal
      ;
      ((self.ui).img_emoji):SetIndex(1)
    end
  end
end

UINFriendshipPresentNodeGiftItem.GetIntimacyAddNum = function(self)
  -- function num : 0_3 , upvalues : eLiskeDegree, _ENV
  if self.likeDegree == eLiskeDegree.like then
    return ((ConfigData.friendship_gift)[self.giftItemID]).gift_like
  else
    if self.likeDegree == eLiskeDegree.dislike then
      return ((ConfigData.friendship_gift)[self.giftItemID]).gift_dislike
    else
      return ((ConfigData.friendship_gift)[self.giftItemID]).gift_base
    end
  end
end

UINFriendshipPresentNodeGiftItem.AddOne = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if self.selectNum < self.itemNum and (self.addExpCallback)(self:GetIntimacyAddNum()) then
    self.selectNum = self.selectNum + 1
  end
  ;
  (self.changeSelectCallback)(self.giftItemID, self.selectNum)
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tex_Count).text = tostring(self.selectNum)
  self:SetNumVisible()
end

UINFriendshipPresentNodeGiftItem.PressAdd = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local pressedTime = ((self.ui).btn_presentItem):GetPressedTime()
  local addNum = (math.ceil)(pressedTime * pressedTime / 5)
  if self.selectNum + addNum <= self.itemNum then
    local could, maxExp = (self.addExpCallback)(self:GetIntimacyAddNum() * addNum)
    if could then
      self.selectNum = self.selectNum + (math.min)(addNum, maxExp // self:GetIntimacyAddNum())
    end
  else
    do
      local maxAddNum = self.itemNum - self.selectNum
      do
        local could, maxExp = (self.addExpCallback)(self:GetIntimacyAddNum() * maxAddNum)
        if could then
          self.selectNum = self.selectNum + (math.min)(maxAddNum, maxExp // self:GetIntimacyAddNum())
        end
        ;
        (self.changeSelectCallback)(self.giftItemID, self.selectNum)
        -- DECOMPILER ERROR at PC61: Confused about usage of register: R3 in 'UnsetPending'

        ;
        ((self.ui).tex_Count).text = tostring(self.selectNum)
        self:SetNumVisible()
      end
    end
  end
end

UINFriendshipPresentNodeGiftItem.MineOne = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if self.selectNum > 0 and (self.minExpCallback)(self:GetIntimacyAddNum()) then
    self.selectNum = self.selectNum - 1
  end
  ;
  (self.changeSelectCallback)(self.giftItemID, self.selectNum)
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tex_Count).text = tostring(self.selectNum)
  self:SetNumVisible()
end

UINFriendshipPresentNodeGiftItem.SetNumVisible = function(self)
  -- function num : 0_7
  ((self.ui).obj_selectCount):SetActive(self.selectNum > 0)
  ;
  ((self.ui).obj_btn_Minus):SetActive(self.selectNum > 0)
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UINFriendshipPresentNodeGiftItem.Claer = function(self)
  -- function num : 0_8 , upvalues : _ENV
  if self.selectNum == 0 then
    return 
  end
  ;
  (self.minExpCallback)(self:GetIntimacyAddNum() * self.selectNum)
  self.selectNum = 0
  ;
  (self.changeSelectCallback)(self.giftItemID, self.selectNum)
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tex_Count).text = tostring(self.selectNum)
  self:SetNumVisible()
end

UINFriendshipPresentNodeGiftItem.OnDelete = function(self)
  -- function num : 0_9 , upvalues : base
  (base.OnDelete)(self)
end

return UINFriendshipPresentNodeGiftItem

