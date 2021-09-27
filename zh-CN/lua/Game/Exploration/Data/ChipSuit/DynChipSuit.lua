local DynChipSuit = class("DynChipSuit")
local ChipBattleData = require("Game.PlayerData.Item.ChipBattleData")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
DynChipSuit.ctor = function(self, tagId, count)
  -- function num : 0_0 , upvalues : _ENV
  self.tagId = tagId
  self.__count = count
  local chipTagCfg = (ConfigData.chip_tag)[tagId]
  self.chipTagCfg = chipTagCfg
  local tagSuitCfg = ((ConfigData.chip_tag).tag_suits)[tagId]
  self.tagSuitCfg = tagSuitCfg
  self.__suitLevel = {}
end

DynChipSuit.GetChipSuitCount = function(self)
  -- function num : 0_1
  return self.__count
end

DynChipSuit.AddChipSuitCount = function(self, offset)
  -- function num : 0_2
  self.__count = self.__count + offset
end

DynChipSuit.SetChipSuitCount = function(self, count)
  -- function num : 0_3
  self.__count = count
end

DynChipSuit.GetChipSuitMaxCount = function(self)
  -- function num : 0_4
  return (self.chipTagCfg).chip_max_count
end

DynChipSuit.GetChipSuitIconSprite = function(self)
  -- function num : 0_5 , upvalues : _ENV
  return CRH:GetSprite((self.chipTagCfg).tag_icon, CommonAtlasType.ExplorationIcon)
end

DynChipSuit.GetChipSuitName = function(self)
  -- function num : 0_6 , upvalues : _ENV
  return (LanguageUtil.GetLocaleText)((self.chipTagCfg).tag_name)
end

DynChipSuit.GetSuitChipList = function(self)
  -- function num : 0_7
  return (self.chipTagCfg).chip_list
end

DynChipSuit.GetSuitChipInfluence = function(self)
  -- function num : 0_8
  return (self.chipTagCfg).influence
end

DynChipSuit.UpdateChipSuitEffector = function(self, dynPlayer)
  -- function num : 0_9 , upvalues : _ENV, ChipBattleData
  for _,tag_suit in pairs(self.tagSuitCfg) do
    if self.__count < tag_suit.number then
      local chipBattleData = (self.__suitLevel)[tag_suit.number]
      if chipBattleData ~= nil then
        self:__RollBackSuitChip(chipBattleData, dynPlayer)
      end
      -- DECOMPILER ERROR at PC19: Confused about usage of register: R8 in 'UnsetPending'

      ;
      (self.__suitLevel)[tag_suit.number] = nil
    else
      do
        local chipBattleData = (self.__suitLevel)[tag_suit.number]
        do
          if chipBattleData == nil then
            local chipCfg = (ConfigData.chip)[tag_suit.chip_id]
            chipBattleData = (ChipBattleData.New)(chipCfg, 1, eBattleSkillLogicType.TempChip)
            self:__ExecuteSuitChip(chipBattleData, dynPlayer)
            -- DECOMPILER ERROR at PC43: Confused about usage of register: R9 in 'UnsetPending'

            ;
            (self.__suitLevel)[tag_suit.number] = chipBattleData
          end
          -- DECOMPILER ERROR at PC44: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC44: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC44: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
end

DynChipSuit.ClearChipSuitEffector = function(self, dynPlayer)
  -- function num : 0_10 , upvalues : _ENV
  if (table.count)(self.__suitLevel) <= 0 then
    return 
  end
  for k,chipBattleData in pairs(self.__suitLevel) do
    self:__RollBackSuitChip(chipBattleData, dynPlayer)
  end
  self.__suitLevel = {}
end

DynChipSuit.ExecuteSuitChipForList = function(self, heroList)
  -- function num : 0_11 , upvalues : _ENV
  for k,chipBattleData in pairs(self.__suitLevel) do
    local validRoleList = chipBattleData:GetValidRoleList(heroList, eBattleRoleBelong.player)
    for k,role in pairs(validRoleList) do
      chipBattleData:ExecuteChipBattle(role)
    end
  end
end

DynChipSuit.__ExecuteSuitChip = function(self, chipBattleData, dynPlayer)
  -- function num : 0_12 , upvalues : _ENV
  if chipBattleData:IsValidDynPlayer() then
    chipBattleData:ExecuteChipBattle(dynPlayer)
  else
    local validRoleList = chipBattleData:GetValidRoleList(dynPlayer.heroList, eBattleRoleBelong.player)
    for k,role in pairs(validRoleList) do
      chipBattleData:ExecuteChipBattle(role)
    end
  end
end

DynChipSuit.__RollBackSuitChip = function(self, chipBattleData, dynPlayer)
  -- function num : 0_13 , upvalues : _ENV
  if chipBattleData:IsValidDynPlayer() then
    chipBattleData:RollbackChipBattle(dynPlayer)
  else
    local validRoleList = chipBattleData:GetValidRoleList(dynPlayer.heroList, eBattleRoleBelong.player)
    for k,role in pairs(validRoleList) do
      chipBattleData:RollbackChipBattle(role)
    end
  end
end

DynChipSuit.GetActivatedAffixCount = function(self)
  -- function num : 0_14 , upvalues : _ENV
  return (table.count)(self.__suitLevel)
end

return DynChipSuit

