-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10196 = class("bs_10196", LuaSkillBase)
local base = LuaSkillBase
bs_10196.config = {buffId = 1065}
bs_10196.ctor = function(self)
  -- function num : 0_0
end

bs_10196.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_10196_2", 1, self.OnSetHurt, self.caster)
end

bs_10196.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if context.sender == self.caster and not context.isTriggerSet then
    if LuaSkillCtrl:GetRoleEfcGrid(context.target) ~= 10 then
      local tier = (context.target):GetBuffTier((self.config).buffId)
      if tier <= 0 then
        return 
      end
      LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, tier, true)
    else
      do
        self:PlayChipEffect()
        local tier = 1
        LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, tier, nil, true)
      end
    end
  end
end

bs_10196.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10196

