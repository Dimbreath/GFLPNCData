-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_60001 = class("bs_60001", LuaSkillBase)
local base = LuaSkillBase
bs_60001.config = {buffId1 = 175, buffId2 = 1033, buffId3 = 198, effectId1 = 10505, effectId2 = 10506}
bs_60001.ctor = function(self)
  -- function num : 0_0
end

bs_60001.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_60001_1", 1, self.OnAfterBattleStart)
end

bs_60001.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId2, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId3, 1, nil, true)
end

bs_60001.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base, _ENV
  (base.OnCasterDie)(self)
  if (self.caster).roleDataId == 1001 then
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId2, self)
  else
    if (self.caster).roleDataId == 1005 then
      LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId1, self)
    end
  end
end

return bs_60001

