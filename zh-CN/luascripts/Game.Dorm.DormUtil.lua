-- params : ...
-- function num : 0 , upvalues : _ENV
local DormUtil = {}
local RoomPosOffset = 256
local eDormFntType = require("Game.Dorm.Enum.eDormFntType")
local sinTab = {[0] = 0, [90] = 1, [180] = 0, [270] = -1, [360] = 0}
local cosTab = {[0] = 1, [90] = 0, [180] = -1, [270] = 0, [360] = 1}
DormUtil.FntForOffset = {
{x = -1, y = -1}
, 
{x = -1, y = 0}
, 
{x = -1, y = 1}
, 
{x = 0, y = -1}
, 
{x = 0, y = 1}
, 
{x = 1, y = -1}
, 
{x = 1, y = 0}
, 
{x = 1, y = 1}
}
local cs_Screen = (CS.UnityEngine).Screen
DormUtil.NearInterPointDistance = 100 * cs_Screen.width / 1920
DormUtil.CharacterNoShowPos = (Vector3.New)(9999, 9999, 9999)
DormUtil.HexToUnityCoord = function(x, y)
  -- function num : 0_0 , upvalues : _ENV
  local z = -x - y
  return (Vector3.New)(y * (ConfigData.game_config).HouseSizeWidth, z * (ConfigData.game_config).HouseSizeHeight, x * (ConfigData.game_config).HouseSizeWidth)
end

DormUtil.RoomCoordToXY = function(pos)
  -- function num : 0_1 , upvalues : RoomPosOffset, _ENV
  local x = (pos >> 16) - RoomPosOffset
  local y = (pos & CommonUtil.UInt16Max) - RoomPosOffset
  return x, y
end

DormUtil.XYToRoomCoord = function(x, y)
  -- function num : 0_2 , upvalues : RoomPosOffset
  local pos = x + RoomPosOffset << 16 | y + RoomPosOffset
  return pos
end

DormUtil.FntCoord2XY = function(pos)
  -- function num : 0_3 , upvalues : _ENV
  local x = pos >> 16
  local y = pos & CommonUtil.UInt16Max
  return x, y
end

DormUtil.XYCoord2Fnt = function(x, y)
  -- function num : 0_4
  local pos = x << 16 | y
  return pos
end

DormUtil.FntCoord2Unity = function(x, y, fntType)
  -- function num : 0_5 , upvalues : _ENV, eDormFntType
  local uX = x * (ConfigData.game_config).HouseGridWidth
  local uY = y * (ConfigData.game_config).HouseGridWidth
  local unityPos = nil
  if fntType == eDormFntType.Wall then
    unityPos = (Vector3.New)(-uX, -uY, 0)
  else
    unityPos = (Vector3.New)(uY, 0, uX)
  end
  return unityPos
end

DormUtil.GetFntUnityCoord = function(x, y)
  -- function num : 0_6 , upvalues : DormUtil, eDormFntType
  return (DormUtil.FntCoord2Unity)(x, y, eDormFntType.Furniture)
end

DormUtil.UnityCoord2Fnt = function(pos, fntType)
  -- function num : 0_7 , upvalues : eDormFntType, _ENV
  local x, y = nil, nil
  if fntType == eDormFntType.Wall then
    x = -pos.x / (ConfigData.game_config).HouseGridWidth
    y = -pos.y / (ConfigData.game_config).HouseGridWidth
  else
    x = pos.z / (ConfigData.game_config).HouseGridWidth
    y = pos.x / (ConfigData.game_config).HouseGridWidth
  end
  x = (math.floor)(x + 0.5)
  y = (math.floor)(y + 0.5)
  return x, y
end

DormUtil.GetFntArea = function(posX, posY, sizeX, sizeY, angle)
  -- function num : 0_8 , upvalues : cosTab, sinTab, _ENV
  local areaList = {}
  for i = 0, sizeX - 1 do
    for j = 0, sizeY - 1 do
      local x = i
      local y = j
      local pos = {x = x * cosTab[angle] - y * sinTab[angle] + posX, y = x * sinTab[angle] + y * cosTab[angle] + posY}
      ;
      (table.insert)(areaList, pos)
    end
  end
  return areaList
