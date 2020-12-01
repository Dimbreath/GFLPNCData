-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthHeroInfo = class("UINAthHeroInfo", UIBaseNode)
local base = UIBaseNode
local UINChartArea = require("Game.Arithmetic.AthMain.Chart.UINChartArea")
local UINAthHeroInfoSuit = require("Game.Arithmetic.AthHeroInfo.UINAthHeroInfoSuit")
local UINAthHeroInfoAreaName = require("Game.Arithmetic.AthHeroInfo.UINAthHeroInfoAreaName")
UINAthHeroInfo.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINChartArea, UINAthHeroInfoAreaName, UINAthHeroInfoSuit
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Root, self, self.__OnClickRoot)
  ;
  ((self.ui).charItem):SetActive(false)
  self.areaPool = (UIItemPool.New)(UINChartArea, (self.ui).charItem)
  ;
  ((self.ui).tex_AreaName):SetActive(false)
  self.areaNamePool = (UIItemPool.New)(UINAthHeroInfoAreaName, (self.ui).tex_AreaName)
  self.suitItemList = {}
  for k,go in ipairs((self.ui).suitItemGoList) do
    local suitItem = (UINAthHeroInfoSuit.New)()
    suitItem:Init(go)
    ;
    (table.insert)(self.suitItemList, suitItem)
  end
  self.__onAthDataUpdate = BindCallback(self, self.__OnAthDataUpdate)
  MsgCenter:AddListener(eMsgEventId.OnAthDataUpdate, self.__onAthDataUpdate)
end

UINAthHeroInfo.InitAthHeroInfo = function(self, heroData, resLoader, withRedDot)
  -- function num : 0_1 , upvalues : _ENV
  self.heroData = heroData
  self.resLoader = resLoader
  local funcUnLockCrtl = ControllerManager:GetController(ControllerTypeId.FunctionUnlock)
  local unlock = funcUnLockCrtl:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Algorithm)
  self.unlock = unlock
  ;
  ((self.ui).lock):SetActive(not unlock)
  ;
  ((self.ui).normal):SetActive(unlock)
  self:RefreshAthHeroInfoChart()
  if unlock then
    self:__RefreshBuleDot()
  else
    ;
    ((self.ui).blueDot):SetActive(false)
  end
end

UINAthHeroInfo.__OnAthDataUpdate = function(self)
  -- function num : 0_2
  if self.unlock then
    self:__RefreshBuleDot()
  end
end

UINAthHeroInfo.__RefreshBuleDot = function(self)
  -- function num : 0_3 , upvalues : _ENV
  ((self.ui).blueDot):SetActive((PlayerDataCenter.allAthData):GetHeroCanLoaded(self.heroData))
end

UINAthHeroInfo.SetShowAthWindowParam = function(self, heroResLoader, addAllTouchFunc, removeAllTouchFunc)
  -- function num : 0_4
  self.canShowAthWindow = true
  self.heroResLoader = heroResLoader
  self.addAllTouchFunc = addAllTouchFunc
  self.removeAllTouchFunc = removeAllTouchFunc
end

