local UINDormInteractItem = class("UINDormInteractItem", UIBaseNode)
local DormEnum = require("Game.Dorm.DormEnum")
UINDormInteractItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Interact, self, self.OnInteractBtnClick)
end

UINDormInteractItem.InitInteractActionItem = function(self, interactAction, iconAtlas)
  -- function num : 0_1 , upvalues : _ENV
  self.interactAction = interactAction
  local desc, spriteName, title, hasNew = interactAction:GetActionData()
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).tex_Interact).text = desc
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).tex_State).text = title
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).sprite = iconAtlas:GetSprite(spriteName)
  if not hasNew or not (self.ui).col_HasNew then
    local buttomCol = Color.white
  end
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R8 in 'UnsetPending'

  ;
  ((self.ui).img_Buttom).color = buttomCol
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R8 in 'UnsetPending'

  ;
  ((self.ui).tex_IsNew).enabled = hasNew
  if hasNew then
    (self.transform):SetAsFirstSibling()
  end
end

UINDormInteractItem.OnInteractBtnClick = function(self)
  -- function num : 0_2
  if self.interactAction ~= nil then
    (self.interactAction):InvokeInteractAction()
  end
end

UINDormInteractItem.OnDelete = function(self)
  -- function num : 0_3
end

return UINDormInteractItem

