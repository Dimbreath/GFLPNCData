-- params : ...
-- function num : 0 , upvalues : _ENV
local AllAthData = class("AllAthData")
local ArithmeticData = require("Game.PlayerData.Arithmetic.ArithmeticData")
AllAthData.ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.athDic = {}
  self.slotAthDic = {}
  for i = 1, (ConfigData.game_config).athSlotCount do
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R5 in 'UnsetPending'

    (self.slotAthDic)[i] = {}
  end
  self.heroAthDic = {}
  self.heroAthSlotDic = {}
  self.failure = 0
end

AllAthData.InitAllAthData = function(self, msg)
  -- function num : 0_1 , upvalues : _ENV
  self.athDic = {}
  self.heroAthDic = {}
  self.slotAthDic = {}
  for i = 1, (ConfigData.game_config).athSlotCount do
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R6 in 'UnsetPending'

    (self.slotAthDic)[i] = {}
  end
  self.heroAthSlotDic = msg.heroSlot
  self.failure = msg.failure
  self.autoDeco = msg.autoDeco
  self.athReconsitutionData = msg.reconsitution
end

AllAthData.InitBatchAllAthData = function(self, msg)
  -- function num : 0_2 , upvalues : _ENV
  for uid,v in pairs(msg.data) do
    self:__NewAthData(v)
  end
end

AllAthData.UpdateAthReconsitutionData = function(self, reconsitution)
  -- function num : 0_3
  self.athReconsitutionData = reconsitution
end

AllAthData.SyncAthDiff = function(self, msg)
  -- function num : 0_4 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  PlayerDataCenter.lastAthDiff = {}
  for uid,v in pairs(msg.updateAth) do
    local athData = (self.athDic)[uid]
    if athData == nil then
      athData = self:__NewAthData(v)
    else
      local oldBindInfo = athData.bindInfo
      athData:UpdateAthData(v)
      if athData.bindInfo ~= nil then
        (PlayerDataCenter.attributeBonus):DirtyHeroAthBonus((athData.bindInfo).id)
      end
      local newBindInfo = athData.bindInfo
      if oldBindInfo ~= nil and newBindInfo == nil then
        self:__RemoveFromHero(oldBindInfo.id, oldBindInfo.idx, athData.uid)
      else
        if oldBindInfo ~= nil and newBindInfo ~= nil and oldBindInfo.id ~= newBindInfo.id then
          self:__RemoveFromHero(oldBindInfo.id, oldBindInfo.idx, athData.uid)
          self:__AddToHero(athData)
        else
          if oldBindInfo == nil and newBindInfo ~= nil then
            self:__AddToHero(athData)
          end
        end
      end
    end
    do
      do
        ;
        (table.insert)(PlayerDataCenter.lastAthDiff, athData)
        -- DECOMPILER ERROR at PC70: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  for uid,v in pairs(msg.deleteAth) do
    local athData = (self.athDic)[uid]
    if athData ~= nil then
      self:__RemoveFromSlot(athData)
      if athData.bindInfo ~= nil then
        self:__RemoveFromHero((athData.bindInfo).id, (athData.bindInfo).idx, uid)
      end
      -- DECOMPILER ERROR at PC94: Confused about usage of register: R8 in 'UnsetPending'

      ;
      (self.athDic)[uid] = nil
    end
  end
  for heroId,v in pairs(msg.heroSlot) do
    -- DECOMPILER ERROR at PC102: Confused about usage of register: R7 in 'UnsetPending'

    (self.heroAthSlotDic)[heroId] = v
    ;
    (PlayerDataCenter.attributeBonus):DirtyHeroAthBonus(heroId)
  end
end

AllAthData.UpdateAthFalure = function(self, faluer)
  -- function num : 0_5
  self.failure = faluer
end

AllAthData.__NewAthData = function(self, msg)
  -- function num : 0_6 , upvalues : ArithmeticData
  local athData = (ArithmeticData.New)(msg)
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.athDic)[athData.uid] = athData
  self:__AddToSlot(athData)
  self:__AddToHero(athData)
  return athData
