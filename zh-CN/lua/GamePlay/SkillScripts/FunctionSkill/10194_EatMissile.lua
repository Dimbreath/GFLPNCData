local bs_10194 = class("bs_10194", LuaSkillBase)
local base = LuaSkillBase
bs_10194.config = {buffId = 1206, buffCm = 26, buffTier = 1}
bs_10194.ctor = function(self)
  -- function num : 0_0
end

bs_10194.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnDoodad, self.OnDoodad)
end

bs_10194.OnDoodad = function(self, sender, targetRole)
  -- function num : 0_2 , upvalues : _ENV
  if targetRole.belongNum == 2 then
    self:PlayChipEffect()
    if targetRole:GetBuffTier((self.config).buffId) < 1 then
      LuaSkillCtrl:CallBuff(self, targetRole, (self.config).buffId, (self.config).buffTier, (self.arglist)[1], true)
      LuaSkillCtrl:CallBuff(self, targetRole, (self.config).buffCm, (self.config).buffTier, (self.arglist)[1], true)
    end
  end
end

bs_10194.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10194

