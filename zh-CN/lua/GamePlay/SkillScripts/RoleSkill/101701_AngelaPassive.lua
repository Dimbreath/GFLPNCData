local bs_101701 = class("bs_101701", LuaSkillBase)
local base = LuaSkillBase
bs_101701.config = {buffId_cdSpeed = 101701, effectId = 101702}
bs_101701.ctor = function(self)
  -- function num : 0_0
end

bs_101701.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterPlaySkill, "bs_101701_2", 1, self.OnAfterPlaySkill)
end

bs_101701.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_2 , upvalues : _ENV
  if role.belongNum ~= (self.caster).belongNum and role ~= self.caster and skill.isCommonAttack ~= true then
    LuaSkillCtrl:CallBuff(self, role, (self.config).buffId_cdSpeed, 1)
    LuaSkillCtrl:CallEffect(role, (self.config).effectId, self)
  end
end

bs_101701.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_101701

