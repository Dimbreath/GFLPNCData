local UINChartArea = class("UINChartArea", UIBaseNode)
local base = UIBaseNode
local UINChartAreaSector = require("Game.Arithmetic.AthMain.Chart.UINChartAreaSector")
local ArthmeticEnum = require("Game.Arithmetic.ArthmeticEnum")
UINChartArea.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINChartAreaSector
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  ((self.ui).img_Char):SetActive(false)
  self.areaSectorPool = (UIItemPool.New)(UINChartAreaSector, (self.ui).img_Char)
end

UINChartArea.InitAthChartArea = function(self, spaceData, allSpace, totalAngle, curAngleOffset)
  -- function num : 0_1 , upvalues : _ENV, ArthmeticEnum
  local eAngle = (self.transform).localEulerAngles
  eAngle.z = curAngleOffset
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (self.transform).localEulerAngles = eAngle
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).rootImg).fillAmount = spaceData.maxSpace / allSpace * totalAngle / 360
  local sectorAngleOffset = -spaceData.lockedSpace / allSpace * totalAngle
  ;
  (self.areaSectorPool):HideAll()
  if spaceData.unusedSpace > 0 then
    local item = (self.areaSectorPool):GetOne()
    local angle = spaceData.unusedSpace / allSpace * totalAngle
    local ratio = angle / 360
    item:InitAthAreaSector(sectorAngleOffset, ratio, nil)
    sectorAngleOffset = sectorAngleOffset - angle
  end
  do
    local qualityIdList = {}
    for k,v in pairs(spaceData.qualitySpaceDic) do
      (table.insert)(qualityIdList, k)
    end
    ;
    (table.sort)(qualityIdList)
    for k,quality in ipairs(qualityIdList) do
      local space = (spaceData.qualitySpaceDic)[quality]
      local item = (self.areaSectorPool):GetOne()
      local angle = space / allSpace * totalAngle
      local ratio = angle / 360
      local color = (ArthmeticEnum.AthColor)[quality]
      item:InitAthAreaSector(sectorAngleOffset, ratio, color)
      sectorAngleOffset = sectorAngleOffset - angle
    end
  end
end

UINChartArea.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (self.areaSectorPool):DeleteAll()
  ;
  (base.OnDelete)(self)
end

return UINChartArea

