-- params : ...
-- function num : 0 , upvalues : _ENV
local UINFriendshipAttrItem = class("UINFriendshipAttrItem", UIBaseNode)
local base = UIBaseNode
UINFriendshipAttrItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINFriendshipAttrItem.InitAttrItem = function(self, attrID, num)
  -- function num : 0_1 , upvalues : _ENV
  if attrID <= 17 then
    ((self.ui).img_Icon):SetIndex(attrID)
  end
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_attrName).text = (LanguageUtil.GetLocaleText)(((ConfigData.attribute)[attrID]).name)
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Num).text = num
end

UINFriendshipAttrItem.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINFriendshipAttrItem

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINFriendshipAttrItem = class("UINFriendshipAttrItem", UIBaseNode)
local base = UIBaseNode
UINFriendshipAttrItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINFriendshipAttrItem.InitAttrItem = function(self, attrID, num)
    -- function num : 0_1 , upvalues : _ENV
    if attrID <= 17 then ((self.ui).img_Icon):SetIndex(attrID) end -- DECOMPILER ERROR at PC16: Confused about usage of register: R3 in 'UnsetPending'
    
    ((self.ui).tex_attrName).text = (LanguageUtil.GetLocaleText)(
                                        ((ConfigData.attribute)[attrID]).name) -- DECOMPILER ERROR at PC19: Confused about usage of register: R3 in 'UnsetPending'
    ;
    ((self.ui).tex_Num).text = num
end

UINFriendshipAttrItem.OnDelete = function(self)
    -- function num : 0_2 , upvalues : base
    (base.OnDelete)(self)
end

return UINFriendshipAttrItem

