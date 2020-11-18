-- params : ...
-- function num : 0 , upvalues : _ENV
local AthFilterEnum = {}
AthFilterEnum.eAttribute = {}
AthFilterEnum.SetEAttribute = function(attrList)
  -- function num : 0_0 , upvalues : AthFilterEnum
  AthFilterEnum.eAttribute = attrList
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (AthFilterEnum.eKindMaxCount)[(AthFilterEnum.eKindType).Attribute] = #AthFilterEnum.eAttribute
end

AthFilterEnum.eKindType = {Quality = 1, Attribute = 2}
AthFilterEnum.eKindMaxCount = {[(AthFilterEnum.eKindType).Quality] = 3, [(AthFilterEnum.eKindType).Attribute] = #AthFilterEnum.eAttribute}
AthFilterEnum.GetQuality = function(qualityIndex)
  -- function num : 0_1
  return qualityIndex + 2
end

AthFilterEnum.GetQualityIndex = function(quality)
  -- function num : 0_2
  return quality - 2
end

return AthFilterEnum

