-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_202302 = class("bs_202302", LuaSkillBase)
local base = LuaSkillBase
bs_202302.config = {buffId = 191}
bs_202302.ctor = function(self)
  -- function num : 0_0
end

bs_202302.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_202302_1", 1, self.OnAfterBattleStart)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_202302_10", 1, self.OnRoleDie)
  self:AddSelfTrigger(eSkillTriggerType.BeforePlaySkill, "bs_202302_11", 1, self.OnBeforePlaySkill)
end

bs_202302.OnBeforePlaySkill = function(self, role, context)
  -- function num : 0_2 , upvalues : _ENV
  if role == self.caster and (context.skill).dataId == 202303 then
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 2, 10)
    if targetList.Count > 0 then
      LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0)
      LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, targetList.Count)
    end
  end
end

bs_202302.OnAfterBattleStart = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 2, 10)
  if targetList.Count > 0 then
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, targetList.Count)
  end
end

bs_202302.OnRoleDie = function(self, killer, role)
  -- function num : 0_4 , upvalues : _ENV
  if role.belongNum == (self.caster).belongNum then
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 1)
  end
end

bs_202302.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_202302

