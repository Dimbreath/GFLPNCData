local CommonLogicUtil = {}
local IsLegalFuncTable = {}
local GetDesFuncTable = {[eLogicType.ResourceLimit] = function(para1, para2, para3)
  -- function num : 0_0 , upvalues : _ENV
  local itemName = (LanguageUtil.GetLocaleText)(((ConfigData.item)[para1]).name)
  local itemNum = para2
  return (string.format)("%s存储上限增加%s", itemName, tostring(itemNum)), itemName, itemNum
end
, [eLogicType.ResourceOutput] = function(para1, para2, para3)
  -- function num : 0_1 , upvalues : _ENV
  local itemName = (LanguageUtil.GetLocaleText)(((ConfigData.item)[para1]).name)
  local speed = para2 * 36 // 1000
  return (string.format)("%s产出增加%s/h", itemName, tostring(speed)), itemName, speed
end
, [eLogicType.CampBuff] = function(para1, para2, para3)
  -- function num : 0_2 , upvalues : _ENV
  local campName = (LanguageUtil.GetLocaleText)(((ConfigData.camp)[para1]).name)
  local attrName = (LanguageUtil.GetLocaleText)(((ConfigData.attribute)[para2]).name)
  local attrValue = para3
  return (string.format)("%s的%s属增加%s", campName, attrName, tostring(attrValue)), campName, attrName, attrValue
end
, [eLogicType.CareerBuff] = function(para1, para2, para3)
  -- function num : 0_3 , upvalues : _ENV
  local careerName = (LanguageUtil.GetLocaleText)(((ConfigData.career)[para1]).name)
  local attrName = (LanguageUtil.GetLocaleText)(((ConfigData.attribute)[para2]).name)
  local attrValue = para3
  return (string.format)("%s的%s属增加%s", careerName, attrName, tostring(attrValue)), careerName, attrName, attrValue
end
, [eLogicType.FactoryPipelie] = function(para1, para2, para3)
  -- function num : 0_4 , upvalues : _ENV
  local lineNum = para1
  return (string.format)("工厂流水线增加%s", tostring(lineNum)), lineNum
end
, [eLogicType.GlobalExpCeiling] = function(para1, para2, para3)
  -- function num : 0_5 , upvalues : _ENV
  local expLimt = para1
  return (string.format)("全局Exp上限增加%s", tostring(expLimt)), expLimt
end
, [eLogicType.StaminaCeiling] = function(para1, para2, para3)
  -- function num : 0_6 , upvalues : _ENV
  local staminaLimt = para1
  return (string.format)("密钥上限增加%s", tostring(staminaLimt)), staminaLimt
end
, [eLogicType.StaminaOutput] = function(para1, para2, para3)
  -- function num : 0_7 , upvalues : _ENV
  local speed = para1 * 0.036
  return (string.format)("密钥产出增加%s/h", tostring(speed)), speed
end
, [eLogicType.ResOutputEfficiency] = function(para1, para2, para3)
  -- function num : 0_8 , upvalues : _ENV
  local itemName = nil
  if para1 == 0 then
    itemName = "全部道具"
  else
    local itemCfg = (ConfigData.item)[para1]
    itemName = (LanguageUtil.GetLocaleText)(itemCfg.name)
  end
  do
    local rate = GetPreciseDecimalStr(para2 / 10, 2) .. "%"
    return (string.format)("%s生产效率提升%s", itemName, rate), itemName, rate
  end
end
, [eLogicType.BuildQueue] = function(para1, para2, para3)
  -- function num : 0_9 , upvalues : _ENV
  local placeName = nil
  if para1 == 1 then
    placeName = "绿洲"
  else
    placeName = "扇区"
  end
  local listNum = para2
  return (string.format)("%s建造队列增加%s", placeName, tostring(listNum)), listNum
end
, [eLogicType.BuildSpeed] = function(para1, para2, para3)
  -- function num : 0_10 , upvalues : _ENV
  ((theSelf.ui).tex_AttriName):SetIndex(eLogicType.BuildSpeed)
  local speed = para1
  local rate = GetPreciseDecimalStr(speed / 10, 2) .. "%"
  return (string.format)("建造速度提升%s", rate), rate
end
, [eLogicType.GlobalExpRatio] = function(para1, para2, para3)
  -- function num : 0_11 , upvalues : _ENV
  local rate = GetPreciseDecimalStr(para1 / 10, 2) .. "%"
  return (string.format)("溢出Exp转化效率提升%s", rate), rate
end
, [eLogicType.AllHeroBuff] = function(para1, para2, para3)
  -- function num : 0_12 , upvalues : _ENV
  local attrName = (LanguageUtil.GetLocaleText)(((ConfigData.attribute)[para1]).name)
  local attrValue = para2
  return (string.format)("全体的%s属性增加%s", attrName, tostring(attrValue)), attrName, attrValue
end
, [eLogicType.OverClock] = function(para1, para2, para3)
  -- function num : 0_13 , upvalues : _ENV
  local name = (LanguageUtil.GetLocaleText)((((ConfigData.overclock)[para1])[level]).name)
  local level = para2
  return (string.format)("超频项%s提升到Lv.%s", name, tostring(level)), name, level
end
, [eLogicType.OverClockFreeNum] = function(para1, para2, para3)
  -- function num : 0_14 , upvalues : _ENV
  return (string.format)("超频免费数目%s", tostring(para1)), para1
end
, [eLogicType.FocusPointCeiling] = function(para1, para2, para3)
  -- function num : 0_15 , upvalues : _ENV
  return (string.format)("专注点数上限%s", tostring(para1)), para1
end
, [eLogicType.BattleExpBonus] = function(para1, para2, para3)
  -- function num : 0_16 , upvalues : _ENV
  local rate = GetPreciseDecimalStr(para1 / 10, 2) .. "%"
  return (string.format)("战斗经验增加%s", rate), rate
end
, [eLogicType.DynSkillUpgrade] = function(para1, para2, para3)
  -- function num : 0_17 , upvalues : _ENV
  local rate = GetPreciseDecimalStr(para1 / 100, 2) .. "%"
  return (string.format)("增援技能树获取经验增加%s", rate), rate
end
, [eLogicType.DynChipCountMax] = function(para1, para2, para3)
  -- function num : 0_18 , upvalues : _ENV
  return (string.format)("探索函数上限%s", tostring(para1)), para1
end
, [eLogicType.AutoRecoverItem] = function(para1, para2, para3)
  -- function num : 0_19 , upvalues : _ENV
  local itemName = nil
  if para1 == 0 then
    itemName = "全部道具"
  else
    local itemCfg = (ConfigData.item)[para1]
    itemName = (LanguageUtil.GetLocaleText)(itemCfg.name)
  end
  do
    local rate = GetPreciseDecimalStr(para2 / 100000 * 3600, 2)
    return (string.format)("%s每小时产出增加%s", itemName, rate), itemName, rate
  end
end
, [eLogicType.DungeonCountAdd] = function(para1, para2, para3)
  -- function num : 0_20 , upvalues : _ENV
  local dungeonName = (LanguageUtil.GetLocaleText)(((ConfigData.material_dungeon)[para1]).name)
  local describ = (LanguageUtil.GetLocaleText)(((ConfigData.buildingBuff)[eLogicType.DungeonCountAdd]).buff_text_context)
  local value = (LanguageUtil.GetLocaleText)(((ConfigData.buildingBuff)[eLogicType.DungeonCountAdd]).buff_value)
  local describ_text = dungeonName .. "：" .. (string.format)(describ, para2)
  return describ_text, para2
end
, [eLogicType.DungeonRewardExtraNum] = function(para1, para2, para3)
  -- function num : 0_21 , upvalues : _ENV
  local describ_text = (string.format)(ConfigData:GetTipContent(2029), para1)
  return describ_text
end
, [eLogicType.FriendshipBonus] = function(para1, para2, para3)
  -- function num : 0_22 , upvalues : _ENV
  local describ_text = (string.format)(ConfigData:GetTipContent(2030), para1)
  return describ_text
end
, [eLogicType.DailyFixedOutput] = function(para1, para2, para3)
  -- function num : 0_23 , upvalues : _ENV
  local para1Str = tostring(para1)
  local hourStr = (string.sub)(para1Str, 1, 2)
  local minuteStr = ((string.sub)(para1Str, 3, 4))
  local itemName = nil
  local itemCfg = (ConfigData.item)[para2]
  if itemCfg ~= nil then
    itemName = (LanguageUtil.GetLocaleText)(itemCfg.name)
  end
  local describ_text = (string.format)(ConfigData:GetTipContent(2031), hourStr, minuteStr, itemName, para3)
  return describ_text
end
}
local MergeType = {equal = 1, add = 2, max = 3}
local MergeInfoTable = {
[eLogicType.ResourceLimit] = {[1] = MergeType.equal, [2] = MergeType.add}
, 
[eLogicType.ResourceOutput] = {donotMerge = true}
, 
[eLogicType.CampBuff] = {[1] = MergeType.equal, [2] = MergeType.equal, [3] = MergeType.add}
, 
[eLogicType.CareerBuff] = {[1] = MergeType.equal, [2] = MergeType.equal, [3] = MergeType.add}
, 
[eLogicType.FactoryPipelie] = {[1] = MergeType.add}
, 
[eLogicType.GlobalExpCeiling] = {[1] = MergeType.add}
, 
[eLogicType.StaminaCeiling] = {[1] = MergeType.add}
, 
[eLogicType.StaminaOutput] = {[1] = MergeType.add}
, 
[eLogicType.ResOutputEfficiency] = {[1] = MergeType.equal, [2] = MergeType.add}
, 
[eLogicType.BuildQueue] = {[1] = MergeType.equal, [2] = MergeType.add}
, 
[eLogicType.BuildSpeed] = {[1] = MergeType.add}
, 
[eLogicType.GlobalExpRatio] = {[1] = MergeType.add}
, 
[eLogicType.AllHeroBuff] = {[1] = MergeType.equal, [2] = MergeType.add}
, 
[eLogicType.OverClock] = {[1] = MergeType.equal, [2] = MergeType.max}
, 
[eLogicType.OverClockFreeNum] = {[1] = MergeType.add}
, 
[eLogicType.FocusPointCeiling] = {[1] = MergeType.add}
, 
[eLogicType.BattleExpBonus] = {[1] = MergeType.add}
, 
[eLogicType.DynSkillUpgrade] = {[1] = MergeType.add}
, 
[eLogicType.DynChipCountMax] = {[1] = MergeType.add}
, 
[eLogicType.AutoRecoverItem] = {[1] = MergeType.equal, [2] = MergeType.add}
, 
[eLogicType.DungeonCountAdd] = {[1] = MergeType.equal, [2] = MergeType.add}
, 
[eLogicType.DungeonRewardExtraNum] = {[1] = MergeType.add}
, 
[eLogicType.FriendshipBonus] = {[1] = MergeType.add}
, 
[eLogicType.DailyFixedOutput] = {[1] = MergeType.equal, [2] = MergeType.equal, [3] = MergeType.add}
}
CommonLogicUtil.GetDesString = function(logic, para1, para2, para3)
  -- function num : 0_24 , upvalues : GetDesFuncTable
  local desFunc = GetDesFuncTable[logic]
  if desFunc == nil then
    return ""
  else
    return desFunc(para1, para2, para3)
  end
