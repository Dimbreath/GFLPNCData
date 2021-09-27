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

UINBaseItemWithCount.InitItemWithCount = function(self, itemCfg, count, clickEvent, wareHouseNum, clickExtrEvent)
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
  (self.baseItem):InitBaseItem(itemCfg, clickEvent, clickExtrEvent)
  self:SetNum(count, nil, wareHouseNum)
  -- DECOMPILER ERROR at PC48: Confused about usage of register: R6 in 'UnsetPending'

  if (self.ui).tex_ItemName ~= nil then
    ((self.ui).tex_ItemName).text = tostring((LanguageUtil.GetLocaleText)(itemCfg.name))
  end
end

UINBaseItemWithCount.EnableButton = function(self, flag)
  -- function num : 0_2
  if self.baseItem ~= nil then
    (self.baseItem):EnableButton(flag)
  end
end

UINBaseItemWithCount.SetNum = function(self, count, notAutoHide, wareHouseNum)
  -- function num : 0_3 , upvalues : _ENV
  if count == nil and not notAutoHide and not IsNull((self.ui).count) then
    ((self.ui).count):SetActive(false)
  end
  if wareHouseNum ~= nil then
    ((self.ui).count):SetActive(true)
    if count <= wareHouseNum then
      ((self.ui).tex_TotalCount):SetIndex(1, tostring(wareHouseNum), tostring(count))
    else
      ;
      ((self.ui).tex_TotalCount):SetIndex(2, tostring(wareHouseNum), tostring(count))
    end
  else
    ;
    ((self.ui).count):SetActive(true)
    if ((self.ui).tex_TotalCount).SetIndex ~= nil then
      ((self.ui).tex_TotalCount):SetIndex(0, tostring(count))
    else
      -- DECOMPILER ERROR at PC73: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((self.ui).tex_TotalCount).text = tostring(count)
    end
  end
end

UINBaseItemWithCount.SetFade = function(self, value)
  -- function num : 0_4
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).Fade).alpha = value
end

UINBaseItemWithCount.GetFade = function(self)
  -- function num : 0_5
  return (self.ui).Fade
end

UINBaseItemWithCount.SetNotNeedAnyJump = function(self, bool)
  -- function num : 0_6
  (self.baseItem):SetNotNeedAnyJump(bool)
end

UINBaseItemWithCount.LoadGetRewardFx = function(self, resloader, xRotate)
  -- function num : 0_7
  (self.baseItem):LoadGetRewardFx(resloader, xRotate)
end

UINBaseItemWithCount.LoadGetGreatRewardFx = function(self, resloader, xRotate)
  -- function num : 0_8
  (self.baseItem):LoadGetGreatRewardFx(resloader, xRotate)
end

UINBaseItemWithCount.LoadGetGreatRewardLoopFx = function(self, xRotate)
  -- function num : 0_9
  (self.baseItem):LoadGetGreatRewardLoopFx(xRotate)
end

UINBaseItemWithCount.CloseGreatRewardLoopFx = function(self)
  -- function num : 0_10
  (self.baseItem):CloseGreatRewardLoopFx()
end

UINBaseItemWithCount.OnDelete = function(self)
  -- function num : 0_11 , upvalues : base
  (self.baseItem):Delete()
  ;
  (base.OnDelete)(self)
end

return UINBaseItemWithCount