UINAthHeroInfo.RefreshAthHeroInfoChart = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if not self.unlock then
    return 
  end
  local athAreaCurSpaceList = (self.heroData):GetAthSlotList()
  local athAreaMaxSpaceList = (self.heroData):GetAthSlotList(true)
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
    local athList = (PlayerDataCenter.allAthData):GetHeroAthList((self.heroData).dataId, id)
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
  local totalAngle = 360 - (self.ui).space * #allSpaceDataList
  local curAngleOffset = 0
  ;
  (self.areaPool):HideAll()
  ;
  (self.areaNamePool):HideAll()
  for id,spaceData in ipairs(allSpaceDataList) do
    local areaItem = (self.areaPool):GetOne()
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
      local nameIndex = posIndex % 2 == 0 and 1 or 0
      areaName:InitAthHeroInfoAreaName(areaCfg.name1, namePos, nameIndex)
      curAngleOffset = curAngleOffset - angle
      curAngleOffset = curAngleOffset - (self.ui).space
    end
  end
  local allAttrDic, slotAttrTab, suitDic = (PlayerDataCenter.allAthData):GetHeroAthAttr((self.heroData).dataId)
  local suitIdList = {}
  for suitId,suitData in pairs(suitDic) do
    (table.insert)(suitIdList, suitId)
  end
  ;
  (table.sort)(suitIdList)
  for k,suitItem in ipairs(self.suitItemList) do
    local suitId = suitIdList[k]
    if suitId == nil then
      suitItem:Hide()
    else
      suitItem:Show()
      local suitData = suitDic[suitId]
      local suitParamCfg = ((ConfigData.ath_suit).suitParamDic)[suitId]
      suitItem:InitAthHeroInfoSuit(suitParamCfg, suitData.curCount, suitData.maxCount)
    end
  end
end

UINAthHeroInfo.__OnClickRoot = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if not self.unlock or not self.canShowAthWindow then
    return 
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.Ath, function(window)
    -- function num : 0_6_0 , upvalues : self
    if window == nil then
      return 
    end
    if self.removeAllTouchFunc ~= nil then
      (self.removeAllTouchFunc)()
    end
    window:InitAth(self.heroData, self.resLoader, self.heroResLoader, self.addAllTouchFunc)
  end
)
  UIManager:HideWindow(UIWindowTypeID.HeroState)
end

UINAthHeroInfo.OnDelete = function(self)
  -- function num : 0_7 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.OnAthDataUpdate, self.__onAthDataUpdate)
  ;
  (self.areaPool):DeleteAll()
  ;
  (self.areaNamePool):DeleteAll()
  ;
  (base.OnDelete)(self)
end

return UINAthHeroInfo

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthHeroInfo = class("UINAthHeroInfo", UIBaseNode)
local base = UIBaseNode
local UINChartArea = require("Game.Arithmetic.AthMain.Chart.UINChartArea")
local UINAthHeroInfoSuit = require(
                               "Game.Arithmetic.AthHeroInfo.UINAthHeroInfoSuit")
local UINAthHeroInfoAreaName = require(
                                   "Game.Arithmetic.AthHeroInfo.UINAthHeroInfoAreaName")
UINAthHeroInfo.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, UINChartArea, UINAthHeroInfoAreaName, UINAthHeroInfoSuit
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddButtonListener)((self.ui).btn_Root, self, self.__OnClickRoot);
    ((self.ui).charItem):SetActive(false)
    self.areaPool = (UIItemPool.New)(UINChartArea, (self.ui).charItem);
    ((self.ui).tex_AreaName):SetActive(false)
    self.areaNamePool = (UIItemPool.New)(UINAthHeroInfoAreaName,
                                         (self.ui).tex_AreaName)
    self.suitItemList = {}
    for k, go in ipairs((self.ui).suitItemGoList) do
        local suitItem = (UINAthHeroInfoSuit.New)()
        suitItem:Init(go);
        (table.insert)(self.suitItemList, suitItem)
    end
    self.__onAthDataUpdate = BindCallback(self, self.__OnAthDataUpdate)
    MsgCenter:AddListener(eMsgEventId.OnAthDataUpdate, self.__onAthDataUpdate)
end

UINAthHeroInfo.InitAthHeroInfo = function(self, heroData, resLoader, withRedDot)
    -- function num : 0_1 , upvalues : _ENV
    self.heroData = heroData
    self.resLoader = resLoader
    local funcUnLockCrtl = ControllerManager:GetController(
                               ControllerTypeId.FunctionUnlock)
    local unlock = funcUnLockCrtl:ValidateUnlock(
                       proto_csmsg_SystemFunctionID.SystemFunctionID_Algorithm)
    self.unlock = unlock;
    ((self.ui).lock):SetActive(not unlock);
    ((self.ui).normal):SetActive(unlock)
    self:RefreshAthHeroInfoChart()
    if unlock then
        self:__RefreshBuleDot()
    else

        ((self.ui).blueDot):SetActive(false)
    end
