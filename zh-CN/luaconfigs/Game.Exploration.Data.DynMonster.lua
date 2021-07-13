-- params : ...
-- function num : 0 , upvalues : _ENV
local DynBattleRole = require("Game.Exploration.Data.DynBattleRole")
local DynBattleSkill = require("Game.Exploration.Data.DynBattleSkill")
local DynMonster = class("DynMonster", DynBattleRole)
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local MonsterSkillSort = function(skill1, skill2)
  -- function num : 0_0
  do return skill1.dataId < skill2.dataId end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DynMonster.ctor = function(self, monsterData)
  -- function num : 0_1 , upvalues : _ENV, DynBattleSkill, ExplorationEnum, MonsterSkillSort
  self.dataId = (monsterData.stc).dataId
  if not (monsterData.stc).uid then
    self.uid = self.dataId
    self.monsterCfg = (ConfigData.monster)[self.dataId]
    if self.monsterCfg == nil then
      error("monster Cfg is null,id:" .. tostring(self.dataId))
      return 
    end
    self.resCfg = (ConfigData.resource_model)[(self.monsterCfg).src_id]
    if self.resCfg == nil then
      error("resource model cfg is null,id:" .. tostring((self.monsterCfg).src_id))
      return 
    end
    self.isShowStateBar = (self.monsterCfg).isShowStateBar
    self.isShowInfoBar = (self.monsterCfg).isShowInfoBar
    self.isContainAction = (self.monsterCfg).contain_action
    self.belong = eBattleRoleBelong.enemy
    self.onBench = false
    self.attackRange = (self.monsterCfg).range
    self.moveSpeed = (self.monsterCfg).move_spd
    self.intensity = (self.monsterCfg).intensity
    self.baseAttr = {}
    self.ratioAttr = {}
    self.extraAttr = {}
    self.originAttr = {}
    if monsterData.stc ~= nil and (monsterData.stc).attr ~= nil then
      for i = 2, max_property_count + 1 do
        -- DECOMPILER ERROR at PC90: Confused about usage of register: R6 in 'UnsetPending'

        (self.originAttr)[i - 1] = ((monsterData.stc).attr)[i]
      end
    end
    do
      self.originSkillList = {}
      for skillId,skillLevel in pairs((monsterData.stc).skillGroup) do
        local battleSkill = (DynBattleSkill.New)(skillId, skillLevel, (ExplorationEnum.eBattleSkillType).Original)
        ;
        (table.insert)(self.originSkillList, battleSkill)
      end
      ;
      (table.sort)(self.originSkillList, MonsterSkillSort)
      self.coordination = (monsterData.dyc).coordination
      self:SetCoord((monsterData.dyc).coordination)
      self.hpPer = (monsterData.dyc).hpPer
      self.death_frames = (self.resCfg).death_frames
      self.isContainAction = true
      self.priority = 1
      self.fixedSkillSequence = (self.monsterCfg).skill_array
    end
  end
end

DynMonster.GetMonsterInfo = function(self)
  -- function num : 0_2 , upvalues : _ENV
  return (LanguageUtil.GetLocaleText)((self.monsterCfg).info)
end

DynMonster.GetName = function(self)
  -- function num : 0_3 , upvalues : _ENV
  return (LanguageUtil.GetLocaleText)((self.monsterCfg).name)
end

DynMonster.GetCareer = function(self)
  -- function num : 0_4
  return (self.monsterCfg).career
end

DynMonster.GetCamp = function(self)
  -- function num : 0_5
  return (self.monsterCfg).camp
end

DynMonster.GetResPicName = function(self)
  -- function num : 0_6
  return (self.resCfg).res_Name
end

DynMonster.GetResModelName = function(self, isDefault)
  -- function num : 0_7
  return (self.resCfg).res_Name
end

DynMonster.GetExtendResName = function(self)
  -- function num : 0_8
  return (self.resCfg).extend_res
end

DynMonster.GetResSrcId = function(self)
  -- function num : 0_9
  return (self.monsterCfg).src_id
end

DynMonster.GetRoleTag = function(self)
  -- function num : 0_10
  return (self.monsterCfg).monster_tag, false
end

DynMonster.GetBossBloodNum = function(self)
  -- function num : 0_11
  return (self.monsterCfg).blood_bar_num
end

return DynMonster

