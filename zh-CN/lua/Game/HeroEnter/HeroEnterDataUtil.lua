local HeroEnterDataUtil = class("HeroEnterDataUtil")
local valueFuncTable = {[eLogicType.ResourceLimit] = function(heroScoreRate, levelBuffCfg, index, isRemove, buildingId)
  -- function num : 0_0 , upvalues : _ENV
  local para1 = (levelBuffCfg.buff_para1)[index]
  local para2 = (math.floor)((levelBuffCfg.buff_para2)[index] * heroScoreRate)
  local para3 = (levelBuffCfg.buff_para3)[index]
  if isRemove then
    (PlayerDataCenter.playerBonus):UninstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter, buildingId, eLogicType.ResourceLimit)
  else
    ;
    (PlayerDataCenter.playerBonus):InstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter, buildingId, eLogicType.ResourceLimit, para1, para2, para3)
  end
end
, [eLogicType.ResourceOutput] = function(heroScoreRate, levelBuffCfg, index, isRemove, buildingId)
  -- function num : 0_1 , upvalues : _ENV
  local para1 = (levelBuffCfg.buff_para1)[index]
  local speed = (levelBuffCfg.buff_para2)[index] * 36 // 1000
  local para2 = (math.floor)(speed * heroScoreRate)
  local para3 = (levelBuffCfg.buff_para3)[index]
  if isRemove then
    (PlayerDataCenter.playerBonus):UninstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter, buildingId, eLogicType.ResourceOutput)
  else
    ;
    (PlayerDataCenter.playerBonus):InstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter, buildingId, eLogicType.ResourceOutput, para1, para2, para3)
  end
end
, [eLogicType.CampBuff] = function(heroScoreRate, levelBuffCfg, index, isRemove, buildingId)
  -- function num : 0_2 , upvalues : _ENV
  local para1 = (levelBuffCfg.buff_para1)[index]
  local para2 = (levelBuffCfg.buff_para2)[index]
  local attrValue = (levelBuffCfg.buff_para3)[index]
  local para3 = (math.floor)(attrValue * heroScoreRate)
  if isRemove then
    (PlayerDataCenter.playerBonus):UninstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter, buildingId, eLogicType.CampBuff)
  else
    ;
    (PlayerDataCenter.playerBonus):InstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter, buildingId, eLogicType.CampBuff, para1, para2, para3)
  end
end
, [eLogicType.CareerBuff] = function(heroScoreRate, levelBuffCfg, index, isRemove, buildingId)
  -- function num : 0_3 , upvalues : _ENV
  local para1 = (levelBuffCfg.buff_para1)[index]
  local para2 = (levelBuffCfg.buff_para2)[index]
  local attrValue = (levelBuffCfg.buff_para3)[index]
  local para3 = (math.floor)(attrValue * heroScoreRate)
  if isRemove then
    (PlayerDataCenter.playerBonus):UninstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter, buildingId, eLogicType.CareerBuff)
  else
    ;
    (PlayerDataCenter.playerBonus):InstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter, buildingId, eLogicType.CareerBuff, para1, para2, para3)
  end
end
, [eLogicType.FactoryPipelie] = function(heroScoreRate, levelBuffCfg, index, isRemove, buildingId)
  -- function num : 0_4 , upvalues : _ENV
  local para1 = (math.floor)((levelBuffCfg.buff_para1)[index] * heroScoreRate)
  local para2 = (levelBuffCfg.buff_para2)[index]
  local para3 = (levelBuffCfg.buff_para3)[index]
  if isRemove then
    (PlayerDataCenter.playerBonus):UninstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter, buildingId, eLogicType.FactoryPipelie)
  else
    ;
    (PlayerDataCenter.playerBonus):InstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter, buildingId, eLogicType.FactoryPipelie, para1, para2, para3)
  end
end
, [eLogicType.GlobalExpCeiling] = function(heroScoreRate, levelBuffCfg, index, isRemove, buildingId)
  -- function num : 0_5 , upvalues : _ENV
  local expLimt = (levelBuffCfg.buff_para1)[index]
  local para1 = (math.floor)(expLimt * heroScoreRate)
  local para2 = (levelBuffCfg.buff_para2)[index]
  local para3 = (levelBuffCfg.buff_para3)[index]
  if isRemove then
    (PlayerDataCenter.playerBonus):UninstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter, buildingId, eLogicType.GlobalExpCeiling)
  else
    ;
    (PlayerDataCenter.playerBonus):InstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter, buildingId, eLogicType.GlobalExpCeiling, para1, para2, para3)
  end