end

DormUtil.FntAreaOutMap = function(posX, posY, sizeX, sizeY, angle, fntType)
  -- function num : 0_9 , upvalues : _ENV, cosTab, sinTab, eDormFntType
  local mapX = (ConfigData.game_config).HouseGridCount - 1
  local mapY = (ConfigData.game_config).HouseHeightCount - 1
  local areaList = {
{0, 0}
}
  if sizeX > 1 then
    (table.insert)(areaList, {sizeX - 1, 0})
  end
  if sizeY > 1 then
    (table.insert)(areaList, {0, sizeY - 1})
  end
  if sizeX > 1 and sizeY > 1 then
    (table.insert)(areaList, {sizeX - 1, sizeY - 1})
  end
  local outX = false
  local outY = false
  local offsetX = 0
  local offsetY = 0
  for k,v in pairs(areaList) do
    local x, y = v[1], v[2]
    local areaX = x * cosTab[angle] - y * sinTab[angle] + posX
    local areaY = x * sinTab[angle] + y * cosTab[angle] + posY
    if areaX < 0 then
      outX = true
      offsetX = (math.max)(-areaX, offsetX)
    else
      if mapX < areaX then
        outX = true
        offsetX = (math.min)(mapX - areaX, offsetX)
      end
    end
    if fntType == eDormFntType.Wall then
      if areaY < 0 then
        outY = true
        offsetY = (math.max)(offsetY, -areaY)
      else
        if mapY < areaY then
          outY = true
          offsetY = (math.min)(offsetY, mapY - areaY)
        end
      end
    else
      if areaY < 0 then
        outY = true
        offsetY = (math.max)(offsetY, -areaY)
      else
        if mapX < areaY then
          outY = true
          offsetY = (math.min)(offsetY, mapX - areaY)
        end
      end
    end
  end
  local newX = posX + offsetX
  local newY = posY + offsetY
  return outX, outY, newX, newY
end

DormUtil.FntPosOutMap = function(x, y, fntType)
  -- function num : 0_10 , upvalues : _ENV, eDormFntType
  local sizeX = (ConfigData.game_config).HouseGridCount
  local sizeY = (ConfigData.game_config).HouseHeightCount
  if x >= 0 and sizeX > x and y >= 0 and sizeY > y then
    do return fntType ~= eDormFntType.Wall end
    do return x < 0 or sizeX <= x or y < 0 or sizeX <= y end
    -- DECOMPILER ERROR: 4 unprocessed JMP targets
  end
end

DormUtil.FntSize2Unity = function(sizeX, sizeY, fntType)
  -- function num : 0_11 , upvalues : _ENV, eDormFntType
  local uX = sizeX * (ConfigData.game_config).HouseGridWidth
  local uY = sizeY * (ConfigData.game_config).HouseGridWidth
  if fntType == eDormFntType.Wall then
    return (Vector3.New)(uX, 1, uY)
  else
    return (Vector3.New)(uY, 1, uX)
  end
end

DormUtil.AddFntToMapDic = function(mapDic, posX, posY, sizeX, sizeY, angle)
  -- function num : 0_12 , upvalues : cosTab, sinTab, DormUtil
  for x = 0, sizeX - 1 do
    for y = 0, sizeY - 1 do
      local curx = x * cosTab[angle] - y * sinTab[angle] + posX
      local cury = x * sinTab[angle] + y * cosTab[angle] + posY
      local pos = (DormUtil.XYCoord2Fnt)(curx, cury)
      mapDic[pos] = 1
    end
  end
end

DormUtil.IsFntCoordLegal = function(x, y)
  -- function num : 0_13 , upvalues : _ENV
  if x < 0 or (ConfigData.game_config).HouseGridCount <= x then
    return false
  end
  if y < 0 or (ConfigData.game_config).HouseGridCount <= y then
    return false
  end
  return true
end

DormUtil.GetFntOffsetCoord = function(fntX, fntY, fntR, x, y)
  -- function num : 0_14 , upvalues : cosTab, sinTab
  local dstX = x * cosTab[fntR] - y * sinTab[fntR] + fntX
  local dstY = x * sinTab[fntR] + y * cosTab[fntR] + fntY
  return dstX, dstY
