local ChipBattleData = class("ChipBattleData")
local CS_BattleManager_Ins = (CS.BattleManager).Instance
local DynBattleSkill = require("Game.Exploration.Data.DynBattleSkill")
local HeroAttrUtility = require("Game.Exploration.Data.HeroAttrUtility")
local ChipEnum = require("Game.PlayerData.Item.ChipEnum")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local PlayerSelectorFunc = {[(ChipEnum.eChipInfluenceType).AllHero] = function(roleList, validRoleDic, influenceArg)
  -- function num : 0_0 , upvalues : _ENV
  for k,role in ipairs(roleList) do
    validRoleDic[role] = true
  end
end
, [(ChipEnum.eChipInfluenceType).Camp] = function(roleList, validRoleDic, influenceArg)
  -- function num : 0_1 , upvalues : _ENV
  for k,role in ipairs(roleList) do
    if role:GetCamp() == influenceArg then
      validRoleDic[role] = true
    end
  end
end
, [(ChipEnum.eChipInfluenceType).Career] = function(roleList, validRoleDic, influenceArg)
  -- function num : 0_2 , upvalues : _ENV
  for k,role in ipairs(roleList) do
    if role:GetCareer() == influenceArg then
      validRoleDic[role] = true
    end
  end
end
, [(ChipEnum.eChipInfluenceType).Row] = function(roleList, validRoleDic, influenceArg)
  -- function num : 0_3 , upvalues : _ENV
  for k,role in ipairs(roleList) do
    if role:GetAttackRangeType() == influenceArg then
      validRoleDic[role] = true
    end
  end
end
, [(ChipEnum.eChipInfluenceType).HeroId] = function(roleList, validRoleDic, influenceArg)
  -- function num : 0_4 , upvalues : _ENV
  for k,role in ipairs(roleList) do
    if role.dataId == influenceArg then
      validRoleDic[role] = true
    end
  end
end
}
local EnemySelectorFunc = {[(ChipEnum.eChipInfluenceType).EnemyAllHero] = PlayerSelectorFunc[(ChipEnum.eChipInfluenceType).AllHero], [(ChipEnum.eChipInfluenceType).EnemyCamp] = PlayerSelectorFunc[(ChipEnum.eChipInfluenceType).Camp], [(ChipEnum.eChipInfluenceType).EnemyCareer] = PlayerSelectorFunc[(ChipEnum.eChipInfluenceType).Career], [(ChipEnum.eChipInfluenceType).EnemyRow] = PlayerSelectorFunc[(ChipEnum.eChipInfluenceType).Row], [(ChipEnum.eChipInfluenceType).EnemyHeroId] = PlayerSelectorFunc[(ChipEnum.eChipInfluenceType).HeroId]}
ChipBattleData.ctor = function(self, chipCfg, skillLevel, skillType)
  -- function num : 0_5 , upvalues : _ENV, ChipEnum, DynBattleSkill
  if not skillLevel then
    skillLevel = 1
  end
  self.level = skillLevel
  self.chipCfg = chipCfg
  self.influenceType = (self.chipCfg).influence
  self.influenceArg = (self.chipCfg).arg
  self.attributeIdList = (self.chipCfg).attribute_id
  if not skillType then
    local battleSkillType = eBattleSkillLogicType.Chip
  end
  if self.influenceType == (ChipEnum.eChipInfluenceType).PlayerConsume then
    battleSkillType = eBattleSkillLogicType.ChipConsume
  end
  if #(self.chipCfg).skill_list > 0 then
    self.skillDataList = {}
    for k,skillId in ipairs((self.chipCfg).skill_list) do
      local skillData = (DynBattleSkill.New)(skillId, skillLevel, battleSkillType)
      skillData.itemId = (self.chipCfg).id
      ;
      (table.insert)(self.skillDataList, skillData)
    end
  end
end

