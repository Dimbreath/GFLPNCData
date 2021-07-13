-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10191 = class("bs_10191", LuaSkillBase)
local base = LuaSkillBase
bs_10191.config = {buffId = 1071, buffTier = 1}
bs_10191.ctor = function(self)
  -- function num : 0_0
end

bs_10191.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnDoodad, self.OnDoodad)
end

bs_10191.OnDoodad = function(self, sender, targetRole)
  -- function num : 0_2 , upvalues : _ENV
  if targetRole == self.caster then
    self:PlayChipEffect()
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.config).buffTier, (self.arglist)[2], true)
  end
end

bs_10191.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10191

