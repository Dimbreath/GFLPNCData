local base = require("Game.PlayerData.Item.ItemData")
local ChipData = class("ChipData", base)
local ChipBattleData = require("Game.PlayerData.Item.ChipBattleData")
local cs_FormulaUtility = CS.FormulaUtility
ChipData.NewChipForServer = function(chipKey)
  -- function num : 0_0 , upvalues : _ENV, ChipData
  local chipId, level = (ExplorationManager.ChipServerIdConvert)(chipKey)
  return (ChipData.New)(chipId, level)
end

ChipData.NewChipForLocal = function(chipId, level)
  -- function num : 0_1 , upvalues : ChipData
  local chipData = (ChipData.New)(chipId, 1)
  if level == nil then
    level = (chipData.itemCfg).quality - 2
  end
  chipData:SetCount(level)
  return chipData
end

ChipData.ctor = function(self, dataId, count)
  -- function num : 0_2 , upvalues : _ENV, ChipBattleData
  local chipCfg = (ConfigData.chip)[self.dataId]
  if chipCfg == nil then
    error("Can\'t find chip cfg, id = " .. tostring(self.dataId))
    return 
  end
  self.chipCfg = chipCfg
  self.isShowTemp = false
  self.chipBattleData = (ChipBattleData.New)(self.chipCfg, self:GetChipRealLevel())
end

ChipData.OnCountChanged = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCountChanged)(self)
  if self.chipBattleData ~= nil then
    (self.chipBattleData):UpdateChipBattleLevel(self:GetChipRealLevel())
  end
end

ChipData.GetValidRoleList = function(self, dynBattleRoleList, belong)
  -- function num : 0_4
  return (self.chipBattleData):GetValidRoleList(dynBattleRoleList, belong)
end

ChipData.IsValidDynPlayer = function(self)
  -- function num : 0_5
  return (self.chipBattleData):IsValidDynPlayer()
end

ChipData.IsConsumeSkillChip = function(self)
  -- function num : 0_6
  return (self.chipBattleData):IsConsumeChipBattle()
end

ChipData.IsForEnemyChip = function(self)
  -- function num : 0_7
  return (self.chipBattleData):IsForEnemyChipBattle()
end

ChipData.ExecuteChipData = function(self, chipHolder)
  -- function num : 0_8
  if (self.chipBattleData):ExecuteChipBattle(chipHolder) then
    chipHolder:AddChip(self)
  end
end

ChipData.RollbackChipData = function(self, chipHolder)
  -- function num : 0_9
  if (self.chipBattleData):RollbackChipBattle(chipHolder) then
    chipHolder:RemoveChip(self)
  end
end

ChipData.GetChipCfg = function(self)
  -- function num : 0_10
  return self.chipCfg
end

ChipData.GetChipMarkId = function(self)
  -- function num : 0_11
  return (self.chipCfg).markid
end

ChipData.GetChipMarkIcon = function(self)
  -- function num : 0_12 , upvalues : _ENV
  return ((ConfigData.chip_mark)[(self.chipCfg).markid]).icon
end

ChipData.GetChipMaxLevel = function(self)
  -- function num : 0_13
  return self:GetItemTopLimit()
end

ChipData.IsChipFullLevel = function(self)
  -- function num : 0_14
  do return self:GetChipMaxLevel() <= self:GetCount() end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

ChipData.GetChipRealLevel = function(self)
  -- function num : 0_15 , upvalues : _ENV
  return (math.min)(self:GetCount(), self:GetChipMaxLevel())
end

ChipData.GetChipInfo = function(self)
  -- function num : 0_16 , upvalues : _ENV
  return (LanguageUtil.GetLocaleText)((self.chipCfg).info)
end

ChipData.GetName = function(self)
  -- function num : 0_17 , upvalues : base
  local name = (base.GetName)(self)
  if self:IsCopyItem() then
    name = name .. "-" .. self.heroName
  end
  return name
end

ChipData.IsCopyItem = function(self)
  -- function num : 0_18
  return false
end

ChipData.SetIsShowTemp = function(self, bool)
  -- function num : 0_19
  self.isShowTemp = bool
end

ChipData.IsShowTemp = function(self)
  -- function num : 0_20
  return self.isShowTemp
end

ChipData.GetHeroName = function(self)
  -- function num : 0_21
  return self.heroName
end

ChipData.GetHeroID = function(self)
  -- function num : 0_22
  return self.heroId
end

ChipData.GetQuality = function(self)
  -- function num : 0_23 , upvalues : base, _ENV
  if self:IsConsumeSkillChip() then
    return (base.GetQuality)(self)
  end
  return ConfigData:GetChipQuality(self.__count)
end

ChipData.GetChipBuyPrice = function(self, epModuleId)
  -- function num : 0_24 , upvalues : _ENV
  local epTypeCfg = (ConfigData.exploration_type)[epModuleId]
  if epTypeCfg == nil then
    error("Cant get exploration_type cfg, epModuleId = " .. tostring(epModuleId))
    return 0
  end
  local level = (math.min)(self.__count, self:GetChipMaxLevel())
  do return not self:IsConsumeSkillChip() or (epTypeCfg.chip_act_level_price)[level] or 0 end
  return (epTypeCfg.chip_level_price)[level] or 0
end

ChipData.GetChipFuncTag = function(self)
  -- function num : 0_25
  return (self.chipCfg).fun_tag
end

ChipData.GetChipDescription = function(self, isShowDetail)
  -- function num : 0_26 , upvalues : _ENV
  return ConfigData:GetChipDescriptionById((self.chipCfg).id, self:GetCount(), isShowDetail)
end

ChipData.GetChipType = function(self)
  -- function num : 0_27
  return (self.chipCfg).type
end

ChipData.GetSkillCfg = function(self)
  -- function num : 0_28 , upvalues : _ENV
  local skillId = self:GetSkillID()
  local skillCfg = (((CS.GameData).instance).listBattleSkillDatas):GetDataById(skillId)
  if skillCfg == nil then
    error("Can\'t find skillCfg, id = " .. tostring(skillId))
    return 
  end
  return skillCfg
end

ChipData.GetSkillID = function(self)
  -- function num : 0_29
  return ((self.chipCfg).skill_list)[1]
end

ChipData.TryGetSkillCD = function(self, curLevel, digits)
  -- function num : 0_30 , upvalues : cs_FormulaUtility, _ENV
  local hasCD = false
  local cd = ""
  local skillId = self:GetSkillID()
  local skillCfg = self:GetSkillCfg()
  do
    if skillCfg ~= nil and skillId ~= nil then
      local skillCD = (cs_FormulaUtility.CalculateSkillCd)(skillId, curLevel)
      if skillCD ~= 0 then
        hasCD = true
        cd = GetPreciseDecimalStr(skillCD, digits)
      end
    end
    return hasCD, cd
  end
end

return ChipData

