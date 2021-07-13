-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_100101 = class("bs_100101", LuaSkillBase)
local base = LuaSkillBase
bs_100101.config = {effectId_line = 10764, effectId_PassHit = 10345, 
heal_config = {baseheal_formula = 10087}
, selectId = 20, selectRange = 10}
bs_100101.ctor = function(self)
  -- function num : 0_0
end

bs_100101.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
  self:AddSetDeadHurtTrigger("bs_100101_1", 99, self.OnSetDeadHurt, nil, nil, nil, (self.caster).belongNum, nil, 1)
end

bs_100101.OnSetDeadHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if self:IsReadyToTake() and (context.target).belongNum == (self.caster).belongNum and (context.target).roleType == 1 then
    context.hurt = 0
    LuaSkillCtrl:CallFloatText(self.caster, 7)
    LuaSkillCtrl:CallEffectWithArg(context.target, (self.config).effectId_line, self, false, false, self.SkillEventFunc)
    do
      if (self.arglist)[2] > 0 then
        local targetList = LuaSkillCtrl:CallTargetSelect(self, (self.config).selectId, (self.config).selectRange, context.target)
        if targetList.Count ~= 0 then
          LuaSkillCtrl:CallEffectWithArgOverride(targetList[0], (self.config).effectId_line, self, context.target, false, false, self.SkillEventFunc)
        end
      end
      self:OnSkillTake()
    end
  end
end

bs_100101.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if effect.dataId == (self.config).effectId_line and eventId == eBattleEffectEvent.Create then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HealResult(skillResult, (self.config).heal_config, nil, false, false)
    skillResult:EndResult()
    LuaSkillCtrl:CallEffect(target, (self.config).effectId_PassHit, self)
  end
end

bs_100101.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_100101

