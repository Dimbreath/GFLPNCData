local UINDmRoomOutputItem = class("UINDmRoomOutputItem", UIBaseNode)
local base = UIBaseNode
UINDmRoomOutputItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).rootBtn, self, self._OnClickRoot)
end

UINDmRoomOutputItem.InitUINDmRoomOutputItem = function(self, tmProductData, clickFunc)
  -- function num : 0_1 , upvalues : _ENV
  self.tmProductData = tmProductData
  self.clickFunc = clickFunc
  local itemCfg = (ConfigData.item)[tmProductData.itemId]
  if itemCfg == nil then
    return 
  end
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).img_ItemIcon).sprite = CRH:GetSpriteByItemConfig(itemCfg)
  ;
  ((self.ui).tex_ItemNum):SetIndex(0, tostring(tmProductData.realNum))
end

UINDmRoomOutputItem._OnClickRoot = function(self)
  -- function num : 0_2
  if self.clickFunc ~= nil then
    (self.clickFunc)(self.tmProductData, self)
  end
end

UINDmRoomOutputItem.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UINDmRoomOutputItem