end

AllAthData.__AddToSlot = function(self, athData)
  -- function num : 0_7 , upvalues : _ENV
  local slotAthList = (self.slotAthDic)[athData.area_type]
  if slotAthList == nil then
    error("Can\'t find arithmetic slot. slot id = " .. tostring((athData.bindInfo).idx))
    return 
  end
  slotAthList[athData.uid] = athData
end

AllAthData.__RemoveFromSlot = function(self, athData)
  -- function num : 0_8
  local slotAthList = (self.slotAthDic)[athData.area_type]
  if slotAthList == nil then
    return 
  end
  slotAthList[athData.uid] = nil
end

AllAthData.__AddToHero = function(self, athData)
  -- function num : 0_9 , upvalues : _ENV
  if athData.bindInfo ~= nil then
    local heroId = (athData.bindInfo).id
    local slotId = (athData.bindInfo).idx
    local heroAth = (self.heroAthDic)[heroId]
    if heroAth == nil then
      heroAth = {}
      -- DECOMPILER ERROR at PC14: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (self.heroAthDic)[heroId] = heroAth
    end
    local heroAthSlot = heroAth[slotId]
    if heroAthSlot == nil then
      heroAthSlot = {}
      heroAth[slotId] = heroAthSlot
    end
    heroAthSlot[athData.uid] = athData
    ;
    (PlayerDataCenter.attributeBonus):DirtyHeroAthBonus(heroId)
  end
end

AllAthData.__RemoveFromHero = function(self, heroId, slotId, uid)
  -- function num : 0_10 , upvalues : _ENV
  local heroAth = (self.heroAthDic)[heroId]
  if heroAth == nil then
    return 
  end
  local heroAthSlot = heroAth[slotId]
  if heroAthSlot == nil then
    return 
  end
  heroAthSlot[uid] = nil
  ;
  (PlayerDataCenter.attributeBonus):DirtyHeroAthBonus(heroId)
end

AllAthData.GetHeroAthList = function(self, heroId, slotId)
  -- function num : 0_11 , upvalues : _ENV
  local heroAth = (self.heroAthDic)[heroId]
  if heroAth == nil then
    return {}, {}
  end
  local athDic = heroAth[slotId]
  if athDic == nil then
    return {}, {}
  end
  local athList = {}
  for uid,data in pairs(athDic) do
    (table.insert)(athList, data)
  end
  ;
  (table.sort)(athList, function(a, b)
    -- function num : 0_11_0
    if a.size >= b.size then
      do return a.size == b.size end
      do return a.id < b.id end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
)
  return athList, athDic
end

AllAthData.GetHeroAthSlotInfo = function(self, heroId)
  -- function num : 0_12
  local level = 1
  local exp = 0
  local heroArea = (self.heroAthSlotDic)[heroId]
  if heroArea ~= nil then
    level = heroArea.lv
    exp = heroArea.exp
  end
  return level, exp
end

AllAthData.IsHeroAthSlotMaxLevel = function(self, heroId)
  -- function num : 0_13 , upvalues : _ENV
  local level = self:GetHeroAthSlotInfo(heroId)
  do return (ConfigData.ath_efficiency).maxLevel <= level end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

AllAthData.GetAllAthList = function(self, space, ignoreInstalled, quality)
  -- function num : 0_14 , upvalues : _ENV
  local dic = self.athDic
  if dic == nil then
    error("Can\'t find athDic")
    return {}
  end
  local list = {}
  for k,v in pairs(dic) do
    if (not ignoreInstalled or v.bindInfo == nil) and (quality == nil or v:GetAthQuality() == quality) then
      if space == nil then
        (table.insert)(list, v)
      else
        if v.size == space then
          (table.insert)(list, v)
        end
      end
    end
  end
  return list
end

