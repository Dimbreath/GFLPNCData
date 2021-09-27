local CommonMonsterCasterSkill = class("CommonMonsterCasterSkill", LuaSkillBase)
local Stack = require("Framework.Lib.Stack")
local base = LuaSkillBase
CommonMonsterCasterSkill.config = {effectId1 = 10263, startAnimId = 1002, buffId_196 = 196, buffId_1033 = 1033, buffId_175 = 175, buffId_286 = 286, buffId_88 = 88, skill_time = 18, buffId_1191 = 1191, buffId_513101 = 513101, abandonMoveBuff = 1196, casterWaveInterval = 375, countDownDuration = 45, latestAtkEffect = 10107, monsterBornInterval = 38, routeMonsterId = 55555, route_monster_buff = 1201, callNextBtnRewardFormula = 10167, campNotBeSelectBuff = 50}
CommonMonsterCasterSkill.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_0 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "CommonMonsterCasterSkill_start", 1, self.OnAfterBattleStart)
  self:AddTrigger(eSkillTriggerType.RoleDie, "CommonMonsterCasterSkill_roleDie", 1, self.OnRoleDie)
  self:AddTrigger(eSkillTriggerType.OnCallNextWaveTowerMonster, "CommonMonsterCasterSkill_nextWave", 1, self.OnNextWave)
  self.aliveMonsterList = {}
end

CommonMonsterCasterSkill.OnNextWave = function(self)
  -- function num : 0_1 , upvalues : _ENV
  if #self.aliveMonsterList > 0 or self.maxWave <= self.waveRound or (self.maxIndexPerWave)[self.waveRound] > 0 and self.totalRoleCount <= 0 then
    return 
  end
  if self.loopCasterTimer ~= nil then
    local lastLeft = (self.loopCasterTimer).left
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self.loopCasterTimer).left = 0
    self.nextReward = self.nextWaveRewardArg * lastLeft // 1000
    if self.nextReward > 0 then
      LuaSkillCtrl:AddPlayerTowerMp(self.nextReward)
    end
    MsgCenter:Broadcast(eMsgEventId.TDNextClickActive, false)
  end
end

CommonMonsterCasterSkill.OnRoleDie = function(self, killer, role, killSkill)
  -- function num : 0_2 , upvalues : _ENV
  if role.belongNum == (self.caster).belongNum then
    (table.removebyvalue)(self.aliveMonsterList, role)
    local reward = LuaSkillCtrl:GetTDMosterDieReward(role)
    if reward == 0 then
      return 
    end
    LuaSkillCtrl:AddPlayerTowerMp(reward)
  end
  do
    if #self.aliveMonsterList > 0 or self.maxWave <= self.waveRound or (self.maxIndexPerWave)[self.waveRound] > 0 or self.totalRoleCount <= 0 then
      return 
    end
    if self.loopCasterTimer or not 0 then
      local leftTime = (self.loopCasterTimer).left
    end
    self.nextReward = self.nextWaveRewardArg * leftTime // 1000
    if self.nextReward > 40 then
      self.nextReward = 40
    end
    local curFrame = (LuaSkillCtrl.battleCtrl).frame
    if self:IsCanCallNextActive() then
      MsgCenter:Broadcast(eMsgEventId.TDNextClickActive, true, self.nextReward, self.nextWaveRewardArg)
    end
  end
end

CommonMonsterCasterSkill.OnAfterBattleStart = function(self)
  -- function num : 0_3 , upvalues : _ENV
  self.nextWaveRewardArg = LuaSkillCtrl:CallFormulaNumber((self.config).callNextBtnRewardFormula, self.caster, self.caster)
  LuaSkillCtrl:CallSetPlayerTowerMpIncreasedSpeed(400)
  self:MakeUpCampRole()
  self:MakeUpWaitToCasterMonsters()
  self.waveRound = 0
  self.loopCasterTimer = LuaSkillCtrl:StartTimer(nil, (self.config).casterWaveInterval, self.LoopCaster, self, -1, (self.config).casterWaveInterval)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_1033, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_196, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_88, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_175, 1, nil, true)
