local VirtualFormationData = class("VirtualFormationData")
local FormationData = require("Game.PlayerData.FormationData")
local CommanderSkillTreeData = require("Game.CommanderSkill.CommanderSkillTreeData")
VirtualFormationData.ctor = function(self, treeId, skillActive, specificHeroDataRuler)
  -- function num : 0_0 , upvalues : FormationData, _ENV, CommanderSkillTreeData
  self.formation = (FormationData.FromCustomData)(0, {}, 1, {})
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.formation).isVirtualFormation = true
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.formation).specificHeroDataRuler = specificHeroDataRuler
  local oriFormation = (PlayerDataCenter.formationDic)[1]
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R5 in 'UnsetPending'

  if treeId ~= nil and (ConfigData.commander_skill)[treeId] ~= nil then
    (self.formation).cst = (CommanderSkillTreeData.New)(treeId)
    ;
    ((self.formation).cst):ApplySavingData(skillActive)
  else
    -- DECOMPILER ERROR at PC35: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (self.formation).cst = oriFormation:GetFmtCSTData()
  end
  self.buffIds = {}
end

VirtualFormationData.TryRestoreFormation = function(self)
  -- function num : 0_1 , upvalues : _ENV
  local saveUserData = PersistentManager:GetDataModel((PersistentConfig.ePackage).UserData)
  if not saveUserData:GetLastWeeklyChallengeFmt() then
    local weeklyFmt = {}
  end
  for k,lastHeroid in pairs(weeklyFmt) do
    if not (table.contain)(((self.formation).specificHeroDataRuler).heroIds, lastHeroid) then
      weeklyFmt = {}
      break
    end
  end
  do
    ;
    (self.formation):CleanFormation()
    for index,heroId in pairs(weeklyFmt) do
      (self.formation):SetHero2Formation(index, heroId)
    end
  end
end

VirtualFormationData.SetFormation = function(self, formation)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.formation).data = formation
end

VirtualFormationData.SetBuffList = function(self, buffIds)
  -- function num : 0_3
  self.buffIds = buffIds
end

VirtualFormationData.SetCst = function(self, cst)
  -- function num : 0_4
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.formation).cst = cst
end

VirtualFormationData.GetCstTreeId = function(self)
  -- function num : 0_5
  return ((self.formation).cst).treeId
end

VirtualFormationData.GetSctSkills = function(self)
  -- function num : 0_6
  return ((self.formation).cst):GetUsingCmdSkillList()
end

return VirtualFormationData

