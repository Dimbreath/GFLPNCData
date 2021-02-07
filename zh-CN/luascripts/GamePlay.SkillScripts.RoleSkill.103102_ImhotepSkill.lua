-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_103102 = class("bs_103102", LuaSkillBase)
local base = LuaSkillBase
bs_103102.config = {birdId = 12, snakeId = 13, buff_bird = 200, buff_snake = 201, buffId = 88, buffId2 = 196, effect_bird_birth = 10546, effect_snake_birth = 10548}
bs_103102.ctor = function(self)
  -- function num : 0_0
end

bs_103102.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_103102_10", 1, self.OnRoleDie)
end

bs_103102.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local role = nil
  local summonerId = 0
  local lastAtkRole = ((self.caster).recordTable).lastComAttackRole
  if lastAtkRole ~= nil and lastAtkRole.belongNum ~= eBattleRoleBelong.neutral then
    role = lastAtkRole
  end
  summonerId = self:GetSummonerId(role)
  if summonerId <= 0 then
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 33, 10)
    if targetList.Count <= 0 then
      return 
    else
      for i = 0, targetList.Count - 1 do
        role = (targetList[i]).targetRole
        summonerId = self:GetSummonerId(role)
      end
    end
  end
  do
    if summonerId > 0 or summonerId <= 0 then
      return 
    end
    self:CallCasterWait(30)
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, role, summonerId)
    ;
    (self.caster):LookAtTarget(role)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1002, 1, 1, attackTrigger)
  end
end

bs_103102.GetSummonerId = function(self, targetRole)
  -- function num : 0_3 , upvalues : _ENV
  local num = 4
  if targetRole ~= nil and not targetRole.unableSelect and targetRole.hp > 0 then
    if targetRole:GetBuffTier((self.config).buff_bird) >= 1 then
      num = 2
    end
    if targetRole:GetBuffTier((self.config).buff_snake) >= 1 then
      if num ~= 2 then
        num = 1
      else
        num = 0
        return num
      end
    end
    if num == 4 then
      num = LuaSkillCtrl:CallRange(1, 2)
    end
  else
    return 0
  end
  return num
end

bs_103102.OnRoleDie = function(self, killer, role)
  -- function num : 0_4 , upvalues : _ENV
  if (self.arglist)[2] == 1 and (role:GetBuffTier((self.config).buff_bird) == 1 or role:GetBuffTier((self.config).buff_snake) == 1) then
    local skills = (self.caster):GetBattleSkillList()
    if skills ~= nil then
      local skillCount = skills.Count
      if skillCount > 0 then
        for j = 0, skillCount - 1 do
          if (skills[j]).isCommonAttack ~= true then
            local curTotalCd = (skills[j]).totalCDTime * (self.arglist)[3] // 1000
            LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd)
          end
        end
      end
    end
  end
end

bs_103102.OnAttackTrigger = function(self, target, prob)
  -- function num : 0_5 , upvalues : _ENV
  LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0, true)
  local monster = nil
  local arg = 0
  local arg2 = 0
  local arg3 = 0
  if prob == 1 then
    monster = (self.config).birdId
    arg = (self.arglist)[4]
    arg2 = (self.arglist)[5]
    arg3 = (self.arglist)[6]
    LuaSkillCtrl:CallBuff(self, target, (self.config).buff_bird, 1, (self.arglist)[1], true)
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effect_bird_birth, self)
  else
    monster = (self.config).snakeId
    arg = (self.arglist)[7]
    arg2 = (self.arglist)[8]
    LuaSkillCtrl:CallBuff(self, target, (self.config).buff_snake, 1, (self.arglist)[1], true)
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effect_snake_birth, self)
  end
  if monster ~= nil then
    local summoner = LuaSkillCtrl:CreateSummoner(self, monster, target.x, target.y)
    summoner:SetAttr(eHeroAttr.maxHp, 80)
    summoner:SetAttr(eHeroAttr.pow, 80)
    summoner:SetAttr(eHeroAttr.speed, (self.caster).speed)
    summoner:SetAttr(eHeroAttr.moveSpeed, (self.caster).moveSpeed)
    summoner:SetAttr(eHeroAttr.skill_intensity, (self.caster).skill_intensity)
    summoner:SetAsRealEntity(6)
    local tab = {attackTarget = target, senderTarget = self.caster, arg_1 = arg, arg_2 = arg2, arg_3 = arg3, time = (self.arglist)[1]}
    summoner:SetRecordTable(tab)
    local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
    summonerEntity:BindHostEntity(target)
    -- DECOMPILER ERROR at PC126: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (summonerEntity.recordTable).lastAttackRole = target
    -- DECOMPILER ERROR at PC128: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (summonerEntity.recordTable).lastComAttackRole = target
    local over = BindCallback(self, self.Onover, summonerEntity)
    LuaSkillCtrl:CallBuff(self, summonerEntity, (self.config).buffId, 1, (self.arglist)[1] - 2, true)
    LuaSkillCtrl:CallBuff(self, summonerEntity, (self.config).buffId2, 1, (self.arglist)[1] - 2, true)
    LuaSkillCtrl:StartTimer(nil, (self.arglist)[1], over)
  end
end

bs_103102.Onover = function(self, sum)
  -- function num : 0_6 , upvalues : _ENV
  if sum.hp > 0 then
    LuaSkillCtrl:RemoveLife(999, self, sum, true, false, nil, false)
  end
end

bs_103102.OnCasterDie = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_103102

