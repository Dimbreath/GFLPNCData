-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_5016 = class("bs_5016", LuaSkillBase)
local base = LuaSkillBase
bs_5016.config = {buffId = 156}
bs_5016.ctor = function(self)
  -- function num : 0_0
end

bs_5016.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_5016_3", 4, self.OnAfterHurt)
end

bs_5016.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_2 , upvalues : _ENV
  if sender.belongNum == (self.caster).belongNum and isCrit then
    LuaSkillCtrl:CallBuff(self, sender, (self.config).buffId, 1, (self.arglist)[2])
  end
end

bs_5016.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_5016

