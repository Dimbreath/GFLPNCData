-- params : ...
-- function num : 0 , upvalues : _ENV
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
AthSortEnum.GetSortFunc = function(kindType, kindValue)
  -- function num : 0_1 , upvalues : curKindValue, AthSortEnum
  curKindValue = kindValue
  return (AthSortEnum.eSortFunc)[kindType]
end

AthSortEnum.eSortFunc = {[(AthSortEnum.eKindType).GetOrder] = function(a, b)
  -- function num : 0_2 , upvalues : normalSortFunc
  if a.athTs == b.athTs then
    return normalSortFunc(a, b)
  else
    return a.athTs < b.athTs
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end
, [(AthSortEnum.eKindType).Quality] = function(a, b)
  -- function num : 0_3 , upvalues : normalSortFunc
  local qualtyA = a:GetAthQuality()
  local qualtyB = a:GetAthQuality()
  if qualtyA == qualtyB then
    return normalSortFunc(a, b)
  else
    return qualtyB < qualtyA
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end
, [(AthSortEnum.eKindType).Attribute] = function(a, b)
  -- function num : 0_4 , upvalues : _ENV, curKindValue, normalSortFunc
  local attrId = ((ConfigData.game_config).athSortAttrList)[curKindValue]
  local hasAttrA = ((a.athMainAttrCfg).attrtibute_id)[1] == attrId
  local hasAttrB = ((b.athMainAttrCfg).attrtibute_id)[1] == attrId
  if hasAttrA == hasAttrB then
    if hasAttrA then
      local attrValueA = ((a.athMainAttrCfg).attrtibute_num)[1]
      local attrValueB = ((b.athMainAttrCfg).attrtibute_num)[1]
      if attrValueA == attrValueB then
        return normalSortFunc(a, b)
      else
        return attrValueB < attrValueA
      end
    else
      return normalSortFunc(a, b)
    end
  else
    return hasAttrA
  end
  -- DECOMPILER ERROR: 7 unprocessed JMP targets
end
}
return AthSortEnum

