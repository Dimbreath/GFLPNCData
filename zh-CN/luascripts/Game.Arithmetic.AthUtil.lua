-- params : ...
-- function num : 0 , upvalues : _ENV
local AthUtil = {}
AthUtil.AthGridSize = (Vector2.New)(4, 4)
AthUtil.AthUseGridList = {1, 2, 5, 6, 9, 10, 13, 14}
AthUtil.AthUseGridDic = {}
for k,v in ipairs(AthUtil.AthUseGridList) do
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R6 in 'UnsetPending'

  (AthUtil.AthUseGridDic)[v] = true
end
AthUtil.GetAthGridIdList = function(athData, pos)
  -- function num : 0_0 , upvalues : AthUtil, _ENV
  local athSize = athData:GetAthSize()
  local sizeX = (AthUtil.AthGridSize).x
  local gridIdList = {pos}
  if athSize == 2 then
    local gridId = pos + sizeX
    ;
    (table.insert)(gridIdList, gridId)
  else
    do
      if athSize == 4 then
        for i = 0, 1 do
          local gridId = nil
          if i ~= 0 then
            gridId = pos + i
            ;
            (table.insert)(gridIdList, gridId)
          end
          gridId = pos + i + sizeX
          ;
          (table.insert)(gridIdList, gridId)
        end
      else
        do
          if athSize == 8 then
            for i = 0, 1 do
              for j = 0, 3 do
                if i ~= 0 or j ~= 0 then
                  local gridId = pos + i + sizeX * j
                  ;
                  (table.insert)(gridIdList, gridId)
                end
              end
            end
          end
          do
            return gridIdList
          end
        end
      end
    end
  end
end

