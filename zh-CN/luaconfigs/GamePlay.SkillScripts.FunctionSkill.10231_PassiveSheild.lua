-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10231 = class("bs_10231", LuaSkillBase)
local base = LuaSkillBase
bs_10231.config = {buffId = 1086, effectId = 10643}
bs_10231.ctor = function(self)
  -- function num : 0_0
end

bs_10231.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterBattleStart, "bs_10231_1", 1, self.OnAfterBattleStart)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10231_12", 1, self.OnAfterPlaySkill)
end

bs_10231.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self)
  self:RealPlaySkill()
end

bs_10231.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_3
  if role == self.caster and not skill.isCommonAttack then
    self:RealPlaySkill()
  end
end

bs_10231.RealPlaySkill = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 14, 10)
  if targetlist.Count < 1 then
    return 
  end
  local targetRole = (targetlist[0]).targetRole
  LuaSkillCtrl:CallBuff(self, targetRole, (self.config).buffId, (self.arglist)[1])
end

bs_10231.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10231

