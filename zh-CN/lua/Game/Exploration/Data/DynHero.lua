local DynBattleRole = require("Game.Exploration.Data.DynBattleRole")
local DynBattleSkill = require("Game.Exploration.Data.DynBattleSkill")
local DynHero = class("DynHero", DynBattleRole)
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
DynHero.ctor = function(self, heroData, uid, rolType)
  -- function num : 0_0
  self:InitDynHeroData(heroData, uid, rolType)
end

DynHero.InitDynHeroData = function(self, heroData, uid, rolType)
  -- function num : 0_1 , upvalues : _ENV, ExplorationEnum
  self.heroData = heroData
  self.heroCfg = heroData.heroCfg
  self.dataId = (self.heroCfg).id
  if not rolType then
    self.rolType = proto_object_EplBattleRoleType.BattleRoleNormal
    self.cat = heroData.cat
    self.rank = heroData.star
    self.containSpecialModelSign = heroData.containSpecialModelSign
    self.isTowerAbandonMove = self.cat == (BattleUtil.battleRoleCat).waitToCasterHero
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
      self:InitTowerHeroData()
      -- DECOMPILER ERROR: 3 unprocessed JMP targets
    end
  end
end

DynHero.InitTowerHeroData = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self.cat == (BattleUtil.battleRoleCat).waitToCasterHero then
    local towerCfg = (ConfigData.tower_hero_data)[self.dataId]
    if towerCfg == nil then
      error("找不到指定id的塔防角色:" .. self.dataId)
      return 
    end
    self.towerCostFormula = towerCfg.coin_cost_formula
    self.towerCdFormula = towerCfg.cd_formula
    self.towerOnSaleFormula = towerCfg.sell_formula
  end
end

DynHero.UpdateBaseHeroData = function(self, attrDic, baseSkillDic, athSkillGroup)
  -- function num : 0_3 , upvalues : _ENV, DynBattleSkill
  if self.heroData == nil then
    return 
  end
  self.originAttr = {}
  for i = 2, eHeroAttr.max_property_count + 1 do
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R8 in 'UnsetPending'

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
      local battleSkill = (DynBattleSkill.New)(heroSkill:GetLogicSkillId(), skillLevel, eBattleSkillLogicType.Original, heroSkill:IsSkillUnlockAdvance())
      ;
      (table.insert)(self.originSkillList, battleSkill)
    end
  end
  if athSkillGroup ~= nil then
    for athSkillId,_ in pairs(athSkillGroup) do
      local skillLevel = 1
      local skillData = (DynBattleSkill.New)(athSkillId, skillLevel, eBattleSkillLogicType.AthSuit)
      self:AddItemSkill(skillData)
    end
  end
end

DynHero.GetClientOriginAttr = function(self, attrId)
  -- function num : 0_4 , upvalues : _ENV
  if self.heroData == nil then
    return 0
  end
  if (ConfigData.attribute)[attrId] == nil or (ConfigData.attribute)[attrId + 100] == nil or (ConfigData.attribute)[attrId + 200] == nil then
    return 0
  end
  return (self.heroData):GetAttr(attrId)
end

DynHero.GetName = function(self)
  -- function num : 0_5 , upvalues : _ENV
  return (LanguageUtil.GetLocaleText)((self.heroCfg).name)
end

DynHero.GetCareer = function(self)
  -- function num : 0_6
  return (self.heroCfg).career
end

DynHero.GetCamp = function(self)
  -- function num : 0_7
  return (self.heroCfg).camp
end

DynHero.GetResPicName = function(self)
  -- function num : 0_8
  return (self.heroData):GetResPicName()
end

DynHero.GetResModelName = function(self, isDefault)
  -- function num : 0_9
  return (self.heroData):GetResModelName(isDefault)
end

DynHero.GetExtendResName = function(self)
  -- function num : 0_10
  return (self.heroData):GetExtendResName()
end

DynHero.GetResSrcId = function(self)
  -- function num : 0_11
  return (self.heroCfg).src_id
end

DynHero.GetLevel = function(self)
  -- function num : 0_12
  return (self.heroData).level
end

DynHero.GetCurExp = function(self)
  -- function num : 0_13
  return (self.heroData).curExp
end

DynHero.GetTotalExp = function(self)
  -- function num : 0_14
  return (self.heroData):GetLevelTotalExp()
end

DynHero.GetStar = function(self)
  -- function num : 0_15
  return (self.heroData).star
end

DynHero.UpdateTotalDamage = function(self, totalDamage)
  -- function num : 0_16
  self.totalDamage = totalDamage
end

DynHero.GetID = function(self)
  -- function num : 0_17
  return self.dataId
end

DynHero.IsBench = function(self)
  -- function num : 0_18
  return self.onBench
end

DynHero.IsSupport = function(self)
  -- function num : 0_19 , upvalues : _ENV
  do return self.rolType == proto_object_EplBattleRoleType.BattleRoleAssist end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DynHero.IsFriendSupport = function(self)
  -- function num : 0_20 , upvalues : _ENV
  do return self.rolType == proto_object_EplBattleRoleType.BattleRoleFriendAssist end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DynHero.SetDynHeroFmtIdx = function(self, fmtInx)
  -- function num : 0_21 , upvalues : _ENV
  self.fmtInx = fmtInx
  self.onBench = (ConfigData.game_config).max_stage_hero < fmtInx
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DynHero.GetDynHeroFmtIdx = function(self)
  -- function num : 0_22
  return self.fmtInx
end

DynHero.GetTowerCastCostFormula = function(self)
  -- function num : 0_23
  return self.towerCostFormula
end

DynHero.GetTowerCastCdFormula = function(self)
  -- function num : 0_24
  return self.towerCdFormula
end

DynHero.GetTowerLoadOffFormula = function(self)
  -- function num : 0_25
  return self.towerOnSaleFormula
end

return DynHero

