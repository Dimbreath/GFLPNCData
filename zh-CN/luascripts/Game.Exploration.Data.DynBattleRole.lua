-- params : ...
-- function num : 0 , upvalues : _ENV
local DynBattleRole = class("DynBattleRole")
local cs_GameData = (CS.GameData).instance
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
DynBattleRole.ctor = function(self)
  -- function num : 0_0
  self.ownedChips = {}
  self.tempChips = {}
  self.itemSkillDic = {}
  self.effectCampFetters = {}
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

DynBattleRole.GetResName = function(self)
  -- function num : 0_6
end

DynBattleRole.GetResSrcId = function(self)
  -- function num : 0_7
end

DynBattleRole.GetCarrerIcon = function(self)
  -- function num : 0_8 , upvalues : _ENV
  local careerId = self:GetCareer()
  local career = (ConfigData.career)[careerId]
  if career == nil then
    return nil
  end
  return career.icon
end

DynBattleRole.GetCampIcon = function(self)
  -- function num : 0_9 , upvalues : _ENV
  local campId = self:GetCamp()
  local camp = (ConfigData.camp)[campId]
  if camp == nil then
    return nil
  end
  return camp.icon
end

DynBattleRole.GetOriginSkillList = function(self)
  -- function num : 0_10
  return self.originSkillList
end

DynBattleRole.GetItemSkillList = function(self)
  -- function num : 0_11 , upvalues : _ENV
  local skillList = {}
  local skillDic = {}
  for k,v in pairs(self.itemSkillDic) do
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
  return skillList
end

DynBattleRole.GetItemSkillDic = function(self)
  -- function num : 0_12
  return self.itemSkillDic
end

DynBattleRole.AddItemSkill = function(self, dynSkill)
  -- function num : 0_13
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.itemSkillDic)[dynSkill] = true
end

DynBattleRole.RemoveItemSkill = function(self, dynSkill)
  -- function num : 0_14
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.itemSkillDic)[dynSkill] = nil
end

DynBattleRole.GetOwnedChips = function(self)
  -- function num : 0_15
  return self.ownedChips
end

DynBattleRole.GetOwnedChipsById = function(self, chipId)
  -- function num : 0_16 , upvalues : _ENV
  for chipData,v in pairs(self.ownedChips) do
    if chipData.dataId == chipId then
      return chipData
    end
  end
  error("Can\'t Get OwnedChips By Id, id = " .. tostring(chipId))
end

DynBattleRole.ContainChip = function(self, chipData)
  -- function num : 0_17
  local contain = (self.ownedChips)[chipData] ~= nil
  do return contain end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DynBattleRole.AddChip = function(self, chipData)
  -- function num : 0_18
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.ownedChips)[chipData] = true
end

DynBattleRole.RemoveChip = function(self, chipData)
  -- function num : 0_19
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.ownedChips)[chipData] = nil
end

DynBattleRole.ContainTempChip = function(self, epBuff)
  -- function num : 0_20
  local contain = (self.tempChips)[epBuff] ~= nil
  do return contain end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DynBattleRole.AddTempChip = function(self, chipData)
  -- function num : 0_21
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.tempChips)[chipData] = true
end

DynBattleRole.RemoveTempChip = function(self, epBuff)
  -- function num : 0_22
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.tempChips)[epBuff] = nil
end

DynBattleRole.AddCampFetterChip = function(self, chipBattleData)
  -- function num : 0_23
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.effectCampFetters)[chipBattleData] = true
end

DynBattleRole.RemoveCampFetterChip = function(self, chipBattleData)
  -- function num : 0_24
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.effectCampFetters)[chipBattleData] = nil
end

DynBattleRole.ContainCampFetterChip = function(self, chipBattleData)
  -- function num : 0_25
  local contain = (self.effectCampFetters)[chipBattleData] ~= nil
  do return contain end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DynBattleRole.UpdateHpPer = function(self, hpPer)
  -- function num : 0_26
  self.hpPer = hpPer
end

DynBattleRole.SetExtraAttr = function(self, attrId, value)
  -- function num : 0_27 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self.extraAttr)[attrId] = value
  if attrId == eHeroAttr.maxHp then
    self.maxHp = self:GetRealAttr(eHeroAttr.maxHp)
  end
end

DynBattleRole.SetBaseAttr = function(self, attrId, value)
  -- function num : 0_28 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self.baseAttr)[attrId] = value
  if attrId == eHeroAttr.maxHp then
    self.maxHp = self:GetRealAttr(eHeroAttr.maxHp)
  end
end

