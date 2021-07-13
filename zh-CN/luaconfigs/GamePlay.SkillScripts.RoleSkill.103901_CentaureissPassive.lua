-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_103901 = class("bs_103901", LuaSkillBase)
local base = LuaSkillBase
bs_103901.config = {buffId_151 = 151, buffId_66 = 66, 
hurt_config = {hit_formula = 0, basehurt_formula = 10079, crit_formula = 0, crithur_ratio = 0}
}
bs_103901.ctor = function(self)
  -- function num : 0_0
end

bs_103901.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_103901_3", 1, self.OnAfterHurt, self.caster)
  self.attackNum = 0
end

bs_103901.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if skill.isCommonAttack then
    self.attackNum = self.attackNum + 1
  end
  if (self.arglist)[1] <= self.attackNum and target.intensity ~= 0 then
    self.attackNum = 0
    local targetX = target.x
    local targetY = target.y
    local buff = LuaSkillCtrl:CallBuffLifeEvent(self, target, (self.config).buffId_151, 1, 3, BindCallback(self, self.OnBuffLifeEvent, target))
    if buff ~= nil and target.x == targetX and target.y == targetY then
      LuaSkillCtrl:CallBuff(self, target, (self.config).buffId_66, 1, (self.arglist)[2])
      if (self.arglist)[3] > 0 then
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
        LuaSkillCtrl:PlayAuHit(self, target)
        LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config)
        skillResult:EndResult()
      end
    else
      do
        LuaSkillCtrl:StartTimer(nil, 3, function()
    -- function num : 0_2_0 , upvalues : _ENV, self, target
    LuaSkillCtrl:CallBuff(self, target, (self.config).buffId_66, 1, (self.arglist)[2])
  end
)
      end
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