end

CommonMonsterCasterSkill.MakeUpWaitToCasterMonsters = function(self)
  -- function num : 0_4 , upvalues : _ENV, Stack
  local monsters = LuaSkillCtrl:GetAllWaitToCasteMonsters()
  local tempMonsters = {}
  self.curMonsters = {}
  self.maxIndexPerWave = {}
  self.tagRoute = {}
  self.totalRoleCount = monsters.Count
  self.maxRoleCount = monsters.Count
  self.maxWave = 0
  for i = 0, monsters.Count - 1 do
    local wave = (monsters[i]).roleWave // 10
    local index = (monsters[i]).roleWave % (wave * 10)
    local roleTag = (monsters[i]).roleTag
    -- DECOMPILER ERROR at PC34: Confused about usage of register: R10 in 'UnsetPending'

    if (self.tagRoute)[roleTag] == nil then
      (self.tagRoute)[roleTag] = false
    end
    -- DECOMPILER ERROR at PC41: Confused about usage of register: R10 in 'UnsetPending'

    if (self.curMonsters)[roleTag] == nil then
      (self.curMonsters)[roleTag] = {}
    end
    -- DECOMPILER ERROR at PC50: Confused about usage of register: R10 in 'UnsetPending'

    if ((self.curMonsters)[roleTag])[wave] == nil then
      ((self.curMonsters)[roleTag])[wave] = {}
    end
    -- DECOMPILER ERROR at PC56: Confused about usage of register: R10 in 'UnsetPending'

    if (self.maxIndexPerWave)[wave] == nil then
      (self.maxIndexPerWave)[wave] = 0
    end
    -- DECOMPILER ERROR at PC62: Confused about usage of register: R10 in 'UnsetPending'

    if (self.maxIndexPerWave)[wave] < index then
      (self.maxIndexPerWave)[wave] = index
    end
    if self.maxWave < wave then
      self.maxWave = wave
    end
    local roleModel = {role = monsters[i], index = index, wave = wave}
    ;
    (table.insert)(((self.curMonsters)[roleTag])[wave], roleModel)
  end
  for tempTag = 1, self.maxTag do
    for tempWave = 1, self.maxWave do
      if ((self.curMonsters)[tempTag])[tempWave] ~= nil then
        (table.sort)(((self.curMonsters)[tempTag])[tempWave], function(a, b)
    -- function num : 0_4_0
    do return b.index < a.index end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
        local tempRoles = ((self.curMonsters)[tempTag])[tempWave]
        -- DECOMPILER ERROR at PC107: Confused about usage of register: R12 in 'UnsetPending'

        ;
        ((self.curMonsters)[tempTag])[tempWave] = (Stack.New)()
        for _,v in ipairs(tempRoles) do
          (((self.curMonsters)[tempTag])[tempWave]):Push(v)
        end
      end
    end
  end
end

CommonMonsterCasterSkill.MakeUpCampRole = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local campRoles = LuaSkillCtrl:GetAllPlayerDungeonRoles()
  self.allCampRoles = {}
  self.maxTag = 0
  for i = 0, campRoles.Count - 1 do
    LuaSkillCtrl:CallBuff(self, campRoles[i], (self.config).campNotBeSelectBuff, 1, nil, true)
    local roleTag = LuaSkillCtrl:GetRoleTag(campRoles[i])
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self.allCampRoles)[roleTag] = campRoles[i]
    if self.maxTag < roleTag then
      self.maxTag = roleTag
    end
  end
end

CommonMonsterCasterSkill.GetWaveRoles = function(self, wave)
  -- function num : 0_6
  local roles = (self.allWaveMonsters)[wave]
  return roles
end

CommonMonsterCasterSkill.GetCampRole = function(self, camp)
  -- function num : 0_7
  local role = (self.allCampRoles)[camp]
  return role
end

