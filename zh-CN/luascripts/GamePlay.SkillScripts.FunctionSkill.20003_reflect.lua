-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_20003 = class("bs_20003", LuaSkillBase)
local base = LuaSkillBase
bs_20003.config = {buffId = 1096}
bs_20003.ctor = function(self)
  -- function num : 0_0
end

bs_20003.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20003_1", 1, self.OnAfterBattleStart)
  self:AddSelfTrigger(eSkillTriggerType.SetHurt, "bs_20003_14", 1, self.OnSetHurt)
end

bs_20003.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self:PlayChipEffect()
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.arglist)[1], nil, true)
end

bs_20003.OnSetHurt = function(self, context)
  -- function num : 0_3 , upvalues : _ENV
  local tier = (context.target):GetBuffTier((self.config).buffId)
  if tier <= 0 or context.sender == self.caster then
    return 
  end
  if context.target == self.caster and context.sender ~= self.caster then
    LuaSkillCtrl:RemoveLife(context.hurt, self, context.sender, true, false)
    context.hurt = 0
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 1)
  end
end

bs_20003.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_20003

