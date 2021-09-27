local bs_50017 = class("bs_50017", LuaSkillBase)
local base = LuaSkillBase
bs_50017.config = {buffId = 1209}
bs_50017.ctor = function(self)
  -- function num : 0_0
end

bs_50017.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_50017_2", 2, self.OnAfterPlaySkill)
end

bs_50017.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_2 , upvalues : _ENV
  self.curCd = ((self.caster).recordTable).gs_1_CDGrid
  local curCd = self.curCd
  LuaSkillCtrl:CallResetCDNumForRole(role, curCd)
  LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0)
end

bs_50017.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_50017

