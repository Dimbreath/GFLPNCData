-- params : ...
-- function num : 0 , upvalues : _ENV
local FormationData = class("FormationData")
local CommanderSkillModulaData = require("Game.CommanderSkill.CommanderSkillModulaData")
FormationData.ctor = function(self)
  -- function num : 0_0
end

FormationData.FromUserData = function(userFormation)
  -- function num : 0_1 , upvalues : FormationData
  local formation = (FormationData.New)()
  formation.id = userFormation.id
  formation.data = userFormation.data
  formation.name = userFormation.name
  if userFormation.cst ~= nil then
    formation.cst = userFormation.cst
    formation.userSkill = ((formation.cst).saving).skillActive
  end
  return formation
end

FormationData.FormMsgData = function(msgData)
  -- function num : 0_2 , upvalues : FormationData
  local formation = (FormationData.New)()
  formation.id = msgData.id
  formation.data = msgData.data
  formation.name = nil
  formation.userSkill = msgData.userSkill
  return formation
end

FormationData.FromCustomData = function(id, data, cstId, csList)
  -- function num : 0_3 , upvalues : FormationData, _ENV
  local formation = (FormationData.New)()
  formation.id = id
  formation.data = data
  formation.name = nil
  formation.userSkill = csList
  formation.cst = {treeId = cstId, 
saving = {
skillActive = {}
, 
skillProficient = {}
}
}
  for k,v in pairs(csList) do
    -- DECOMPILER ERROR at PC22: Confused about usage of register: R10 in 'UnsetPending'

    (((formation.cst).saving).skillActive)[k] = v
  end
  return formation
end

FormationData.CreateDefault = function(id)
  -- function num : 0_4 , upvalues : _ENV, FormationData
  local fmtHeroCount = ConfigData:GetFormationHeroCount()
  local formationData = {}
  for k,v in ipairs((ConfigData.game_config).first_formation) do
    if fmtHeroCount >= k then
      do
        (table.insert)(formationData, v)
        -- DECOMPILER ERROR at PC17: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC17: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  local formation = (FormationData.New)()
  formation.id = id
  formation.data = formationData
  local isCSUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_commander_skill)
  if isCSUnlock then
    formation.cst = (PlayerDataCenter.CommanderSkillModualData):CreatDefaultFormationCST(id)
    formation.userSkill = ((formation.cst).saving).skillActive
  end
  return formation
end

FormationData.Create = function(id)
  -- function num : 0_5 , upvalues : FormationData, _ENV
  local formation = (FormationData.New)()
  formation.id = id
  formation.data = {}
  local isCSUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_commander_skill)
  if isCSUnlock then
    formation.cst = (PlayerDataCenter.CommanderSkillModualData):CreatDefaultFormationCST(id)
    formation.userSkill = ((formation.cst).saving).skillActive
  end
  return formation
end

FormationData.CreateDefultCST = function(formId)
  -- function num : 0_6 , upvalues : _ENV
  local formation = (PlayerDataCenter.formationDic)[formId]
  formation.cst = (PlayerDataCenter.CommanderSkillModualData):CreatDefaultFormationCST(formId)
  formation.userSkill = ((formation.cst).saving).skillActive
end

FormationData.GetFmtCSTData = function(self)
  -- function num : 0_7 , upvalues : FormationData
  if self.cst == nil then
    (FormationData.CreateDefultCST)(self.id)
  end
  return self.cst
end

FormationData.IsIllegalCST = function(formId, change2Default)
  -- function num : 0_8 , upvalues : _ENV
  local formation = (PlayerDataCenter.formationDic)[formId]
  if formation.cst == nil or ((PlayerDataCenter.CommanderSkillModualData).CommanderSkillTreeDataDic)[(formation.cst).treeId] == nil then
    if change2Default then
      formation.cst = (PlayerDataCenter.CommanderSkillModualData):CreatDefaultFormationCST(formId)
      formation.userSkill = ((formation.cst).saving).skillActive
    end
    return true
  end
  return false
end

return FormationData

