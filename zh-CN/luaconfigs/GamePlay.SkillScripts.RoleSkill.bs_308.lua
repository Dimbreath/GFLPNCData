-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_308 = class("bs_308", LuaSkillBase)
local base = LuaSkillBase
bs_308.config = {
aoe_config = {effect_shape = 1, aoe_select_code = 4, aoe_range = 10}
, 
hurt_config = {basehurt_formula = 10033}
, effectId1 = 10140, effectId2 = 10135, effectId3 = 10086, buffId1 = 66, buffId2 = 140, buffId3 = 130}
bs_308.ctor = function(self)
  -- function num : 0_0
end

bs_308.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_308_1", 1, self.OnSetHurt, nil, nil, (self.caster).belongNum)
end

bs_308.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if (context.sender).belongNum == (self.caster).belongNum and (context.skill).dataId ~= 308 and (context.sender):GetBuffTier((self.config).buffId2) > 0 and (self.arglist)[5] >= 0 then
    LuaSkillCtrl:RemoveLife(context.hurt * 500 // 1000, self, context.target)
  end
end

bs_308.PlaySkill = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId3, self)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 1001, 10)
  if targetList.Count == 0 then
    return 
  end
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  ;
  (self.caster):LookAtTarget((targetList[0]).targetRole)
  self:CallCasterWait(30)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, (targetList[0]).targetRole, data)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1002, 1, 20, attackTrigger)
end

bs_308.OnAttackTrigger = function(self, target, data)
  -- function num : 0_4 , upvalues : _ENV
  LuaSkillCtrl:CallEffect(target, (self.config).effectId1, self)
  LuaSkillCtrl:StartTimer(self, 5, self.callback, self, 0)
end

bs_308.callback = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster, (self.config).aoe_config)
  skillResult:BuffResult((self.config).buffId3, 1, 10)
  LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config)
  skillResult:EndResult()
  LuaSkillCtrl:StartTimer(self, 10, function()
    -- function num : 0_5_0 , upvalues : _ENV, self
    local skillResult2 = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster, (self.config).aoe_config)
    skillResult2:BuffResult((self.config).buffId1, 1, (self.arglist)[1])
  end
, self, 0)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 28, 10)
  if targetList.Count == 0 then
    return 
  end
  for i = 1, targetList.Count - 1 do
    LuaSkillCtrl:CallBuff(self, (targetList[i]).targetRole, (self.config).buffId2, 1, (self.arglist)[4])
  end
end

bs_308.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_308

