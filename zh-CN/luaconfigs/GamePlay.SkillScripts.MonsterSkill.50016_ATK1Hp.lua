-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_50016 = class("bs_50016", LuaSkillBase)
local base = LuaSkillBase
bs_50016.config = {buffId = 1155, buffIdNormal = 1160, buffTier = 1}
bs_50016.ctor = function(self)
  -- function num : 0_0
end

bs_50016.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.OnBattleEnd, "bs_50016_1", 1, self.OnBattleEnd)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_50016_2", 2, self.AfterBattleStart)
end

bs_50016.AfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if (self.caster).career == 3 then
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.config).buffTier, nil, true)
  else
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffIdNormal, (self.config).buffTier, nil, true)
  end
end

bs_50016.OnBattleEnd = function(self)
  -- function num : 0_3
  local hurt = (self.caster).hp - 1
  ;
  (self.caster):SubHp(hurt)
end

bs_50016.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_50016

