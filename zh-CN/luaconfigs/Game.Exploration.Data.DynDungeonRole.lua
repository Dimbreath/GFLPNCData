-- params : ...
-- function num : 0 , upvalues : _ENV
local DynBattleRole = require("Game.Exploration.Data.DynBattleRole")
local DynBattleSkill = require("Game.Exploration.Data.DynBattleSkill")
local DynDungeonRole = class("DynDungeonRole", DynBattleRole)
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local cs_GameData = (CS.GameData).instance
local MonsterSkillSort = function(skill1, skill2)
  -- function num : 0_0
  do return skill1.dataId < skill2.dataId end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DynDungeonRole.ctor = function(self, monsterData)
  -- function num : 0_1 , upvalues : _ENV, DynBattleSkill, ExplorationEnum, MonsterSkillSort
  self.dataId = (monsterData.stc).dataId
  if not (monsterData.stc).uid then
    self.uid = self.dataId
    self.monsterCfg = (ConfigData.monster)[self.dataId]
    if self.monsterCfg == nil then
      error("neutral Cfg is null,id:" .. tostring(self.dataId))
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
    self.belong = eBattleRoleBelong.neutral
    self.onBench = false
    self.attackRange = (self.monsterCfg).range
    self.moveSpeed = (self.monsterCfg).moveSpd
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
    end
  end
end

DynDungeonRole.SetSummonerBelong = function(self, belong)
  -- function num : 0_2
  self.belong = belong
end

DynDungeonRole.GetMonsterInfo = function(self)
  -- function num : 0_3 , upvalues : _ENV
  return (LanguageUtil.GetLocaleText)((self.monsterCfg).info)
end

DynDungeonRole.GetName = function(self)
  -- function num : 0_4 , upvalues : _ENV
  return (LanguageUtil.GetLocaleText)((self.monsterCfg).name)
end

DynDungeonRole.GetCareer = function(self)
  -- function num : 0_5
  return (self.monsterCfg).career
end

DynDungeonRole.GetCamp = function(self)
  -- function num : 0_6
  return (self.monsterCfg).camp
end

DynDungeonRole.GetResPicName = function(self)
  -- function num : 0_7
  return (self.resCfg).res_Name
end

DynDungeonRole.GetResModelName = function(self, isDefault)
  -- function num : 0_8
  return (self.resCfg).res_Name
end

DynDungeonRole.GetExtendResName = function(self)
  -- function num : 0_9
  return (self.resCfg).extend_res
end

DynDungeonRole.GetResSrcId = function(self)
  -- function num : 0_10
  return (self.monsterCfg).src_id
end

DynDungeonRole.GetRoleTag = function(self)
  -- function num : 0_11
  return (self.monsterCfg).monster_tag, false
end

return DynDungeonRole