CommonMonsterCasterSkill.LoopCaster = function(self)
  -- function num : 0_8 , upvalues : _ENV
  if self:IsCanCallNextActive() then
    MsgCenter:Broadcast(eMsgEventId.TDNextCountDown, (self.loopCasterTimer).left)
  end
  self:ClearLastWaveCaster()
  MsgCenter:Broadcast(eMsgEventId.TDNextClickActive, false)
  self.waveRound = self.waveRound + 1
  local callRealCaster = BindCallback(self, self.CallRealCaster)
  LuaSkillCtrl:CallRoleAction(self.caster, (self.config).startAnimId, 1)
  LuaSkillCtrl:StartTimer(self, (self.config).skill_time, callRealCaster)
end

CommonMonsterCasterSkill.ClearLastWaveCaster = function(self)
  -- function num : 0_9
  if self.casteForEachTagTimer ~= nil then
    (self.casteForEachTagTimer):Stop()
    self.casteForEachTagTimer = nil
  end
  if self.waveRound <= 0 then
    return 
  end
  for i = 1, self.maxTag do
    if ((self.curMonsters)[i])[self.waveRound] ~= nil then
      local count = (((self.curMonsters)[i])[self.waveRound]):Count()
      if count > 0 then
        (((self.curMonsters)[i])[self.waveRound]):Clear()
      end
      self.totalRoleCount = self.totalRoleCount - count
    end
  end
  -- DECOMPILER ERROR at PC41: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.maxIndexPerWave)[self.waveRound] = 0
end

CommonMonsterCasterSkill.CallRealCaster = function(self)
  -- function num : 0_10 , upvalues : _ENV
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId1, self)
  do
    if self.aliveMonsterList ~= nil then
      local aliveRoleCount = #self.aliveMonsterList
      if aliveRoleCount > 0 then
        for i = 1, aliveRoleCount do
          local role = (self.aliveMonsterList)[i]
          if role ~= nil and role.hp > 0 then
            LuaSkillCtrl:CallBuff(self, role, (self.config).abandonMoveBuff, 1, (self.config).countDownDuration, true)
          end
        end
        LuaSkillCtrl:StartTimer(nil, (self.config).countDownDuration, BindCallback(self, self.KillAllMonsterAndDamageToCamp, self.aliveMonsterList))
        self.aliveMonsterList = {}
      end
    end
    if self.maxTag <= 0 then
      return 
    end
    local loopCasterCount = (self.maxIndexPerWave)[self.waveRound]
    if loopCasterCount > 0 and self.totalRoleCount > 0 then
      self.casteForEachTagTimer = LuaSkillCtrl:StartTimer(nil, (self.config).monsterBornInterval, (BindCallback(self, self.CasteMonsterForeach)), nil, -1, (self.config).monsterBornInterval)
    end
    if self.maxWave <= self.waveRound and self.loopCasterTimer ~= nil then
      (self.loopCasterTimer):Stop()
      self.loopCasterTimer = nil
    end
  end
end

