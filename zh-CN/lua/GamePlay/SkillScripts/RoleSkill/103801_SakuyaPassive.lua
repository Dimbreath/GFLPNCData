local bs_103801 = class("bs_103801", LuaSkillBase)
local base = LuaSkillBase
bs_103801.config = {buffId_195 = 195, effectId_pass_ex = 10800}
bs_103801.ctor = function(self)
  -- function num : 0_0
end

bs_103801.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_103801_3", 1, self.OnAfterHurt, nil, nil, nil, eBattleRoleBelong.enemy)
  self.ex_target = nil
  self.ex_effect = nil
end

bs_103801.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and skill.isCommonAttack and not isMiss and target.hp > 0 and self.ex_target ~= target then
    if self.ex_effect ~= nil then
      (self.ex_effect):Die()
      self.ex_effect = nil
    end
    self.ex_target = target
    self.ex_effect = LuaSkillCtrl:CallEffect(target, (self.config).effectId_pass_ex, self)
  end
  if target == self.ex_target and target.hp <= 0 and self.ex_effect ~= nil then
    (self.ex_effect):Die()
    self.ex_effect = nil
  end
  if target == self.ex_target and isTriggerSet == false then
    if sender ~= self.caster and LuaSkillCtrl:CallRange(1, 1000) <= (self.arglist)[1] then
      LuaSkillCtrl:CallBuff(self, target, (self.config).buffId_195, 1, (self.arglist)[2])
    end
    if sender == self.caster and LuaSkillCtrl:CallRange(1, 1000) <= (self.arglist)[1] * 2 then
      LuaSkillCtrl:CallBuff(self, target, (self.config).buffId_195, 1, (self.arglist)[2])
    end
  end
end

bs_103801.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  if self.ex_effect ~= nil then
    (self.ex_effect):Die()
    self.ex_effect = nil
  end
  ;
  (base.OnCasterDie)(self)
end

bs_103801.LuaDispose = function(self)
  -- function num : 0_4 , upvalues : base
  (base.LuaDispose)(self)
  self.ex_target = nil
  self.ex_effect = nil
end

return bs_103801

