-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_311 = class("bs_311", LuaSkillBase)
local base = LuaSkillBase
bs_311.config = {effectId7 = 10148, effectId6 = 10147, effectId5 = 10146, effectId4 = 10145, effectId3 = 10144, effectId2 = 10143, effectId1 = 10142, effectId0 = 10149}
bs_311.ctor = function(self)
  -- function num : 0_0
end

bs_311.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_311.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self.caster).recordTable)["311_FQ"] = 7
  self.monsterRecord = {}
  local targetListall = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  if targetListall.Count == 0 then
    return 
  end
  for i = 0, targetListall.Count - 1 do
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R7 in 'UnsetPending'

    (self.monsterRecord)[(targetListall[i]).targetRole] = 0
  end
  self:CallCasterWait(30)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, data)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1002, 1, 20, attackTrigger)
end

bs_311.OnAttackTrigger = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  local effectconfig = (self.config)["effectId" .. tostring(((self.caster).recordTable)["311_FQ"])]
  LuaSkillCtrl:CallEffect(self.caster, effectconfig, self)
  LuaSkillCtrl:StartTimer(self, 7, self.callback, self, 6, 0)
end

bs_311.callback = function(self)
  -- function num : 0_4 , upvalues : _ENV
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  if ((self.caster).recordTable)["311_FQ"] > 0 then
    ((self.caster).recordTable)["311_FQ"] = ((self.caster).recordTable)["311_FQ"] - 1
    local effectconfig = (self.config)["effectId" .. tostring(((self.caster).recordTable)["311_FQ"])]
    LuaSkillCtrl:CallEffect(self.caster, effectconfig, self)
  end
  do
    local targetListR = LuaSkillCtrl:CallTargetSelect(self, 19, 10)
    if targetListR.Count ~= nil then
      LuaSkillCtrl:CallEffect((targetListR[0]).targetRole, (self.config).effectId0, self, self.SkillEventFunc)
    end
  end
end

bs_311.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_5 , upvalues : _ENV
  if effect.dataId == (self.config).effectId0 and eventId == eBattleEffectEvent.Trigger then
    if (self.monsterRecord)[target.targetRole] > 1 and (self.arglist)[3] >= 0 then
      LuaSkillCtrl:RemoveLife((self.caster).pow * (self.arglist)[2] // 1000 * 130 // 100, self, target.targetRole)
    else
      LuaSkillCtrl:RemoveLife((self.caster).pow * (self.arglist)[2] // 1000, self, target.targetRole)
    end
    -- DECOMPILER ERROR at PC49: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (self.monsterRecord)[target.targetRole] = (self.monsterRecord)[target.targetRole] + 1
  end
end

bs_311.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_311

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_311 = class("bs_311", LuaSkillBase)
local base = LuaSkillBase
bs_311.config = {
    effectId7 = 10148,
    effectId6 = 10147,
    effectId5 = 10146,
    effectId4 = 10145,
    effectId3 = 10144,
    effectId2 = 10143,
    effectId1 = 10142,
    effectId0 = 10149
}
bs_311.ctor = function(self)
    -- function num : 0_0
end

bs_311.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base
    (base.InitSkill)(self, isMidwaySkill)
end

bs_311.PlaySkill = function(self, data)
    -- function num : 0_2 , upvalues : _ENV
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

    ((self.caster).recordTable)["311_FQ"] = 7
    self.monsterRecord = {}
    local targetListall = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
    if targetListall.Count == 0 then return end
    for i = 0, targetListall.Count - 1 do
        -- DECOMPILER ERROR at PC23: Confused about usage of register: R7 in 'UnsetPending'

        (self.monsterRecord)[(targetListall[i]).targetRole] = 0
    end
    self:CallCasterWait(30)
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, data)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1002, 1, 20,
                                           attackTrigger)
end

bs_311.OnAttackTrigger = function(self, data)
    -- function num : 0_3 , upvalues : _ENV
    local effectconfig = (self.config)["effectId" ..
                             tostring(((self.caster).recordTable)["311_FQ"])]
    LuaSkillCtrl:CallEffect(self.caster, effectconfig, self)
    LuaSkillCtrl:StartTimer(self, 7, self.callback, self, 6, 0)
end

bs_311.callback = function(self)
    -- function num : 0_4 , upvalues : _ENV
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

    if ((self.caster).recordTable)["311_FQ"] > 0 then
        ((self.caster).recordTable)["311_FQ"] =
            ((self.caster).recordTable)["311_FQ"] - 1
        local effectconfig = (self.config)["effectId" ..
                                 tostring(((self.caster).recordTable)["311_FQ"])]
        LuaSkillCtrl:CallEffect(self.caster, effectconfig, self)
    end
    do
        local targetListR = LuaSkillCtrl:CallTargetSelect(self, 19, 10)
        if targetListR.Count ~= nil then
            LuaSkillCtrl:CallEffect((targetListR[0]).targetRole,
                                    (self.config).effectId0, self,
                                    self.SkillEventFunc)
        end
    end
end

bs_311.SkillEventFunc = function(self, effect, eventId, target)
    -- function num : 0_5 , upvalues : _ENV
    if effect.dataId == (self.config).effectId0 and eventId ==
        eBattleEffectEvent.Trigger then
        if (self.monsterRecord)[target.targetRole] > 1 and (self.arglist)[3] >=
            0 then
            LuaSkillCtrl:RemoveLife((self.caster).pow * (self.arglist)[2] //
                                        1000 * 130 // 100, self,
                                    target.targetRole)
        else
            LuaSkillCtrl:RemoveLife((self.caster).pow * (self.arglist)[2] //
                                        1000, self, target.targetRole)
        end -- DECOMPILER ERROR at PC49: Confused about usage of register: R4 in 'UnsetPending'
        
        (self.monsterRecord)[target.targetRole] =
            (self.monsterRecord)[target.targetRole] + 1
    end
end

bs_311.OnCasterDie = function(self)
    -- function num : 0_6 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_311

