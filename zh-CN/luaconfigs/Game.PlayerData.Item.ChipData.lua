-- params : ...
-- function num : 0 , upvalues : _ENV
local base = require("Game.PlayerData.Item.ItemData")
local ChipData = class("ChipData", base)
local ChipBattleData = require("Game.PlayerData.Item.ChipBattleData")
ChipData.NewChipForServer = function(chipKey)
  -- function num : 0_0 , upvalues : ChipData
  local chipId = chipKey >> 4
  local level = chipKey & 15
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

ChipData.ExecuteChipData = function(self, chipHolder)
  -- function num : 0_6
  if (self.chipBattleData):ExecuteChipBattle(chipHolder) then
    chipHolder:AddChip(self)
  end
end

ChipData.RollbackChipData = function(self, chipHolder)
  -- function num : 0_7
  if (self.chipBattleData):RollbackChipBattle(chipHolder) then
    chipHolder:RemoveChip(self)
  end
end

ChipData.GetChipCfg = function(self)
  -- function num : 0_8
  return self.chipCfg
end

ChipData.GetMarkIconIndex = function(self)
  -- function num : 0_9
  return (self.chipCfg).icon
end

ChipData.GetChipMaxLevel = function(self)
  -- function num : 0_10
  return self:GetItemTopLimit()
end

ChipData.IsChipFullLevel = function(self)
  -- function num : 0_11
  do return self:GetChipMaxLevel() <= self:GetCount() end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

ChipData.GetChipRealLevel = function(self)
  -- function num : 0_12 , upvalues : _ENV
  return (math.min)(self:GetCount(), self:GetChipMaxLevel())
end

ChipData.GetChipInfo = function(self)
  -- function num : 0_13 , upvalues : _ENV
  return (LanguageUtil.GetLocaleText)((self.chipCfg).info)
end

ChipData.GetName = function(self)
  -- function num : 0_14 , upvalues : base
  local name = (base.GetName)(self)
  if self:IsCopyItem() then
    name = name .. "-" .. self.heroName
  end
  return name
end

ChipData.IsCopyItem = function(self)
  -- function num : 0_15
  return false
end

ChipData.SetIsShowTemp = function(self, bool)
  -- function num : 0_16
  self.isShowTemp = bool
end

ChipData.IsShowTemp = function(self)
  -- function num : 0_17
  return self.isShowTemp
end

ChipData.GetHeroName = function(self)
  -- function num : 0_18
  return self.heroName
end

ChipData.GetHeroID = function(self)
  -- function num : 0_19
  return self.heroId
end

ChipData.GetQuality = function(self)
  -- function num : 0_20 , upvalues : _ENV
  return ConfigData:GetChipQuality(self.__count)
end

ChipData.GetChipBuyPrice = function(self, epModuleId)
  -- function num : 0_21 , upvalues : _ENV
  local epTypeCfg = (ConfigData.exploration_type)[epModuleId]
  if epTypeCfg == nil then
    error("Cant get exploration_type cfg, epModuleId = " .. tostring(epModuleId))
    return 0
  end
  local level = (math.min)(self.__count, (ConfigData.buildinConfig).ChipMaxLevel)
  return (epTypeCfg.chip_level_price)[level] or 0
end

ChipData.GetChipFuncTag = function(self)
  -- function num : 0_22
  return (self.chipCfg).fun_tag
end

ChipData.GetChipDescription = function(self)
  -- function num : 0_23 , upvalues : _ENV
  local description = ""
  local num = self:GetCount()
  if #(self.chipCfg).skill_list > 0 then
    local skillId = ((self.chipCfg).skill_list)[1]
    local skillCfg = (((CS.GameData).instance).listBattleSkillDatas):GetDataById(skillId)
    if skillCfg == nil then
      error("Can\'t find skillCfg, id = " .. tostring(skillId))
    else
      description = skillCfg:GetLevelDescribe(num)
    end
  else
    do
      if #(self.chipCfg).attribute_id > 0 then
        local attrId = ((self.chipCfg).attribute_id)[1]
        local initValue = ((self.chipCfg).attribute_initial)[1]
        local fluenceIntro = ConfigData:GetChipinfluenceIntro((self.chipCfg).id)
        local increaseVal = ((self.chipCfg).level_increase)[1]
        local attrInfo = (BattleUtil.GetChipAttrInfo)(attrId, initValue, increaseVal, num)
        description = fluenceIntro .. attrInfo
      end
      do
        return description
      end
    end
  end
end

return ChipData

