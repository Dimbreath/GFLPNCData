-- params : ...
-- function num : 0 , upvalues : _ENV
local UINBaseItemWithCount = class("UINBaseItemWithCount", UIBaseNode)
local base = UIBaseNode
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")
UINBaseItemWithCount.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.baseItem = (UINBaseItem.New)()
  ;
  (self.baseItem):Init((self.ui).uINBaseItem)
end

UINBaseItemWithCount.InitItemWithCount = function(self, itemCfg, count, clickEvent)
  -- function num : 0_1 , upvalues : _ENV
  if (self.ui).obj_Empty ~= nil then
    if itemCfg == nil then
      ((self.ui).obj_Empty):SetActive(true)
      ;
      (self.baseItem):Hide()
      return 
    else
      ;
      ((self.ui).obj_Empty):SetActive(false)
      ;
      (self.baseItem):Show()
    end
  end
  self.itemCfg = itemCfg
  ;
  (self.baseItem):InitBaseItem(itemCfg, clickEvent)
  self:SetNum(count)
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R4 in 'UnsetPending'

  if (self.ui).tex_ItemName ~= nil then
    ((self.ui).tex_ItemName).text = tostring((LanguageUtil.GetLocaleText)(itemCfg.name))
  end
end

UINBaseItemWithCount.SetNum = function(self, count, notAutoHide)
  -- function num : 0_2 , upvalues : _ENV
  if count == nil and not notAutoHide and not IsNull((self.ui).count) then
    ((self.ui).count):SetActive(false)
  end
  ;
  ((self.ui).count):SetActive(true)
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_TotalCount).text = tostring(count)
end

UINBaseItemWithCount.SetFade = function(self, value)
  -- function num : 0_3
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).Fade).alpha = value
end

UINBaseItemWithCount.GetFade = function(self)
  -- function num : 0_4
  return (self.ui).Fade
end

UINBaseItemWithCount.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (self.baseItem):Delete()
  ;
  (base.OnDelete)(self)
end

return UINBaseItemWithCount

