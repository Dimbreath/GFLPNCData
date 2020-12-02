-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_201901 = class("bs_201901", LuaSkillBase)
local base = LuaSkillBase
bs_201901.config = {buffIdSC = 186, buffIdSY = 187}
bs_201901.ctor = function(self)
  -- function num : 0_0
end

bs_201901.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.BeforePlaySkill, "bs_201901_11", 1, self.OnBeforePlaySkill)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["514_Roll"] = (self.arglist)[1]
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["514_skill"] = true
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["514_arg"] = (self.arglist)[2]
end

bs_201901.OnBeforePlaySkill = function(self, role, context)
  -- function num : 0_2
end

bs_201901.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base, _ENV
  (base.OnCasterDie)(self)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  if targetList.Count > 0 then
    for i = 0, targetList.Count - 1 do
      LuaSkillCtrl:DispelBuff((targetList[i]).targetRole, (self.config).buffIdSC, 10)
      LuaSkillCtrl:DispelBuff((targetList[i]).targetRole, (self.config).buffIdSY, 10)
    end
  end
end

return bs_201901

