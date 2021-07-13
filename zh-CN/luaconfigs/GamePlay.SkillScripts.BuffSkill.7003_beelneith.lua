-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_7003 = class("bs_7003", LuaSkillBase)
local base = LuaSkillBase
bs_7003.config = {buffIdShield = 1148, effectId_hit = 10058, buffSilence = 1159}
bs_7003.ctor = function(self)
  -- function num : 0_0
end

bs_7003.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddSetHurtTrigger("bs_7003_2", 1, self.OnSetHurt, nil, self.caster)
  local Value = (self.caster).maxHp * (self.arglist)[1] // 1000
  LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Beelneith, Value)
  LuaSkillCtrl:CallFloatText(self.caster, 11, Value)
  self:AddTrigger(eSkillTriggerType.OnBreakShield, "bs_7003_22", 1, self.OnBreakShield)
end

bs_7003.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if context.target == self.caster and (context.skill).dataId ~= 202003 and context.isTriggerSet ~= true and (LuaSkillCtrl:GetGridsDistance((context.sender).x, (context.sender).y, (self.caster).x, (self.caster).y) > 1 or (context.sender).attackRange > 1 or (context.skill).dataId == 201903) then
    local hurt = context.hurt
    context.hurt = context.hurt * (1000 - (self.arglist)[2]) // 1000
    if ((self.caster).recordTable)["20047_root2arg1"] ~= nil and hurt > 10 then
      LuaSkillCtrl:CallEffectWithArg(context.sender, (self.config).effectId_hit, self, false, false, self.SkillEventFunc, context.sender, hurt)
    end
  end
end

bs_7003.SkillEventFunc = function(self, sender, hurt, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Create then
    LuaSkillCtrl:RemoveLife(hurt * (self.arglist)[3] // 1000, self, sender, false, false, nil, true, true)
  end
end

bs_7003.OnBreakShield = function(self, shieldType, sender, target)
  -- function num : 0_4 , upvalues : _ENV
  if target == self.caster and shieldType == eShieldType.Beelneith then
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffSilence, 1, ((self.caster).recordTable).buffTime)
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffIdShield, 0)
  end
end

bs_7003.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_7003

