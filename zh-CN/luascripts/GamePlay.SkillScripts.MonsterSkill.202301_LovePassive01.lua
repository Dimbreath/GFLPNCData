-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_202301 = class("bs_202301", LuaSkillBase)
local base = LuaSkillBase
bs_202301.config = {buffId = 190}
bs_202301.ctor = function(self)
  -- function num : 0_0
end

bs_202301.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_202301_3", 1, self.OnAfterHurt)
end

bs_202301.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_2 , upvalues : _ENV
  if target.belongNum == (self.caster).belongNum and hurt > 0 and target ~= self.caster then
    local tier = (target.maxHp - target.hp) * 1000 // target.maxHp // (self.arglist)[1]
    if (self.arglist)[3] // (self.arglist)[2] < tier then
      tier = (self.arglist)[3] // (self.arglist)[2]
    end
    LuaSkillCtrl:DispelBuff(target, (self.config).buffId, 0)
    LuaSkillCtrl:CallBuff(self, target, (self.config).buffId, tier)
  end
end

bs_202301.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_202301

