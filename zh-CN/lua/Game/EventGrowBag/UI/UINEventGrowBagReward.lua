local UINEventGrowBagReward = class("UINEventGrowBagReward", UIBaseNode)
local base = UIBaseNode
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")
UINEventGrowBagReward.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.baseItem = (UINBaseItem.New)()
  ;
  (self.baseItem):Init((self.ui).uINBaseItem)
end

UINEventGrowBagReward.InitItem = function(self, id, count, isGetReward, isLocked)
  -- function num : 0_1 , upvalues : _ENV
  ((self.ui).obj_lock):SetActive(isLocked)
  ;
  ((self.ui).obj_isPicked):SetActive(isGetReward)
  if count <= 1 then
    ((self.ui).count):SetActive(false)
  else
    ;
    ((self.ui).count):SetActive(true)
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.ui).tex_TotalCount).text = tostring(count)
  end
  ;
  (self.baseItem):InitBaseItem((ConfigData.item)[id])
end

return UINEventGrowBagReward

