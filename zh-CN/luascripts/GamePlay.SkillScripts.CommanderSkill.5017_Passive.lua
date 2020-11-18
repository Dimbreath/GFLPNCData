-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_5017 = class("bs_5017", LuaSkillBase)
local base = LuaSkillBase
bs_5017.config = {effectIdAttack = 10127}
bs_5017.ctor = function(self)
  -- function num : 0_0
end

bs_5017.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_5017_1", 10, self.OnAfterHurt)
end

bs_5017.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_2 , upvalues : _ENV
  if sender.belongNum == (self.caster).belongNum and skill.isCommonAttack and LuaSkillCtrl:CallRange(1, 1000) <= (self.arglist)[1] then
    LuaSkillCtrl:CallEffect(target, (self.config).effectIdAttack, self, self.SkillEventFunc)
  end
end

bs_5017.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local highAttRole = LuaSkillCtrl:CallTargetSelect(self, 31, 20)
    if highAttRole ~= nil and highAttRole.Count > 0 and highAttRole[0] ~= nil then
      local hurt = ((highAttRole[0]).targetRole).pow * 260 // 1000
      if hurt <= 0 then
        hurt = 1
      end
      LuaSkillCtrl:RemoveLife(hurt, self, target)
    end
  end
end

bs_5017.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_5017

