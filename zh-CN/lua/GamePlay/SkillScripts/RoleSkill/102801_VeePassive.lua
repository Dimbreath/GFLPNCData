local bs_102801 = class("bs_102801", LuaSkillBase)
local base = LuaSkillBase
bs_102801.config = {buffId_263 = 102803, buffId_264 = 102804, buffId_att = 102801}
bs_102801.ctor = function(self)
  -- function num : 0_0
end

bs_102801.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_102801_1", 1, self.OnAfterBattleStart)
  self:AddSetHurtTrigger("bs_102801_2", 20, self.OnSetHurt, self.caster)
  self.ass_role = nil
  self.ass_pow = 0
end

bs_102801.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if LuaSkillCtrl.IsInTDBattle ~= true then
    (self.caster):AddRoleProperty(eHeroAttr.attackRange, (self.arglist)[1] - 1, eHeroAttrType.Origin)
  end
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_att, 1)
end

bs_102801.OnSetHurt = function(self, context)
  -- function num : 0_3 , upvalues : _ENV
  if context.sender == self.caster and (context.skill).isCommonAttack and (context.target).belongNum ~= (self.caster).belongNum and (context.target ~= self.ass_role or (context.target).pow ~= self.ass_pow) then
    if self.ass_role ~= nil and (self.ass_role).hp > 0 then
      LuaSkillCtrl:DispelBuff(self.ass_role, (self.config).buffId_263, 0, true)
    end
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId_264, 0, true)
    local num = (context.target).pow * (self.arglist)[4] // 1000
    local min = (self.caster).pow * (self.arglist)[5] // 1000
    if min < num then
      num = min
    end
    LuaSkillCtrl:CallBuff(self, context.target, (self.config).buffId_263, num, nil, true)
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_264, num, nil, true)
    self.ass_role = context.target
    self.ass_pow = (context.target).pow
  end
end

bs_102801.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

bs_102801.LuaDispose = function(self)
  -- function num : 0_5 , upvalues : base
  (base.LuaDispose)(self)
  self.ass_role = nil
end

return bs_102801

