-- params : ...
-- function num : 0 , upvalues : _ENV
local UINFriendshipGiftItem = class("UINFriendshipGiftItem", UIBaseNode)
local base = UIBaseNode
UINFriendshipGiftItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).tog_giftItem, self, self.OnTogValueChange)
end

UINFriendshipGiftItem.InitGiftItem = function(self, heroId, resloader, giftItemID, itemNum, callback, callbackCancle)
  -- function num : 0_1 , upvalues : _ENV
  self.heroId = heroId
  self.resloader = resloader
  self.giftItemID = giftItemID
  self.itemCfg = (ConfigData.item)[giftItemID]
  self.callback = callback
  self.itemNum = itemNum
  self.callbackCancle = callbackCancle
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)((self.itemCfg).name)
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).sprite = CRH:GetSprite((self.itemCfg).icon)
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).tex_Count).text = tostring(self.itemNum)
  -- DECOMPILER ERROR at PC39: Confused about usage of register: R7 in 'UnsetPending'

  if self.itemNum == 0 then
    ((self.ui).img_Icon).color = (self.ui).color_gray
    -- DECOMPILER ERROR at PC42: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self.ui).tog_giftItem).interactable = false
  else
    -- DECOMPILER ERROR at PC48: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self.ui).img_Icon).color = (self.ui).color_white
    -- DECOMPILER ERROR at PC51: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self.ui).tog_giftItem).interactable = true
  end
  -- DECOMPILER ERROR at PC54: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).tog_giftItem).isOn = false
  self:SetLikeDegree()
end

UINFriendshipGiftItem.OnTogValueChange = function(self, bool)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC6: Unhandled construct in 'MakeBoolean' P1

  if bool and self.callback ~= nil then
    (self.callback)()
  end
  if self.callbackCancle ~= nil then
    (self.callbackCancle)()
  end
end

UINFriendshipGiftItem.GetIntimacyAddNum = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if (((ConfigData.friendship_hero)[self.heroId]).likeGifts)[self.giftItemID] then
    return ((ConfigData.friendship_gift)[self.giftItemID]).gift_like
  end
  if (((ConfigData.friendship_hero)[self.heroId]).dislikeGifts)[self.giftItemID] then
    return ((ConfigData.friendship_gift)[self.giftItemID]).gift_dislike
  end
  return ((ConfigData.friendship_gift)[self.giftItemID]).gift_base
end

UINFriendshipGiftItem.SetLikeDegree = function(self)
  -- function num : 0_4 , upvalues : _ENV
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

  if (((ConfigData.friendship_hero)[self.heroId]).likeGifts)[self.giftItemID] then
    ((self.ui).img_Heart).color = (self.ui).color_heart
    ;
    ((self.ui).imgInfo_Heart):SetIndex(0)
  else
    -- DECOMPILER ERROR at PC33: Confused about usage of register: R1 in 'UnsetPending'

    if (((ConfigData.friendship_hero)[self.heroId]).dislikeGifts)[self.giftItemID] then
      ((self.ui).img_Heart).color = (self.ui).color_white
      ;
      ((self.ui).imgInfo_Heart):SetIndex(2)
    else
      -- DECOMPILER ERROR at PC44: Confused about usage of register: R1 in 'UnsetPending'

      ;
      ((self.ui).img_Heart).color = (self.ui).color_white
      ;
      ((self.ui).imgInfo_Heart):SetIndex(1)
    end
  end
end

UINFriendshipGiftItem.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnDelete)(self)
end

return UINFriendshipGiftItem

