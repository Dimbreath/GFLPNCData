-- params : ...
-- function num : 0 , upvalues : _ENV
local AthAreaGridData = class("AthAreaGridData")
local eAthGridState = require("Game.Arithmetic.Enum.eAthGridState")
local AthUtil = require("Game.Arithmetic.AthUtil")
local CS_MessageCommon = CS.MessageCommon
AthAreaGridData.ctor = function(self, areaId)
  -- function num : 0_0
  self.areaId = areaId
end

AthAreaGridData.InitAthAreaGridData = function(self, heroData, space, maxSpace, withoutInstall)
  -- function num : 0_1 , upvalues : _ENV, eAthGridState
  self.heroData = heroData
  local gridUnlockList = (ConfigData.game_config).athGridUnlockList
  if #gridUnlockList < space then
    error((string.format)("Ath grid count(%s) error, space = (%s)", #gridUnlockList, space))
    return 
  end
  self.gridDataList = {}
  self.gridStateList = {}
  self.athInstalledDic = {}
  for k,gridId in ipairs(gridUnlockList) do
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R11 in 'UnsetPending'

    if k <= space then
      (self.gridStateList)[gridId] = eAthGridState.Unlock
    else
      -- DECOMPILER ERROR at PC36: Confused about usage of register: R11 in 'UnsetPending'

      if k <= maxSpace then
        (self.gridStateList)[gridId] = eAthGridState.Lock
      else
        -- DECOMPILER ERROR at PC40: Confused about usage of register: R11 in 'UnsetPending'

        ;
        (self.gridStateList)[gridId] = eAthGridState.Disable
      end
    end
  end
  if not withoutInstall then
    local athDataList, athDic = (PlayerDataCenter.allAthData):GetHeroAthList(heroData.dataId, self.areaId)
    for k,athData in ipairs(athDataList) do
      self:InstallAthGridData(athData)
    end
  end
end

AthAreaGridData.InstallAthGridData = function(self, athData, gridPos)
  -- function num : 0_2 , upvalues : _ENV
  if gridPos == nil then
    if athData.bindInfo == nil then
      error((string.format)("athData.bindInfo == nil, athData.uid = %s, heroId = %s", athData.uid, (self.heroData).dataId))
      return 
    end
    gridPos = (athData.bindInfo).grid
  end
  local installable, gridIdList = self:CheckAthInstallable(athData, gridPos)
  if not installable then
    return 
  end
  local uid = athData.uid
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (self.athInstalledDic)[uid] = athData
  for k,gridId in ipairs(gridIdList) do
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R11 in 'UnsetPending'

    (self.gridDataList)[gridId] = uid
  end
end

AthAreaGridData.UninstallAthGridData = function(self, athData, gridPos)
  -- function num : 0_3 , upvalues : AthUtil, _ENV
  local gridIdList = (AthUtil.GetAthGridIdList)(athData, gridPos)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.athInstalledDic)[athData.uid] = nil
  for k,gridId in ipairs(gridIdList) do
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R9 in 'UnsetPending'

    (self.gridDataList)[gridId] = nil
  end
end

AthAreaGridData.CheckAthInstallable = function(self, athData, gridPos, containUid)
  -- function num : 0_4 , upvalues : AthUtil, _ENV, eAthGridState
  local gridIdList = (AthUtil.GetAthGridIdList)(athData, gridPos)
  for k,gridId in ipairs(gridIdList) do
    if not (AthUtil.AthUseGridDic)[gridId] or gridId < 1 then
      return 
    end
    if (self.gridStateList)[gridId] == eAthGridState.Lock then
      return 
    end
    if (self.gridStateList)[gridId] == eAthGridState.Disable then
      return 
    end
    -- DECOMPILER ERROR at PC37: Unhandled construct in 'MakeBoolean' P1

    -- DECOMPILER ERROR at PC37: Unhandled construct in 'MakeBoolean' P1

    if (self.gridDataList)[gridId] ~= nil and containUid ~= nil and (self.gridDataList)[gridId] ~= containUid then
      return 
    end
    do return  end
  end
  return true, gridIdList
end

AthAreaGridData.GetAthInstallableGrid = function(self, athData)
  -- function num : 0_5 , upvalues : _ENV, AthUtil, eAthGridState
  for k,gridId in ipairs(AthUtil.AthUseGridList) do
    local uid = (self.gridDataList)[gridId]
    local gridState = (self.gridStateList)[gridId]
    if uid == nil and gridState == eAthGridState.Unlock and self:CheckAthInstallable(athData, gridId) then
      return gridId
    end
  end
  return nil
end

AthAreaGridData.CheckAthAreaSpaceOk = function(self, athData)
  -- function num : 0_6 , upvalues : _ENV
  local athSpace = athData:GetAthSize()
  local ok, freeSpace = (PlayerDataCenter.allAthData):GetHeroAthFreeSpace(self.heroData, self.areaId)
  do return not ok or athSpace <= freeSpace end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

AthAreaGridData.AutoSortAthTable = function(self, athDataList)
  -- function num : 0_7 , upvalues : _ENV, AthUtil
  (table.sort)(athDataList, function(a, b)
    -- function num : 0_7_0
    local sizeA = a:GetAthSize()
    local sizeB = b:GetAthSize()
    if a.id >= b.id then
      do return sizeA ~= sizeB end
      do return sizeB < sizeA end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
)
  local gridDataListBack = self.gridDataList
  local athInstalledDicBack = self.athInstalledDic
  self.gridDataList = {}
  self.athInstalledDic = {}
  local athInstallDic = {}
  local athInstalledDic = {}
  for k,data in pairs(athInstalledDicBack) do
    athInstalledDic[data.uid] = (data.bindInfo).grid
  end
  local hasError = false
  for k,athData in ipairs(athDataList) do
    local installOk = false
    for k,gridId in ipairs(AthUtil.AthUseGridList) do
      local installable, gridIdList = self:CheckAthInstallable(athData, gridId)
      if installable then
        self:InstallAthGridData(athData, gridId)
        athInstallDic[athData.uid] = gridId
        installOk = true
        break
      end
    end
    do
      do
        if not installOk then
          error("AutoSortAthTable error, athDataId = " .. athData.id)
          hasError = true
          break
        end
        -- DECOMPILER ERROR at PC58: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  self.gridDataList = gridDataListBack
  self.athInstalledDic = athInstalledDicBack
  if hasError then
    return 
  else
    return athInstallDic, athInstalledDic
  end
end

AthAreaGridData.ReSortAthTable = function(self, newAthData)
  -- function num : 0_8 , upvalues : _ENV
  if newAthData ~= nil and not self:CheckAthAreaSpaceOk(newAthData) then
    return 
  end
  local athDataList = (PlayerDataCenter.allAthData):GetHeroAthList((self.heroData).dataId, self.areaId)
  if newAthData ~= nil then
    (table.insert)(athDataList, newAthData)
  end
  return self:AutoSortAthTable(athDataList)
end

AthAreaGridData.GetTryReplaceAthDic = function(self, newAthData, replacedAthData)
  -- function num : 0_9 , upvalues : _ENV
  local athDataList = (PlayerDataCenter.allAthData):GetHeroAthList((self.heroData).dataId, self.areaId)
  local athInstalledDic = {}
  for k,data in pairs(self.athInstalledDic) do
    athInstalledDic[data.uid] = (data.bindInfo).grid
  end
  ;
  (table.removebyvalue)(athDataList, replacedAthData)
  local sizeNew = newAthData:GetAthSize()
  local sizeOld = (replacedAthData:GetAthSize())
  local athInstallDic = nil
  if sizeOld < sizeNew then
    (table.insert)(athDataList, newAthData)
    athInstallDic = self:AutoSortAthTable(athDataList)
    if athInstallDic == nil then
      return 
    end
  else
    athInstallDic = {}
    for k,athData in ipairs(athDataList) do
      athInstallDic[athData.uid] = (athData.bindInfo).grid
    end
    athInstallDic[newAthData.uid] = (replacedAthData.bindInfo).grid
  end
  return athInstallDic, athInstalledDic
end

AthAreaGridData.CheckAthReplaceable = function(self, athData, gridPos, withTips)
  -- function num : 0_10 , upvalues : _ENV, CS_MessageCommon
  if (PlayerDataCenter.allAthData):HeroContainAthByUid((self.heroData).dataId, athData.uid) then
    return 
  end
  local installedUid = (self.gridDataList)[gridPos]
  if installedUid == nil then
    return 
  end
  local tarAthData = (self.athInstalledDic)[installedUid]
  local tarSize = tarAthData:GetAthSize()
  local curSize = athData:GetAthSize()
  local spaceOk = false
  local ok, freeSpace = (PlayerDataCenter.allAthData):GetHeroAthFreeSpace(self.heroData, self.areaId)
  if curSize - tarSize <= freeSpace then
    spaceOk = true
  else
    if withTips then
      (CS_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Ath_NotOneReplaceOne))
    end
  end
  local oneReplaceMore = false
  local bigSpaceReplaceSmall = tarSize < curSize
  if spaceOk and bigSpaceReplaceSmall and not self:CheckAthInstallable(athData, gridPos, installedUid) then
    tarAthData = nil
    oneReplaceMore = true
    if withTips then
      (CS_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Ath_NotOneReplaceOne))
    end
  end
  if spaceOk then
    return tarAthData, oneReplaceMore
  else
    return 
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

return AthAreaGridData

