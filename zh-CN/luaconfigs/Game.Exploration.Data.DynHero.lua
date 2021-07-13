-- params : ...
-- function num : 0 , upvalues : _ENV
local DynBattleRole = require("Game.Exploration.Data.DynBattleRole")
local DynBattleSkill = require("Game.Exploration.Data.DynBattleSkill")
local DynHero = class("DynHero", DynBattleRole)
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
DynHero.ctor = function(self, heroData, uid, rolType)
  -- function num : 0_0 , upvalues : _ENV, ExplorationEnum
  self.heroData = heroData
  self.heroCfg = heroData.heroCfg
  self.dataId = (self.heroCfg).id
  if not rolType then
    self.rolType = proto_object_EplBattleRoleType.BattleRoleNormal
    if not uid then
      self.uid = self.dataId
      self.resCfg = (ConfigData.resource_model)[(self.heroCfg).src_id]
      if self.resCfg == nil then
        error("resource model cfg is null,id:" .. tostring((self.heroCfg).src_id))
        return 
      end
      self.totalDamage = 0
      self.belong = eBattleRoleBelong.player
      self.onBench = false
      self.attackRange = (self.heroCfg).range
      self.moveSpeed = (self.heroCfg).move_spd
      self.intensity = (self.heroCfg).intensity
      self.hpPer = ExplorationEnum.eHeroHpPercent
      self.baseAttr = {}
      self.ratioAttr = {}
      self.extraAttr = {}
      self.isContainAction = true
      self.death_frames = (self.resCfg).death_frames
      self.priority = 1
    end
  end
end

DynHero.UpdateBaseHeroData = function(self, attrDic, baseSkillDic, athSkillGroup)
  -- function num : 0_1 , upvalues : _ENV, DynBattleSkill, ExplorationEnum
  if self.heroData == nil then
    return 
  end
  self.originAttr = {}
  for i = 2, max_property_count + 1 do
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R8 in 'UnsetPending'

    (self.originAttr)[i - 1] = attrDic[i]
  end
  self.originSkillList = {}
  for skillId,skillLevel in pairs(baseSkillDic) do
    local heroSkill = ((self.heroData).skillDic)[skillId]
    if heroSkill == nil then
      warn((string.format)("Cant get client heroSkill, skill id = %s, heroId = %s", skillId, (self.heroData).dataId))
    else
      if skillLevel ~= heroSkill.level then
        warn((string.format)("Client heroSkill level is different, skill id = %s, heroId = %s, clientLevel = %s, serverLevel = %s", skillId, (self.heroData).dataId, heroSkill.level, skillLevel))
      end
      local battleSkill = (DynBattleSkill.New)(heroSkill:GetLogicSkillId(), skillLevel, (ExplorationEnum.eBattleSkillType).Original, heroSkill:IsSkillUnlockAdvance())
      ;
      (table.insert)(self.originSkillList, battleSkill)
    end
  end
  if athSkillGroup ~= nil then
    for athSkillId,_ in pairs(athSkillGroup) do
      local skillLevel = 1
      local skillData = (DynBattleSkill.New)(athSkillId, skillLevel, (ExplorationEnum.eBattleSkillType).AthSuit)
      self:AddItemSkill(skillData)
    end
  end
end

DynHero.GetClientOriginAttr = function(self, attrId)
  -- function num : 0_2 , upvalues : _ENV
  if self.heroData == nil then
    return 0
  end
  if (ConfigData.attribute)[attrId] == nil or (ConfigData.attribute)[attrId + 100] == nil or (ConfigData.attribute)[attrId + 200] == nil then
    return 0
  end
  return (self.heroData):GetAttr(attrId)
end

DynHero.GetName = function(self)
  -- function num : 0_3 , upvalues : _ENV
  return (LanguageUtil.GetLocaleText)((self.heroCfg).name)
end

DynHero.GetCareer = function(self)
  -- function num : 0_4
  return (self.heroCfg).career
end

DynHero.GetCamp = function(self)
  -- function num : 0_5
  return (self.heroCfg).camp
end

DynHero.GetResPicName = function(self)
  -- function num : 0_6
  return (self.heroData):GetResPicName()
end

DynHero.GetResModelName = function(self, isDefault)
  -- function num : 0_7
  return (self.heroData):GetResModelName(isDefault)
end

DynHero.GetExtendResName = function(self)
  -- function num : 0_8
  return (self.heroData):GetExtendResName()
end

DynHero.GetResSrcId = function(self)
  -- function num : 0_9
  return (self.heroCfg).src_id
end

DynHero.GetLevel = function(self)
  -- function num : 0_10
  return (self.heroData).level
end

DynHero.GetCurExp = function(self)
  -- function num : 0_11
  return (self.heroData).curExp
end

DynHero.GetTotalExp = function(self)
  -- function num : 0_12
  return (self.heroData):GetLevelTotalExp()
end

DynHero.GetStar = function(self)
  -- function num : 0_13
  return (self.heroData).star
end

DynHero.UpdateTotalDamage = function(self, totalDamage)
  -- function num : 0_14
  self.totalDamage = totalDamage
end

DynHero.GetID = function(self)
  -- function num : 0_15
  return self.dataId
end

DynHero.IsBench = function(self)
  -- function num : 0_16
  return self.onBench
end

DynHero.IsSupport = function(self)
  -- function num : 0_17 , upvalues : _ENV
  do return self.rolType == proto_object_EplBattleRoleType.BattleRoleAssist end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DynHero.SetDynHeroFmtIdx = function(self, fmtInx)
  -- function num : 0_18 , upvalues : _ENV
  self.fmtInx = fmtInx
  self.onBench = (ConfigData.game_config).max_stage_hero < fmtInx
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DynHero.GetDynHeroFmtIdx = function(self)
  -- function num : 0_19
  return self.fmtInx
end

return DynHero

