-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_5006 = class("bs_5006", LuaSkillBase)
local base = LuaSkillBase
bs_5006.config = {effectIdAttack = 10301, buffId = 206}
bs_5006.ctor = function(self)
  -- function num : 0_0
end

bs_5006.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.SetHurt, "5006_1", 1, self.OnSetHurt)
end

bs_5006.PlaySkill = function(self, data, selectTargetCoord, selectRoles)
  -- function num : 0_2 , upvalues : _ENV
  return self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
end

bs_5006.CallSelectExecute = function(self, role)
  -- function num : 0_3 , upvalues : _ENV
  if role ~= nil and role ~= nil and role.belongNum ~= (self.caster).belongNum and not role.unableSelect then
    LuaSkillCtrl:CallEffect(role, (self.config).effectIdAttack, self, self.SkillEventFunc)
  end
end

bs_5006.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_4 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CallBattleCamShake(1)
    LuaSkillCtrl:CallBuff(self, target.targetRole, (self.config).buffId, 1, (self.arglist)[1])
  end
end

bs_5006.OnSetHurt = function(self, context)
  -- function num : 0_5 , upvalues : _ENV
  if (context.skill).dataId ~= 5006 and (context.target):GetBuffTier((self.config).buffId) == 1 then
    local EXhurt = context.hurt * (self.arglist)[3] // 1000
    do
      LuaSkillCtrl:StartTimer(self, 5, function()
    -- function num : 0_5_0 , upvalues : _ENV, EXhurt, self, context
    LuaSkillCtrl:RemoveLife(EXhurt, self, context.target, true)
  end
, self, 0, 0)
    end
  end
end

bs_5006.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_5006