AllAthData.GetAllAthSlotList = function(self, slotId, space, ignoreInstalled, withoutIgnoreHeroId)
  -- function num : 0_15 , upvalues : _ENV
  local dic = (self.slotAthDic)[slotId]
  if dic == nil then
    error("Can\'t find slotAthDic, slotId = " .. tostring(slotId))
    return {}
  end
  local list = {}
  for k,v in pairs(dic) do
    if not ignoreInstalled or v.bindInfo == nil or (v.bindInfo).id == withoutIgnoreHeroId then
      if space == nil then
        (table.insert)(list, v)
      else
        if v.size == space then
          (table.insert)(list, v)
        end
      end
    end
  end
  return list
end

AllAthData.GetAthEfficiency = function(self, slotLevel)
  -- function num : 0_16 , upvalues : _ENV
  local cfg = (ConfigData.ath_efficiency)[slotLevel]
  if cfg == nil then
    error("Can\'t find ath_efficiency, level = " .. tostring(slotLevel))
    return 0
  end
  return cfg.attribute_promote
end

AllAthData.HeroContainAthById = function(self, heroId, slotId, athId)
  -- function num : 0_17 , upvalues : _ENV
  local heroAth = (self.heroAthDic)[heroId]
  if heroAth == nil then
    return false
  end
  if slotId == nil then
    for k,athDic in pairs(heroAth) do
      for uid,data in pairs(athDic) do
        if data.id == athId then
          return true, data
        end
      end
    end
  else
    do
      local athDic = heroAth[slotId]
      if athDic == nil then
        return false
      end
      for uid,data in pairs(athDic) do
        if data.id == athId then
          return true, data
        end
      end
      do
        return false
      end
    end
  end
end

AllAthData.HeroContainAthByUid = function(self, heroId, uid)
  -- function num : 0_18 , upvalues : _ENV
  local heroAth = (self.heroAthDic)[heroId]
  if heroAth == nil then
    return false
  end
  for k,athDic in pairs(heroAth) do
    for installUid,data in pairs(athDic) do
      if uid == installUid then
        return true
      end
    end
  end
end

AllAthData.GetHeroAthFreeSpace = function(self, heroData, slotId)
  -- function num : 0_19 , upvalues : _ENV
  local ok = false
  local freeSpace = 0
  local usedSpace = 0
  self.curheroAth = (self.heroAthDic)[heroData.dataId]
  if self.curheroAth ~= nil then
    self.currAthDic = (self.curheroAth)[slotId]
    if self.currAthDic ~= nil then
      for uid,data in pairs(self.currAthDic) do
        usedSpace = usedSpace + data.size
      end
    end
  end
  do
    local heroAthSpace = (heroData:GetAthSlotList())[slotId]
    if heroAthSpace == nil then
      return ok, freeSpace
    end
    freeSpace = heroAthSpace - (usedSpace)
    if freeSpace > 0 then
      ok = true
    end
    return ok, freeSpace
  end
end

AllAthData.GetHeroCanLoaded = function(self, heroData)
  -- function num : 0_20 , upvalues : _ENV
  local athslotList = heroData:GetAthSlotList()
  for slotId,v in ipairs(athslotList) do
    if self:GetHeroCanLoadedSlot(heroData, slotId) then
      return true
    end
  end
  return false
end

AllAthData.GetHeroCanLoadedSlot = function(self, heroData, slotId)
  -- function num : 0_21 , upvalues : _ENV
  local ATHCount = 0
  local canLoad = false
  local ok, freeSpace = self:GetHeroAthFreeSpace(heroData, slotId)
  if not ok then
    return canLoad, ATHCount
  end
  local slotList = self:GetAllAthSlotList(slotId, nil, true)
  local athDataList, athDic = self:GetHeroAthList(heroData.dataId, slotId)
  local installedAthIdDic = {}
  for k,athData in pairs(athDic) do
    installedAthIdDic[athData.id] = true
  end
  for k,data in pairs(slotList) do
    if data.size <= freeSpace and installedAthIdDic[data.id] == nil then
      ATHCount = 1
      break
    end
  end
  do
    if ATHCount > 0 then
      canLoad = true
    end
    return canLoad, ATHCount
  end
end