end
, [eLogicType.StaminaCeiling] = function(heroScoreRate, levelBuffCfg, index, isRemove, buildingId)
  -- function num : 0_6 , upvalues : _ENV
  local staminaLimt = (levelBuffCfg.buff_para1)[index]
  local para1 = (math.floor)(staminaLimt * heroScoreRate)
  local para2 = (levelBuffCfg.buff_para2)[index]
  local para3 = (levelBuffCfg.buff_para3)[index]
  if isRemove then
    (PlayerDataCenter.playerBonus):UninstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter, buildingId, eLogicType.StaminaCeiling)
  else
    ;
    (PlayerDataCenter.playerBonus):InstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter, buildingId, eLogicType.StaminaCeiling, para1, para2, para3)
  end
end
, [eLogicType.StaminaOutput] = function(heroScoreRate, levelBuffCfg, index, isRemove, buildingId)
  -- function num : 0_7 , upvalues : _ENV
  local speed = (levelBuffCfg.buff_para1)[index] * 0.036
  local para1 = (math.floor)(speed * heroScoreRate)
  local para2 = (levelBuffCfg.buff_para2)[index]
  local para3 = (levelBuffCfg.buff_para3)[index]
  if isRemove then
    (PlayerDataCenter.playerBonus):UninstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter, buildingId, eLogicType.StaminaOutput)
  else
    ;
    (PlayerDataCenter.playerBonus):InstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter, buildingId, eLogicType.StaminaOutput, para1, para2, para3)
  end
end
, [eLogicType.ResOutputEfficiency] = function(heroScoreRate, levelBuffCfg, index, isRemove, buildingId)
  -- function num : 0_8 , upvalues : _ENV
  local para1 = (levelBuffCfg.buff_para1)[index]
  local para2 = (math.floor)((levelBuffCfg.buff_para2)[index] * heroScoreRate)
  local para3 = (levelBuffCfg.buff_para3)[index]
  if isRemove then
    (PlayerDataCenter.playerBonus):UninstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter, buildingId, eLogicType.ResOutputEfficiency)
  else
    ;
    (PlayerDataCenter.playerBonus):InstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter, buildingId, eLogicType.ResOutputEfficiency, para1, para2, para3)
  end
end
, [eLogicType.BuildQueue] = function(heroScoreRate, levelBuffCfg, index, isRemove, buildingId)
  -- function num : 0_9 , upvalues : _ENV
  local para1 = (levelBuffCfg.buff_para1)[index]
  local para2 = (math.floor)((levelBuffCfg.buff_para2)[index] * heroScoreRate)
  local para3 = (levelBuffCfg.buff_para3)[index]
  if isRemove then
    (PlayerDataCenter.playerBonus):UninstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter, buildingId, eLogicType.BuildQueue)
  else
    ;
    (PlayerDataCenter.playerBonus):InstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter, buildingId, eLogicType.BuildQueue, para1, para2, para3)
  end
end
, [eLogicType.BuildSpeed] = function(heroScoreRate, levelBuffCfg, index, isRemove, buildingId)
  -- function num : 0_10 , upvalues : _ENV
  local para1 = (math.floor)((levelBuffCfg.buff_para1)[index] * heroScoreRate)
  local para2 = (levelBuffCfg.buff_para2)[index]
  local para3 = (levelBuffCfg.buff_para3)[index]
  if isRemove then
    (PlayerDataCenter.playerBonus):UninstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter, buildingId, eLogicType.BuildSpeed)
  else
    ;
    (PlayerDataCenter.playerBonus):InstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter, buildingId, eLogicType.BuildSpeed, para1, para2, para3)
  end
end
, [eLogicType.GlobalExpRatio] = function(heroScoreRate, levelBuffCfg, index, isRemove, buildingId)
  -- function num : 0_11 , upvalues : _ENV
  local para1 = (math.floor)((levelBuffCfg.buff_para1)[index] * heroScoreRate)
  local para2 = (levelBuffCfg.buff_para2)[index]
  local para3 = (levelBuffCfg.buff_para3)[index]
  if isRemove then
    (PlayerDataCenter.playerBonus):UninstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter, buildingId, eLogicType.GlobalExpRatio)
  else
    ;
    (PlayerDataCenter.playerBonus):InstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter, buildingId, eLogicType.GlobalExpRatio, para1, para2, para3)
  end
