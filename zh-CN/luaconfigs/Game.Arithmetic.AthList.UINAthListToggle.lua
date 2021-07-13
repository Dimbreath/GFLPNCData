-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthListToggle = class("UINAthListToggle", UIBaseNode)
local base = UIBaseNode
UINAthListToggle.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).tog_Root, self, self._OnClickToggle)
end

UINAthListToggle.InitAthListToggle = function(self, selectFunc)
  -- function num : 0_1
  self.selectFunc = selectFunc
end

UINAthListToggle.SetAthListTogSelect = function(self, select)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).tog_Root).isOn = select
end

UINAthListToggle._OnClickToggle = function(self, isOn)
  -- function num : 0_3 , upvalues : _ENV
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  if not isOn or not Color.black then
    ((self.ui).text).color = Color.white
    if self.selectFunc ~= nil then
      (self.selectFunc)(isOn)
    end
  end
end

UINAthListToggle.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UINAthListToggle

