-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_100301 = class("bs_100301", LuaSkillBase)
local base = LuaSkillBase
bs_100301.config = {effectId_pass = 10062, effectId_hit = 10058, audioId_pass = 39}
bs_100301.ctor = function(self)
  -- function num : 0_0
end

bs_100301.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
  self:AddSetHurtTrigger("bs_100301_2", 1, self.OnSetHurt, nil, self.caster)
end

bs_100301.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if context.target == self.caster and LuaSkillCtrl:CallRange(1, 1000) <= (self.arglist)[3] and (context.skill).dataId ~= 202003 and context.isTriggerSet ~= true and (LuaSkillCtrl:GetGridsDistance((context.sender).x, (context.sender).y, (self.caster).x, (self.caster).y) > 1 or (context.sender).attackRange > 1 or (context.skill).dataId == 201903) then
    LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId_pass)
    local hurt = context.hurt
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId_pass, self)
    context.hurt = context.hurt * (1000 - (self.arglist)[1]) // 1000
    if (self.arglist)[2] > 0 then
      LuaSkillCtrl:CallEffectWithArg(context.sender, (self.config).effectId_hit, self, false, false, self.SkillEventFunc, context.sender, hurt)
    end
    self:OnSkillTake()
  end
end

bs_100301.SkillEventFunc = function(self, sender, hurt, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Create then
    local fantanhurt = hurt
    if fantanhurt < 5 then
      fantanhurt = 5
    end
    LuaSkillCtrl:RemoveLife(fantanhurt * (self.arglist)[4] // 1000, self, sender, false, false, nil, true, true)
  end
end

bs_100301.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_100301