end

CommonLogicUtil.GetLogicDesStrMultiLine = function(logic_list, para1_list, para2_List, para3_list)
  -- function num : 0_25 , upvalues : _ENV, CommonLogicUtil
  local des = nil
  for index,logic in pairs(logic_list) do
    local para1 = para1_list[index]
    local para2 = para2_List[index]
    local para3 = para3_list[index]
    if (string.IsNullOrEmpty)(des) then
      des = (CommonLogicUtil.GetDesString)(logic, para1, para2, para3)
    else
      des = des .. "\n" .. (CommonLogicUtil.GetDesString)(logic, para1, para2, para3)
    end
  end
  return des
end

CommonLogicUtil.MergeLogic = function(logicDic, logic, paras)
  -- function num : 0_26 , upvalues : _ENV, MergeInfoTable, MergeType
  local logicParaTable = logicDic[logic]
  if logicParaTable == nil then
    logicDic[logic] = {}
    for index,value in ipairs(paras) do
      -- DECOMPILER ERROR at PC11: Confused about usage of register: R9 in 'UnsetPending'

      (logicDic[logic])[index] = {}
      -- DECOMPILER ERROR at PC14: Confused about usage of register: R9 in 'UnsetPending'

      ;
      ((logicDic[logic])[index])[1] = value
    end
    return logicDic
  end
  local mergeInfo = MergeInfoTable[logic]
  if mergeInfo == nil or mergeInfo.donotMerge then
    for index,para in ipairs(paras) do
      (table.insert)(logicParaTable[index], para)
    end
  else
    do
      local isMerged = false
      for groupIndex,_ in ipairs(logicParaTable[1]) do
        local couldMerge = true
        local tempParas = {}
        for paraindex,type in ipairs(mergeInfo) do
          if type == MergeType.equal then
            if (logicParaTable[paraindex])[groupIndex] ~= paras[paraindex] then
              couldMerge = false
              break
            else
              tempParas[paraindex] = (logicParaTable[paraindex])[groupIndex]
            end
          else
            if type == MergeType.add then
              tempParas[paraindex] = (logicParaTable[paraindex])[groupIndex] + paras[paraindex]
            else
              if type == MergeType.max then
                tempParas[paraindex] = (math.max)((logicParaTable[paraindex])[groupIndex], paras[paraindex])
              end
            end
          end
        end
        do
          do
            if couldMerge then
              for index,type in ipairs(mergeInfo) do
                -- DECOMPILER ERROR at PC91: Confused about usage of register: R18 in 'UnsetPending'

                (logicParaTable[index])[groupIndex] = tempParas[index]
              end
              isMerged = true
              break
            end
            -- DECOMPILER ERROR at PC96: LeaveBlock: unexpected jumping out DO_STMT

          end
        end
      end
      if not isMerged then
        for index,para in ipairs(paras) do
          (table.insert)(logicParaTable[index], para)
        end
      end
      do
        return logicDic
      end
    end
  end
