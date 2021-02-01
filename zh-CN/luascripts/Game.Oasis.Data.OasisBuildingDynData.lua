-- params : ...
-- function num : 0 , upvalues : _ENV
local OasisBuildingDynData = class("OasisBuildingDynData")
local BuildingBelong = require("Game.Oasis.Data.BuildingBelong")
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local CheckerTypeId, CheckerGlobalConfig = (table.unpack)(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
OasisBuildingDynData.Initialize = function(self, stcData)
  -- function num : 0_0 , upvalues : _ENV, BuildingBelong
  self.stcData = stcData
  self.id = stcData.build_id
  self.levelConfig = (ConfigData.buildingLevel)[self.id]
  if self.levelConfig == nil then
    error("Can\'t find buildingLevel, build_id : " .. tostring(self.id))
  end
  self.maxLevel = ((ConfigData.buildingLevel).maxLevelDic)[self.id]
  self.name = (LanguageUtil.GetLocaleText)(stcData.name)
  self.nameEn = (LanguageUtil.GetLocaleText)(stcData.name_en)
  self.area = 1
  self.icon_res = stcData.icon_res
  self.position = (Vector2.New)()
  if #stcData.coord_base == 3 then
    self.area = (stcData.coord_base)[1]
    -- DECOMPILER ERROR at PC51: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self.position).x = (stcData.coord_base)[2]
    -- DECOMPILER ERROR at PC55: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self.position).y = (stcData.coord_base)[3]
  end
  self.size = stcData.size
  self.height = stcData.height
  if self.height == nil then
    error("Oasis building" .. stcData.name .. ":没有配置 height")
  end
  self.belong = (BuildingBelong.CheckBelong)(stcData.type)
  if self.belong == BuildingBelong.Sector then
    self.sectorId = nil
    for _,id in ipairs((ConfigData.sector).id_sort_list) do
      local sectorCfg = (ConfigData.sector)[id]
      for _,builtId in ipairs(sectorCfg.building) do
        if builtId == stcData.build_id then
          self.sectorId = id
          break
        end
      end
    end
  end
end

OasisBuildingDynData.IsSectorBuilding = function(self)
  -- function num : 0_1 , upvalues : BuildingBelong
  do return self.belong == BuildingBelong.Sector end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

OasisBuildingDynData.UpdateLockAndBuild = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self.unlock = self:Unlock()
  if not self.unlock then
    local level1Cfg = (self.levelConfig)[1]
    local preCondition, prePara1, prePara2 = nil, nil, nil
    for i = 1, #level1Cfg.pre_condition do
      preCondition = {(level1Cfg.pre_condition)[i]}
      prePara1 = {(level1Cfg.pre_para1)[i]}
      prePara2 = {(level1Cfg.pre_para2)[i]}
      if not (CheckCondition.CheckLua)(preCondition, prePara1, prePara2) then
        self.lockReason = (CheckCondition.GetUnlockInfoLua)(preCondition, prePara1, prePara2)
        break
      end
    end
  end
  do
    self.canbuild = self:CanBuild()
  end
end

OasisBuildingDynData.Unlock = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local level1Cfg = (self.levelConfig)[1]
  if not (CheckCondition.CheckLua)(level1Cfg.pre_condition, level1Cfg.pre_para1, level1Cfg.pre_para2) then
    return false
  end
  return true
end

OasisBuildingDynData.CanBuild = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if (PlayerDataCenter.AllBuildingData):FullBuildQue(self.belong) then
    return false
  end
  local level1Cfg = (self.levelConfig)[1]
  if not (CheckCondition.CheckLua)(level1Cfg.pre_condition, level1Cfg.pre_para1, level1Cfg.pre_para2) then
    return false
  end
  for k,v in ipairs(level1Cfg.consumeIds) do
    local resId = v
    local count = PlayerDataCenter:GetItemCount(resId)
    local cost = (level1Cfg.consumeNums)[k]
    if count < cost then
      return false
    end
  end
  return true
