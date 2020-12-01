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
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (AthFilterEnum.eKindMaxCount)[(AthFilterEnum.eKindType).SubAttribute] = #AthFilterEnum.eAttribute
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (AthFilterEnum.eKindMaxWithMatCount)[(AthFilterEnum.eKindType).Attribute] = #AthFilterEnum.eAttribute
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (AthFilterEnum.eKindMaxWithMatCount)[(AthFilterEnum.eKindType).SubAttribute] = #AthFilterEnum.eAttribute
end

AthFilterEnum.GetAttrIndex = function(attrId)
  -- function num : 0_1 , upvalues : _ENV, AthFilterEnum
  for index,id in ipairs(AthFilterEnum.eAttribute) do
    if attrId == id then
      return index
    end
  end
  error("Cant getAttrIndex, attrId = " .. tostring(attrId))
end

AthFilterEnum.eKindType = {Area = 1, Quality = 2, Attribute = 3, SubAttribute = 4}
AthFilterEnum.eKindMaxCount = {[(AthFilterEnum.eKindType).Area] = (ConfigData.game_config).athSlotCount, [(AthFilterEnum.eKindType).Quality] = 3, [(AthFilterEnum.eKindType).Attribute] = #AthFilterEnum.eAttribute, [(AthFilterEnum.eKindType).SubAttribute] = #AthFilterEnum.eAttribute}
AthFilterEnum.eKindMaxWithMatCount = {[(AthFilterEnum.eKindType).Area] = (ConfigData.game_config).athSlotCount, [(AthFilterEnum.eKindType).Quality] = 4, [(AthFilterEnum.eKindType).Attribute] = #AthFilterEnum.eAttribute, [(AthFilterEnum.eKindType).SubAttribute] = #AthFilterEnum.eAttribute}
AthFilterEnum.GetQuality = function(qualityIndex)
  -- function num : 0_2
  return qualityIndex + 2
end

AthFilterEnum.GetQualityIndex = function(quality)
  -- function num : 0_3
  return quality - 2
end

return AthFilterEnum

-- params : ...
-- function num : 0 , upvalues : _ENV
local AthFilterEnum = {}
AthFilterEnum.eAttribute = {}
AthFilterEnum.SetEAttribute = function(attrList)
    -- function num : 0_0 , upvalues : AthFilterEnum
    AthFilterEnum.eAttribute = attrList -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'
    ;
    (AthFilterEnum.eKindMaxCount)[(AthFilterEnum.eKindType).Attribute] =
        #AthFilterEnum.eAttribute -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'
    ;
    (AthFilterEnum.eKindMaxCount)[(AthFilterEnum.eKindType).SubAttribute] =
        #AthFilterEnum.eAttribute -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'
    ;
    (AthFilterEnum.eKindMaxWithMatCount)[(AthFilterEnum.eKindType).Attribute] =
        #AthFilterEnum.eAttribute -- DECOMPILER ERROR at PC24: Confused about usage of register: R1 in 'UnsetPending'
    ;
    (AthFilterEnum.eKindMaxWithMatCount)[(AthFilterEnum.eKindType).SubAttribute] =
        #AthFilterEnum.eAttribute
end

AthFilterEnum.GetAttrIndex = function(attrId)
    -- function num : 0_1 , upvalues : _ENV, AthFilterEnum
    for index, id in ipairs(AthFilterEnum.eAttribute) do
        if attrId == id then return index end
    end
    error("Cant getAttrIndex, attrId = " .. tostring(attrId))
end

AthFilterEnum.eKindType = {
    Area = 1,
    Quality = 2,
    Attribute = 3,
    SubAttribute = 4
}
AthFilterEnum.eKindMaxCount = {
    [(AthFilterEnum.eKindType).Area] = (ConfigData.game_config).athSlotCount,
    [(AthFilterEnum.eKindType).Quality] = 3,
    [(AthFilterEnum.eKindType).Attribute] = #AthFilterEnum.eAttribute,
    [(AthFilterEnum.eKindType).SubAttribute] = #AthFilterEnum.eAttribute
}
AthFilterEnum.eKindMaxWithMatCount = {
    [(AthFilterEnum.eKindType).Area] = (ConfigData.game_config).athSlotCount,
    [(AthFilterEnum.eKindType).Quality] = 4,
    [(AthFilterEnum.eKindType).Attribute] = #AthFilterEnum.eAttribute,
    [(AthFilterEnum.eKindType).SubAttribute] = #AthFilterEnum.eAttribute
}
AthFilterEnum.GetQuality = function(qualityIndex)
    -- function num : 0_2
    return qualityIndex + 2
end

AthFilterEnum.GetQualityIndex = function(quality)
    -- function num : 0_3
    return quality - 2
end

return AthFilterEnum

