-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_103102 = class("bs_103102", LuaSkillBase)
local base = LuaSkillBase
bs_103102.config = {birdId = 12, snakeId = 13, buff_bird = 200, buff_snake = 201, buffId = 88, effect_bird_birth = 10546, effect_snake_birth = 10548}
bs_103102.ctor = function(self)
  -- function num : 0_0
end

bs_103102.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).lastAttackRole = nil
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_103102_10", 1, self.OnRoleDie)
end

bs_103102.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local role = nil
  self.num = 0
  if ((self.caster).recordTable).lastAttackRole ~= nil then
    role = ((self.caster).recordTable).lastAttackRole
  end
  if role ~= nil then
    if role:GetBuffTier((self.config).buff_brid) < 1 or role:GetBuffTier((self.config).buff_snake) < 1 then
      if role:GetBuffTier((self.config).buff_brid) < 1 then
        self.num = self.num + 1
      end
      if role:GetBuffTier((self.config).buff_snake) < 1 then
        self.num = self.num + 3
      end
    else
      role = nil
    end
  end
  if role == nil then
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 33, 10)
    if targetList.Count > 0 then
      for i = 0, targetList.Count - 1 do
        role = (targetList[i]).targetRole
        if role:GetBuffTier((self.config).buff_brid) < 1 or role:GetBuffTier((self.config).buff_snake) < 1 then
          if role:GetBuffTier((self.config).buff_brid) < 1 then
            self.num = self.num + 1
          end
          if role:GetBuffTier((self.config).buff_snake) < 1 then
            self.num = self.num + 3
          end
          break
        else
          role = nil
        end
      end
    else
      do
        do
          do return  end
          if role == nil then
            return 
          end
          if self.num == 4 then
            self.prob = LuaSkillCtrl:CallRange(1, 2)
          else
            if self.num == 1 then
              self.prob = 1
            else
              self.prob = 2
            end
            if self.num == 0 then
              return 
            end
          end
          self:CallCasterWait(30)
          local attackTrigger = BindCallback(self, self.OnAttackTrigger, role, self.prob)
          ;
          (self.caster):LookAtTarget(role)
          LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1002, 1, 1, attackTrigger)
        end
      end
    end
  end
end

bs_103102.OnRoleDie = function(self, killer, role)
  -- function num : 0_3 , upvalues : _ENV
  if (self.arglist)[2] == 1 and (role:GetBuffTier((self.config).buff_brid) == 1 or role:GetBuffTier((self.config).buff_snake) == 1) then
    LuaSkillCtrl:CallBuff(self, (self.caster).buffId, 1)
  end
end

bs_103102.OnAttackTrigger = function(self, target, prob)
  -- function num : 0_4 , upvalues : _ENV
  LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0)
  local monster = nil
  local arg = 0
  local arg2 = 0
  local arg3 = 0
  if prob == 1 then
    monster = (self.config).birdId
    arg = (self.arglist)[4]
    arg2 = (self.arglist)[5]
    arg3 = (self.arglist)[6]
    LuaSkillCtrl:CallBuff(self, target, (self.config).buff_bird, 1, (self.arglist)[1])
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effect_bird_birth, self)
  else
    monster = (self.config).snakeId
    arg = (self.arglist)[7]
    arg2 = (self.arglist)[8]
    LuaSkillCtrl:CallBuff(self, target, (self.config).buff_snake, 1, (self.arglist)[1])
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effect_snake_birth, self)
  end
  if monster ~= nil then
    local summoner = LuaSkillCtrl:CreateSummoner(self, monster, target.x, target.y)
    summoner:SetAttr(eHeroAttr.maxHp, 80)
    summoner:SetAttr(eHeroAttr.pow, 80)
    summoner:SetAttr(eHeroAttr.speed, (self.caster).speed)
    summoner:SetAttr(eHeroAttr.skill_intensity, (self.caster).skill_intensity)
    summoner:SetAsRealEntity(6)
    local tab = {attackTarget = target, senderTarget = self.caster, arg_1 = arg, arg_2 = arg2, arg_3 = arg3, time = (self.arglist)[1]}
    summoner:SetRecordTable(tab)
    local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
    summonerEntity:BindHostEntity(target)
    local over = BindCallback(self, self.Onover, summonerEntity)
    LuaSkillCtrl:CallBuff(self, summonerEntity, (self.config).buffId, 1, (self.arglist)[1] - 2)
    LuaSkillCtrl:StartTimer(self, (self.arglist)[1], over, self)
  end
end

bs_103102.Onover = function(self, sum)
  -- function num : 0_5 , upvalues : _ENV
  if sum.hp > 0 then
    LuaSkillCtrl:RemoveLife(999, self, sum, true, false, nil, false)
  end
end

bs_103102.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_103102

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_103102 = class("bs_103102", LuaSkillBase)
local base = LuaSkillBase
bs_103102.config = {
    birdId = 12,
    snakeId = 13,
    buff_bird = 200,
    buff_snake = 201,
    buffId = 88,
    effect_bird_birth = 10546,
    effect_snake_birth = 10548
}
bs_103102.ctor = function(self)
    -- function num : 0_0
