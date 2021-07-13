-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_100701 = class("bs_100701", LuaSkillBase)
local base = LuaSkillBase
bs_100701.config = {buffId_243 = 243, 
HurtConfig = {hit_formula = 0, basehurt_formula = 10031, crit_formula = 0, crithur_ratio = 0}
}
bs_100701.ctor = function(self)
  -- function num : 0_0
end

bs_100701.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
  self:AddAfterHurtTrigger("bs_100701_3", 1, self.OnAfterHurt, self.caster, nil, nil, nil, nil, nil, 3)
end

bs_100701.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and skill.dataId == 3 and not isMiss then
    local targets = (self:GetBehindTargetsPos(2, (self.caster).x, (self.caster).y, target.x, target.y))
    local targetNext = nil
    if targets ~= nil and (table.length)(targets) >= 2 and (targets[2]).belongNum ~= (self.caster).belongNum then
      targetNext = targets[2]
    end
    do
      if targetNext ~= nil then
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetNext)
        LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig)
        skillResult:EndResult()
        if (self.arglist)[2] > 0 then
          LuaSkillCtrl:CallBuff(self, targetNext, (self.config).buffId_243, 1, (self.arglist)[3])
        end
      end
      if (self.arglist)[2] > 0 then
        LuaSkillCtrl:CallBuff(self, target, (self.config).buffId_243, 1, (self.arglist)[3])
      end
    end
  end
end

bs_100701.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_100701