end

CommonLogicUtil.MinLogicCfg = function(cfg, front_cfg)
  -- function num : 0_27 , upvalues : _ENV, CommonLogicUtil
  if front_cfg == nil then
    return cfg.logic, cfg.para1, cfg.para2, cfg.para3
  else
    local logic_out = {}
    local para1_out = {}
    local para2_out = {}
    local para3_out = {}
    for index,logic in ipairs(cfg.logic) do
      local paras = {(cfg.para1)[index], (cfg.para2)[index], (cfg.para3)[index]}
      local success = false
      for index,front_logic in ipairs(front_cfg.logic) do
        local tempparas = {(front_cfg.para1)[index], (front_cfg.para2)[index], (front_cfg.para3)[index]}
        if logic == front_logic then
          success = (CommonLogicUtil.MinLogic)(logic, paras, front_logic, tempparas)
        else
          success = true
        end
        if not success then
          error("common logic can\'t min")
          return cfg.logic, cfg.para1, cfg.para2, cfg.para3
        else
        end
      end
      do
        do
          if paras == nil or paras ~= nil then
            (table.insert)(logic_out, logic)
            ;
            (table.insert)(para1_out, paras[1])
            ;
            (table.insert)(para2_out, paras[2])
            ;
            (table.insert)(para3_out, paras[3])
          end
          -- DECOMPILER ERROR at PC86: LeaveBlock: unexpected jumping out DO_STMT

        end
      end
    end
    return logic_out, para1_out, para2_out, para3_out
  end
end

CommonLogicUtil.MinLogic = function(logic1, argList1, logic2, argList2)
  -- function num : 0_28 , upvalues : _ENV, MergeInfoTable, MergeType
  if logic1 ~= logic2 then
    warn("use diff logic to min logic1:" .. tostring(logic1) .. " logic2:" .. tostring(logic2))
    return false
  end
  local mergeInfo = MergeInfoTable[logic1]
  if mergeInfo == nil or #argList1 < #mergeInfo then
    error("not have mergeInfo or mergeInfo error")
    return false
  end
  local argList = {}
  for index,type in ipairs(mergeInfo) do
    if type == MergeType.equal then
      if argList1[index] ~= argList2[index] then
        return true, argList1
      else
        argList[index] = argList1[index]
      end
    else
      if type == MergeType.add then
        argList[index] = argList1[index] - argList2[index]
        if argList[index] == 0 then
          return true, nil
        end
      else
        if type == MergeType.max then
          argList[index] = argList1[index] - argList2[index]
          if argList[index] == 0 then
            return true, nil
          end
        end
      end
    end
  end
  return true, argList
end

return CommonLogicUtil

