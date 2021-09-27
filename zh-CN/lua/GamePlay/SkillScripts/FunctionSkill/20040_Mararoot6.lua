local bs_20040 = class("bs_20040", LuaSkillBase)
local base = LuaSkillBase
bs_20040.config = {buffId1 = 164, buffId2 = 256, skillDelay = 60}
bs_20040.ctor = function(self)
  -- function num : 0_0
end

bs_20040.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  if (self.caster).roleDataId ~= 30001 and (self.caster).roleDataId ~= 30002 then
    return 
  end
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_20040_3", 3, self.OnAfterPlaySkill)
end

bs_20040.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_2 , upvalues : _ENV
  if skill.dataId == 201003 then
    local arriveCallBack = BindCallback(self, self.OnArriveAction, skill.maker)
    LuaSkillCtrl:StartTimer(nil, (self.config).skillDelay, arriveCallBack, self, 1)
  end
end

bs_20040.OnArriveAction = function(self, role)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId1, 0)
  LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId2, 0)
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 5, 10)
  if targetlist.Count < 1 then
    return 
  end
end

bs_20040.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_20040

