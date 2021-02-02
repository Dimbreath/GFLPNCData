-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_102801 = class("bs_102801", LuaSkillBase)
local base = LuaSkillBase
bs_102801.config = {buffId = 227}
bs_102801.ctor = function(self)
  -- function num : 0_0
end

bs_102801.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_102801_1", 1, self.OnAfterBattleStart)
  self:AddSelfTrigger(eSkillTriggerType.SetHurt, "bs_102801_2", 20, self.OnSetHurt)
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).passive_roll = (self.arglist)[2]
end

bs_102801.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if (self.arglist)[1] > 0 then
    (self.caster):AddRoleProperty(eHeroAttr.attackRange, (self.arglist)[1] - 1, eHeroAttrType.Origin)
  end
end

bs_102801.OnSetHurt = function(self, context)
  -- function num : 0_3
  if context.sender == self.caster and (context.skill).isCommonAttack and (context.target).belongNum ~= (self.caster).belongNum then
    context.hurt = context.hurt + context.hurt * (self.arglist)[4] // 1000
  end
end

bs_102801.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_102801