AthUtil.OnekeyInstallAthArea = function(heroData, slotId, space, maxSpace, areaGridData)
  -- function num : 0_1 , upvalues : _ENV, AthUtil
  if not (PlayerDataCenter.allAthData):GetHeroCanLoadedSlot(heroData, slotId) then
    return 
  end
  local freeSpace = (heroData:GetAthSlotList())[slotId]
  areaGridData:InitAthAreaGridData(heroData, space, maxSpace, true)
  local onekeyInstallDic = {}
  local onekeyInstallList = {}
  local slotUninstalledAthList = (PlayerDataCenter.allAthData):GetAllAthSlotList(slotId, nil, true)
  local slotUninstalledAthDic = {}
  local athDataList, athDic = (PlayerDataCenter.allAthData):GetHeroAthList(heroData.dataId, slotId)
  if #athDataList > 0 then
    local uninstallAthDataListByIdDic = {}
    for k,athData in ipairs(slotUninstalledAthList) do
      local athList = uninstallAthDataListByIdDic[athData.id]
      if athList == nil then
        athList = {}
        uninstallAthDataListByIdDic[athData.id] = athList
      end
      ;
      (table.insert)(athList, athData)
    end
    local installedSuitIdDic = {}
    local installedSuitIdDicNum = 0
    for k,athData in pairs(athDic) do
      (table.insert)(onekeyInstallList, athData)
      onekeyInstallDic[athData.uid] = athData
      freeSpace = freeSpace - athData:GetAthSize()
      local suitId = athData:GetAthSuit()
      if suitId ~= 0 then
        local suitExit = installedSuitIdDic[suitId]
        if suitExit == nil then
          suitExit = {}
          installedSuitIdDic[suitId] = suitExit
          installedSuitIdDicNum = installedSuitIdDicNum + 1
        end
        suitExit[athData.id] = athData
        if (table.count)(suitExit) >= 3 then
          installedSuitIdDic[suitId] = nil
        end
      end
    end
    do
      while installedSuitIdDicNum > 0 and freeSpace > 2 do
        local firstSuitId = (AthUtil._FindFirstSuitId)(installedSuitIdDic, heroData.heroCfg)
        local suitExit = installedSuitIdDic[firstSuitId]
        local suitCfg = ((ConfigData.arithmetic).suitDic)[firstSuitId]
        if suitCfg == nil then
          error("Cant get ConfigData.arithmetic.suitDic, suitId = " .. tostring(firstSuitId))
        end
        for k,athId in ipairs(suitCfg) do
          if suitExit[athId] == nil then
            local athDataList = uninstallAthDataListByIdDic[athId]
            if athDataList ~= nil then
              (AthUtil._AthUidListSort)(athDataList, heroData)
              local athData = athDataList[1]
              if athData:GetAthSize() <= freeSpace then
                freeSpace = AthUtil:_InstallAthData(athData, onekeyInstallList, onekeyInstallDic, freeSpace, slotUninstalledAthDic)
              end
            end
          end
        end
        installedSuitIdDic[firstSuitId] = nil
        installedSuitIdDicNum = installedSuitIdDicNum - 1
      end
      do
        local existSuitDic = {}
        for k,athData in ipairs(slotUninstalledAthList) do
          slotUninstalledAthDic[athData.uid] = athData
          local suitId = athData:GetAthSuit()
          if suitId ~= 0 then
            local existSuit = existSuitDic[suitId]
            if existSuit == nil then
              existSuit = 
              existSuitDic[suitId] = existSuit
            end
            local suitAthList = ({
suitDic = {}
, num = 0})[athData.id]
            if suitAthList == nil then
              suitAthList = {}
              existSuit.num = existSuit.num + 1
              -- DECOMPILER ERROR at PC182: Confused about usage of register: R21 in 'UnsetPending'

              ;
              (existSuit.suitDic)[athData.id] = suitAthList
            end
            ;
            (table.insert)(suitAthList, athData)
          end
        end
        local existSuit3DicNum = 0
        local existSuit2DicNum = 0
        local existSuit3Dic = {}
        local existSuit2Dic = {}
        for suitId,existSuit in pairs(existSuitDic) do
          if existSuit.num == 3 then
            existSuit3Dic[suitId] = existSuit
            existSuit3DicNum = existSuit3DicNum + 1
          else
            if existSuit.num == 2 then
              existSuit2Dic[suitId] = existSuit
              existSuit2DicNum = existSuit2DicNum + 1
            end
          end
        end
        if freeSpace >= 6 then
          if existSuit3DicNum > 0 then
            local firstSuitId = (AthUtil._FindFirstSuitId)(existSuit3Dic, heroData.heroCfg)
            local firstExistSuit = existSuit3Dic[firstSuitId]
            freeSpace = (AthUtil._InstallSuit)(firstExistSuit, heroData, onekeyInstallList, onekeyInstallDic, freeSpace, slotUninstalledAthDic, 3)
          else
            do
              if existSuit2DicNum > 0 then
                local firstSuitId = (AthUtil._FindFirstSuitId)(existSuit2Dic, heroData.heroCfg)
                local firstExistSuit = existSuit2Dic[firstSuitId]
                freeSpace = (AthUtil._InstallSuit)(firstExistSuit, heroData, onekeyInstallList, onekeyInstallDic, freeSpace, slotUninstalledAthDic, 2)
                existSuit2Dic[firstSuitId] = nil
                existSuit2DicNum = existSuit2DicNum - 1
                if freeSpace >= 4 then
                  local firstSuitId = (AthUtil._FindFirstSuitId)(existSuit2Dic, heroData.heroCfg)
                  local firstExistSuit = existSuit2Dic[firstSuitId]
                  freeSpace = (AthUtil._InstallSuit)(firstExistSuit, heroData, onekeyInstallList, onekeyInstallDic, freeSpace, slotUninstalledAthDic, 2)
                end
              end
              do
                if freeSpace >= 4 then
                  local firstSuitId = nil
                  if existSuit3DicNum > 0 then
                    firstSuitId = (AthUtil._FindFirstSuitId)(existSuit3Dic, heroData.heroCfg)
                  end
                  if existSuit2DicNum > 0 then
                    firstSuitId = (AthUtil._FindFirstSuitId)(existSuit2Dic, heroData.heroCfg, firstSuitId)
                  end
                  if firstSuitId ~= nil then
                    local firstExistSuit = existSuit3Dic[firstSuitId]
                    if firstExistSuit == nil then
                      firstExistSuit = existSuit2Dic[firstSuitId]
                    end
                    freeSpace = (AthUtil._InstallSuit)(firstExistSuit, heroData, onekeyInstallList, onekeyInstallDic, freeSpace, slotUninstalledAthDic, 2)
                  end
                end
                do
                  local athInstallDic = (AthUtil._fillEmptySpace)(onekeyInstallList, freeSpace, areaGridData, slotId, slotUninstalledAthDic, heroData)
                  return athInstallDic
                end
              end
            end
          end
        end
      end
    end
  end
end

AthUtil._FindFirstSuitId = function(existSuitDic, heroCfg, firstSuitId)
  -- function num : 0_2 , upvalues : _ENV
  for suitId,_ in pairs(existSuitDic) do
    if firstSuitId == nil then
      firstSuitId = suitId
    else
      local firstSuitPriority = (heroCfg.priority_suit_dic)[firstSuitId]
      if firstSuitPriority == nil then
        error("Cant get heroCfg.priority_suit, suitId = " .. tostring(firstSuitId))
      else
        local curSuitPriority = (heroCfg.priority_suit_dic)[suitId]
        if curSuitPriority == nil then
          error("Cant get heroCfg.priority_suit, suitId = " .. tostring(suitId))
        else
          if curSuitPriority < firstSuitPriority then
            firstSuitId = suitId
          end
        end
      end
    end
  end
  return firstSuitId
end