ChipBattleData.UpdateChipBattleLevel = function(self, level)
  -- function num : 0_6 , upvalues : _ENV
  if self.level == level then
    return 
  end
  self.level = level
  if self.skillDataList ~= nil then
    for k,v in ipairs(self.skillDataList) do
      v:Update(level)
    end
  end
end

ChipBattleData.ExecuteChipBattle = function(self, chipHolder)
  -- function num : 0_7 , upvalues : _ENV
  if chipHolder == nil then
    return false
  end
  if chipHolder:ContainChipEffector(self) then
    error("该芯片效果已经生效:" .. tostring((self.chipCfg).id))
    return false
  end
  for k,property in ipairs(self.attributeIdList) do
    local value = ((self.chipCfg).attribute_initial)[k] + (((self.chipCfg).level_increase)[k] or 0) * (self.level - 1)
    chipHolder:OffsetAttrFromChip(property, value)
  end
  if self.skillDataList ~= nil then
    for k,v in ipairs(self.skillDataList) do
      chipHolder:AddItemSkill(v)
    end
  end
  do
    chipHolder:AddChipEffector(self)
    return true
  end
end

ChipBattleData.RollbackChipBattle = function(self, chipHolder)
  -- function num : 0_8 , upvalues : _ENV
  if chipHolder == nil then
    return false
  end
  if not chipHolder:ContainChipEffector(self) then
    return false
  end
  for k,property in ipairs(self.attributeIdList) do
    local value = ((self.chipCfg).attribute_initial)[k] + (((self.chipCfg).level_increase)[k] or 0) * (self.level - 1)
    chipHolder:OffsetAttrFromChip(property, -value)
  end
  if self.skillDataList ~= nil then
    for k,v in ipairs(self.skillDataList) do
      chipHolder:RemoveItemSkill(v)
    end
  end
  do
    chipHolder:RemoveChipEffector(self)
    return true
  end
end

ChipBattleData.GetValidRoleList = function(self, dynBattleRoleList, belong)
  -- function num : 0_9 , upvalues : _ENV, PlayerSelectorFunc, EnemySelectorFunc
  local result = {}
  if #dynBattleRoleList == 0 then
    return result
  end
  local validRoleDic = nil
  if belong == eBattleRoleBelong.player then
    local selectorFunc = PlayerSelectorFunc[self.influenceType]
    if selectorFunc ~= nil then
      validRoleDic = {}
      selectorFunc(dynBattleRoleList, validRoleDic, self.influenceArg)
    end
  else
    do
      do
        local selectorFunc = EnemySelectorFunc[self.influenceType]
        if selectorFunc ~= nil then
          validRoleDic = {}
          selectorFunc(dynBattleRoleList, validRoleDic, self.influenceArg)
        end
        if validRoleDic ~= nil then
          for k,v in ipairs(dynBattleRoleList) do
            if validRoleDic[v] ~= nil then
              (table.insert)(result, v)
            end
          end
        end
        do
          return result
        end
      end
    end
  end
end

ChipBattleData.IsValidDynPlayer = function(self)
  -- function num : 0_10 , upvalues : ChipEnum
  do return self.influenceType == (ChipEnum.eChipInfluenceType).DynPlayer or self.influenceType == (ChipEnum.eChipInfluenceType).PlayerConsume end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

ChipBattleData.IsConsumeChipBattle = function(self)
  -- function num : 0_11 , upvalues : ChipEnum
  do return self.influenceType == (ChipEnum.eChipInfluenceType).PlayerConsume end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

ChipBattleData.IsForEnemyChipBattle = function(self)
  -- function num : 0_12 , upvalues : EnemySelectorFunc
  do return EnemySelectorFunc[self.influenceType] ~= nil end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

ChipBattleData.SetOnlyForOneHero = function(self, heroId)
  -- function num : 0_13 , upvalues : ChipEnum
  self.influenceType = (ChipEnum.eChipInfluenceType).HeroId
  self.influenceArg = heroId
end

return ChipBattleData