AllAthData.GetAthFightPower = function(self, athAttrDic)
  -- function num : 0_22 , upvalues : _ENV
  do
    if self.__fightingPowerFun == nil then
      local formula = (ConfigData.game_config).athPowerFormula
      self.__fightingPowerFun = (load("return function(ath) return " .. formula .. " end"))()
    end
    local power = (self.__fightingPowerFun)(athAttrDic)
    return power
  end
end

AllAthData.GetAthDensity = function(self, athAttrDic, size)
  -- function num : 0_23
  local power = self:GetAthFightPower(athAttrDic)
  return power / size
end

AllAthData.GetAthEfficiencyCfg = function(self, level)
  -- function num : 0_24 , upvalues : _ENV
  local cfg = (ConfigData.ath_efficiency)[level]
  if cfg == nil then
    error("Cant\'t get ath_efficiency cfg, level = " .. tostring(level))
    return nil
  end
  return cfg
end

AllAthData.TryAddAthAreaExp = function(self, exp, curLevel, curExp)
  -- function num : 0_25 , upvalues : _ENV
  local curLvlCfg = self:GetAthEfficiencyCfg(curLevel)
  local nextExp = 0
  local nextTotalExp = curLvlCfg.shard
  local overflowExp = 0
  local testExp = exp + curExp
  local testLevel = curLevel
  for i = curLevel, (ConfigData.ath_efficiency).maxLevel - 1 do
    local levelCfg = self:GetAthEfficiencyCfg(i)
    if levelCfg == nil then
      return testLevel, nextExp, nextTotalExp, overflowExp
    end
    nextTotalExp = levelCfg.shard
    if testExp >= levelCfg.shard then
      do
        testExp = testExp - levelCfg.shard
        testLevel = i + 1
        -- DECOMPILER ERROR at PC32: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC32: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  if testLevel == (ConfigData.ath_efficiency).maxLevel then
    nextExp = 0
    overflowExp = testExp
    nextTotalExp = 0
  else
    nextExp = testExp
    overflowExp = 0
  end
  return testLevel, nextExp, nextTotalExp, overflowExp
end

AllAthData.GetHeroAthSuitIdDic = function(self, heroId, ignoreSlotId)
  -- function num : 0_26 , upvalues : _ENV
  local suitIdDic = {}
  local heroAth = (self.heroAthDic)[heroId]
  if heroAth == nil then
    return suitIdDic
  end
  for slotId,athDic in pairs(heroAth) do
    if ignoreSlotId ~= slotId then
      for uid,athData in pairs(athDic) do
        local suitId = athData:GetAthSuit()
        if suitId ~= 0 then
          suitIdDic[suitId] = true
        end
      end
    end
  end
  return suitIdDic
end

