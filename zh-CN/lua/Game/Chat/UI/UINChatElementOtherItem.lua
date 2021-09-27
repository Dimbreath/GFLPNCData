local UINChatElementOtherItem = class("UINChatElementOtherItem", UIBaseNode)
local base = UIBaseNode
UINChatElementOtherItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINChatElementOtherItem.SetChatData = function(self, chatData)
  -- function num : 0_1
  local isSinglePic = chatData:GetIsSinglePicture()
  ;
  (((self.ui).tex_Chat).gameObject):SetActive(not isSinglePic)
  ;
  (((self.ui).img_Pic).gameObject):SetActive(isSinglePic)
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R3 in 'UnsetPending'

  if isSinglePic then
    ((self.ui).tex_Chat).text = chatData:GetContent()
  end
end

UINChatElementOtherItem.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINChatElementOtherItem

