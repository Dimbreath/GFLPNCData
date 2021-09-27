local FormationData = class("FormationData")
local CommanderSkillTreeData = require("Game.CommanderSkill.CommanderSkillTreeData")
FormationData.ctor = function(self)
  -- function num : 0_0
end

FormationData.FromUserData = function(userFormation)
  -- function num : 0_1 , upvalues : FormationData
  local formation = (FormationData.New)()
  formation.id = userFormation.id
  formation.data = userFormation.data
  formation.name = userFormation.name
  formation:ModifyCSTData(userFormation.savingTree)
  return formation
end

FormationData.FormMsgData = function(msgData)
  -- function num : 0_2 , upvalues : FormationData
  local formation = (FormationData.New)()
  formation.id = msgData.id
  formation.data = msgData.data
  formation.name = nil
  formation:ModifyCSTData(msgData.savingTree)
  return formation
end

FormationData.FromCustomData = function(id, data, cstId, csList)
  -- function num : 0_3 , upvalues : FormationData, CommanderSkillTreeData
  local formation = (FormationData.New)()
  formation.id = id
  formation.data = data
  formation.name = nil
  formation.userSkill = csList
  formation.cst = (CommanderSkillTreeData.New)(cstId)
  ;
  (formation.cst):ApplySavingData(csList)
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
    formation:__CreateDefaultCSTByFormation()
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
    formation:__CreateDefaultCSTByFormation()
  end
  return formation
end

FormationData.CreateDefultCST = function(formId)
  -- function num : 0_6 , upvalues : _ENV
  local formation = (PlayerDataCenter.formationDic)[formId]
  formation:__CreateDefaultCSTByFormation()
end

FormationData.IsIllegalCST = function(self, change2Default)
  -- function num : 0_7 , upvalues : _ENV, CommanderSkillTreeData
  local isUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_commander_skill)
  if not isUnlock then
    return false
  end
  local illMark = false
  if self.cst == nil or (self.cst).treeCfg == nil then
    illMark = true
  end
  if not illMark then
    local skills = (self.cst):GetUsingCmdSkillList()
    for _,skillId in ipairs(skills) do
      local cmdSkillData = ((self.cst).commanderSkillDataDic)[skillId]
      if cmdSkillData == nil or not cmdSkillData:IsCmdSkillUnlock() then
        illMark = true
        break
      end
    end
  end
  do
    if not illMark then
      local skillSlots = (self.cst).slotSkillList
      for slot,skillId in ipairs(skillSlots) do
        if skillId == 0 then
          local defaultSkillId = (((self.cst).slotSkillOverloadList)[slot])[1]
          if defaultSkillId ~= nil and (((self.cst).commanderSkillDataDic)[defaultSkillId]):IsCmdSkillUnlock() then
            illMark = true
            break
          end
        end
      end
    end
    do
      if not illMark then
        return false
      end
      if change2Default then
        if self.cst == nil or (self.cst).treeCfg == nil then
          local defaultTreeId = (ConfigData.game_config).FormationDefaultCommanderSkillTree
          self.cst = (CommanderSkillTreeData.New)(defaultTreeId)
        else
          do
            local fixSkills = {}
            do
              local skillSlots = (self.cst).slotSkillList
              for slot,skillId in ipairs(skillSlots) do
                skillId = skillId ~= 0 or (((self.cst).slotSkillOverloadList)[slot])[1] or 0
                local cmdSkillData = ((self.cst).commanderSkillDataDic)[skillId]
                if cmdSkillData ~= nil and cmdSkillData:IsCmdSkillUnlock() then
                  (table.insert)(fixSkills, skillId)
                end
              end
              ;
              (self.cst):ApplySavingData(fixSkills)
              return true
            end
          end
        end
      end
    end
  end
end

FormationData.__CreateDefaultCSTByFormation = function(self)
  -- function num : 0_8 , upvalues : _ENV, CommanderSkillTreeData
  local defaultTreeId = (ConfigData.game_config).FormationDefaultCommanderSkillTree
  self.cst = (CommanderSkillTreeData.New)(defaultTreeId)
  local treeId = (self.cst).treeId
  local skills = (self.cst):GetUsingCmdSkillList()
  ;
  (NetworkManager:GetNetwork(NetworkTypeID.CommanderSkill)):CS_COMMANDSKILL_SaveFromFormation(self.id, treeId, skills)
end

FormationData.GetFmtCSTData = function(self)
  -- function num : 0_9
  if self.cst == nil then
    self:__CreateDefaultCSTByFormation()
  end
  return self.cst
end

FormationData.ModifyCSTData = function(self, cstTreeData)
  -- function num : 0_10 , upvalues : CommanderSkillTreeData
  if cstTreeData == nil then
    self.cst = nil
    return 
  end
  if self.cst == nil or (self.cst).treeId ~= cstTreeData.id then
    self.cst = (CommanderSkillTreeData.New)(cstTreeData.id)
  end
  ;
  (self.cst):ApplySavingData(cstTreeData.skills)
end

FormationData.ModifyFormationData = function(self, formationData, newHeroDic)
  -- function num : 0_11 , upvalues : _ENV
  if formationData ~= nil then
    self:CleanFormation()
    for index,heroId in pairs(formationData:GetFormationHeroList(true)) do
      self:SetHero2Formation(index, heroId)
    end
    self.isHaveSupport = formationData.isHaveSupport
    self.suooprtHeroData = formationData.suooprtHeroData
    self.__suooprtHeroData = formationData.__suooprtHeroData
  else
    if newHeroDic ~= nil then
      self:CleanFormation()
      for index,heroId in pairs(newHeroDic) do
        self:SetHero2Formation(index, heroId)
      end
    end
  end
end

FormationData.SetHero2Formation = function(self, index, heroId)
  -- function num : 0_12
  if self.isHaveSupport and (self.suooprtHeroData).formIdx == index then
    self:CleanSupportData()
  end
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.data)[index] = heroId
end

FormationData.Exchange2Hero = function(self, index1, index2)
  -- function num : 0_13
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

  if self.isHaveSupport then
    if (self.suooprtHeroData).formIdx == index1 then
      (self.data)[index1] = (self.data)[index2]
      -- DECOMPILER ERROR at PC12: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (self.data)[index2] = nil
      -- DECOMPILER ERROR at PC14: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (self.suooprtHeroData).formIdx = index2
      return 
    end
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R3 in 'UnsetPending'

    if (self.suooprtHeroData).formIdx == index2 then
      (self.data)[index2] = (self.data)[index1]
      -- DECOMPILER ERROR at PC25: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (self.data)[index1] = nil
      -- DECOMPILER ERROR at PC27: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (self.suooprtHeroData).formIdx = index1
      return 
    end
  end
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R4 in 'UnsetPending'

  -- DECOMPILER ERROR at PC36: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.data)[index2] = (self.data)[index1]
end

FormationData.CleanFormation = function(self)
  -- function num : 0_14
  self:CleanSupportData()
  self.data = {}
end

FormationData.GetFormationHeroList = function(self, isNotNeedSupport)
  -- function num : 0_15 , upvalues : _ENV
  if self._fixedHeroIdList ~= nil then
    return self._fixedHeroIdList
  end
  do
    if self.isHaveSupport and not isNotNeedSupport then
      local data = {}
      for key,value in pairs(self.data) do
        data[key] = value
      end
      data[(self.suooprtHeroData).formIdx] = (self.suooprtHeroData).heroId
      return data
    end
    return self.data
  end
end

FormationData.GetFormationHeroData = function(self, index)
  -- function num : 0_16 , upvalues : _ENV
  if self._fixedHeroList ~= nil then
    return (self._fixedHeroList)[index]
  end
  local heroId = nil
  if self.isHaveSupport and (self.suooprtHeroData).formIdx == index then
    return self.__suooprtHeroData
  else
    heroId = (self.data)[index]
  end
  if heroId == nil then
    return 
  end
  if self.specificHeroDataRuler ~= nil then
    return (PlayerDataCenter.specialRuleGenerator):GetSpecificHeroData(heroId, self.specificHeroDataRuler)
  end
  return PlayerDataCenter:GetHeroData(heroId)
end

FormationData.SetSupportHeroData = function(self, suooprtHeroData, index, useLast)
  -- function num : 0_17
  if self.suooprtHeroData == nil then
    self.suooprtHeroData = {}
  end
  self.isHaveSupport = true
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.data)[index] = nil
  self.__suooprtHeroData = suooprtHeroData
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.suooprtHeroData).formIdx = index
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R4 in 'UnsetPending'

  if not useLast then
    (self.suooprtHeroData).uid = (suooprtHeroData:GetUserInfo()):GetUserUID()
  end
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.suooprtHeroData).heroId = suooprtHeroData.dataId
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.suooprtHeroData).useLast = useLast
end

FormationData.GetSupportHeroData = function(self)
  -- function num : 0_18
  if self.isHaveSupport then
    return self.suooprtHeroData
  end
end

FormationData.GetRealSupportHeroData = function(self)
  -- function num : 0_19
  if self.isHaveSupport then
    return self.__suooprtHeroData
  end
end

FormationData.CleanSupportData = function(self)
  -- function num : 0_20
  self.isHaveSupport = false
  self.__suooprtHeroData = nil
  self.suooprtHeroData = nil
end

FormationData.GetCstSkillList = function(self)
  -- function num : 0_21
  if self.cst == nil or not (self.cst):GetUsingCmdSkillList() then
    return {}
  end
end

FormationData.GetIsOnlyHaveSupportHero = function(self)
  -- function num : 0_22 , upvalues : _ENV
  if not self.isHaveSupport then
    return false
  end
  local count = 0
  for _,_ in pairs(self:GetFormationHeroList()) do
    count = count + 1
    if count >= 2 then
      return false
    end
  end
  return true
end

FormationData.SetFmtFixedHeroList = function(self, heroList, heroIdList)
  -- function num : 0_23
  self._fixedHeroList = heroList
  self._fixedHeroIdList = heroIdList
end

FormationData.ClearFmtFixedHero = function(self)
  -- function num : 0_24
  self._fixedHeroList = nil
  self._fixedHeroIdList = nil
end

return FormationData

