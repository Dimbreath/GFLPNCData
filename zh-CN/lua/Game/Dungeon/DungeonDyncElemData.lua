local DungeonDyncElemData = class("DungeonDyncElemData")
DungeonDyncElemData.CreateDefaultDungeonDyncElemData = function(moduleId)
  -- function num : 0_0 , upvalues : DungeonDyncElemData
  local msg = {moduleId = moduleId, idx = 0, 
selectedChipGroup = {}
, 
charHpPer = {}
, 
monsterHpPer = {}
, formId = 101, 
lastChipGroup = {}
, astDync = nil}
  local data = (DungeonDyncElemData.New)()
  data:_InitData(msg, true)
  return data
end

DungeonDyncElemData.ctor = function(self)
  -- function num : 0_1
end

DungeonDyncElemData._InitData = function(self, msg, isDailyDungeonNew)
  -- function num : 0_2 , upvalues : _ENV
  self.moduleId = msg.moduleId
  self.idx = msg.idx
  self.selectedChipGroup = msg.selectedChipGroup
  self.charHpPer = msg.charHpPer
  self.lastChipGroup = msg.lastChipGroup
  self.astDync = msg.astDync
  self.isDailyDungeonNew = isDailyDungeonNew
  local matDungeonCfg = (ConfigData.material_dungeon)[self.moduleId]
  if matDungeonCfg == nil then
    error("Cant get ConfigData.material_dungeon, id = " .. tostring(self.moduleId))
  end
  self.matDungeonCfg = matDungeonCfg
  self:_CheckLastChipGroup()
end

DungeonDyncElemData._CheckLastChipGroup = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local waitRemoveSuitIdDic = {}
  for suitId,v in pairs(self.lastChipGroup) do
    local curNum = (self.selectedChipGroup)[suitId] or 0
    local maxNum = ((self.matDungeonCfg).chipSuitNumMaxDic)[suitId]
    if maxNum == nil then
      error("Cant find chip suit, id:" .. tostring(suitId))
      waitRemoveSuitIdDic[suitId] = true
    else
      if maxNum <= curNum then
        waitRemoveSuitIdDic[suitId] = true
      end
    end
  end
  for suitId,v in pairs(waitRemoveSuitIdDic) do
    -- DECOMPILER ERROR at PC34: Confused about usage of register: R7 in 'UnsetPending'

    (self.lastChipGroup)[suitId] = nil
  end
end

DungeonDyncElemData.UpdDungeonDyncElemData = function(self, msg)
  -- function num : 0_4
  self:_InitData(msg)
end

DungeonDyncElemData.GetDungeonDyncHeroHpPer = function(self, heroData)
  -- function num : 0_5
  local hpPer = nil
  -- DECOMPILER ERROR at PC8: Unhandled construct in 'MakeBoolean' P1

  if heroData.isFriendSupport and self.astDync ~= nil then
    hpPer = (self.astDync).hpPer
  end
  hpPer = (self.charHpPer)[heroData.dataId]
  if not hpPer then
    hpPer = 10000
  end
  return hpPer
end

DungeonDyncElemData.HasDgDyncLastAstHero = function(self)
  -- function num : 0_6
  do return self.astDync ~= nil end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DungeonDyncElemData.GetDgDyncLastAstHeroHpPer = function(self)
  -- function num : 0_7
  if not self:HasDgDyncLastAstHero() then
    return 0
  end
  return (self.astDync).hpPer
end

DungeonDyncElemData.GetDgDyncAscHeroData = function(self)
  -- function num : 0_8 , upvalues : _ENV
  if self.astDync == nil then
    error("self.astDync is nil")
    return nil
  end
  return (self.astDync).brief, (self.astDync).random
end

DungeonDyncElemData.IsDgDyncComplete = function(self)
  -- function num : 0_9
  local allNum = #(self.matDungeonCfg).stage_id
  local completeAll = allNum == self.idx
  do return completeAll end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DungeonDyncElemData.SetDgDyncElemLastChipGroup = function(self, lastChipGroup)
  -- function num : 0_10
  self.lastChipGroup = lastChipGroup
end

DungeonDyncElemData.GetDgDyncElemName = function(self)
  -- function num : 0_11 , upvalues : _ENV
  local name = (LanguageUtil.GetLocaleText)((self.matDungeonCfg).name)
  return name
end

return DungeonDyncElemData

