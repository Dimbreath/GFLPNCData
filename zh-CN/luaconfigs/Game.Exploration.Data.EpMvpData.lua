-- params : ...
-- function num : 0 , upvalues : _ENV
local EpMvpData = class("EpMvpData")
local cs_BattleStatistics = (CS.BattleStatistics).Instance
EpMvpData.mvpParaType = {injury = 1, damage = 2, selfHeal = 3, otherHeal = 4}
EpMvpData.mvpType = {heal = 0, damagem = 1, injury = 2}
EpMvpData.ctor = function(self, heros)
  -- function num : 0_0 , upvalues : _ENV
  self.heroStatisicsDic = {}
  self.heroBossDic = {}
  self.totalDamage = 0
  self.totalInjury = 0
  self.totalHeal = 0
  self.cachedMvpId = nil
  self.dirtyData = false
  self.defaultMVPHeroId = nil
  self.heroIdMapping = {}
  for k,v in pairs(heros) do
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R7 in 'UnsetPending'

    (self.heroIdMapping)[v.uid] = v.dataId
  end
end

EpMvpData.UpdataEpMvpDataHeroIdMapping = function(self, heros, removeHeroList)
  -- function num : 0_1 , upvalues : _ENV
  self.heroIdMapping = {}
  for k,v in pairs(heros) do
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R8 in 'UnsetPending'

    (self.heroIdMapping)[v.uid] = v.dataId
  end
  for k,dynHero in ipairs(removeHeroList) do
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R8 in 'UnsetPending'

    (self.heroStatisicsDic)[dynHero.dataId] = nil
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (self.heroBossDic)[dynHero.dataId] = nil
  end
  self.defaultMVPHeroId = (heros[1]).dataId
end

EpMvpData.AddHeroData = function(self, heroId, damage, ingjury, healSelf, healOther)
  -- function num : 0_2
  self.totalDamage = self.totalDamage + damage
  self.totalInjury = self.totalInjury + ingjury
  self.totalHeal = self.totalHeal + healSelf + healOther
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R6 in 'UnsetPending'

  if (self.heroStatisicsDic)[heroId] == nil then
    (self.heroStatisicsDic)[heroId] = {damage = 0, ingjury = 0, healSelf = 0, healOther = 0}
  end
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.heroStatisicsDic)[heroId]).damage = ((self.heroStatisicsDic)[heroId]).damage + damage
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.heroStatisicsDic)[heroId]).ingjury = ((self.heroStatisicsDic)[heroId]).ingjury + ingjury
  -- DECOMPILER ERROR at PC41: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.heroStatisicsDic)[heroId]).healSelf = ((self.heroStatisicsDic)[heroId]).healSelf + healSelf
  -- DECOMPILER ERROR at PC48: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.heroStatisicsDic)[heroId]).healOther = ((self.heroStatisicsDic)[heroId]).healOther + healOther
  self.dirtyData = true
end

EpMvpData.CoverBossFightData = function(self, heroId, damage, ingjury, healSelf, healOther)
  -- function num : 0_3
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (self.heroBossDic)[heroId] = {damage = damage or 0, ingjury = ingjury or 0, healSelf = healSelf or 0, healOther = healOther or 0}
end

EpMvpData.AddBattleStatisticsData = function(self, isBossFight)
  -- function num : 0_4 , upvalues : _ENV, cs_BattleStatistics
  local temp = {}
  local getTempSingleFunc = function(id)
    -- function num : 0_4_0 , upvalues : temp
    local res = temp[id]
    if res == nil then
      res = {damage = 0, ingjury = 0, healSelf = 0, healOther = 0}
      temp[id] = res
    end
    return res
  end

  for key,value in pairs(cs_BattleStatistics.playerDamage) do
    (getTempSingleFunc(key.roleDataId)).damage = value.damage
  end
  for key,value in pairs(cs_BattleStatistics.playerTakeDamage) do
    (getTempSingleFunc(key.roleDataId)).ingjury = value.damage
  end
  for key,value in pairs(cs_BattleStatistics.playerHeal) do
    local tempSingle = getTempSingleFunc(key.roleDataId)
    tempSingle.healSelf = value.selfHeal
    tempSingle.healOther = value.otherHeal
  end
  for key,value in pairs(temp) do
    self:AddHeroData(key, value.damage, value.ingjury, value.healSelf, value.healOther)
    if isBossFight then
      self:CoverBossFightData(key, value.damage, value.ingjury, value.healSelf, value.healOther)
    end
  end
end

EpMvpData.AddServerSaveData = function(self, data)
  -- function num : 0_5 , upvalues : _ENV
  for uid,value in pairs(data) do
    do
      if value.record ~= nil and value.record ~= nil then
        local record = value.record
        self:AddHeroData((self.heroIdMapping)[uid], record[2], record[1], record[3], record[4])
      end
      do
        if value.record ~= nil and value.bossRecord ~= nil then
          local record = value.bossRecord
          self:CoverBossFightData((self.heroIdMapping)[uid], record[2], record[1], record[3], record[4])
        end
        -- DECOMPILER ERROR at PC34: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
end