end

bs_103102.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitSkill)(self, isMidwaySkill) -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'
    ;
    ((self.caster).recordTable).lastAttackRole = nil
    self:AddTrigger(eSkillTriggerType.RoleDie, "bs_103102_10", 1, self.OnRoleDie)
end

bs_103102.PlaySkill = function(self, data)
    -- function num : 0_2 , upvalues : _ENV
    local role = nil
    self.num = 0
    if ((self.caster).recordTable).lastAttackRole ~= nil then
        role = ((self.caster).recordTable).lastAttackRole
    end
    if role ~= nil then
        if role:GetBuffTier((self.config).buff_brid) < 1 or
            role:GetBuffTier((self.config).buff_snake) < 1 then
            if role:GetBuffTier((self.config).buff_brid) < 1 then
                self.num = self.num + 1
            end
            if role:GetBuffTier((self.config).buff_snake) < 1 then
                self.num = self.num + 3
            end
        else
            role = nil
        end
    end
    if role == nil then
        local targetList = LuaSkillCtrl:CallTargetSelect(self, 33, 10)
        if targetList.Count > 0 then
            for i = 0, targetList.Count - 1 do
                role = (targetList[i]).targetRole
                if role:GetBuffTier((self.config).buff_brid) < 1 or
                    role:GetBuffTier((self.config).buff_snake) < 1 then
                    if role:GetBuffTier((self.config).buff_brid) < 1 then
                        self.num = self.num + 1
                    end
                    if role:GetBuffTier((self.config).buff_snake) < 1 then
                        self.num = self.num + 3
                    end
                    break
                else
                    role = nil
                end
            end
        else
            do
                do
                    do return end
                    if role == nil then return end
                    if self.num == 4 then
                        self.prob = LuaSkillCtrl:CallRange(1, 2)
                    else
                        if self.num == 1 then
                            self.prob = 1
                        else
                            self.prob = 2
                        end
                        if self.num == 0 then return end
                    end
                    self:CallCasterWait(30)
                    local attackTrigger =
                        BindCallback(self, self.OnAttackTrigger, role, self.prob);
                    (self.caster):LookAtTarget(role)
                    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster,
                                                           1002, 1, 1,
                                                           attackTrigger)
                end
            end
        end
    end
end

bs_103102.OnRoleDie = function(self, killer, role)
    -- function num : 0_3 , upvalues : _ENV
    if (self.arglist)[2] == 1 and
        (role:GetBuffTier((self.config).buff_brid) == 1 or
            role:GetBuffTier((self.config).buff_snake) == 1) then
        LuaSkillCtrl:CallBuff(self, (self.caster).buffId, 1)
    end
end

bs_103102.OnAttackTrigger = function(self, target, prob)
    -- function num : 0_4 , upvalues : _ENV
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0)
    local monster = nil
    local arg = 0
    local arg2 = 0
    local arg3 = 0
    if prob == 1 then
        monster = (self.config).birdId
        arg = (self.arglist)[4]
        arg2 = (self.arglist)[5]
        arg3 = (self.arglist)[6]
        LuaSkillCtrl:CallBuff(self, target, (self.config).buff_bird, 1,
                              (self.arglist)[1])
        LuaSkillCtrl:CallEffect(self.caster, (self.config).effect_bird_birth,
                                self)
    else
        monster = (self.config).snakeId
        arg = (self.arglist)[7]
        arg2 = (self.arglist)[8]
        LuaSkillCtrl:CallBuff(self, target, (self.config).buff_snake, 1,
                              (self.arglist)[1])
        LuaSkillCtrl:CallEffect(self.caster, (self.config).effect_snake_birth,
                                self)
    end
    if monster ~= nil then
        local summoner = LuaSkillCtrl:CreateSummoner(self, monster, target.x,
                                                     target.y)
        summoner:SetAttr(eHeroAttr.maxHp, 80)
        summoner:SetAttr(eHeroAttr.pow, 80)
        summoner:SetAttr(eHeroAttr.speed, (self.caster).speed)
        summoner:SetAttr(eHeroAttr.skill_intensity,
                         (self.caster).skill_intensity)
        summoner:SetAsRealEntity(6)
        local tab = {
            attackTarget = target,
            senderTarget = self.caster,
            arg_1 = arg,
            arg_2 = arg2,
            arg_3 = arg3,
            time = (self.arglist)[1]
        }
        summoner:SetRecordTable(tab)
        local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
        summonerEntity:BindHostEntity(target)
        local over = BindCallback(self, self.Onover, summonerEntity)
        LuaSkillCtrl:CallBuff(self, summonerEntity, (self.config).buffId, 1,
                              (self.arglist)[1] - 2)
        LuaSkillCtrl:StartTimer(self, (self.arglist)[1], over, self)
    end
end

bs_103102.Onover = function(self, sum)
    -- function num : 0_5 , upvalues : _ENV
    if sum.hp > 0 then
        LuaSkillCtrl:RemoveLife(999, self, sum, true, false, nil, false)
    end
end

bs_103102.OnCasterDie = function(self)
    -- function num : 0_6 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_103102