end

UINAthHeroInfo.__OnAthDataUpdate = function(self)
    -- function num : 0_2
    if self.unlock then self:__RefreshBuleDot() end
end

UINAthHeroInfo.__RefreshBuleDot = function(self)
    -- function num : 0_3 , upvalues : _ENV
    ((self.ui).blueDot):SetActive(
        (PlayerDataCenter.allAthData):GetHeroCanLoaded(self.heroData))
end

UINAthHeroInfo.SetShowAthWindowParam = function(self, heroResLoader,
                                                addAllTouchFunc,
                                                removeAllTouchFunc)
    -- function num : 0_4
    self.canShowAthWindow = true
    self.heroResLoader = heroResLoader
    self.addAllTouchFunc = addAllTouchFunc
    self.removeAllTouchFunc = removeAllTouchFunc
end

UINAthHeroInfo.RefreshAthHeroInfoChart =
    function(self)
        -- function num : 0_5 , upvalues : _ENV
        if not self.unlock then return end
        local athAreaCurSpaceList = (self.heroData):GetAthSlotList()
        local athAreaMaxSpaceList = (self.heroData):GetAthSlotList(true)
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
            local athList = (PlayerDataCenter.allAthData):GetHeroAthList(
                                (self.heroData).dataId, id)
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
        local totalAngle = 360 - (self.ui).space * #allSpaceDataList
        local curAngleOffset = 0;
        (self.areaPool):HideAll();
        (self.areaNamePool):HideAll()
        for id, spaceData in ipairs(allSpaceDataList) do
            local areaItem = (self.areaPool):GetOne()
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
                local nameIndex = posIndex % 2 == 0 and 1 or 0
                areaName:InitAthHeroInfoAreaName(areaCfg.name1, namePos,
                                                 nameIndex)
                curAngleOffset = curAngleOffset - angle
                curAngleOffset = curAngleOffset - (self.ui).space
            end
        end
        local allAttrDic, slotAttrTab, suitDic =
            (PlayerDataCenter.allAthData):GetHeroAthAttr((self.heroData).dataId)
        local suitIdList = {}
        for suitId, suitData in pairs(suitDic) do
            (table.insert)(suitIdList, suitId)
        end
        (table.sort)(suitIdList)
        for k, suitItem in ipairs(self.suitItemList) do
            local suitId = suitIdList[k]
            if suitId == nil then
                suitItem:Hide()
            else
                suitItem:Show()
                local suitData = suitDic[suitId]
                local suitParamCfg =
                    ((ConfigData.ath_suit).suitParamDic)[suitId]
                suitItem:InitAthHeroInfoSuit(suitParamCfg, suitData.curCount,
                                             suitData.maxCount)
            end
        end
    end

UINAthHeroInfo.__OnClickRoot = function(self)
    -- function num : 0_6 , upvalues : _ENV
    if not self.unlock or not self.canShowAthWindow then return end
    UIManager:ShowWindowAsync(UIWindowTypeID.Ath, function(window)
        -- function num : 0_6_0 , upvalues : self
        if window == nil then return end
        if self.removeAllTouchFunc ~= nil then
            (self.removeAllTouchFunc)()
        end
        window:InitAth(self.heroData, self.resLoader, self.heroResLoader,
                       self.addAllTouchFunc)
    end)
    UIManager:HideWindow(UIWindowTypeID.HeroState)
end

UINAthHeroInfo.OnDelete = function(self)
    -- function num : 0_7 , upvalues : _ENV, base
    MsgCenter:RemoveListener(eMsgEventId.OnAthDataUpdate, self.__onAthDataUpdate);
    (self.areaPool):DeleteAll();
    (self.areaNamePool):DeleteAll();
    (base.OnDelete)(self)
end

return UINAthHeroInfo