end

OasisBuildingDynData.GetLevelCostItem = function(self, lvl)
  -- function num : 0_5 , upvalues : _ENV
  local nextLvlCfg = (self.levelConfig)[lvl]
  if nextLvlCfg == nil then
    return 
  end
  local resNeedItems = {}
  for i = 1, #nextLvlCfg.consumeIds do
    local resId = (nextLvlCfg.consumeIds)[i]
    local resCount = (nextLvlCfg.consumeNums)[i]
    local count = PlayerDataCenter:GetItemCount(resId)
    local name = (LanguageUtil.GetLocaleText)(((ConfigData.item)[resId]).name)
    resNeedItems[i] = {}
    -- DECOMPILER ERROR at PC29: Confused about usage of register: R12 in 'UnsetPending'

    ;
    (resNeedItems[i]).name = name
    -- DECOMPILER ERROR at PC31: Confused about usage of register: R12 in 'UnsetPending'

    ;
    (resNeedItems[i]).count = count
    -- DECOMPILER ERROR at PC33: Confused about usage of register: R12 in 'UnsetPending'

    ;
    (resNeedItems[i]).resCount = resCount
    -- DECOMPILER ERROR at PC35: Confused about usage of register: R12 in 'UnsetPending'

    ;
    (resNeedItems[i]).resId = resId
  end
  ;
  (table.sort)(resNeedItems, function(a, b)
    -- function num : 0_5_0
    do return a.resId < b.resId end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  return resNeedItems
end

OasisBuildingDynData.GetPreBuildingLvlInfo = function(self, targetLvl)
  -- function num : 0_6 , upvalues : _ENV
  local tarLvlCfg = (self.levelConfig)[targetLvl]
  local preConditionList = {}
  local preCondition, prePara1, prePara2 = nil, nil, nil
  for i = 1, #tarLvlCfg.pre_condition do
    preCondition = {(tarLvlCfg.pre_condition)[i]}
    prePara1 = {(tarLvlCfg.pre_para1)[i]}
    prePara2 = {(tarLvlCfg.pre_para2)[i]}
    local unlock = (CheckCondition.CheckLua)(preCondition, prePara1, prePara2)
    local lockReason = (CheckCondition.GetUnlockInfoLua)(preCondition, prePara1, prePara2)
    ;
    (table.insert)(preConditionList, {unlock = unlock, lockReason = lockReason})
  end
  return preConditionList
end

OasisBuildingDynData.GetPreBuildingId = function(self, targetLvl)
  -- function num : 0_7 , upvalues : CheckerTypeId
  local tarLvlCfg = (self.levelConfig)[targetLvl]
  for i = 1, #tarLvlCfg.pre_condition do
    if (tarLvlCfg.pre_condition)[i] == CheckerTypeId.BuildingLevel then
      local buildingId = (tarLvlCfg.pre_para1)[i]
      return buildingId
    end
  end
end

OasisBuildingDynData.GetTargetLevelNeedTime = function(self, tarlvl)
  -- function num : 0_8 , upvalues : _ENV
  local levelCfg = (self.levelConfig)[tarlvl]
  if levelCfg == nil then
    return 
  end
  return (math.ceil)(levelCfg.time / (1 + (PlayerDataCenter.playerBonus):GetBuildSpeed() / 1000))
end

OasisBuildingDynData.GetBuffItems = function(self, level, getNext, includeZero)
  -- function num : 0_9 , upvalues : _ENV
  local levelCfg = (self.levelConfig)[level]
  if levelCfg == nil then
    return 
  end
  local buffList = {}
  local nextlvlCfg = nil
  if getNext and level < self.maxLevel then
    nextlvlCfg = (self.levelConfig)[level + 1]
  end
  local ignoreZeroFcuc = function(index, paraId)
    -- function num : 0_9_0 , upvalues : _ENV, includeZero, levelCfg, nextlvlCfg
    local para = "para" .. tostring(paraId)
    do return not includeZero and (levelCfg[para])[index] == 0 and nextlvlCfg == nil or (nextlvlCfg[para])[index] == 0 end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end

  for i = 1, #levelCfg.logic do
    local currentInfo, curValue, nextInfoValue = nil, nil, nil
    local logic = (levelCfg.logic)[i]
    local buildingBuffCfg = (ConfigData.buildingBuff)[logic]
    local describ, valueFormat = nil, nil
    if buildingBuffCfg ~= nil then
      describ = (LanguageUtil.GetLocaleText)(((ConfigData.buildingBuff)[logic]).buff_text_context)
      valueFormat = (LanguageUtil.GetLocaleText)(((ConfigData.buildingBuff)[logic]).buff_value)
    end
    if logic == eLogicType.ResourceOutput and not ignoreZeroFcuc(i, 2) then
      local itemCfg = (ConfigData.item)[(levelCfg.para1)[i]]
      local speed = (levelCfg.para2)[i]
      speed = speed * 36 / 1000
      local describ_text = (string.format)(describ, (LanguageUtil.GetLocaleText)(itemCfg.name))
      currentInfo = describ_text
      curValue = (string.format)(valueFormat, speed)
      if getNext and nextlvlCfg ~= nil and (nextlvlCfg.logic)[i] == eLogicType.ResourceOutput then
        local nextItemCfg = (ConfigData.item)[(nextlvlCfg.para1)[i]]
        local speed = (nextlvlCfg.para2)[i] * 36 / 1000
        nextInfoValue = (string.format)(valueFormat, speed)
      end
      do
        if logic == eLogicType.FactoryPipelie and not ignoreZeroFcuc(i, 1) then
          currentInfo = describ
          curValue = (string.format)(valueFormat, (levelCfg.para1)[i])
          if getNext and nextlvlCfg ~= nil and (nextlvlCfg.logic)[i] == eLogicType.FactoryPipelie then
            nextInfoValue = (string.format)(valueFormat, (nextlvlCfg.para1)[i])
          end
          if logic == eLogicType.ResourceLimit and not ignoreZeroFcuc(i, 2) then
            local itemCfg = (ConfigData.item)[(levelCfg.para1)[i]]
            do
              local describ_text = (string.format)(describ, (LanguageUtil.GetLocaleText)(itemCfg.name))
              currentInfo = describ_text
              curValue = (string.format)(valueFormat, (levelCfg.para2)[i])
              if getNext and nextlvlCfg ~= nil and (nextlvlCfg.logic)[i] == eLogicType.ResourceLimit then
                nextInfoValue = (string.format)(valueFormat, (nextlvlCfg.para2)[i])
              end
              if logic == eLogicType.GlobalExpCeiling and not ignoreZeroFcuc(i, 1) then
                currentInfo = describ
                curValue = (string.format)(valueFormat, (levelCfg.para1)[i])
                if getNext and nextlvlCfg ~= nil and (nextlvlCfg.logic)[i] == eLogicType.GlobalExpCeiling then
                  nextInfoValue = (string.format)(valueFormat, (nextlvlCfg.para1)[i])
                end
                if logic == eLogicType.StaminaCeiling and not ignoreZeroFcuc(i, 2) then
                  currentInfo = describ
                  curValue = (string.format)(valueFormat, (levelCfg.para1)[i])
                  if getNext and nextlvlCfg ~= nil and (nextlvlCfg.logic)[i] == eLogicType.StaminaCeiling then
                    nextInfoValue = (string.format)(valueFormat, (nextlvlCfg.para1)[i])
                  end
                  if logic == eLogicType.StaminaOutput and not ignoreZeroFcuc(i, 1) then
                    do
                      local speed = (levelCfg.para1)[i] * 0.0006
                      currentInfo = describ
                      curValue = (string.format)(valueFormat, speed)
                      if getNext and nextlvlCfg ~= nil and (nextlvlCfg.logic)[i] == eLogicType.StaminaOutput then
                        nextInfoValue = (string.format)(valueFormat, (nextlvlCfg.para1)[i] * 0.0006)
                      end
                      if logic == eLogicType.ResOutputEfficiency and not ignoreZeroFcuc(i, 2) then
                        local itemCfg = (ConfigData.item)[(levelCfg.para1)[i]]
                        local efficiency = (levelCfg.para2)[i] * 0.1
                        do
                          local describ_text = nil
                          if (levelCfg.para1)[i] == 0 then
                            describ_text = (string.format)(describ, "全部道具")
                          else
                            describ_text = (string.format)(describ, (LanguageUtil.GetLocaleText)(itemCfg.name))
                          end
                          currentInfo = describ_text
                          curValue = (string.format)(valueFormat, efficiency)
                          if getNext and nextlvlCfg ~= nil and (nextlvlCfg.logic)[i] == eLogicType.ResOutputEfficiency then
                            nextInfoValue = (string.format)(valueFormat, (nextlvlCfg.para2)[i] * 0.1)
                          end
                          if (levelCfg.para1)[i] ~= eBuildQueueType.Oasis or not "绿洲" then
                            local buildingBelongText = logic ~= eLogicType.BuildQueue or ignoreZeroFcuc(i, 2) or "扇区"
                          end
                          do
                            local describ_text = (string.format)(describ, buildingBelongText)
                            currentInfo = describ_text
                            curValue = (string.format)(valueFormat, (levelCfg.para2)[i])
                            if getNext and nextlvlCfg ~= nil and (nextlvlCfg.logic)[i] == eLogicType.BuildQueue then
                              nextInfoValue = (string.format)(valueFormat, (nextlvlCfg.para2)[i])
                            end
                            if logic == eLogicType.BuildSpeed and not ignoreZeroFcuc(i, 1) then
                              do
                                local speed = (levelCfg.para1)[i] * 0.1
                                currentInfo = describ
                                curValue = (string.format)(valueFormat, speed)
                                if getNext and nextlvlCfg ~= nil and (nextlvlCfg.logic)[i] == eLogicType.BuildSpeed then
                                  nextInfoValue = (string.format)(valueFormat, (nextlvlCfg.para1)[i] * 0.1)
                                end
                                if logic == eLogicType.GlobalExpRatio and not ignoreZeroFcuc(i, 1) then
                                  do
                                    local ratio = (levelCfg.para1)[i] * 0.1
                                    currentInfo = describ
                                    curValue = (string.format)(valueFormat, ratio)
                                    if getNext and nextlvlCfg ~= nil and (nextlvlCfg.logic)[i] == eLogicType.GlobalExpRatio then
                                      nextInfoValue = (string.format)(valueFormat, (nextlvlCfg.para1)[i] * 0.1)
                                    end
                                    if logic == eLogicType.AllHeroBuff and not ignoreZeroFcuc(i, 2) then
                                      local attrId = (levelCfg.para1)[i]
                                      local value = (levelCfg.para2)[i]
                                      local attrDes, valueDes = ConfigData:GetAttribute(attrId, value)
                                      local describ_text = (string.format)(describ, attrDes)
                                      currentInfo = describ_text
                                      curValue = (string.format)(valueFormat, valueDes)
                                      if getNext and nextlvlCfg ~= nil and (nextlvlCfg.logic)[i] == eLogicType.AllHeroBuff then
                                        local nextValue = (nextlvlCfg.para2)[i]
                                        local nextAttrDes, nextValueDes = ConfigData:GetAttribute(attrId, nextValue)
                                        nextInfoValue = (string.format)(valueFormat, nextValueDes)
                                      end
                                      do
                                        if logic == eLogicType.OverClock and not ignoreZeroFcuc(i, 2) then
                                          local id = (levelCfg.para1)[i]
                                          local level = (levelCfg.para2)[i]
                                          do
                                            local name = (LanguageUtil.GetLocaleText)((((ConfigData.overclock)[id])[level]).name)
                                            currentInfo = (string.format)(describ, name)
                                            curValue = (string.format)(valueFormat, level)
                                            if getNext and nextlvlCfg ~= nil and (nextlvlCfg.logic)[i] == eLogicType.OverClock then
                                              nextInfoValue = (string.format)(valueFormat, (nextlvlCfg.para2)[i])
                                            end
                                            if logic == eLogicType.OverClockFreeNum and not ignoreZeroFcuc(i, 1) then
                                              do
                                                local freeNum = (levelCfg.para1)[i]
                                                currentInfo = describ
                                                curValue = (string.format)(valueFormat, freeNum)
                                                if getNext and nextlvlCfg ~= nil and (nextlvlCfg.logic)[i] == eLogicType.OverClockFreeNum then
                                                  nextInfoValue = (string.format)(valueFormat, (nextlvlCfg.para1)[i])
                                                end
                                                if logic == eLogicType.DynSkillUpgrade and not ignoreZeroFcuc(i, 1) then
                                                  do
                                                    local skillUpgradeSpeed = (levelCfg.para1)[i] * 0.01
                                                    currentInfo = describ
                                                    curValue = (string.format)(valueFormat, skillUpgradeSpeed)
                                                    if getNext and nextlvlCfg ~= nil and (nextlvlCfg.logic)[i] == eLogicType.DynSkillUpgrade then
                                                      nextInfoValue = (string.format)(valueFormat, (nextlvlCfg.para1)[i] * 0.01)
                                                    end
                                                    if logic == eLogicType.DynChipCountMax and not ignoreZeroFcuc(i, 1) then
                                                      do
                                                        local chipCount = (levelCfg.para1)[i]
                                                        currentInfo = describ
                                                        curValue = (string.format)(valueFormat, chipCount)
                                                        if getNext and nextlvlCfg ~= nil and (nextlvlCfg.logic)[i] == eLogicType.DynChipCountMax then
                                                          nextInfoValue = (string.format)(valueFormat, (nextlvlCfg.para1)[i])
                                                        end
                                                        if logic == eLogicType.CareerBuff and not ignoreZeroFcuc(i, 3) then
                                                          local careerId = (levelCfg.para1)[i]
                                                          local attrId = (levelCfg.para2)[i]
                                                          local attibuteCfg = (ConfigData.attribute)[attrId]
                                                          if attibuteCfg == nil then
                                                            error("Can\'t find attibuteCfg, id = " .. tostring(attrId))
                                                          else
                                                            local attrName = (LanguageUtil.GetLocaleText)(attibuteCfg.name)
                                                            local isRatio = attibuteCfg.num_type == 2
                                                            local careerCfg = (ConfigData.career)[careerId]
                                                            if careerCfg == nil then
                                                              error("can\'t find career, id=" .. tostring(careerId))
                                                            else
                                                              local count = (levelCfg.para3)[i]
                                                              local valueStr = nil
                                                              if isRatio then
                                                                valueStr = tostring(FormatNum(count / 10)) .. "%"
                                                              else
                                                                valueStr = tostring(count)
                                                              end
                                                              currentInfo = (string.format)(describ, (LanguageUtil.GetLocaleText)(careerCfg.name), attrName)
                                                              curValue = (string.format)(valueFormat, valueStr)
                                                              do
                                                                if getNext ~= nil and nextlvlCfg ~= nil and (nextlvlCfg.logic)[i] == eLogicType.CareerBuff then
                                                                  local nextCount = (nextlvlCfg.para3)[i]
                                                                  if isRatio then
                                                                    valueStr = tostring(FormatNum(nextCount / 10)) .. "%"
                                                                  else
                                                                    valueStr = tostring(nextCount)
                                                                  end
                                                                  nextInfoValue = (string.format)(valueFormat, valueStr)
                                                                end
                                                                if logic == eLogicType.CampBuff and not ignoreZeroFcuc(i, 3) then
                                                                  local campId = (levelCfg.para1)[i]
                                                                  local attrId = (levelCfg.para2)[i]
                                                                  local attibuteCfg = (ConfigData.attribute)[attrId]
                                                                  if attibuteCfg == nil then
                                                                    error("Can\'t find attibuteCfg, id = " .. tostring(attrId))
                                                                    return 
                                                                  end
                                                                  local attrName = (LanguageUtil.GetLocaleText)(attibuteCfg.name)
                                                                  local isRatio = attibuteCfg.num_type == 2
                                                                  local campCfg = (ConfigData.career)[campId]
                                                                  if campCfg == nil then
                                                                    error("can\'t find career, id=" .. tostring(campId))
                                                                    return 
                                                                  end
                                                                  local count = (levelCfg.para3)[i]
                                                                  local valueStr = nil
                                                                  if isRatio then
                                                                    valueStr = tostring(FormatNum(count / 10)) .. "%"
                                                                  else
                                                                    valueStr = tostring(count)
                                                                  end
                                                                  currentInfo = (string.format)(describ, (LanguageUtil.GetLocaleText)(campCfg.name), attrName)
                                                                  curValue = (string.format)(valueFormat, valueStr)
                                                                  do
                                                                    if getNext ~= nil and nextlvlCfg ~= nil and (nextlvlCfg.logic)[i] == eLogicType.CampBuff then
                                                                      local nextCount = (nextlvlCfg.para3)[i]
                                                                      if isRatio then
                                                                        valueStr = tostring(FormatNum(nextCount / 10)) .. "%"
                                                                      else
                                                                        valueStr = tostring(nextCount)
                                                                      end
                                                                      nextInfoValue = (string.format)(valueFormat, valueStr)
                                                                    end
                                                                    if logic == eLogicType.DynPlayerAttrBuff and not ignoreZeroFcuc(i, 2) then
                                                                      local dynAttrId = (levelCfg.para1)[i]
                                                                      local value = (levelCfg.para2)[i]
                                                                      if dynAttrId == 16 or dynAttrId == 23 then
                                                                        value = FormatNum(value / 10)
                                                                      end
                                                                      local buffDesIndex = logic * 100 + dynAttrId
                                                                      if (ConfigData.buildingBuff)[buffDesIndex] == nil then
                                                                        error("Cant get buildingBuff, id = " .. tostring(buffDesIndex))
                                                                      else
                                                                        describ = (LanguageUtil.GetLocaleText)(((ConfigData.buildingBuff)[buffDesIndex]).buff_text_context)
                                                                        valueFormat = (LanguageUtil.GetLocaleText)(((ConfigData.buildingBuff)[buffDesIndex]).buff_value)
                                                                        currentInfo = describ
                                                                        curValue = (string.format)(valueFormat, value)
                                                                        do
                                                                          if getNext and nextlvlCfg ~= nil and (nextlvlCfg.logic)[i] == eLogicType.DynPlayerAttrBuff then
                                                                            local nextValue = (nextlvlCfg.para2)[i]
                                                                            if dynAttrId == 16 or dynAttrId == 23 then
                                                                              nextValue = FormatNum(nextValue / 10)
                                                                            end
                                                                            nextInfoValue = (string.format)(valueFormat, nextValue)
                                                                          end
                                                                          if logic == eLogicType.HeroLevelCeiling and not ignoreZeroFcuc(i, 1) then
                                                                            do
                                                                              local value = (levelCfg.para1)[i]
                                                                              currentInfo = describ
                                                                              curValue = (string.format)(valueFormat, value)
                                                                              if getNext and nextlvlCfg ~= nil and (nextlvlCfg.logic)[i] == eLogicType.HeroLevelCeiling then
                                                                                nextInfoValue = (string.format)(valueFormat, (nextlvlCfg.para1)[i])
                                                                              end
                                                                              if logic == eLogicType.AutoRecoverItem and not ignoreZeroFcuc(i, 2) then
                                                                                local itemCfg = (ConfigData.item)[(levelCfg.para1)[i]]
                                                                                local speed = (levelCfg.para2)[i]
                                                                                speed = speed * 36 / 1000
                                                                                currentInfo = (string.format)(describ, (LanguageUtil.GetLocaleText)(itemCfg.name))
                                                                                curValue = (string.format)(valueFormat, speed)
                                                                                do
                                                                                  if getNext and nextlvlCfg ~= nil and (nextlvlCfg.logic)[i] == eLogicType.AutoRecoverItem then
                                                                                    local speed = (nextlvlCfg.para2)[i] * 36 / 1000
                                                                                    nextInfoValue = (string.format)(valueFormat, speed)
                                                                                  end
                                                                                  if logic == eLogicType.FactoryEfficiency and not ignoreZeroFcuc(i, 2) then
                                                                                    currentInfo = (string.format)(describ, orderName)
                                                                                    curValue = (string.format)(valueFormat, (levelCfg.para2)[i] * 0.1)
                                                                                    if getNext and nextlvlCfg ~= nil and (nextlvlCfg.logic)[i] == eLogicType.FactoryEfficiency then
                                                                                      nextInfoValue = (string.format)(valueFormat, (nextlvlCfg.para2)[i] * 0.1)
                                                                                    end
                                                                                    if logic == eLogicType.ResOutputCeiling and not ignoreZeroFcuc(i, 2) then
                                                                                      local buildingCfg = (ConfigData.building)[(levelCfg.para1)[i]]
                                                                                      do
                                                                                        do
                                                                                          local describ_text = (string.format)(describ, (LanguageUtil.GetLocaleText)(buildingCfg.name))
                                                                                          currentInfo = describ_text
                                                                                          curValue = (string.format)(valueFormat, (levelCfg.para2)[i])
                                                                                          if getNext and nextlvlCfg ~= nil and (nextlvlCfg.logic)[i] == eLogicType.ResOutputCeiling then
                                                                                            nextInfoValue = (string.format)(valueFormat, (nextlvlCfg.para2)[i])
                                                                                          end
                                                                                          if not (string.IsNullOrEmpty)(currentInfo) then
                                                                                            (table.insert)(buffList, {logicId = logic, currentInfo = currentInfo, curValue = curValue, nextInfoValue = nextInfoValue})
                                                                                          end
                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out DO_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out IF_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out IF_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out DO_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out IF_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out DO_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out IF_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out DO_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out IF_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out IF_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out DO_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out IF_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out DO_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out IF_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out IF_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out IF_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out DO_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out IF_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out DO_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out IF_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out DO_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out IF_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out DO_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out IF_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out DO_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out IF_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out DO_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out IF_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out DO_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out IF_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out DO_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out DO_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out IF_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out DO_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out IF_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out IF_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out IF_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out DO_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out IF_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out IF_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out DO_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                                                          -- DECOMPILER ERROR at PC1231: LeaveBlock: unexpected jumping out IF_STMT

                                                                                        end
                                                                                      end
                                                                                    end
                                                                                  end
                                                                                end
                                                                              end
                                                                            end
                                                                          end
                                                                        end
                                                                      end
                                                                    end
                                                                  end
                                                                end
                                                              end
                                                            end
                                                          end
                                                        end
                                                      end
                                                    end
                                                  end
                                                end
                                              end
                                            end
                                          end
                                        end
                                      end
                                    end
                                  end
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  do return buffList end
  -- DECOMPILER ERROR: 26 unprocessed JMP targets
end

return OasisBuildingDynData

