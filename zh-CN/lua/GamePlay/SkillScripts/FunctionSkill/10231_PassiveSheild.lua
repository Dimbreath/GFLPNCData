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
end

bs_10231.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:StartTimer(nil, (self.arglist)[3], self.RealPlaySkill, self, -1)
end

bs_10231.RealPlaySkill = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 14, 10)
  if targetlist.Count < 1 then
    return 
  end
  local targetRole = (targetlist[0]).targetRole
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self)
  LuaSkillCtrl:CallBuff(self, targetRole, (self.config).buffId, (self.arglist)[1])
end

bs_10231.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10231

