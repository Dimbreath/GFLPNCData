local UINChartAreaSector = class("UINChartAreaSector", UIBaseNode)
local base = UIBaseNode
UINChartAreaSector.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.defaultColor = ((self.ui).img).color
end

UINChartAreaSector.InitAthAreaSector = function(self, angleOffset, ratio, color)
  -- function num : 0_1
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R4 in 'UnsetPending'

  ((self.ui).img).fillAmount = ratio
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R4 in 'UnsetPending'

  if color == nil then
    ((self.ui).img).color = self.defaultColor
  else
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).img).color = color
  end
  local eAngle = (self.transform).localEulerAngles
  eAngle.z = angleOffset
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.transform).localEulerAngles = eAngle
end

UINChartAreaSector.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINChartAreaSector

