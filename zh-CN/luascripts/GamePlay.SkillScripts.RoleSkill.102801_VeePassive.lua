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
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).passive_roll = (self.arglist)[2]
end

bs_102801.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, 1, nil, true)
  if (self.arglist)[1] > 0 then
    (self.caster):AddRoleProperty(eHeroAttr.attackRange, (self.arglist)[1] - 1, eHeroAttrType.Origin)
  end
end

bs_102801.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_102801

