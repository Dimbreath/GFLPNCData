-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_202401 = class("bs_202401", LuaSkillBase)
local base = LuaSkillBase
bs_202401.config = {buffId1 = 192}
bs_202401.ctor = function(self)
  -- function num : 0_0
end

bs_202401.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_202401_1", 1, self.OnAfterBattleStart)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_202401_10", 1, self.OnRoleDie)
  self:AddTrigger(eSkillTriggerType.BeforePlaySkill, "bs_202401_11", 1, self.OnBeforePlaySkill)
end

bs_202401.OnBeforePlaySkill = function(self, role, context)
  -- function num : 0_2 , upvalues : _ENV
  if role == self.caster then
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 2, 10)
    if targetList.Count > 0 then
      LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId1, 0)
      LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId1, targetList.Count)
    end
  end
end

bs_202401.OnAfterBattleStart = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local targetall = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
  if targetall.Count > 0 then
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId1, targetall.Count)
  end
end

bs_202401.OnRoleDie = function(self, killer, role)
  -- function num : 0_4 , upvalues : _ENV
  if role.belongNum == (self.caster).belongNum then
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId1, 1)
  end
end

bs_202401.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_202401