DynBattleRole.SetRatioAttr = function(self, attrId, value)
  -- function num : 0_29 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self.ratioAttr)[attrId] = value
  if attrId == eHeroAttr.maxHp then
    self.maxHp = self:GetRealAttr(eHeroAttr.maxHp)
  end
end

DynBattleRole.GetClientOriginAttr = function(self, attrId)
  -- function num : 0_30
  return 0
end

DynBattleRole.GetOriginAttr = function(self, attrId)
  -- function num : 0_31
  return (self.originAttr)[attrId] or 0
end

DynBattleRole.GetBaseAttr = function(self, attrId)
  -- function num : 0_32
  return (self.baseAttr)[attrId] or 0
end

DynBattleRole.GetRatioAttr = function(self, attrId)
  -- function num : 0_33
  return (self.ratioAttr)[attrId] or 0
end

DynBattleRole.GetExtraAttr = function(self, attrId)
  -- function num : 0_34
  return (self.extraAttr)[attrId] or 0
end

DynBattleRole.GetRealAttr = function(self, attrId)
  -- function num : 0_35 , upvalues : _ENV
  return (((self.originAttr)[attrId] or 0) + ((self.baseAttr)[attrId] or 0)) * (eHeroAttrPercent + ((self.ratioAttr)[attrId] or 0)) // eHeroAttrPercent + ((self.extraAttr)[attrId] or 0)
end

DynBattleRole.GetFormulaAttr = function(self, attrEnum)
  -- function num : 0_36 , upvalues : _ENV, ExplorationEnum
  local attrId = (GR.EnumToInt)(attrEnum)
  if attrId == eHeroAttr.hp then
    local maxHp = self:GetRealAttr(eHeroAttr.maxHp)
    local hp = self.hpPer * maxHp // ExplorationEnum.eHeroHpPercent
    if hp == 0 and self.hpPer > 0 then
      hp = 1
    end
    return hp
  else
    do
      if attrId == eHeroAttr.intensity then
        return self.intensity
      else
        if attrId == eHeroAttr.attack_range then
          return self.attackRange
        else
          return self:GetRealAttr(attrId)
        end
      end
    end
  end
end

DynBattleRole.GetSkillFightingPower = function(self, fullHp)
  -- function num : 0_37 , upvalues : _ENV, cs_GameData
  local skillList = {}
  local skillDic = {}
  if self.originSkillList ~= nil then
    for k,v in pairs(self.originSkillList) do
      (table.insert)(skillList, v)
      skillDic[v.dataId] = v
    end
  end
  do
    if self.itemSkillDic ~= nil then
      for k,v in pairs(self.itemSkillDic) do
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
        local skillCfg = (cs_GameData.listBattleSkillDatas):GetDataById(battleSkill.dataId)
        if skillCfg == nil then
          error("battle skill cfg is null,id:" .. tostring(battleSkill.dataId))
        else
          if skillCfg.combatFormula ~= nil then
            if fullHp then
              fightingPower = fightingPower + ((((skillCfg.combatFormula):BindOption(((CS.BattleFormula).eFormationOption).ReplaceHpWithMaxHp)):BindData(((CS.BattleFormula).eFormulaBindType).SkillLevel, ((CS.FormulaOperand).OperandValue)(battleSkill.level))):GetValue(self, self)):AsLong()
            else
              fightingPower = fightingPower + (((skillCfg.combatFormula):BindData(((CS.BattleFormula).eFormulaBindType).SkillLevel, ((CS.FormulaOperand).OperandValue)(battleSkill.level))):GetValue(self, self)):AsLong()
            end
          end
        end
      end
      return fightingPower
    end
  end
end

DynBattleRole.GetFightingPower = function(self, fullHp)
  -- function num : 0_38 , upvalues : _ENV
  local fightingPower = 0
  if fullHp then
    fightingPower = (((((CS.BattleConsts).BattleRoleFightPowerFormula).battleFormula):BindOption(((CS.BattleFormula).eFormationOption).ReplaceHpWithMaxHp)):GetValue(self, self)):AsLong()
  else
    fightingPower = ((((CS.BattleConsts).BattleRoleFightPowerFormula).battleFormula):GetValue(self, self)):AsLong()
  end
  fightingPower = fightingPower + self:GetSkillFightingPower(fullHp)
  self.fightingPower = fightingPower
  return fightingPower
end

DynBattleRole.GetAttackRangeType = function(self)
  -- function num : 0_39
  if self.attackRange > 1 then
    return 2
  else
    return 1
  end
end

DynBattleRole.IsDead = function(self)
  -- function num : 0_40
  do return self.hpPer <= 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DynBattleRole.GetStandardMoveSpd = function(self)
  -- function num : 0_41
  return (self.resCfg).base_move_spd
end

return DynBattleRole

