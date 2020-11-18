-- params : ...
-- function num : 0 , upvalues : _ENV
local UINFriendshipPageTog = class("UINFriendshipPageTog", UIBaseNode)
local base = UIBaseNode
local FriendshipEnum = require("Game.Friendship.FriendshipEnum")
UINFriendshipPageTog.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).toggle, self, self.OnPageChange)
end

UINFriendshipPageTog.InitAchivTypeToggle = function(self, index, isOn, onChangedEvent)
  -- function num : 0_1 , upvalues : FriendshipEnum
  self.index = index
  self.onChangedEvent = onChangedEvent
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).toggle).isOn = isOn
  ;
  ((self.ui).img_Icon):SetIndex(index)
  ;
  ((self.ui).img_SelIcon):SetIndex(index)
  if index == (FriendshipEnum.togTypes).PersonalInfo then
    ((self.ui).obj_img_Line):SetActive(false)
  end
end

UINFriendshipPageTog.OnPageChange = function(self, bool)
  -- function num : 0_2
  if self.onChangedEvent ~= nil and bool then
    (self.onChangedEvent)(self.index)
  end
  if bool then
    (((self.ui).img_Icon).gameObject):SetActive(false)
    ;
    (((self.ui).img_SelIcon).gameObject):SetActive(true)
  else
    ;
    (((self.ui).img_Icon).gameObject):SetActive(true)
    ;
    (((self.ui).img_SelIcon).gameObject):SetActive(false)
  end
end

UINFriendshipPageTog.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UINFriendshipPageTog

