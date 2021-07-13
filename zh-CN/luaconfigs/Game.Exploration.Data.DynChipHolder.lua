-- params : ...
-- function num : 0 , upvalues : _ENV
local DynChipHolder = class("DynChipHolder")
DynChipHolder.ctor = function(self)
  -- function num : 0_0
  self.__ownedChips = {}
  self.__chipEffector = {}
  self.__itemSkillDic = {}
end

DynChipHolder.GetOwnedChips = function(self)
  -- function num : 0_1
  return self.__ownedChips
end

DynChipHolder.GetOwnedChipsById = function(self, chipId)
  -- function num : 0_2 , upvalues : _ENV
  for chipData,v in pairs(self.__ownedChips) do
    if chipData.dataId == chipId then
      return chipData
    end
  end
  error("Can\'t Get OwnedChips By Id, id = " .. tostring(chipId))
end

DynChipHolder.ContainChip = function(self, chipData)
  -- function num : 0_3
  local contain = (self.__ownedChips)[chipData] ~= nil
  do return contain end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DynChipHolder.AddChip = function(self, chipData)
  -- function num : 0_4
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.__ownedChips)[chipData] = true
end

DynChipHolder.RemoveChip = function(self, chipData)
  -- function num : 0_5
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.__ownedChips)[chipData] = nil
end

DynChipHolder.ContainChipEffector = function(self, chipBattle)
  -- function num : 0_6
  local contain = (self.__chipEffector)[chipBattle] ~= nil
  do return contain end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DynChipHolder.AddChipEffector = function(self, chipBattle)
  -- function num : 0_7
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.__chipEffector)[chipBattle] = true
end

DynChipHolder.RemoveChipEffector = function(self, chipBattle)
  -- function num : 0_8
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.__chipEffector)[chipBattle] = nil
end

DynChipHolder.GetItemSkillList = function(self)
  -- function num : 0_9 , upvalues : _ENV
  local skillList = {}
  local skillDic = {}
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
  return skillList
end

DynChipHolder.GetItemSkillDic = function(self)
  -- function num : 0_10
  return self.__itemSkillDic
end

DynChipHolder.AddItemSkill = function(self, dynSkill)
  -- function num : 0_11
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.__itemSkillDic)[dynSkill] = true
end

DynChipHolder.RemoveItemSkill = function(self, dynSkill)
  -- function num : 0_12
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.__itemSkillDic)[dynSkill] = nil
end

DynChipHolder.OffsetAttrFromChip = function(self, property, value)
  -- function num : 0_13
end

return DynChipHolder

