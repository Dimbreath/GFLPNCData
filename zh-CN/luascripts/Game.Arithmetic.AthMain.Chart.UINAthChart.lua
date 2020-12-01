-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthChart = class("UINAthChart", UIBaseNode)
local base = UIBaseNode
local UINChartArea = require("Game.Arithmetic.AthMain.Chart.UINChartArea")
local UINChartAreaName = require("Game.Arithmetic.AthMain.Chart.UINChartAreaName")
UINAthChart.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINChartArea, UINChartAreaName
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.bigAreaChart = (UINChartArea.New)()
  ;
  (self.bigAreaChart):Init((self.ui).charBigItem)
  ;
  ((self.ui).charSmallItem):SetActive(false)
  self.smallAreaPool = (UIItemPool.New)(UINChartArea, (self.ui).charSmallItem)
  ;
  ((self.ui).tex_Area):SetActive(false)
  self.areaNamePool = (UIItemPool.New)(UINChartAreaName, (self.ui).tex_Area)
end

UINAthChart.InitAthChart = function(self, heroId, athAreaCurSpaceList, athAreaMaxSpaceList)
  -- function num : 0_1 , upvalues : _ENV
  local allSpace = 0
  local allSpaceDataList = {}
  local largestAreaId = nil
  local largestAreaSpace = 0
  for id,maxSpace in ipairs(athAreaMaxSpaceList) do
    allSpace = allSpace + maxSpace
    if largestAreaSpace < maxSpace then
      largestAreaSpace = maxSpace
      largestAreaId = id
    end
    local curSpace = athAreaCurSpaceList[id]
    local lockedSpace = maxSpace - curSpace
    local unusedSpace = curSpace
    local qualitySpaceDic = {}
    local athList = (PlayerDataCenter.allAthData):GetHeroAthList(heroId, id)
    for k,athData in ipairs(athList) do
      if qualitySpaceDic[athData.quality] == nil then
        qualitySpaceDic[athData.quality] = 0
      end
      unusedSpace = unusedSpace - athData.size
      qualitySpaceDic[athData.quality] = athData.size + qualitySpaceDic[athData.quality]
    end
    local spaceData = {maxSpace = maxSpace, lockedSpace = lockedSpace, unusedSpace = unusedSpace, qualitySpaceDic = qualitySpaceDic}
    allSpaceDataList[id] = spaceData
  end
  ;
  (self.smallAreaPool):HideAll()
  ;
  (self.areaNamePool):HideAll()
  local totalAngle = 360 - (self.ui).space * #allSpaceDataList
  local curAngleOffset = 0
  for id,spaceData in ipairs(allSpaceDataList) do
    local areaItem = nil
    if largestAreaId == id then
      areaItem = self.bigAreaChart
    else
      areaItem = (self.smallAreaPool):GetOne()
    end
    local angle = spaceData.maxSpace / (allSpace) * totalAngle
    areaItem:InitAthChartArea(spaceData, allSpace, totalAngle, curAngleOffset)
    local areaName = (self.areaNamePool):GetOne()
    local areaCfg = (ConfigData.ath_area)[id]
    if areaCfg == nil then
      error("Can\'t get ath areaCfg, id == " .. id)
    else
      local posIndex = (math.ceil)((-curAngleOffset + spaceData.maxSpace / (allSpace) / 2 * totalAngle) / 90)
      if posIndex > 4 or posIndex < 1 then
        warn("Ath area name pos index error,index = " .. tostring(posIndex))
      end
      local namePos = ((self.ui).areaNamePos)[posIndex]
      areaName:InitAthChartAreaName(areaCfg.name1, namePos)
      curAngleOffset = curAngleOffset - angle
      curAngleOffset = curAngleOffset - (self.ui).space
    end
  end
end

UINAthChart.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (self.smallAreaPool):DeleteAll()
  ;
  (self.areaNamePool):DeleteAll()
  ;
  (self.bigAreaChart):Delete()
  ;
  (base.OnDelete)(self)