CommonMonsterCasterSkill.CasteMonsterForeach = function(self)
  -- function num : 0_11 , upvalues : _ENV
  if (self.maxIndexPerWave)[self.waveRound] <= 0 then
    (self.casteForEachTagTimer):Stop()
    self.casteForEachTagTimer = nil
    return 
  end
  for curTag = 1, self.maxTag do
    local campRole = self:GetCampRole(curTag)
    if campRole ~= nil then
      local tempMonsterStack = ((self.curMonsters)[curTag])[self.waveRound]
      if tempMonsterStack ~= nil and tempMonsterStack:Count() > 0 then
        local tempMonsterData = tempMonsterStack:Peek()
        if not (self.tagRoute)[curTag] then
          local routeSummoner = LuaSkillCtrl:CreateSummoner(self, (self.config).routeMonsterId, (tempMonsterData.role).x, (tempMonsterData.role).y)
          routeSummoner:SetAttr(eHeroAttr.maxHp, 100)
          routeSummoner:SetAsRealEntity(7)
          local routeSummonerEntity = LuaSkillCtrl:AddSummonerRole(routeSummoner)
          routeSummonerEntity:SetRoleMoveFollowTarget(campRole, true, true)
          LuaSkillCtrl:CallBuff(self, routeSummonerEntity, (self.config).route_monster_buff, 1, 99, true)
          -- DECOMPILER ERROR at PC73: Confused about usage of register: R10 in 'UnsetPending'

          ;
          (self.tagRoute)[curTag] = true
        else
          do
            local role = LuaSkillCtrl:CreateTDMonster(tempMonsterData.role, self, campRole)
            do
              if role ~= nil then
                local bloodNum = (tempMonsterData.role):GetBossBloodNum()
                -- DECOMPILER ERROR at PC89: Confused about usage of register: R10 in 'UnsetPending'

                if bloodNum > 0 then
                  (role.recordTable).isTowerBoss = true
                end
                tempMonsterStack:Pop()
                -- DECOMPILER ERROR at PC98: Confused about usage of register: R10 in 'UnsetPending'

                ;
                (self.maxIndexPerWave)[self.waveRound] = (self.maxIndexPerWave)[self.waveRound] - 1
                self.totalRoleCount = self.totalRoleCount - 1
                self:OnMonsterCastered(role)
                ;
                (table.insert)(self.aliveMonsterList, role)
              end
              -- DECOMPILER ERROR at PC110: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC110: LeaveBlock: unexpected jumping out IF_ELSE_STMT

              -- DECOMPILER ERROR at PC110: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC110: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC110: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC110: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC110: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
    end
  end
end

CommonMonsterCasterSkill.OnMonsterCastered = function(self, role)
  -- function num : 0_12 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, role, (self.config).buffId_286, 1, nil, true)
  if self.totalRoleCount <= 0 then
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId_88, 0)
    LuaSkillCtrl:RemoveLife((self.caster).hp + 1, self, self.caster, false, nil, true, true)
  end
end

CommonMonsterCasterSkill.KillAllMonsterAndDamageToCamp = function(self, monsters)
  -- function num : 0_13 , upvalues : _ENV
  for i = 1, #monsters do
    local monster = monsters[i]
    if monster ~= nil then
      local campRole = self:GetCampRole(monster:GetRoleTag())
      if campRole ~= nil then
        LuaSkillCtrl:CallEffectWithArgAndSpeedOverride(campRole, (self.config).latestAtkEffect, self, monster, 1, false, false, self.EffectEventTrigger, monster)
      end
    end
  end
end

CommonMonsterCasterSkill.EffectEventTrigger = function(self, monster, effect, eventId, target)
  -- function num : 0_14 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local targetRole = target.targetRole
    if targetRole ~= nil and targetRole.hp > 0 then
      LuaSkillCtrl:RemoveLife(targetRole.maxHp // 8 + 1, self, target, true, nil, true, true)
    end
    if monster.hp > 0 then
      LuaSkillCtrl:RemoveLife(monster.hp + 1, self, monster, true, nil, true, true)
    end
  end
end

CommonMonsterCasterSkill.OnCasterDie = function(self)
  -- function num : 0_15
  if self.CallSummoner then
    (self.CallSummoner):Stop()
    self.CallSummoner = nil
  end
end

CommonMonsterCasterSkill.IsCanCallNextActive = function(self)
  -- function num : 0_16 , upvalues : _ENV
  do return (self.maxWave > 1 and self.waveRound < self.maxWave and not LuaSkillCtrl.IsInVerify) end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

CommonMonsterCasterSkill.LuaDispose = function(self)
  -- function num : 0_17 , upvalues : base
  (base.LuaDispose)(self)
  self.maxIndexPerWave = nil
  self.aliveMonsterList = nil
  self.allCampRoles = nil
  self.curMonsters = nil
  if self.loopCasterTimer ~= nil then
    (self.loopCasterTimer):Stop()
    self.loopCasterTimer = nil
  end
  if self.casteForEachTagTimer ~= nil then
    (self.casteForEachTagTimer):Stop()
    self.casteForEachTagTimer = nil
  end
end

return CommonMonsterCasterSkill

