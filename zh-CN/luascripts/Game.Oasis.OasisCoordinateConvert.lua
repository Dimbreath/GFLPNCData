-- params : ...
-- function num : 0 , upvalues : _ENV
local OasisCoordinateConvert = {}
local hexSize = (ConfigData.game_config).OasisHexSize
local sqrt3 = (math.sqrt)(3)
local hexHeight = hexSize * 2
local hexWidth = hexSize * sqrt3
local size3Offset, size4Offset = nil, nil
local Init = function()
  -- function num : 0_0 , upvalues : size3Offset, OasisCoordinateConvert, _ENV, size4Offset
  size3Offset = (OasisCoordinateConvert.ToUnity)(((Vector2.New)(0, 1) + (Vector2.New)(1, 0)) / 3)
  size4Offset = (OasisCoordinateConvert.ToUnity)((Vector2.New)(1, 1) / 2)
end

OasisCoordinateConvert.ToUnity = function(vector2)
  -- function num : 0_1 , upvalues : _ENV, hexSize, sqrt3
  local z = -vector2.x - vector2.y
  local position = (Vector3.New)()
  position.x = hexSize * sqrt3 * (vector2.x + z / 2)
  position.z = hexSize * z * 3 / 2
  return position
end

OasisCoordinateConvert.ToOasis = function(vector3)
  -- function num : 0_2 , upvalues : _ENV, sqrt3, hexSize
  local position = (Vector2.New)()
  position.x = (sqrt3 / 3 * vector3.x - 0.33333333333333 * vector3.z) / hexSize
  local z = 0.66666666666667 * vector3.z / hexSize
  position.y = -z - position.x
  local rx = (math.floor)(position.x + 0.5)
  local ry = (math.floor)(position.y + 0.5)
  local rz = (math.floor)(z + 0.5)
  local xDiff = (math.abs)(rx - position.x)
  local yDiff = (math.abs)(ry - position.y)
  local zDiff = (math.abs)(rz - z)
  if yDiff < xDiff and zDiff < xDiff then
    rx = -ry - rz
  else
    if zDiff < yDiff then
      ry = -(rx) - rz
    else
      rz = -(rx) - (ry)
    end
  end
  position.x = rx
  position.y = ry
  return position
end

OasisCoordinateConvert.ToUnityCenterPos = function(vector2, size)
  -- function num : 0_3 , upvalues : _ENV, OasisCoordinateConvert, size3Offset, size4Offset
  if #size ~= 2 then
    error("building size cfg error")
  end
  local position = (OasisCoordinateConvert.ToUnity)(vector2)
  local sizeType = size[1]
  if sizeType == 1 then
    return position
  else
    if sizeType == 2 then
      return position + size3Offset
    else
      if sizeType == 3 then
        return position + size4Offset
      end
    end
  end
end

OasisCoordinateConvert.UnityCenterToOasis = function(vector3, size)
  -- function num : 0_4 , upvalues : _ENV, size3Offset, size4Offset, OasisCoordinateConvert
  if #size ~= 2 then
    error("building size cfg error")
  end
  local sizeType = size[1]
  if sizeType ~= 1 or sizeType == 2 then
    vector3 = vector3 - size3Offset
  else
    if sizeType == 3 then
      vector3 = vector3 - size4Offset
    end
  end
  local pos = (OasisCoordinateConvert.ToOasis)(vector3)
  return pos
end

OasisCoordinateConvert.GetHexWidth = function()
  -- function num : 0_5 , upvalues : hexWidth
  return hexWidth
end

OasisCoordinateConvert.GetHexHeight = function()
  -- function num : 0_6 , upvalues : hexHeight
  return hexHeight
end

OasisCoordinateConvert.GetHexArea = function(hexPos, size)
  -- function num : 0_7 , upvalues : _ENV
  local area = {}
  if #size ~= 2 then
    error("building size cfg error")
  end
  local sizeType = size[1]
  if sizeType == 1 then
    local radius = size[2]
    local n = radius - 1
    for x = -n, n do
      for y = (math.max)(-n, -x - n), (math.min)(n, -x + n) do
        local pos = (Vector2.New)(hexPos.x + x, hexPos.y + y)
        ;
        (table.insert)(area, pos)
      end
    end
  else
    do
      if sizeType == 2 then
        (table.insert)(area, hexPos)
        local pos = (Vector2.New)(hexPos.x, hexPos.y + 1)
        ;
        (table.insert)(area, pos)
        pos = (Vector2.New)(hexPos.x + 1, hexPos.y)
        ;
        (table.insert)(area, pos)
      else
        do
          if sizeType == 3 then
            (table.insert)(area, hexPos)
            local pos = (Vector2.New)(hexPos.x, hexPos.y + 1)
            ;
            (table.insert)(area, pos)
            pos = (Vector2.New)(hexPos.x + 1, hexPos.y)
            ;
            (table.insert)(area, pos)
            pos = (Vector2.New)(hexPos.x + 1, hexPos.y + 1)
            ;
            (table.insert)(area, pos)
          end
          do
            return area
          end
        end
      end
    end
  end
end

OasisCoordinateConvert.HexDistance = function(a, b)
  -- function num : 0_8 , upvalues : _ENV
  local az = -a.x - a.y
  local bz = -b.x - b.y
  local distance = ((math.abs)(a.x - b.x) + (math.abs)(a.y - b.y) + (math.abs)(az - bz)) // 2
  return distance
end

OasisCoordinateConvert.HexDistance2Center = function(hexPos)
  -- function num : 0_9 , upvalues : OasisCoordinateConvert, _ENV
  local distance = (OasisCoordinateConvert.HexDistance)(hexPos, Vector2.zero)
  return distance
end

Init()
return OasisCoordinateConvert

