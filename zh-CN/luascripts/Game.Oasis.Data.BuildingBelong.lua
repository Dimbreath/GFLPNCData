-- params : ...
-- function num : 0 , upvalues : _ENV
local BuildingBelong = {Oasis = 1, Sector = 2}
BuildingBelong.SectorType = {production = 201, Addition = 202}
BuildingBelong.CheckBelong = function(buildingType)
  -- function num : 0_0 , upvalues : BuildingBelong, _ENV
  if buildingType >= 100 and buildingType <= 109 then
    return BuildingBelong.Oasis
  else
    if buildingType >= 200 and buildingType <= 209 then
      return BuildingBelong.Sector
    else
      error("建筑type错误： " .. tostring(buildingType))
    end
  end
end

return BuildingBelong

