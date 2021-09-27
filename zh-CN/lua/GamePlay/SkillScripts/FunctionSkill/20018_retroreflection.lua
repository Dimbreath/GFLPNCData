local bs_20018 = class("bs_20018", LuaSkillBase)
local base = LuaSkillBase
bs_20018.config = {buffId = 1112}
bs_20018.ctor = function(self)
  -- function num : 0_0
end

bs_20018.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20018_1", 1, self.OnAfterBattleStart)
end

bs_20018.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if (self.caster).belongNum == 2 then
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, 1, nil, true)
  end
end

bs_20018.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_20018