end
, [eLogicType.AllHeroBuff] = function(heroScoreRate, levelBuffCfg, index, isRemove, buildingId)
  -- function num : 0_12 , upvalues : _ENV
  local para1 = (levelBuffCfg.buff_para1)[index]
  local para2 = (math.floor)((levelBuffCfg.buff_para2)[index] * heroScoreRate)
  local para3 = (levelBuffCfg.buff_para3)[index]
  if isRemove then
    (PlayerDataCenter.playerBonus):UninstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter, buildingId, eLogicType.AllHeroBuff)
  else
    ;
    (PlayerDataCenter.playerBonus):InstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter, buildingId, eLogicType.AllHeroBuff, para1, para2, para3)
  end
end
}
HeroEnterDataUtil.ctor = function(self)
  -- function num : 0_13
end

HeroEnterDataUtil.InitMsgListern = function(self)
  -- function num : 0_14 , upvalues : _ENV
  self.__OnBuildingLevelChange = BindCallback(self, self.OnBuildingLevelChange)
  MsgCenter:AddListener(eMsgEventId.BuildingUpgradeComplete, self.__OnBuildingLevelChange)
end

HeroEnterDataUtil.InitBuff = function(self, allEnterData)
  -- function num : 0_15 , upvalues : _ENV
  for buildingId,data in pairs(allEnterData) do
    for heroId,_ in pairs(data.data) do
      self:AddBuff(heroId, buildingId)
    end
  end
  ;
  (PlayerDataCenter.playerBonus):CheckPlayerBonusBroadcast()
end

HeroEnterDataUtil.AddBuff = function(self, heroId, buildingId, manualRate)
  -- function num : 0_16 , upvalues : _ENV, valueFuncTable
  local level = (((PlayerDataCenter.AllBuildingData).oasisBuilt)[buildingId]).level
  local levelBuffCfg = ((ConfigData.buildingLevel)[buildingId])[level]
  local heroData = (PlayerDataCenter.heroDic)[heroId]
  for i,logic in ipairs(levelBuffCfg.buff_logic) do
    if manualRate ~= nil then
      (valueFuncTable[logic])(manualRate, levelBuffCfg, i, nil, buildingId)
    else
      ;
      (valueFuncTable[logic])(self:CalRate(heroData), levelBuffCfg, i, nil, buildingId)
    end
  end
  local skillDic = heroData.skillDic
  for key,skilldata in pairs(skillDic) do
    if skilldata.type == eHeroSkillType.LifeSkill then
      self:AddSkillBuff(skilldata, heroId)
    end
  end
end

HeroEnterDataUtil.RemoveBuff = function(self, heroId, levelBuffCfg, manualRate, buildingId)
  -- function num : 0_17 , upvalues : _ENV, valueFuncTable
  local levelBuffCfg = levelBuffCfg
  if levelBuffCfg == nil then
    levelBuffCfg = self:GetHeroEnteredBuildingCfgById(heroId)
  end
  local heroData = (PlayerDataCenter.heroDic)[heroId]
  for i,logic in ipairs(levelBuffCfg.buff_logic) do
    if manualRate ~= nil then
      (valueFuncTable[logic])(manualRate, levelBuffCfg, i, true, buildingId)
    else
      ;
      (valueFuncTable[logic])(self:CalRate(heroData), levelBuffCfg, i, true, buildingId)
    end
  end
  local skillDic = heroData.skillDic
  for key,skilldata in pairs(skillDic) do
    if skilldata.type == eHeroSkillType.LifeSkill then
      self:RemoveSkillBuff(skilldata, heroId)
    end
  end
end

HeroEnterDataUtil.AddSkillBuff = function(self, skilldata, heroId)
  -- function num : 0_18 , upvalues : _ENV
  local skillLevel = skilldata.level
  local cfg = (skilldata.lifeSkillCfg)[skillLevel]
  for index,logic in ipairs(cfg.logic) do
    local para1 = (cfg.para1)[index]
    local para2 = (cfg.para2)[index]
    local para3 = (cfg.para3)[index]
    ;
    (PlayerDataCenter.playerBonus):InstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_LifeSkill, heroId, logic, para1, para2, para3)
  end
end

HeroEnterDataUtil.RemoveSkillBuff = function(self, skilldata, oldLevel, heroId)
  -- function num : 0_19 , upvalues : _ENV
  if not oldLevel then
    local skillLevel = skilldata.level
  end
  local cfg = (skilldata.lifeSkillCfg)[skillLevel]
  for index,logic in ipairs(cfg.logic) do
    local para1 = (cfg.para1)[index]
    local para2 = (cfg.para2)[index]
    local para3 = (cfg.para3)[index]
    ;
    (PlayerDataCenter.playerBonus):UninstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_LifeSkill, heroId, logic)
  end
