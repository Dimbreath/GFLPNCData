-- params : ...
-- function num : 0 , upvalues : _ENV
local UINChartAreaName = class("UINChartAreaName", UIBaseNode)
local base = UIBaseNode
UINChartAreaName.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINChartAreaName.InitAthChartAreaName = function(self, name, anchoredPosition)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

  if not anchoredPosition then
    (self.transform).anchoredPosition = Vector2.zero
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).tex_Name).text = name
  end
end

UINChartAreaName.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINChartAreaName

