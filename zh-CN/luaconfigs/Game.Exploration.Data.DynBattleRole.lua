-- params : ...
-- function num : 0 , upvalues : _ENV
local DynChipHolder = require("Game.Exploration.Data.DynChipHolder")
local DynBattleRole = class("DynBattleRole", DynChipHolder)
local cs_GameData = (CS.GameData).instance
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local HeroAttrUtility = require("Game.Exploration.Data.HeroAttrUtility")
DynBattleRole.ctor = function(self)
  -- function num : 0_0
  self.fightingPower = 0
end

DynBattleRole.SetCoord = function(self, coord, benchRow)
  -- function num : 0_1 , upvalues : _ENV
  self.coord = coord
  self.x = (BattleUtil.Pos2XYCoord)(coord)
  if benchRow > self.x then
    self.onBench = not benchRow
    self.onBench = false
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
  end
end

DynBattleRole.SetCoordXY = function(self, x, y, benchRow)
  -- function num : 0_2 , upvalues : _ENV
  self.coord = (BattleUtil.XYCoord2Pos)(x, y)
  self.x = x
  self.y = y
  if benchRow > self.x then
    self.onBench = not benchRow
    self.onBench = false
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
  end
end

DynBattleRole.GetName = function(self)
  -- function num : 0_3
end

DynBattleRole.GetCareer = function(self)
  -- function num : 0_4
end

DynBattleRole.GetCamp = function(self)
  -- function num : 0_5
end

DynBattleRole.GetResPicName = function(self)
  -- function num : 0_6
end

DynBattleRole.GetResModelName = function(self, isDefault)
  -- function num : 0_7
end

DynBattleRole.GetExtendResName = function(self)
  -- function num : 0_8
end

DynBattleRole.GetResSrcId = function(self)
  -- function num : 0_9
end

DynBattleRole.GetCarrerIcon = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local careerId = self:GetCareer()
  local career = (ConfigData.career)[careerId]
  if career == nil then
    return nil
  end
  return career.icon
end

DynBattleRole.GetCampIcon = function(self)
  -- function num : 0_11 , upvalues : _ENV
  local campId = self:GetCamp()
  local camp = (ConfigData.camp)[campId]
  if camp == nil then
    return nil
  end
  return camp.icon
end

DynBattleRole.GetOriginSkillList = function(self)
  -- function num : 0_12
  return self.originSkillList
end

DynBattleRole.OffsetAttrFromChip = function(self, property, value)
  -- function num : 0_13 , upvalues : HeroAttrUtility
  (HeroAttrUtility.OffsetAttrFromDynHero)(self, property, value)
end

DynBattleRole.UpdateHpPer = function(self, hpPer)
  -- function num : 0_14
  self.hpPer = hpPer
end

DynBattleRole.SetExtraAttr = function(self, attrId, value)
  -- function num : 0_15 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self.extraAttr)[attrId] = value
  if attrId == eHeroAttr.maxHp then
    self.maxHp = self:GetRealAttr(eHeroAttr.maxHp)
  end
end

DynBattleRole.SetBaseAttr = function(self, attrId, value)
  -- function num : 0_16 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self.baseAttr)[attrId] = value
  if attrId == eHeroAttr.maxHp then
    self.maxHp = self:GetRealAttr(eHeroAttr.maxHp)
  end
end

DynBattleRole.SetRatioAttr = function(self, attrId, value)
  -- function num : 0_17 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self.ratioAttr)[attrId] = value
  if attrId == eHeroAttr.maxHp then
    self.maxHp = self:GetRealAttr(eHeroAttr.maxHp)
  end
end

DynBattleRole.GetClientOriginAttr = function(self, attrId)
  -- function num : 0_18
  return 0
end

DynBattleRole.GetOriginAttr = function(self, attrId)
  -- function num : 0_19
  return (self.originAttr)[attrId] or 0
end

DynBattleRole.GetBaseAttr = function(self, attrId)
  -- function num : 0_20
  return (self.baseAttr)[attrId] or 0
end

DynBattleRole.GetRatioAttr = function(self, attrId)
  -- function num : 0_21
  return (self.ratioAttr)[attrId] or 0
end

DynBattleRole.GetExtraAttr = function(self, attrId)
  -- function num : 0_22
  return (self.extraAttr)[attrId] or 0
end

DynBattleRole.GetRealAttr = function(self, attrId)
  -- function num : 0_23 , upvalues : _ENV
  return (((self.originAttr)[attrId] or 0) + ((self.baseAttr)[attrId] or 0)) * (eHeroAttrPercent + ((self.ratioAttr)[attrId] or 0)) // eHeroAttrPercent + ((self.extraAttr)[attrId] or 0)
end

DynBattleRole.GetFormulaAttr = function(self, attrId)
  -- function num : 0_24 , upvalues : _ENV, ExplorationEnum
  if attrId == eHeroAttr.hp then
    local maxHp = self:GetRealAttr(eHeroAttr.maxHp)
    local hp = self.hpPer * maxHp // ExplorationEnum.eHeroHpPercent
    if hp == 0 and self.hpPer > 0 then
      hp = 1
    end
    return hp
  else
    do
      if attrId == eHeroAttr.attack_range then
        return self.attackRange
      else
        return self:GetRealAttr(attrId)
      end
    end
  end
end

DynBattleRole.GetSkillFightingPower = function(self, heroPower)
  -- function num : 0_25 , upvalues : _ENV, ExplorationEnum
  local skillList = {}
  local skillDic = {}
  if self.originSkillList ~= nil then
    for k,v in pairs(self.originSkillList) do
      (table.insert)(skillList, v)
      skillDic[v.dataId] = v
    end
  end
  do
    if self.__itemSkillDic ~= nil then
      for k,v in pairs(self.__itemSkillDic) do
        local oldSkill = skillDic[k.dataId]
        if oldSkill == nil or oldSkill.level < k.level then
          if oldSkill then
            (table.removebyvalue)(skillList, oldSkill)
          end
          ;
          (table.insert)(skillList, k)
          skillDic[k.dataId] = k
        end
      end
    end
    do
      local fightingPower = 0
      for k,battleSkill in pairs(skillList) do
        local battleCfg = (ConfigData.battle_skill)[battleSkill.dataId]
        if battleSkill.type ~= (ExplorationEnum.eBattleSkillType).Chip and battleSkill.type ~= (ExplorationEnum.eBattleSkillType).TempChip then
          local isChipType = battleCfg == nil or battleCfg.skill_comat == ""
          do
            local power = PlayerDataCenter:GetBattleSkillFightPower(battleSkill.dataId, battleSkill.level, heroPower, isChipType)
            fightingPower = fightingPower + power
            -- DECOMPILER ERROR at PC83: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC83: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
      do return fightingPower end
      -- DECOMPILER ERROR: 2 unprocessed JMP targets
    end
  end
end

DynBattleRole.GetFightingPower = function(self, fullHp)
  -- function num : 0_26 , upvalues : _ENV
  local attrDic = self:GetDynBattleRoleAttrDic()
  local heroPower = 0
  if fullHp then
    heroPower = (ConfigData.GetFormulaValue)(eFormulaType.Hero, attrDic)
  else
    if self.belong == eBattleRoleBelong.enemy then
      heroPower = (ConfigData.GetFormulaValue)(eFormulaType.BattleHeroEnemy, attrDic)
    else
      heroPower = (ConfigData.GetFormulaValue)(eFormulaType.BattleHero, attrDic)
    end
  end
  local fightingPower = heroPower + self:GetSkillFightingPower(heroPower)
  fightingPower = (math.floor)(fightingPower)
  self.fightingPower = fightingPower
  return fightingPower
end

DynBattleRole.GetDynBattleRoleAttrDic = function(self)
  -- function num : 0_27 , upvalues : _ENV
  local attrDic = (table.GetDefaulValueTable)(0)
  for i = 1, (ConfigData.attribute).maxPropertyId - 1 do
    attrDic[i] = self:GetFormulaAttr(i)
  end
  return attrDic
end

DynBattleRole.GetAttackRangeType = function(self)
  -- function num : 0_28
  if self.attackRange > 1 then
    return 2
  else
    return 1
  end
end

DynBattleRole.IsDead = function(self)
  -- function num : 0_29
  do return self.hpPer <= 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DynBattleRole.GetStandardMoveSpd = function(self)
  -- function num : 0_30
  return (self.resCfg).base_move_spd
end

return DynBattleRole

