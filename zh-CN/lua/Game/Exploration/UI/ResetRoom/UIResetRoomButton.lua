local UIResetRoomButton = class("UIResetRoomButton", UIBaseNode)
local base = UIBaseNode
UIResetRoomButton.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Operation, self, self.OnButtonClick)
end

UIResetRoomButton.InitOperationButton = function(self, id, reseRoomData, clickAction)
  -- function num : 0_1
  self.id = id
  self.price = reseRoomData.costNum
  self:UpdateMoney(reseRoomData.costNum)
  self.clickAction = clickAction
  ;
  ((self.ui).tex_Name):SetIndex(id)
end

UIResetRoomButton.UpdateMoney = function(self, costNum)
  -- function num : 0_2 , upvalues : _ENV
  ((self.ui).tex_Money):SetIndex(0, tostring(costNum))
end

UIResetRoomButton.OnButtonClick = function(self)
  -- function num : 0_3
  if self.clickAction ~= nil then
    (self.clickAction)(self)
  end
end

return UIResetRoomButton

