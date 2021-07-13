-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_20011 = class("bs_20011", LuaSkillBase)
local base = LuaSkillBase
bs_20011.config = {buffId1 = 1110, buffId2 = 1113}
bs_20011.ctor = function(self)
  -- function num : 0_0
end

bs_20011.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId1, 1)
  LuaSkillCtrl:StartTimer(nil, (self.arglist)[1], function()
    -- function num : 0_1_0 , upvalues : _ENV, self
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId1, 0)
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId2, 1, nil, true)
  end
, 1, (self.arglist)[1])
end

bs_20011.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_20011

