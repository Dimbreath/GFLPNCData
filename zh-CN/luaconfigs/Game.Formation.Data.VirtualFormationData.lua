-- params : ...
-- function num : 0 , upvalues : _ENV
local VirtualFormationData = class("VirtualFormationData")
local FormationData = require("Game.PlayerData.FormationData")
VirtualFormationData.ctor = function(self, defalutFormationId, skillActive)
  -- function num : 0_0 , upvalues : FormationData, _ENV
  self.formation = (FormationData.FromCustomData)(0, {}, 1, {})
  local oriFormation = (PlayerDataCenter.formationDic)[defalutFormationId]
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R4 in 'UnsetPending'

  if oriFormation ~= nil and oriFormation.cst ~= nil then
    (self.formation).cst = (table.deepCopy)(oriFormation.cst)
  else
    -- DECOMPILER ERROR at PC29: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (self.formation).cst = (PlayerDataCenter.CommanderSkillModualData):CreatDefaultFormationCST(0, true)
  end
  -- DECOMPILER ERROR at PC38: Confused about usage of register: R4 in 'UnsetPending'

  if skillActive ~= nil and #skillActive > 0 then
    (((self.formation).cst).saving).skillActive = skillActive
  end
  self.buffIds = {}
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.formation).treeId = ((self.formation).cst).treeId
end

VirtualFormationData.SetFormation = function(self, formation)
  -- function num : 0_1
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.formation).data = formation
end

VirtualFormationData.SetBuffList = function(self, buffIds)
  -- function num : 0_2
  self.buffIds = buffIds
end

VirtualFormationData.SetCst = function(self, treeId, cst)
  -- function num : 0_3
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R3 in 'UnsetPending'

  (self.formation).cst = {treeId = treeId, saving = cst}
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.formation).treeId = treeId
end

return VirtualFormationData

