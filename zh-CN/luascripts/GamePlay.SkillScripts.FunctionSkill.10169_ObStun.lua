-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10169 = class("bs_10169", LuaSkillBase)
local base = LuaSkillBase
bs_10169.config = {buffId = 66, buffTier = 1, 
aoe_config = {effect_shape = 3, aoe_select_code = 4, aoe_range = 10}
, effectId = 10556}
bs_10169.ctor = function(self)
  -- function num : 0_0
end

bs_10169.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.RoleDie, "bs_10169_1", 1, self.OnRoleDie)
end

bs_10169.OnRoleDie = function(self, killer, role)
  -- function num : 0_2 , upvalues : _ENV
  if role.intensity == 0 and killer == self.caster then
    LuaSkillCtrl:CallEffect(role, (self.config).effectId, self, self.SkillEventFunc)
  end
end

bs_10169.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target, (self.config).aoe_config)
    if (skillResult.roleList).Count > 0 then
      for i = 0, (skillResult.roleList).Count - 1 do
        local role = (skillResult.roleList)[i]
        if role.belongNum == 2 then
          LuaSkillCtrl:CallBuff(self, role, (self.config).buffId, (self.config).buffTier, (self.arglist)[1])
        end
      end
    end
    do
      skillResult:EndResult()
    end
  end
end

bs_10169.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10169

