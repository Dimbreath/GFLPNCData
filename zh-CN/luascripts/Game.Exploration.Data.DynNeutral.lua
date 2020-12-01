-- params : ...
-- function num : 0 , upvalues : _ENV
local DynBattleRole = require("Game.Exploration.Data.DynBattleRole")
local DynBattleSkill = require("Game.Exploration.Data.DynBattleSkill")
local DynNeutral = class("DynNeutral", DynBattleRole)
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local cs_GameData = (CS.GameData).instance
local NeutralSkillSort = function(skill1, skill2)
  -- function num : 0_0
  do return skill1.dataId < skill2.dataId end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DynNeutral.ctor = function(self, neutralData)
  -- function num : 0_1 , upvalues : cs_GameData, _ENV, DynBattleSkill, ExplorationEnum, NeutralSkillSort
  self.dataId = neutralData.templateId
  self.neutralCfg = (cs_GameData.listSummonerDatas):GetDataById(self.dataId)
  self.isShowStateBar = (self.neutralCfg).IsShowStateBar
  self.isShowInfoBar = (self.neutralCfg).IsShowInfoBar
  self.isContainAction = (self.neutralCfg).ContainAction
  self.priority = (self.neutralCfg).priority
  if self.neutralCfg == nil then
    error("neutral Cfg is null,id:" .. tostring(self.dataId))
    return 
  end
  self.resCfg = (ConfigData.resource_model)[(self.neutralCfg).SrcId]
  if self.resCfg == nil then
    error("resource model cfg is null,id:" .. tostring((self.neutralCfg).SrcId))
    return 
  end
  self.belong = eBattleRoleBelong.neutral
  self.onBench = false
  self.attackRange = (self.neutralCfg).Range
  self.moveSpeed = (self.neutralCfg).MoveSpd
  self.intensity = (self.neutralCfg).Intensity
  self.baseAttr = {}
  self.ratioAttr = {}
  self.extraAttr = {}
  self.originAttr = {}
  for k,v in pairs(neutralData.attr) do
    -- DECOMPILER ERROR at PC74: Confused about usage of register: R7 in 'UnsetPending'

    (self.originAttr)[k] = v
  end
  self.originSkillList = {}
  for skillId,skillLevel in pairs(neutralData.skillGroup) do
    local battleSkill = (DynBattleSkill.New)(skillId, skillLevel, (ExplorationEnum.eBattleSkillType).Original)
    ;
    (table.insert)(self.originSkillList, battleSkill)
  end
  ;
  (table.sort)(self.originSkillList, NeutralSkillSort)
  self.coordination = neutralData.coordination
  self:SetCoord(neutralData.coordination)
  self.hpPer = neutralData.hpPer
end

DynNeutral.GetMonsterInfo = function(self)
  -- function num : 0_2 , upvalues : _ENV
  return (LanguageUtil.GetLocaleText)((self.neutralCfg).Info)
end

DynNeutral.GetName = function(self)
  -- function num : 0_3 , upvalues : _ENV
  return (LanguageUtil.GetLocaleText)((self.neutralCfg).Name)
end

DynNeutral.GetCareer = function(self)
  -- function num : 0_4
  return (self.neutralCfg).Career
end

DynNeutral.GetCamp = function(self)
  -- function num : 0_5
  return (self.neutralCfg).Camp
end

DynNeutral.GetResName = function(self)
  -- function num : 0_6
  return (self.resCfg).res_Name
end

DynNeutral.GetExtendResName = function(self)
  -- function num : 0_7
  return (self.resCfg).extend_res
end

DynNeutral.GetResSrcId = function(self)
  -- function num : 0_8
  return (self.neutralCfg).SrcId
end

DynNeutral.GetTag = function(self)
  -- function num : 0_9
  return (self.neutralCfg).summonerTag
end

return DynNeutral

-- params : ...
-- function num : 0 , upvalues : _ENV
local DynBattleRole = require("Game.Exploration.Data.DynBattleRole")
local DynBattleSkill = require("Game.Exploration.Data.DynBattleSkill")
local DynNeutral = class("DynNeutral", DynBattleRole)
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local cs_GameData = (CS.GameData).instance
local NeutralSkillSort = function(skill1, skill2)
    -- function num : 0_0
    do return skill1.dataId < skill2.dataId end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DynNeutral.ctor = function(self, neutralData)
    -- function num : 0_1 , upvalues : cs_GameData, _ENV, DynBattleSkill, ExplorationEnum, NeutralSkillSort
    self.dataId = neutralData.templateId
    self.neutralCfg = (cs_GameData.listSummonerDatas):GetDataById(self.dataId)
    self.isShowStateBar = (self.neutralCfg).IsShowStateBar
    self.isShowInfoBar = (self.neutralCfg).IsShowInfoBar
    self.isContainAction = (self.neutralCfg).ContainAction
    self.priority = (self.neutralCfg).priority
    if self.neutralCfg == nil then
        error("neutral Cfg is null,id:" .. tostring(self.dataId))
        return
    end
    self.resCfg = (ConfigData.resource_model)[(self.neutralCfg).SrcId]
    if self.resCfg == nil then
        error("resource model cfg is null,id:" ..
                  tostring((self.neutralCfg).SrcId))
        return
    end
    self.belong = eBattleRoleBelong.neutral
    self.onBench = false
    self.attackRange = (self.neutralCfg).Range
    self.moveSpeed = (self.neutralCfg).MoveSpd
    self.intensity = (self.neutralCfg).Intensity
    self.baseAttr = {}
    self.ratioAttr = {}
    self.extraAttr = {}
    self.originAttr = {}
    for k, v in pairs(neutralData.attr) do
        -- DECOMPILER ERROR at PC74: Confused about usage of register: R7 in 'UnsetPending'

        (self.originAttr)[k] = v
    end
    self.originSkillList = {}
    for skillId, skillLevel in pairs(neutralData.skillGroup) do
        local battleSkill = (DynBattleSkill.New)(skillId, skillLevel,
                                                 (ExplorationEnum.eBattleSkillType).Original);
        (table.insert)(self.originSkillList, battleSkill)
    end
    (table.sort)(self.originSkillList, NeutralSkillSort)
    self.coordination = neutralData.coordination
    self:SetCoord(neutralData.coordination)
    self.hpPer = neutralData.hpPer
end

DynNeutral.GetMonsterInfo = function(self)
    -- function num : 0_2 , upvalues : _ENV
    return (LanguageUtil.GetLocaleText)((self.neutralCfg).Info)
end

DynNeutral.GetName = function(self)
    -- function num : 0_3 , upvalues : _ENV
    return (LanguageUtil.GetLocaleText)((self.neutralCfg).Name)
end

DynNeutral.GetCareer = function(self)
    -- function num : 0_4
    return (self.neutralCfg).Career
end

DynNeutral.GetCamp = function(self)
    -- function num : 0_5
    return (self.neutralCfg).Camp
end

DynNeutral.GetResName = function(self)
    -- function num : 0_6
    return (self.resCfg).res_Name
end

DynNeutral.GetExtendResName = function(self)
    -- function num : 0_7
    return (self.resCfg).extend_res
end

DynNeutral.GetResSrcId = function(self)
    -- function num : 0_8
    return (self.neutralCfg).SrcId
end

DynNeutral.GetTag = function(self)
    -- function num : 0_9
    return (self.neutralCfg).summonerTag
end

return DynNeutral

