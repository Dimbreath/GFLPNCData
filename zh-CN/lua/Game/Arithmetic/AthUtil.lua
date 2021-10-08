local AthUtil = {}
AthUtil.AthGridSize = (Vector2.New)(4, 4)
AthUtil.AthUseGridList = {1, 2, 5, 6, 9, 10, 13, 14}
AthUtil.AthUseGridDic = {}
for k,v in ipairs(AthUtil.AthUseGridList) do
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R6 in 'UnsetPending'

  (AthUtil.AthUseGridDic)[v] = true
end
AthUtil.GetAthGridIdList = function(athData, pos)
  -- function num : 0_0 , upvalues : AthUtil
  local athSize = athData:GetAthSize()
  return (AthUtil.GetAthGridIdListBySize)(athSize, pos)
end

AthUtil.GetAthGridIdListBySize = function(athSize, pos)
  -- function num : 0_1 , upvalues : AthUtil, _ENV
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
  -- function num : 0_2 , upvalues : _ENV, AthUtil
  local freeSpace = (heroData:GetAthSlotList())[slotId]
  areaGridData:InitAthAreaGridData(heroData, space, maxSpace, true)
  local onekeyInstallDic = {}
  local onekeyInstallList = {}
  local slotUninstalledAthList = (PlayerDataCenter.allAthData):GetAllAthSlotList(slotId, nil, true, heroData.dataId)
  local slotUninstalledAthDic = {}
  local athDataList = {}
  local athDic = {}
  local existSuitDic = {}
  for k,athData in ipairs(slotUninstalledAthList) do
    slotUninstalledAthDic[athData.uid] = athData
    local suitId, suitCfltId = athData:GetAthSuit()
    if suitId ~= 0 then
      local existSuit = existSuitDic[suitId]
      if existSuit == nil then
        existSuit = {
suitDic = {}
, 
suitMaxQualityDic = {}
, num = 0}
        existSuitDic[suitId] = existSuit
      end
      local suitAthList = (existSuit.suitDic)[suitCfltId]
      if suitAthList == nil then
        suitAthList = {}
        existSuit.num = existSuit.num + 1
        -- DECOMPILER ERROR at PC54: Confused about usage of register: R22 in 'UnsetPending'

        ;
        (existSuit.suitDic)[suitCfltId] = suitAthList
      end
      ;
      (table.insert)(suitAthList, athData)
      -- DECOMPILER ERROR at PC67: Confused about usage of register: R22 in 'UnsetPending'

      if athData:GetAthQuality() == eItemQualityType.Orange then
        (existSuit.suitMaxQualityDic)[suitCfltId] = true
      end
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
  local findSuitInstallFunc = function(propertyLv)
    -- function num : 0_2_0 , upvalues : freeSpace, existSuit3DicNum, AthUtil, existSuit3Dic, heroData, onekeyInstallList, onekeyInstallDic, slotUninstalledAthDic, existSuit2DicNum, _ENV, existSuit2Dic
    while 1 do
      if freeSpace >= 6 and existSuit3DicNum > 0 then
        local firstSuitId = nil
        if propertyLv == 1 then
          firstSuitId = (AthUtil._FindFirstSuitId1)(existSuit3Dic, heroData.heroCfg)
        else
          firstSuitId = (AthUtil._FindFirstSuitId2)(existSuit3Dic, heroData.heroCfg)
        end
        if firstSuitId ~= nil then
          do
            local firstExistSuit = existSuit3Dic[firstSuitId]
            freeSpace = (AthUtil._InstallSuit)(firstExistSuit, heroData, onekeyInstallList, onekeyInstallDic, freeSpace, slotUninstalledAthDic, 3)
            existSuit3DicNum = existSuit3DicNum - 1
            existSuit3Dic[firstSuitId] = nil
            -- DECOMPILER ERROR at PC37: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC37: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC37: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC37: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
    while 1 do
      while 1 do
        if freeSpace >= 4 and existSuit2DicNum > 0 then
          local firstSuitId = nil
          local maxQualityNum = 0
          if existSuit3DicNum > 0 then
            if propertyLv == 1 then
              firstSuitId = (AthUtil._FindFirstSuitId1)(existSuit3Dic, heroData.heroCfg, firstSuitId, maxQualityNum)
              -- DECOMPILER ERROR at PC64: Overwrote pending register: R2 in 'AssignReg'

            else
              -- DECOMPILER ERROR at PC71: Overwrote pending register: R2 in 'AssignReg'

              firstSuitId = (AthUtil._FindFirstSuitId2)(existSuit3Dic, heroData.heroCfg, firstSuitId)
            end
          end
          if existSuit2DicNum > 0 then
            if propertyLv == 1 then
              firstSuitId = (AthUtil._FindFirstSuitId1)(existSuit2Dic, heroData.heroCfg, firstSuitId, maxQualityNum)
            else
              firstSuitId = (AthUtil._FindFirstSuitId2)(existSuit2Dic, heroData.heroCfg, firstSuitId)
            end
          end
          if not existSuit3Dic[firstSuitId] then
            local firstExistSuit = firstSuitId == nil or existSuit2Dic[firstSuitId]
          end
          local isSuit3 = existSuit3Dic[firstSuitId] ~= nil
          freeSpace = (AthUtil._InstallSuit)(firstExistSuit, heroData, onekeyInstallList, onekeyInstallDic, freeSpace, slotUninstalledAthDic, 2)
          if isSuit3 then
            existSuit3DicNum = existSuit3DicNum - 1
            existSuit3Dic[firstSuitId] = nil
            -- DECOMPILER ERROR at PC119: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC119: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC119: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC119: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
      existSuit2Dic[firstSuitId] = nil
      existSuit2DicNum = existSuit2DicNum - 1
    end
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
  end

  findSuitInstallFunc(1)
  findSuitInstallFunc(2)
  local athInstallDic = (AthUtil._fillEmptySpace)(onekeyInstallList, freeSpace, areaGridData, slotId, slotUninstalledAthDic, heroData)
  if athInstallDic ~= nil then
    local _, oldAthDic = (PlayerDataCenter.allAthData):GetHeroAthList(heroData.dataId, slotId)
    if (table.count)(athInstallDic) == (table.count)(oldAthDic) then
      local allSame = true
      for uid,athData in pairs(oldAthDic) do
        if athInstallDic[uid] == nil then
          allSame = false
          break
        end
      end
      do
        do
          if allSame then
            return nil
          end
          return athInstallDic
        end
      end
    end
  end