AthUtil._InstallSuit = function(firstExistSuit, heroData, onekeyInstallList, onekeyInstallDic, freeSpace, slotUninstalledAthDic, installNum)
  -- function num : 0_3 , upvalues : _ENV, AthUtil
  local curNum = 0
  for athId,suitAthList in pairs(firstExistSuit.suitDic) do
    (AthUtil._AthUidListSort)(suitAthList, heroData)
    local athData = suitAthList[1]
    freeSpace = AthUtil:_InstallAthData(athData, onekeyInstallList, onekeyInstallDic, freeSpace, slotUninstalledAthDic)
    curNum = curNum + 1
  end
  do
    if installNum > curNum then
      return freeSpace
    end
  end
end

AthUtil._InstallAthData = function(self, athData, onekeyInstallList, onekeyInstallDic, freeSpace, slotUninstalledAthDic)
  -- function num : 0_4 , upvalues : _ENV
  (table.insert)(onekeyInstallList, athData)
  onekeyInstallDic[athData.uid] = athData
  freeSpace = freeSpace - athData:GetAthSize()
  slotUninstalledAthDic[athData.uid] = nil
  return freeSpace
end

AthUtil._fillEmptySpace = function(tryInstallAthList, freeSpace, areaGridData, slotId, slotUninstalledAthDic, heroData)
  -- function num : 0_5 , upvalues : _ENV, AthUtil
  local slotUninstalledAthList = {}
  if freeSpace > 0 then
    for uid,athData in pairs(slotUninstalledAthDic) do
      (table.insert)(slotUninstalledAthList, athData)
    end
    ;
    (AthUtil._AthUidListSort)(slotUninstalledAthList, heroData)
  end
  local tryInstallIdDic = {}
  if tryInstallAthList == nil then
    tryInstallAthList = {}
  else
    for k,athData in ipairs(tryInstallAthList) do
      tryInstallIdDic[athData.id] = true
    end
  end
  do
    for k,athData in ipairs(slotUninstalledAthList) do
      if freeSpace > 0 then
        do
          local athSize = athData:GetAthSize()
          if athSize <= freeSpace and tryInstallIdDic[athData.id] == nil then
            (table.insert)(tryInstallAthList, athData)
            tryInstallIdDic[athData.id] = true
            freeSpace = freeSpace - athSize
          end
          -- DECOMPILER ERROR at PC54: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC54: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
    local athInstallDic, athInstalledDic = areaGridData:AutoSortAthTable(tryInstallAthList)
    if athInstallDic == nil then
      return 
    end
    local isEqual = true
    for k,v in pairs(athInstallDic) do
      if athInstalledDic[k] ~= v then
        isEqual = false
        break
      end
    end
    do
      if isEqual then
        return 
      end
      return athInstallDic
    end
  end
end

AthUtil._AthUidListSort = function(athDataList, heroData)
  -- function num : 0_6 , upvalues : _ENV, AthUtil
  (table.sort)(athDataList, function(athDataA, athDataB)
    -- function num : 0_6_0 , upvalues : AthUtil, heroData
    local mainAttrPriorityA = (AthUtil.GetHeroAthMainAttrPriority)(heroData, athDataA)
    local mainAttrPriorityB = (AthUtil.GetHeroAthMainAttrPriority)(heroData, athDataB)
    local qulityA = athDataA:GetAthQuality()
    local qulityB = athDataB:GetAthQuality()
    local subAttrPriorityA = (AthUtil.GetHeroAthSubAttrPriority)(heroData, athDataA)
    local subAttrPriorityB = (AthUtil.GetHeroAthSubAttrPriority)(heroData, athDataA)
    if qulityA == qulityB then
      if subAttrPriorityA == subAttrPriorityB then
        if athDataA.athTs >= athDataB.athTs then
          do return mainAttrPriorityA ~= mainAttrPriorityB end
          do return subAttrPriorityA < subAttrPriorityB end
          do return qulityB < qulityA end
          do return mainAttrPriorityA < mainAttrPriorityB end
          -- DECOMPILER ERROR: 8 unprocessed JMP targets
        end
      end
    end
  end
)
end

AthUtil.GetHeroAthMainAttrPriority = function(heroData, athData)
  -- function num : 0_7
  local mainAttrId = ((athData.athMainAttrCfg).attrtibute_id)[1]
  local mainAttrPriority = ((heroData.heroCfg).priority_main_attribute_dic)[mainAttrId]
  if mainAttrPriority == nil then
    return 1000
  end
  return mainAttrPriority
end

AthUtil.GetHeroAthSubAttrPriority = function(heroData, athData)
  -- function num : 0_8 , upvalues : _ENV
  local highestPriority = 1000
  local areaId = athData:GetAthAreaType()
  local cfgName = "priority_sub_attribute" .. tostring(areaId) .. "_dic"
  for k,affixElem in ipairs(athData.affixList) do
    local attrId = affixElem.id
    local subAttrPriority = ((heroData.heroCfg)[cfgName])[attrId]
    if subAttrPriority ~= nil and subAttrPriority < highestPriority then
      highestPriority = subAttrPriority
    end
  end
  return highestPriority
end

return AthUtil