end

return UINAthChart

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthChart = class("UINAthChart", UIBaseNode)
local base = UIBaseNode
local UINChartArea = require("Game.Arithmetic.AthMain.Chart.UINChartArea")
local UINChartAreaName = require(
                             "Game.Arithmetic.AthMain.Chart.UINChartAreaName")
UINAthChart.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, UINChartArea, UINChartAreaName
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
    self.bigAreaChart = (UINChartArea.New)();
    (self.bigAreaChart):Init((self.ui).charBigItem);
    ((self.ui).charSmallItem):SetActive(false)
    self.smallAreaPool = (UIItemPool.New)(UINChartArea, (self.ui).charSmallItem);
    ((self.ui).tex_Area):SetActive(false)
    self.areaNamePool = (UIItemPool.New)(UINChartAreaName, (self.ui).tex_Area)
end

UINAthChart.InitAthChart = function(self, heroId, athAreaCurSpaceList,
                                    athAreaMaxSpaceList)
    -- function num : 0_1 , upvalues : _ENV
    local allSpace = 0
    local allSpaceDataList = {}
    local largestAreaId = nil
    local largestAreaSpace = 0
    for id, maxSpace in ipairs(athAreaMaxSpaceList) do
        allSpace = allSpace + maxSpace
        if largestAreaSpace < maxSpace then
            largestAreaSpace = maxSpace
            largestAreaId = id
        end
        local curSpace = athAreaCurSpaceList[id]
        local lockedSpace = maxSpace - curSpace
        local unusedSpace = curSpace
        local qualitySpaceDic = {}
        local athList = (PlayerDataCenter.allAthData):GetHeroAthList(heroId, id)
        for k, athData in ipairs(athList) do
            if qualitySpaceDic[athData.quality] == nil then
                qualitySpaceDic[athData.quality] = 0
            end
            unusedSpace = unusedSpace - athData.size
            qualitySpaceDic[athData.quality] =
                athData.size + qualitySpaceDic[athData.quality]
        end
        local spaceData = {
            maxSpace = maxSpace,
            lockedSpace = lockedSpace,
            unusedSpace = unusedSpace,
            qualitySpaceDic = qualitySpaceDic
        }
        allSpaceDataList[id] = spaceData
    end
    (self.smallAreaPool):HideAll();
    (self.areaNamePool):HideAll()
    local totalAngle = 360 - (self.ui).space * #allSpaceDataList
    local curAngleOffset = 0
    for id, spaceData in ipairs(allSpaceDataList) do
        local areaItem = nil
        if largestAreaId == id then
            areaItem = self.bigAreaChart
        else
            areaItem = (self.smallAreaPool):GetOne()
        end
        local angle = spaceData.maxSpace / (allSpace) * totalAngle
        areaItem:InitAthChartArea(spaceData, allSpace, totalAngle,
                                  curAngleOffset)
        local areaName = (self.areaNamePool):GetOne()
        local areaCfg = (ConfigData.ath_area)[id]
        if areaCfg == nil then
            error("Can\'t get ath areaCfg, id == " .. id)
        else
            local posIndex = (math.ceil)(
                                 (-curAngleOffset + spaceData.maxSpace /
                                     (allSpace) / 2 * totalAngle) / 90)
            if posIndex > 4 or posIndex < 1 then
                warn("Ath area name pos index error,index = " ..
                         tostring(posIndex))
            end
            local namePos = ((self.ui).areaNamePos)[posIndex]
            areaName:InitAthChartAreaName(areaCfg.name1, namePos)
            curAngleOffset = curAngleOffset - angle
            curAngleOffset = curAngleOffset - (self.ui).space
        end
    end
end

UINAthChart.OnDelete = function(self)
    -- function num : 0_2 , upvalues : base
    (self.smallAreaPool):DeleteAll();
    (self.areaNamePool):DeleteAll();
    (self.bigAreaChart):Delete();
    (base.OnDelete)(self)
end

return UINAthChart