end

AthUtil._FindFirstSuitId1 = function(existSuitDic, heroCfg, firstSuitId, maxQualityNum)
  -- function num : 0_3 , upvalues : _ENV
  for suitId,existSuit in pairs(existSuitDic) do
    if (heroCfg.priority1_suit_dic)[suitId] ~= nil then
      local curNum = (table.count)(existSuit.suitMaxQualityDic)
      if firstSuitId == nil then
        firstSuitId = suitId
        maxQualityNum = curNum
      else
        if maxQualityNum < curNum then
          firstSuitId = suitId
          maxQualityNum = curNum
        else
          if curNum == maxQualityNum then
            local firstSuitPriority = (heroCfg.priority1_suit_dic)[firstSuitId]
            local curSuitPriority = (heroCfg.priority1_suit_dic)[suitId]
            if curSuitPriority < firstSuitPriority or firstSuitPriority == curSuitPriority and suitId < firstSuitId then
              firstSuitId = suitId
            end
          end
        end
      end
    end
  end
  return firstSuitId, maxQualityNum
end

AthUtil._FindFirstSuitId2 = function(existSuitDic, heroCfg, firstSuitId)
  -- function num : 0_4 , upvalues : _ENV
  for suitId,_ in pairs(existSuitDic) do
    if firstSuitId == nil then
      firstSuitId = suitId
    else
      if not (heroCfg.priority2_suit_dic)[firstSuitId] then
        local firstSuitPriority = math.maxinteger
      end
      if not (heroCfg.priority2_suit_dic)[suitId] then
        local curSuitPriority = math.maxinteger
      end
      if curSuitPriority < firstSuitPriority or firstSuitPriority == curSuitPriority and suitId < firstSuitId then
        firstSuitId = suitId
      end
    end
  end
  return firstSuitId
end

AthUtil._InstallSuit = function(firstExistSuit, heroData, onekeyInstallList, onekeyInstallDic, freeSpace, slotUninstalledAthDic, installNum)
  -- function num : 0_5 , upvalues : _ENV, AthUtil
  local curNum = 0
  for suitCflsuittId,suitAthList in pairs(firstExistSuit.suitDic) do
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
  -- function num : 0_6 , upvalues : _ENV
  (table.insert)(onekeyInstallList, athData)
  onekeyInstallDic[athData.uid] = athData
  freeSpace = freeSpace - athData:GetAthSize()
  slotUninstalledAthDic[athData.uid] = nil
  return freeSpace
