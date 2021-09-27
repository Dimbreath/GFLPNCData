local bs_101001 = class("bs_101001", LuaSkillBase)
local base = LuaSkillBase
bs_101001.config = {buffId_149 = 101001, buffId_151 = 3007, buffId_66 = 3006, audioId1 = 101004, 
heal_config = {baseheal_formula = 3021}
}
bs_101001.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_0 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_101001_btlStart", 1, self.OnAfterBattleStart)
  self:AddSetHurtTrigger("bs_101001_setHurt", 1, self.OnSetHurt, nil, self.caster)
  self:AddAfterAddBuffTrigger("bs_101001_8", 1, self.OnAfterAddBuff, self.caster)
end

bs_101001.OnAfterBattleStart = function(self)
  -- function num : 0_1 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_149, 1, nil, true)
end

bs_101001.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if context.target == self.caster and (context.sender).hp > 0 and self:IsReadyToTake() and context.sender ~= self.caster and LuaSkillCtrl:GetGridsDistance((context.sender).x, (context.sender).y, (self.caster).x, (self.caster).y) <= 1 and LuaSkillCtrl:CallRange(1, 1000) <= (self.arglist)[2] and LuaSkillCtrl:RoleContainsBuffFeature(context.sender, eBuffFeatureType.NotBeSelected) ~= true and LuaSkillCtrl:RoleContainsBuffFeature(context.sender, eBuffFeatureType.NotBeSelectedExceptSameBlong) ~= true and LuaSkillCtrl:RoleContainsBuffFeature(context.sender, eBuffFeatureType.Exiled) ~= true then
    LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId1)
    local targetX = (context.sender).x
    local targetY = (context.sender).y
    local buff = LuaSkillCtrl:CallBuff(self, context.sender, (self.config).buffId_151, 1, 3)
    if buff ~= nil and (context.sender).x == targetX and (context.sender).y == targetY then
      LuaSkillCtrl:CallBuff(self, context.sender, (self.config).buffId_66, 1, (self.arglist)[4])
    else
      LuaSkillCtrl:StartTimer(nil, 3, function()
    -- function num : 0_2_0 , upvalues : _ENV, self, context
    LuaSkillCtrl:CallBuff(self, context.sender, (self.config).buffId_66, 1, (self.arglist)[3])
  end
)
    end
    self:OnSkillTake()
  end
end

bs_101001.OnAfterAddBuff = function(self, buff, target)
  -- function num : 0_3 , upvalues : _ENV
  if LuaSkillCtrl:RoleContainsBuffFeature(target, eBuffFeatureType.Stun) and target.belongNum ~= (self.caster).belongNum then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
    LuaSkillCtrl:HealResult(skillResult, (self.config).heal_config, {(self.arglist)[5]})
    skillResult:EndResult()
  end
end

bs_101001.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_101001

