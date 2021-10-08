local bs_5022 = class("bs_5022", LuaSkillBase)
local base = LuaSkillBase
bs_5022.config = {buffId = 502101, playerInvisibleBuff = 3004}
bs_5022.AbandonTakeFeature = {eBuffFeatureType.BeatBack, eBuffFeatureType.KnockOff, eBuffFeatureType.Stun, eBuffFeatureType.Exiled, eBuffFeatureType.CtrlImmunity}
bs_5022.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_0 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterBuffRemoveTrigger("bs_5022_buff_die", 1, self.AfterBuffRemove, nil, nil, (self.config).buffId)
end

bs_5022.PlaySkill = function(self, data, selectTargetCoord, selectRoles)
  -- function num : 0_1 , upvalues : _ENV
  return self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
end

bs_5022.CallSelectExecute = function(self, role)
  -- function num : 0_2 , upvalues : _ENV
  if role ~= nil and role.belongNum ~= eBattleRoleBelong.neutral then
    LuaSkillCtrl:CallBuff(self, role, (self.config).buffId, 1, (self.arglist)[1])
  end
end

bs_5022.AfterBuffRemove = function(self, buffId, target, removeType)
  -- function num : 0_3 , upvalues : _ENV
  if target.hp <= 0 then
    return 
  end
  if target.belongNum == eBattleRoleBelong.player then
    LuaSkillCtrl:CallBuff(self, target, (self.config).playerInvisibleBuff, 1, (self.arglist)[2], true)
  end
  LuaSkillCtrl:CallRedisplayInSkillInputCtrl(target)
end

bs_5022.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_5022

