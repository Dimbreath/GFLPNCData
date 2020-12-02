-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1068 = class("bs_1068", LuaSkillBase)
local base = LuaSkillBase
bs_1068.config = {}
bs_1068.ctor = function(self)
  -- function num : 0_0
end

bs_1068.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.SetHurt, "bs_1068_2", 1, self.OnSetHurt)
end

bs_1068.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if context.sender == self.caster and (context.skill).isCommonAttack and not context.isMiss then
    LuaSkillCtrl:CallBuff(self, context.target, (self.config).buffId1, 1, (self.arglist)[3])
    if (self.arglist)[4] > 0 then
      LuaSkillCtrl:CallBuff(self, self.caster, (self.config).BuffId2, 2, (self.arglist)[3])
    end
  end
end

bs_1068.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_1068