AllAthData.GetHeroAthAttr = function(self, heroId)
  -- function num : 0_27 , upvalues : _ENV
  local heroData = (PlayerDataCenter.heroDic)[heroId]
  if heroData == nil then
    error("Can\'t get heroData, id = " .. tostring(heroId))
    return 
  end
  local athSlotList = heroData:GetAthSlotList()
  local allAttrDic = (table.GetDefaulValueTable)(0)
  local allAttrDicNoEfcc = (table.GetDefaulValueTable)(0)
  local slotAttrTab = {}
  local slotAttrTabNoEfcc = {}
  local suitDic = {}
  for slotId,v in ipairs(athSlotList) do
    local attrDic = (table.GetDefaulValueTable)(0)
    local slotAttrDicNoEfcc = (table.GetDefaulValueTable)(0)
    slotAttrTab[slotId] = attrDic
    slotAttrTabNoEfcc[slotId] = slotAttrDicNoEfcc
    local athList = self:GetHeroAthList(heroId, slotId)
    for k,athData in ipairs(athList) do
      for k2,attrId in ipairs((athData.athMainAttrCfg).attrtibute_id) do
        local value = ((athData.athMainAttrCfg).attrtibute_num)[k2]
        local slotLevel = self:GetHeroAthSlotInfo(heroId)
        local efficiency = self:GetAthEfficiency(slotLevel)
        local attrValue = value * efficiency // 1000
        attrDic[attrId] = attrValue + attrDic[attrId]
        slotAttrDicNoEfcc[attrId] = value + slotAttrDicNoEfcc[attrId]
        allAttrDic[attrId] = attrValue + allAttrDic[attrId]
        allAttrDicNoEfcc[attrId] = value + allAttrDicNoEfcc[attrId]
      end
      for k2,elem in ipairs(athData.affixList) do
        local cfg = (ConfigData.ath_affix_pool)[elem.id]
        if cfg == nil then
          error("Cant\'t find ath_affix_pool, id = " .. tostring(elem.id))
        else
          local attrId = cfg.affix_para
          local attrValue = elem.value
          attrDic[attrId] = attrValue + attrDic[attrId]
          slotAttrDicNoEfcc[attrId] = attrValue + slotAttrDicNoEfcc[attrId]
          allAttrDic[attrId] = attrValue + allAttrDic[attrId]
          allAttrDicNoEfcc[attrId] = attrValue + allAttrDicNoEfcc[attrId]
        end
      end
      local suitId = athData.suit
      if suitId ~= 0 and suitDic[suitId] == nil then
        local suitAthList = ((ConfigData.arithmetic).suitDic)[suitId]
        if suitAthList == nil then
          error("Can\'t find ConfigData.arithmetic.suitDic,id = " .. tostring(suitId))
        end
        local suitAthCount = 0
        local suitAthDic = {}
        for k2,athId in ipairs(suitAthList) do
          local installed, instAthData = self:HeroContainAthById(heroId, nil, athId)
          if installed then
            suitAthCount = suitAthCount + 1
            suitAthDic[instAthData.id] = instAthData
          end
        end
        local suitCfg = (ConfigData.ath_suit)[suitId]
        if suitCfg == nil then
          error("Can\'t find suitCfg, id = " .. tostring(suitId))
          return 
        end
        local suitDetailCfg = nil
        local suitMaxCount = 0
        if suitAthCount > 0 then
          suitDetailCfg = suitCfg[1]
        end
        for k2,v2 in ipairs(suitCfg) do
          if v2.num <= suitAthCount then
            suitDetailCfg = v2
            for k2,attrId in ipairs(suitDetailCfg.attrIdList) do
              local attrValue = (suitDetailCfg.attrValueList)[k2]
              allAttrDic[attrId] = attrValue + allAttrDic[attrId]
              allAttrDicNoEfcc[attrId] = attrValue + allAttrDicNoEfcc[attrId]
            end
          end
          do
            do
              suitMaxCount = (math.max)(v2.num)
              -- DECOMPILER ERROR at PC194: LeaveBlock: unexpected jumping out DO_STMT

            end
          end
        end
        if suitDetailCfg ~= nil then
          suitDic[suitId] = {curCount = suitAthCount, maxCount = suitMaxCount, cfg = suitDetailCfg, suitAthDic = suitAthDic}
        end
      end
    end
  end
  return allAttrDic, slotAttrTab, suitDic, allAttrDicNoEfcc, slotAttrTabNoEfcc
end

AllAthData.GenAthAffixValue = function(self, affixId, quality, level)
  -- function num : 0_28 , upvalues : _ENV
  local affixCfg = (ConfigData.ath_affix_pool)[affixId]
  if affixCfg == nil then
    error("Cant get ath_affix_pool, id = " .. tostring(affixId))
    return 
  end
  local index = (affixCfg.qualityIndexDic)[quality]
  local baseValue = (affixCfg.attribute_num)[index]
  if baseValue == nil then
    error((string.format)("Cant get ath_affix_pool.quality, id:%s, quality:%s", affixId, quality))
    return 
  end
  local affixLvCfg = (ConfigData.ath_affix_lv)[level]
  if affixLvCfg == nil then
    error("Cant get ath_affix_lv, level = " .. tostring(level))
    return 
  end
  local value = affixLvCfg.promote * baseValue // 1000
  return value
end

return AllAthData

