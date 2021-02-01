-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_103901 = class("bs_103901", LuaSkillBase)
local base = LuaSkillBase
bs_103901.config = {beatBackBuff = 151, stunBuff = 66, effectId = 10464, 
hurt_config = {basehurt_formula = 10079}
}
bs_103901.ctor = function(self)
  -- function num : 0_0
end

bs_103901.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterHurt, "bs_103901_3", 1, self.OnAfterHurt)
end

bs_103901.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and skill.isCommonAttack and LuaSkillCtrl:CallRange(1, 1000) <= (self.arglist)[1] and not isMiss and target.intensity ~= 0 then
    local targetX = target.x
    local targetY = target.y
    local buffCheck = LuaSkillCtrl:CallBuffLifeEvent(self, target, (self.config).beatBackBuff, 1, 3, BindCallback(self, self.OnBuffLifeEvent, target))
    LuaSkillCtrl:CallBuff(self, target, (self.config).stunBuff, 1, (self.arglist)[2])
    if (self.arglist)[3] == 1 and buffCheck ~= nil and target.x == targetX and target.y == targetY then
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config)
      skillResult:EndResult()
    end
  end
end

bs_103901.OnBuffLifeEvent = function(self, role, lifeType, arg)
  -- function num : 0_3 , upvalues : _ENV
  if lifeType == eBuffLifeEvent.NewAdd then
    LuaSkillCtrl:CallStartLocalScale(role, (Vector3.New)(1.2, 1.2, 0.8), 0.2)
    LuaSkillCtrl:StartTimer(nil, 3, function()
    -- function num : 0_3_0 , upvalues : _ENV, role
    LuaSkillCtrl:CallStartLocalScale(role, (Vector3.New)(1, 1, 1), 0.2)
  end
)
  end
end

bs_103901.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_103901