end

AthUtil._fillEmptySpace = function(tryInstallAthList, freeSpace, areaGridData, slotId, slotUninstalledAthDic, heroData)
  -- function num : 0_7 , upvalues : _ENV, AthUtil
  local slotUninstalledAthList = {}
  if freeSpace > 0 then
    for uid,athData in pairs(slotUninstalledAthDic) do
      (table.insert)(slotUninstalledAthList, athData)
    end
    ;
    (AthUtil._AthUidListSort)(slotUninstalledAthList, heroData)
  end
  local tryInstallIdDic = {}
  local tryInstallSuitDic = {}
  if tryInstallAthList == nil then
    tryInstallAthList = {}
  else
    for k,athData in ipairs(tryInstallAthList) do
      tryInstallIdDic[athData.id] = true
      local suitId, cfltId = athData:GetAthSuit()
      if suitId ~= 0 then
        if not tryInstallSuitDic[suitId] then
          do
            tryInstallSuitDic[suitId] = {}
            -- DECOMPILER ERROR at PC41: Confused about usage of register: R16 in 'UnsetPending'

            ;
            (tryInstallSuitDic[suitId])[cfltId] = true
            -- DECOMPILER ERROR at PC42: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC42: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC42: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC42: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
  for k,athData in ipairs(slotUninstalledAthList) do
    if freeSpace > 0 then
      local athSize = athData:GetAthSize()
      local suitId, cfltId = athData:GetAthSuit()
      if athSize <= freeSpace and tryInstallIdDic[athData.id] == nil and (tryInstallSuitDic[suitId] == nil or (tryInstallSuitDic[suitId])[cfltId] == nil) then
        (table.insert)(tryInstallAthList, athData)
        tryInstallIdDic[athData.id] = true
        if suitId ~= 0 then
          if not tryInstallSuitDic[suitId] then
            do
              tryInstallSuitDic[suitId] = {}
              -- DECOMPILER ERROR at PC82: Confused about usage of register: R17 in 'UnsetPending'

              ;
              (tryInstallSuitDic[suitId])[cfltId] = true
              freeSpace = freeSpace - athSize
              -- DECOMPILER ERROR at PC84: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC84: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC84: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC84: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC84: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC84: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC84: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC84: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
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

AthUtil._AthUidListSort = function(athDataList, heroData)
  -- function num : 0_8 , upvalues : _ENV, AthUtil
  (table.sort)(athDataList, function(athDataA, athDataB)
    -- function num : 0_8_0 , upvalues : AthUtil, heroData
    local mainAttrPriorityA = (AthUtil.GetHeroAthMainAttrPriority)(heroData, athDataA)
    local mainAttrPriorityB = (AthUtil.GetHeroAthMainAttrPriority)(heroData, athDataB)
    local qulityA = athDataA:GetAthQuality()
    local qulityB = athDataB:GetAthQuality()
    local subAttrPriorityA = (AthUtil.GetHeroAthSubAttrPriority)(heroData, athDataA)
    local subAttrPriorityB = (AthUtil.GetHeroAthSubAttrPriority)(heroData, athDataA)
    if qulityB >= qulityA then
      do return qulityA == qulityB end
      if mainAttrPriorityA >= mainAttrPriorityB then
        do return mainAttrPriorityA == mainAttrPriorityB end
        if subAttrPriorityA >= subAttrPriorityB then
          do return subAttrPriorityA == subAttrPriorityB end
          do return athDataA.athTs < athDataB.athTs end
          -- DECOMPILER ERROR: 7 unprocessed JMP targets
        end
      end
    end
  end
)
end

AthUtil.GetHeroAthMainAttrPriority = function(heroData, athData)
  -- function num : 0_9
  local mainAttrId = ((athData.athMainAttrCfg).attrtibute_id)[1]
  local mainAttrPriority = ((heroData.heroCfg).priority_main_attribute_dic)[mainAttrId]
  if mainAttrPriority == nil then
    return 1000
  end
  return mainAttrPriority
end

AthUtil.GetHeroAthSubAttrPriority = function(heroData, athData)
  -- function num : 0_10 , upvalues : _ENV
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

