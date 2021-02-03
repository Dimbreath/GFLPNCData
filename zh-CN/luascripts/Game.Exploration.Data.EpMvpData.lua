-- params : ...
-- function num : 0 , upvalues : _ENV
local EpMvpData = class("EpMvpData")
local cs_BattleStatistics = (CS.BattleStatistics).Instance
EpMvpData.mvpParaType = {damage = 1, injury = 2, selfHeal = 3, otherHeal = 4}
EpMvpData.mvpType = {heal = 0, damagem = 1, injury = 2}
EpMvpData.ctor = function(self)
  -- function num : 0_0
  self.heroStatisicsDic = {}
  self.heroBossDic = {}
  self.totalDamage = 0
  self.totalInjury = 0
  self.totalHeal = 0
  self.cachedMvpId = nil
  self.dirtyData = false
  self.defaultMVPHeroId = nil
end

EpMvpData.AddHeroData = function(self, heroId, damage, ingjury, healSelf, healOther)
  -- function num : 0_1
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
  -- function num : 0_2
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (self.heroBossDic)[heroId] = {damage = damage or 0, ingjury = ingjury or 0, healSelf = healSelf or 0, healOther = healOther or 0}
end

EpMvpData.AddBattleStatisticsData = function(self, isBossFight)
  -- function num : 0_3 , upvalues : _ENV, cs_BattleStatistics
  local temp = {}
  local getTempSingleFunc = function(id)
    -- function num : 0_3_0 , upvalues : temp
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
  -- function num : 0_4 , upvalues : _ENV
  for heroId,value in pairs(data) do
    do
      if value.record ~= nil and (value.record).record ~= nil then
        local record = (value.record).record
        self:AddHeroData(heroId, record[3], record[2], record[4], record[5])
      end
      do
        if value.record ~= nil and (value.record).bossRecord ~= nil then
          local record = (value.record).bossRecord
          self:CoverBossFightData(heroId, record[3], record[2], record[4], record[5])
        end
        -- DECOMPILER ERROR at PC36: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
end

EpMvpData.CalculateMvp = function(self, datadDic)
  -- function num : 0_5 , upvalues : _ENV, EpMvpData
  local mvpList = {}
  for heroId,data in pairs(datadDic) do
    local MvpNum = nil
    local heroCfg = (ConfigData.hero_data)[heroId]
    if heroCfg == nil then
      error("can\'t read heroData config heroId = " .. heroId)
    else
      MvpNum = data.damage * ((heroCfg.mvp_para)[(EpMvpData.mvpParaType).damage] or 1) + data.ingjury * ((heroCfg.mvp_para)[(EpMvpData.mvpParaType).injury] or 1) + data.healSelf * ((heroCfg.mvp_para)[(EpMvpData.mvpParaType).selfHeal] or 1) + data.healOther * ((heroCfg.mvp_para)[(EpMvpData.mvpParaType).otherHeal] or 1)
      ;
      (table.insert)(mvpList, {heroId = heroId, MvpNum = MvpNum})
    end
  end
  ;
  (table.sort)(mvpList, function(a, b)
    -- function num : 0_5_0
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
  -- function num : 0_6
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
  -- function num : 0_7 , upvalues : EpMvpData
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
  -- function num : 0_8 , upvalues : _ENV
  local recordArry = {}
  local heroStatisics = (self.heroStatisicsDic)[heroId]
  if heroStatisics ~= nil then
    (table.insert)(recordArry, 0)
    ;
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
    ;
    (table.insert)(recordArry, 0)
  end
  local bossRecordArray = nil
  if containsBossFightData then
    bossRecordArray = {}
    local heroBossFightData = (self.heroBossDic)[heroId]
    if heroBossFightData ~= nil then
      (table.insert)(bossRecordArray, 0)
      ;
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
      ;
      (table.insert)(bossRecordArray, 0)
    end
  end
  do
    return {record = recordArry, bossRecord = bossRecordArray}
  end
end

EpMvpData.GetBossFightMvp = function(self)
  -- function num : 0_9
  local mvpData = self:CalculateMvp(self.heroBossDic)
  if mvpData ~= nil then
    return mvpData.heroId
  end
  return self:GetEpMvpID()
end

return EpMvpData