end

return DormUtil

-- params : ...
-- function num : 0 , upvalues : _ENV
local DormUtil = {}
local RoomPosOffset = 256
local eDormFntType = require("Game.Dorm.Enum.eDormFntType")
local sinTab = {[0] = 0, [90] = 1, [180] = 0, [270] = -1, [360] = 0}
local cosTab = {[0] = 1, [90] = 0, [180] = -1, [270] = 0, [360] = 1}
DormUtil.FntForOffset = {
    {x = -1, y = -1}, {x = -1, y = 0}, {x = -1, y = 1}, {x = 0, y = -1},
    {x = 0, y = 1}, {x = 1, y = -1}, {x = 1, y = 0}, {x = 1, y = 1}
}
local cs_Screen = (CS.UnityEngine).Screen
DormUtil.NearInterPointDistance = 100 * cs_Screen.width / 1920
DormUtil.CharacterNoShowPos = (Vector3.New)(9999, 9999, 9999)
DormUtil.HexToUnityCoord = function(x, y)
    -- function num : 0_0 , upvalues : _ENV
    local z = -x - y
    return (Vector3.New)(y * (ConfigData.game_config).HouseSizeWidth,
                         z * (ConfigData.game_config).HouseSizeHeight,
                         x * (ConfigData.game_config).HouseSizeWidth)
end

DormUtil.RoomCoordToXY = function(pos)
    -- function num : 0_1 , upvalues : RoomPosOffset, _ENV
    local x = (pos >> 16) - RoomPosOffset
    local y = (pos & CommonUtil.UInt16Max) - RoomPosOffset
    return x, y
end

DormUtil.XYToRoomCoord = function(x, y)
    -- function num : 0_2 , upvalues : RoomPosOffset
    local pos = x + RoomPosOffset << 16 | y + RoomPosOffset
    return pos
end

DormUtil.FntCoord2XY = function(pos)
    -- function num : 0_3 , upvalues : _ENV
    local x = pos >> 16
    local y = pos & CommonUtil.UInt16Max
    return x, y
end

DormUtil.XYCoord2Fnt = function(x, y)
    -- function num : 0_4
    local pos = x << 16 | y
    return pos
end

DormUtil.FntCoord2Unity = function(x, y, fntType)
    -- function num : 0_5 , upvalues : _ENV, eDormFntType
    local uX = x * (ConfigData.game_config).HouseGridWidth
    local uY = y * (ConfigData.game_config).HouseGridWidth
    local unityPos = nil
    if fntType == eDormFntType.Wall then
        unityPos = (Vector3.New)(-uX, -uY, 0)
    else
        unityPos = (Vector3.New)(uY, 0, uX)
    end
    return unityPos
end

DormUtil.GetFntUnityCoord = function(x, y)
    -- function num : 0_6 , upvalues : DormUtil, eDormFntType
    return (DormUtil.FntCoord2Unity)(x, y, eDormFntType.Furniture)
end

DormUtil.UnityCoord2Fnt = function(pos, fntType)
    -- function num : 0_7 , upvalues : eDormFntType, _ENV
    local x, y = nil, nil
    if fntType == eDormFntType.Wall then
        x = -pos.x / (ConfigData.game_config).HouseGridWidth
        y = -pos.y / (ConfigData.game_config).HouseGridWidth
    else
        x = pos.z / (ConfigData.game_config).HouseGridWidth
        y = pos.x / (ConfigData.game_config).HouseGridWidth
    end
    x = (math.floor)(x + 0.5)
    y = (math.floor)(y + 0.5)
    return x, y
end

DormUtil.GetFntArea = function(posX, posY, sizeX, sizeY, angle)
    -- function num : 0_8 , upvalues : cosTab, sinTab, _ENV
    local areaList = {}
    for i = 0, sizeX - 1 do
        for j = 0, sizeY - 1 do
            local x = i
            local y = j
            local pos = {
                x = x * cosTab[angle] - y * sinTab[angle] + posX,
                y = x * sinTab[angle] + y * cosTab[angle] + posY
            };
            (table.insert)(areaList, pos)
        end
    end
    return areaList
