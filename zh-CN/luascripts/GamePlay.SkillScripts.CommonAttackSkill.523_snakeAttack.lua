-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_523 = class("bs_523", bs_1)
local base = bs_1
bs_523.config = {action1 = 1001, action2 = 1001, 
HurtConfig = {basehurt_formula = 10086}
, effect_snake = 10522, effectId1 = 10547, effectId2 = 10547}
bs_523.config = setmetatable(bs_523.config, {__index = base.config})
bs_523.ctor = function(self)
  -- function num : 0_0
end

bs_523.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self.targetreal = ((self.caster).recordTable).attackTarget
  self.senderreal = ((self.caster).recordTable).senderTarget
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_523_10", 1, self.OnRoleDie)
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_523_11", 1, self.OnAfterHurt)
  self.killcaster = nil
  self.time = ((self.caster).recordTable).time + 2
end

bs_523.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster then
    local arg2 = ((self.caster).recordTable).arg_2
    local heal = hurt * arg2 // 1000
    if heal <= 0 then
      heal = 1
    end
    LuaSkillCtrl:CallHeal(heal, self, self.senderreal)
  end
end

bs_523.OnRoleDie = function(self, killer, role)
  -- function num : 0_3 , upvalues : _ENV
  if role == self.targetreal then
    LuaSkillCtrl:DispelBuff(self.caster, 88, 0)
    LuaSkillCtrl:RemoveLife(999, self, self.caster, true, false, nil, false)
    ;
    (self.caster):BindHostEntity(nil)
  end
end

bs_523.RealPlaySkill = function(self, target, data)
  -- function num : 0_4 , upvalues : _ENV, base
  target = self.targetreal
  if target.hp <= 0 then
    LuaSkillCtrl:DispelBuff(self.caster, 88, 0)
    LuaSkillCtrl:RemoveLife(999, self, self.caster, true, false, nil, false)
    ;
    (self.caster):BindHostEntity(nil)
  end
  if self.killcaster == nil then
    LuaSkillCtrl:StartTimer(self, self.time, function()
    -- function num : 0_4_0 , upvalues : self, _ENV
    if (self.caster).hp > 0 then
      LuaSkillCtrl:RemoveLife(999, self, self.caster, true, false, nil, false)
    end
  end
)
  end
  if LuaSkillCtrl:RoleContainsBuffFeature(target, eBuffFeatureType.NotBeSelected) or LuaSkillCtrl:RoleContainsBuffFeature(target, eBuffFeatureType.Exiled) then
    return 
  end
  ;
  (base.RealPlaySkill)(self, target, data)
end

bs_523.OnAttackTrigger = function(self, target, data, atkSpeedRatio, atkActionId)
  -- function num : 0_5 , upvalues : _ENV
  local arg2 = (self.caster).resistance
  if data.audioId3 ~= nil then
    ((self.caster).auSource):PlayAudioById(data.audioId3)
  end
  if not target.unableSelect then
    local arg = ((self.caster).recordTable).arg_1
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResult(skillResult, (self.config).HurtConfig, {arg})
    skillResult:EndResult()
    -- DECOMPILER ERROR at PC39: Confused about usage of register: R8 in 'UnsetPending'

    if ((self.caster).recordTable).completeFirstComatk == nil then
      ((self.caster).recordTable).completeFirstComatk = true
    end
  else
    do
      self:BreakSkill()
    end
  end
end

bs_523.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_523

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_523 = class("bs_523", bs_1)
local base = bs_1
bs_523.config = {
    action1 = 1001,
    action2 = 1001,
    HurtConfig = {basehurt_formula = 10086},
    effect_snake = 10522,
    effectId1 = 10547,
    effectId2 = 10547
}
bs_523.config = setmetatable(bs_523.config, {__index = base.config})
bs_523.ctor = function(self)
    -- function num : 0_0
end

bs_523.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitSkill)(self, isMidwaySkill)
    self.targetreal = ((self.caster).recordTable).attackTarget
    self.senderreal = ((self.caster).recordTable).senderTarget
    self:AddTrigger(eSkillTriggerType.RoleDie, "bs_523_10", 1, self.OnRoleDie)
    self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_523_11", 1,
                    self.OnAfterHurt)
    self.killcaster = nil
    self.time = ((self.caster).recordTable).time + 2
end

bs_523.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit,
                              isRealDmg)
    -- function num : 0_2 , upvalues : _ENV
    if sender == self.caster then
        local arg2 = ((self.caster).recordTable).arg_2
        local heal = hurt * arg2 // 1000
        if heal <= 0 then heal = 1 end
        LuaSkillCtrl:CallHeal(heal, self, self.senderreal)
    end
end

bs_523.OnRoleDie = function(self, killer, role)
    -- function num : 0_3 , upvalues : _ENV
    if role == self.targetreal then
        LuaSkillCtrl:DispelBuff(self.caster, 88, 0)
        LuaSkillCtrl:RemoveLife(999, self, self.caster, true, false, nil, false);
        (self.caster):BindHostEntity(nil)
    end
end

bs_523.RealPlaySkill = function(self, target, data)
    -- function num : 0_4 , upvalues : _ENV, base
    target = self.targetreal
    if target.hp <= 0 then
        LuaSkillCtrl:DispelBuff(self.caster, 88, 0)
        LuaSkillCtrl:RemoveLife(999, self, self.caster, true, false, nil, false);
        (self.caster):BindHostEntity(nil)
    end
    if self.killcaster == nil then
        LuaSkillCtrl:StartTimer(self, self.time, function()
            -- function num : 0_4_0 , upvalues : self, _ENV
            if (self.caster).hp > 0 then
                LuaSkillCtrl:RemoveLife(999, self, self.caster, true, false,
                                        nil, false)
            end
        end)
    end
    if LuaSkillCtrl:RoleContainsBuffFeature(target,
                                            eBuffFeatureType.NotBeSelected) or
        LuaSkillCtrl:RoleContainsBuffFeature(target, eBuffFeatureType.Exiled) then
        return
    end
    (base.RealPlaySkill)(self, target, data)
end

bs_523.OnAttackTrigger =
    function(self, target, data, atkSpeedRatio, atkActionId)
        -- function num : 0_5 , upvalues : _ENV
        local arg2 = (self.caster).resistance
        if data.audioId3 ~= nil then
            ((self.caster).auSource):PlayAudioById(data.audioId3)
        end
        if not target.unableSelect then
            local arg = ((self.caster).recordTable).arg_1
            local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self,
                                                                     target)
            LuaSkillCtrl:HurtResult(skillResult, (self.config).HurtConfig, {arg})
            skillResult:EndResult()
            -- DECOMPILER ERROR at PC39: Confused about usage of register: R8 in 'UnsetPending'

            if ((self.caster).recordTable).completeFirstComatk == nil then
                ((self.caster).recordTable).completeFirstComatk = true
            end
        else
            do self:BreakSkill() end
        end
    end

bs_523.OnCasterDie = function(self)
    -- function num : 0_6 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_523

