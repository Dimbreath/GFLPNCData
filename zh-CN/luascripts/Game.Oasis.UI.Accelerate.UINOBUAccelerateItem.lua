-- params : ...
-- function num : 0 , upvalues : _ENV
local UINOBUAccelerateItem = class("UINOBUAccelerateItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")
UINOBUAccelerateItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.baseItem = (UINBaseItem.New)()
  ;
  (self.baseItem):Init((self.ui).obj_BaseItem)
end

UINOBUAccelerateItem.InitItem = function(self, itemId, num, needNum)
  -- function num : 0_1 , upvalues : _ENV
  local itemCfg = (ConfigData.item)[itemId]
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R5 in 'UnsetPending'

  if (self.ui).CanvasGroup ~= nil then
    if num == 0 then
      ((self.ui).CanvasGroup).alpha = 0.5
    else
      -- DECOMPILER ERROR at PC15: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.ui).CanvasGroup).alpha = 1
    end
  end
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(itemCfg.name)
  ;
  (self.baseItem):InitBaseItem(itemCfg, nil)
  self:UpdateSelectedNum(num, needNum)
end

UINOBUAccelerateItem.UpdateSelectedNum = function(self, num, needNum)
  -- function num : 0_2 , upvalues : _ENV
  if (self.ui).tex_TotalCount ~= nil then
    if needNum == nil or needNum == 0 then
      ((self.ui).tex_TotalCount):SetIndex(0, tostring(num))
    else
      if num < needNum then
        ((self.ui).tex_TotalCount):SetIndex(2, tostring(num), tostring(needNum))
      else
        ;
        ((self.ui).tex_TotalCount):SetIndex(1, tostring(num), tostring(needNum))
      end
    end
  end
end

UINOBUAccelerateItem.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UINOBUAccelerateItem