end

DormUtil.FntAreaOutMap = function(posX, posY, sizeX, sizeY, angle, fntType)
    -- function num : 0_9 , upvalues : _ENV, cosTab, sinTab, eDormFntType
    local mapX = (ConfigData.game_config).HouseGridCount - 1
    local mapY = (ConfigData.game_config).HouseHeightCount - 1
    local areaList = {{0, 0}}
    if sizeX > 1 then (table.insert)(areaList, {sizeX - 1, 0}) end
    if sizeY > 1 then (table.insert)(areaList, {0, sizeY - 1}) end
    if sizeX > 1 and sizeY > 1 then
        (table.insert)(areaList, {sizeX - 1, sizeY - 1})
    end
    local outX = false
    local outY = false
    local offsetX = 0
    local offsetY = 0
    for k, v in pairs(areaList) do
        local x, y = v[1], v[2]
        local areaX = x * cosTab[angle] - y * sinTab[angle] + posX
        local areaY = x * sinTab[angle] + y * cosTab[angle] + posY
        if areaX < 0 then
            outX = true
            offsetX = (math.max)(-areaX, offsetX)
        else
            if mapX < areaX then
                outX = true
                offsetX = (math.min)(mapX - areaX, offsetX)
            end
        end
        if fntType == eDormFntType.Wall then
            if areaY < 0 then
                outY = true
                offsetY = (math.max)(offsetY, -areaY)
            else
                if mapY < areaY then
                    outY = true
                    offsetY = (math.min)(offsetY, mapY - areaY)
                end
            end
        else
            if areaY < 0 then
                outY = true
                offsetY = (math.max)(offsetY, -areaY)
            else
                if mapX < areaY then
                    outY = true
                    offsetY = (math.min)(offsetY, mapX - areaY)
                end
            end
        end
    end
    local newX = posX + offsetX
    local newY = posY + offsetY
    return outX, outY, newX, newY
end

DormUtil.FntPosOutMap = function(x, y, fntType)
    -- function num : 0_10 , upvalues : _ENV, eDormFntType
    local sizeX = (ConfigData.game_config).HouseGridCount
    local sizeY = (ConfigData.game_config).HouseHeightCount
    if x >= 0 and sizeX > x and y >= 0 and sizeY > y then
        do return fntType ~= eDormFntType.Wall end
        do return x < 0 or sizeX <= x or y < 0 or sizeX <= y end
        -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
end

DormUtil.FntSize2Unity = function(sizeX, sizeY, fntType)
    -- function num : 0_11 , upvalues : _ENV, eDormFntType
    local uX = sizeX * (ConfigData.game_config).HouseGridWidth
    local uY = sizeY * (ConfigData.game_config).HouseGridWidth
    if fntType == eDormFntType.Wall then
        return (Vector3.New)(uX, 1, uY)
    else
        return (Vector3.New)(uY, 1, uX)
    end
end

DormUtil.AddFntToMapDic = function(mapDic, posX, posY, sizeX, sizeY, angle)
    -- function num : 0_12 , upvalues : cosTab, sinTab, DormUtil
    for x = 0, sizeX - 1 do
        for y = 0, sizeY - 1 do
            local curx = x * cosTab[angle] - y * sinTab[angle] + posX
            local cury = x * sinTab[angle] + y * cosTab[angle] + posY
            local pos = (DormUtil.XYCoord2Fnt)(curx, cury)
            mapDic[pos] = 1
        end
    end
end

DormUtil.IsFntCoordLegal = function(x, y)
    -- function num : 0_13 , upvalues : _ENV
    if x < 0 or (ConfigData.game_config).HouseGridCount <= x then
        return false
    end
    if y < 0 or (ConfigData.game_config).HouseGridCount <= y then
        return false
    end
    return true
end

DormUtil.GetFntOffsetCoord = function(fntX, fntY, fntR, x, y)
    -- function num : 0_14 , upvalues : cosTab, sinTab
    local dstX = x * cosTab[fntR] - y * sinTab[fntR] + fntX
    local dstY = x * sinTab[fntR] + y * cosTab[fntR] + fntY
    return dstX, dstY
end

return DormUtil

