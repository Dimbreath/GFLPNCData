-- params : ...
-- function num : 0 , upvalues : _ENV
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

DynChipSuit.GetChipSuitMaxCount = function(self)
  -- function num : 0_3
  return (self.chipTagCfg).chip_max_count
end

DynChipSuit.GetChipSuitIconSprite = function(self)
  -- function num : 0_4 , upvalues : _ENV
  return CRH:GetSprite((self.chipTagCfg).tag_icon, CommonAtlasType.ExplorationIcon)
end

DynChipSuit.GetChipSuitName = function(self)
  -- function num : 0_5 , upvalues : _ENV
  return (LanguageUtil.GetLocaleText)((self.chipTagCfg).tag_name)
end

DynChipSuit.GetSuitChipList = function(self)
  -- function num : 0_6
  return (self.chipTagCfg).chip_list
end

DynChipSuit.UpdateChipSuitEffector = function(self, dynPlayer)
  -- function num : 0_7 , upvalues : _ENV, ChipBattleData, ExplorationEnum
  for _,tag_suit in pairs(self.tagSuitCfg) do
    if self.__count < tag_suit.number then
      local chipBattleData = (self.__suitLevel)[tag_suit.number]
      if chipBattleData ~= nil then
        local validRoleList = chipBattleData:GetValidRoleList(dynPlayer.heroList, eBattleRoleBelong.player)
        for k,role in pairs(validRoleList) do
          self:__RollBackSuitChip(chipBattleData, role)
        end
      end
    else
      do
        local chipBattleData = (self.__suitLevel)[tag_suit.number]
        if chipBattleData == nil then
          local chipCfg = (ConfigData.chip)[tag_suit.chip_id]
          chipBattleData = (ChipBattleData.New)(chipCfg, 1, (ExplorationEnum.eBattleSkillType).TempChip)
          local validRoleList = chipBattleData:GetValidRoleList(dynPlayer.heroList, eBattleRoleBelong.player)
          for k,role in pairs(validRoleList) do
            self:__ExecuteSuitChip(chipBattleData, role)
          end
          -- DECOMPILER ERROR at PC62: Confused about usage of register: R10 in 'UnsetPending'

          ;
          (self.__suitLevel)[tag_suit.number] = chipBattleData
        end
        do
          -- DECOMPILER ERROR at PC63: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC63: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC63: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
end

DynChipSuit.ClearChipSuitEffector = function(self, dynPlayer)
  -- function num : 0_8 , upvalues : _ENV
  if (table.count)(self.__suitLevel) <= 0 then
    return 
  end
  for k,chipBattleData in pairs(self.__suitLevel) do
    local validRoleList = chipBattleData:GetValidRoleList(dynPlayer.heroList, eBattleRoleBelong.player)
    for k,role in pairs(validRoleList) do
      self:__RollBackSuitChip(chipBattleData, role)
    end
  end
  self.__suitLevel = {}
end

DynChipSuit.ExecuteSuitChipForList = function(self, heroList)
  -- function num : 0_9 , upvalues : _ENV
  for k,chipBattleData in pairs(self.__suitLevel) do
    local validRoleList = chipBattleData:GetValidRoleList(heroList, eBattleRoleBelong.player)
    for k,role in pairs(validRoleList) do
      self:__ExecuteSuitChip(chipBattleData, role)
    end
  end
end

DynChipSuit.__ExecuteSuitChip = function(self, chipBattleData, role)
  -- function num : 0_10
  chipBattleData:ExecuteChipBattle(role)
end

DynChipSuit.__RollBackSuitChip = function(self, chipBattleData, role)
  -- function num : 0_11
  chipBattleData:RollbackChipBattle(role)
end

return DynChipSuit