EpMvpData.CalculateMvp = function(self, datadDic)
  -- function num : 0_6 , upvalues : _ENV, EpMvpData
  local mvpList = {}
  for heroId,data in pairs(datadDic) do
    local MvpNum = nil
    local dataId = heroId
    local heroCfg = (ConfigData.hero_data)[dataId]
    if heroCfg == nil then
      error("can\'t read heroData config heroId = " .. dataId)
    else
      MvpNum = data.damage * ((heroCfg.mvp_para)[(EpMvpData.mvpParaType).damage] or 1) + data.ingjury * ((heroCfg.mvp_para)[(EpMvpData.mvpParaType).injury] or 1) + data.healSelf * ((heroCfg.mvp_para)[(EpMvpData.mvpParaType).selfHeal] or 1) + data.healOther * ((heroCfg.mvp_para)[(EpMvpData.mvpParaType).otherHeal] or 1)
      ;
      (table.insert)(mvpList, {heroId = dataId, MvpNum = MvpNum})
    end
  end
  ;
  (table.sort)(mvpList, function(a, b)
    -- function num : 0_6_0
    if b.MvpNum >= a.MvpNum then
      do return a.MvpNum == b.MvpNum end
      do return a.heroId < b.heroId end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
)
  return mvpList[1]
end

EpMvpData.GetEpMvpID = function(self)
  -- function num : 0_7
  if self.dirtyData then
    self.dirtyData = false
  else
    if self.cachedMvpId == nil or not self.cachedMvpId then
      do return self.defaultMVPHeroId end
      local mvpData = self:CalculateMvp(self.heroStatisicsDic)
      if mvpData ~= nil then
        self.cachedMvpId = mvpData.heroId
      end
      if self.cachedMvpId == nil or not self.cachedMvpId then
        return self.defaultMVPHeroId
      end
    end
  end
end

EpMvpData.GetEpMvpData = function(self)
  -- function num : 0_8 , upvalues : EpMvpData
  local MvpType = (EpMvpData.mvpType).damagem
  local diggestRate = 0
  local heroId = self:GetEpMvpID()
  if heroId == nil then
    heroId = self.defaultMVPHeroId
  end
  local heroData = (self.heroStatisicsDic)[heroId]
  local healRate = nil
  if self.totalHeal == 0 then
    healRate = 0
  else
    healRate = (heroData.healSelf + heroData.healOther) / self.totalHeal
  end
  if diggestRate <= healRate then
    MvpType = (EpMvpData.mvpType).heal
    diggestRate = healRate
  end
  local injuryRate = nil
  if self.totalInjury == 0 then
    injuryRate = 0
  else
    injuryRate = heroData.ingjury / self.totalInjury
  end
  if diggestRate <= injuryRate then
    MvpType = (EpMvpData.mvpType).injury
    diggestRate = injuryRate
  end
  local damageRate = nil
  if self.totalDamage == 0 then
    damageRate = 0
  else
    damageRate = heroData.damage / self.totalDamage
  end
  if diggestRate <= damageRate then
    MvpType = (EpMvpData.mvpType).damagem
    diggestRate = damageRate
  end
  return heroId, MvpType, diggestRate
end

EpMvpData.GetSaveData = function(self, heroId, containsBossFightData)
  -- function num : 0_9 , upvalues : _ENV
  local recordArry = {}
  local heroStatisics = (self.heroStatisicsDic)[heroId]
  if heroStatisics ~= nil then
    (table.insert)(recordArry, heroStatisics.ingjury)
    ;
    (table.insert)(recordArry, heroStatisics.damage)
    ;
    (table.insert)(recordArry, heroStatisics.healSelf)
    ;
    (table.insert)(recordArry, heroStatisics.healOther)
  else
    ;
    (table.insert)(recordArry, 0)
    ;
    (table.insert)(recordArry, 0)
    ;
    (table.insert)(recordArry, 0)
    ;
    (table.insert)(recordArry, 0)
  end
  local bossRecordArray = nil
  if containsBossFightData then
    bossRecordArray = {}
    local heroBossFightData = (self.heroBossDic)[heroId]
    if heroBossFightData ~= nil then
      (table.insert)(bossRecordArray, heroBossFightData.ingjury)
      ;
      (table.insert)(bossRecordArray, heroBossFightData.damage)
      ;
      (table.insert)(bossRecordArray, heroBossFightData.healSelf)
      ;
      (table.insert)(bossRecordArray, heroBossFightData.healOther)
    else
      ;
      (table.insert)(bossRecordArray, 0)
      ;
      (table.insert)(bossRecordArray, 0)
      ;
      (table.insert)(bossRecordArray, 0)
      ;
      (table.insert)(bossRecordArray, 0)
    end
  end
  do
    return {record = recordArry, bossRecord = bossRecordArray}
  end
end

EpMvpData.GetBossFightMvp = function(self, isNeedUid)
  -- function num : 0_10
  local mvpId = nil
  local mvpData = self:CalculateMvp(self.heroBossDic)
  if mvpData ~= nil then
    mvpId = mvpData.heroId
  else
    mvpId = self:GetEpMvpID()
  end
  if isNeedUid then
    mvpId = self:GetUidByDataId(mvpId)
  end
  return mvpId
end

EpMvpData.GetUidByDataId = function(self, dataId)
  -- function num : 0_11 , upvalues : _ENV
  for k,v in pairs(self.heroIdMapping) do
    if v == dataId then
      return k
    end
  end
  return nil
end

return EpMvpData