end

HeroEnterDataUtil.GetHeroEnteredBuildingCfgById = function(self, heroId)
  -- function num : 0_20 , upvalues : _ENV
  local allEnterData = PlayerDataCenter.allEnterData
  for buildingId,data in pairs(allEnterData) do
    for allDtatHeroId,_ in pairs(data.data) do
      if allDtatHeroId == heroId then
        local level = (((PlayerDataCenter.AllBuildingData).oasisBuilt)[buildingId]).level
        local levelBuffCfg = ((ConfigData.buildingLevel)[buildingId])[level]
        return levelBuffCfg
      end
    end
  end
  return nil
end

HeroEnterDataUtil.CalRate = function(self, heroData, manualRank, manualLevel)
  -- function num : 0_21 , upvalues : _ENV
  if heroData == nil then
    return 0
  end
  if not manualRank then
    local rank = heroData.rank
  end
  if not manualLevel then
    local level = heroData.level
  end
  local score = ((ConfigData.star_score)[rank]).score + level
  local scoreRate = score / (ConfigData.game_config).heroEnterScoreDenominator
  return scoreRate
end

HeroEnterDataUtil.CalRateById = function(self, heroId, manualRank, manualLevel)
  -- function num : 0_22 , upvalues : _ENV
  local heroData = (PlayerDataCenter.heroDic)[heroId]
  if heroData == nil then
    return 0
  end
  return self:CalRate(heroData, manualRank, manualLevel)
end

HeroEnterDataUtil.OnHeroRankChange = function(self, oldRanK, newRank, heroId)
  -- function num : 0_23 , upvalues : _ENV
  local buildingId = nil
  for dataBuildingId,data in pairs(PlayerDataCenter.allEnterData) do
    for dataHeroId,_ in pairs(data.data) do
      if dataHeroId == heroId then
        buildingId = dataBuildingId
      end
    end
  end
  if buildingId == nil then
    return 
  end
  local heroData = (PlayerDataCenter.heroDic)[heroId]
  local oldRate = self:CalRate(heroData, oldRanK, nil)
  local newRate = self:CalRate(heroData, newRank, nil)
  self:AddBuff(heroId, buildingId, newRate)
  ;
  (PlayerDataCenter.playerBonus):CheckPlayerBonusBroadcast()
end

HeroEnterDataUtil.OnHeroLevelChange = function(self, oldLevel, newLevel, heroId)
  -- function num : 0_24 , upvalues : _ENV
  local buildingId = nil
  for dataBuildingId,data in pairs(PlayerDataCenter.allEnterData) do
    for dataHeroId,_ in pairs(data.data) do
      if dataHeroId == heroId then
        buildingId = dataBuildingId
      end
    end
  end
  if buildingId == nil then
    return 
  end
  local heroData = (PlayerDataCenter.heroDic)[heroId]
  local oldRate = self:CalRate(heroData, nil, oldLevel)
  local newRate = self:CalRate(heroData, nil, newLevel)
  self:AddBuff(heroId, buildingId, newRate)
  ;
  (PlayerDataCenter.playerBonus):CheckPlayerBonusBroadcast()
end

HeroEnterDataUtil.OnBuildingLevelChange = function(self, buildingId)
  -- function num : 0_25 , upvalues : _ENV
  for dataBuildingId,data in pairs(PlayerDataCenter.allEnterData) do
    if dataBuildingId == buildingId then
      for heroId,_ in pairs(data.data) do
        local level = (((PlayerDataCenter.AllBuildingData).oasisBuilt)[buildingId]).level
        local oldLevelCfg = ((ConfigData.buildingLevel)[buildingId])[level - 1]
        self:AddBuff(heroId, buildingId)
      end
    end
  end
  ;
  (PlayerDataCenter.playerBonus):CheckPlayerBonusBroadcast()
end

HeroEnterDataUtil.OnLifeSkillLevelUp = function(self, newskillData)
  -- function num : 0_26 , upvalues : _ENV
  for dataBuildingId,data in pairs(PlayerDataCenter.allEnterData) do
    for heroId,_ in pairs(data.data) do
      if heroId == (newskillData.heroData).dataId then
        self:AddSkillBuff(newskillData, heroId)
      end
    end
  end
  ;
  (PlayerDataCenter.playerBonus):CheckPlayerBonusBroadcast()
end

return HeroEnterDataUtil

