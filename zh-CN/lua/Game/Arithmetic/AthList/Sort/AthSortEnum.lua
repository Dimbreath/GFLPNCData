local AthSortEnum = {}
AthSortEnum.eKindType = {GetOrder = 1, Quality = 2, Attribute = 3}
AthSortEnum.KindTypeMaxCount = 3
AthSortEnum.eKindTypeNum = {[(AthSortEnum.eKindType).GetOrder] = 1, [(AthSortEnum.eKindType).Quality] = 1, [(AthSortEnum.eKindType).Attribute] = #(ConfigData.game_config).athSortAttrList}
local normalSortFunc = function(a, b)
  -- function num : 0_0
  local powerA = a:GetAthFightPower()
  local powerB = b:GetAthFightPower()
  if a.id >= b.id then
    do return powerA ~= powerB end
    do return powerB < powerA end
    -- DECOMPILER ERROR: 4 unprocessed JMP targets
  end
end

local curKindValue = nil
AthSortEnum.GetSortFunc = function(kindType, kindValue, isConsumeSort)
  -- function num : 0_1 , upvalues : curKindValue, AthSortEnum
  curKindValue = kindValue
  if isConsumeSort then
    return (AthSortEnum.eConsumeSortFunc)[kindType]
  end
  return (AthSortEnum.eSortFunc)[kindType]
end

AthSortEnum.eSortFunc = {[(AthSortEnum.eKindType).GetOrder] = function(a, b)
  -- function num : 0_2 , upvalues : normalSortFunc
  local hasBindA = a.bindInfo ~= nil
  local hasBindB = b.bindInfo ~= nil
  if hasBindA == hasBindB then
    if a.athTs == b.athTs then
      return normalSortFunc(a, b)
    else
      return a.athTs < b.athTs
    end
  else
    return hasBindB
  end
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end
, [(AthSortEnum.eKindType).Quality] = function(a, b)
  -- function num : 0_3 , upvalues : normalSortFunc
  local hasBindA = a.bindInfo ~= nil
  local hasBindB = b.bindInfo ~= nil
  local qualtyA = a:GetAthQuality()
  local qualtyB = b:GetAthQuality()
  if hasBindA == hasBindB then
    if qualtyA == qualtyB then
      return normalSortFunc(a, b)
    else
      return qualtyB < qualtyA
    end
  else
    return hasBindB
  end
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end
, [(AthSortEnum.eKindType).Attribute] = function(a, b)
  -- function num : 0_4 , upvalues : _ENV, curKindValue, normalSortFunc
  local hasBindA = a.bindInfo ~= nil
  local hasBindB = b.bindInfo ~= nil
  if hasBindA == hasBindB then
    local attrId = ((ConfigData.game_config).athSortAttrList)[curKindValue]
    local mainAttrIdA = ((a.athMainAttrCfg).attrtibute_id)[1]
    local mainAttrIdB = ((b.athMainAttrCfg).attrtibute_id)[1]
    local attrCfgA = (ConfigData.attribute)[mainAttrIdA]
    local attrCfgB = (ConfigData.attribute)[mainAttrIdB]
    local hasAttrA = mainAttrIdA == attrId or attrCfgA.merge_attribute == attrId
    local hasAttrB = mainAttrIdB == attrId or attrCfgB.merge_attribute == attrId
    local isPersentA = attrCfgA.num_type == 2
    local isPersentB = attrCfgB.num_type == 2
    if hasAttrA == hasAttrB then
      if hasAttrA then
        if isPersentA == isPersentB then
          local attrValueA = ((a.athMainAttrCfg).attrtibute_num)[1]
          local attrValueB = ((b.athMainAttrCfg).attrtibute_num)[1]
          if attrValueA == attrValueB then
            return normalSortFunc(a, b)
          else
            return attrValueB < attrValueA
          end
        else
          return isPersentB
        end
      else
        return normalSortFunc(a, b)
      end
    else
      return hasAttrA
    end
  else
    return hasBindB
  end
  -- DECOMPILER ERROR: 13 unprocessed JMP targets
end
}
AthSortEnum.eConsumeSortFunc = {[(AthSortEnum.eKindType).GetOrder] = (AthSortEnum.eSortFunc)[(AthSortEnum.eKindType).GetOrder], [(AthSortEnum.eKindType).Quality] = function(a, b)
  -- function num : 0_5
  local hasBindA = a.bindInfo ~= nil
  local hasBindB = b.bindInfo ~= nil
  local qualtyA = a:GetAthQuality()
  local qualtyB = b:GetAthQuality()
  local powerA = a:GetAthFightPower()
  local powerB = b:GetAthFightPower()
  if qualtyA == qualtyB then
    if powerA == powerB then
      if a.id >= b.id then
        do return hasBindA ~= hasBindB end
        do return powerA < powerB end
        do return qualtyA < qualtyB end
        do return hasBindB end
        -- DECOMPILER ERROR: 9 unprocessed JMP targets
      end
    end
  end
end
}
return AthSortEnum

