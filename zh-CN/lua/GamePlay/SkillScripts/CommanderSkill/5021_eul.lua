local bs_5021 = class("bs_5021", LuaSkillBase)
local base = LuaSkillBase
bs_5021.config = {buffId = 502101}
bs_5021.AbandonTakeFeature = {eBuffFeatureType.BeatBack, eBuffFeatureType.KnockOff, eBuffFeatureType.Stun, eBuffFeatureType.Exiled, eBuffFeatureType.CtrlImmunity}
bs_5021.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_0 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_5021.PlaySkill = function(self, data, selectTargetCoord, selectRoles)
  -- function num : 0_1 , upvalues : _ENV
  return self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
end

bs_5021.CallSelectExecute = function(self, role)
  -- function num : 0_2 , upvalues : _ENV
  if role ~= nil and role.belongNum ~= eBattleRoleBelong.neutral then
    LuaSkillCtrl:CallBuff(self, role, (self.config).buffId, 1, (self.arglist)[1])
  end
end

bs_5021.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_5021

