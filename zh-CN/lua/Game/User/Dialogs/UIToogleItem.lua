local UIToogleItem = class("UIToogleItem", UIBaseNode)
local base = UIBaseNode
UIToogleItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).tog_SwitchItem, self, self.OnSwitchValueChange)
end

UIToogleItem.InitData = function(self, clickFun)
  -- function num : 0_1
  self.changeValueFunc = clickFun
end

UIToogleItem.SelectActivityTag = function(self)
  -- function num : 0_2
  if ((self.ui).tog_SwitchItem).isOn then
    self:OnSwitchValueChange(true)
  else
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).tog_SwitchItem).isOn = true
  end
end

UIToogleItem.OnSwitchValueChange = function(self, flag)
  -- function num : 0_3
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  if flag then
    ((self.ui).tog_Txt).color = (self.ui).color_Txtselected
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).tog_Icon).color = (self.ui).color_IconSelected
  else
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).tog_Txt).color = (self.ui).color_TxtUnselect
    -- DECOMPILER ERROR at PC22: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).tog_Icon).color = (self.ui).color_IconUnselect
  end
  if self.changeValueFunc ~= nil then
    (self.changeValueFunc)(self, flag)
  end
end

UIToogleItem.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UIToogleItem

