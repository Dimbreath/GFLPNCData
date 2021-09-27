local bs_40032 = class("bs_40032", LuaSkillBase)
local base = LuaSkillBase
bs_40032.config = {buffId_124 = 124, buffId_164 = 164, buffId_256 = 256, effectId1 = 10263, effectId2 = 10264}
bs_40032.ctor = function(self)
  -- function num : 0_0
end

bs_40032.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_40032_2", 1, self.OnSetHurt, nil, self.caster, nil, nil, eBattleRoleType.character)
end

bs_40032.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if context.target == self.caster and context.sender ~= self.caster and LuaSkillCtrl:CallRange(1, 1000) <= (self.arglist)[1] and (context.sender).roleType == 1 and (context.skill).isCommonAttack and self:IsReadyToTake() then
    self:OnSkillTake()
    context.hurt = 0
    do
      if context.sender ~= ((self.caster).recordTable).lastAttackRole then
        local grid = LuaSkillCtrl:FindEmptyGrid(function(x, y)
    -- function num : 0_2_0
    do return x >= 0 end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
        if grid ~= nil then
          LuaSkillCtrl:CallEffect(context.sender, (self.config).effectId1, self)
          LuaSkillCtrl:SetRolePos(grid, context.sender)
          LuaSkillCtrl:CallEffect(context.sender, (self.config).effectId2, self)
        end
      end
      LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_164, 1, nil, true)
      if ((self.caster).recordTable)["20039_root5arg"] then
        LuaSkillCtrl:CallBuff(self, context.sender, (self.config).buffId_256, 1, nil, true)
      else
        LuaSkillCtrl:CallBuff(self, context.sender, (self.config).buffId_164, 1, nil, true)
      end
      LuaSkillCtrl:CallBuff(self, context.sender, (self.config).buffId_124, 1, 1, true)
    end
  end
end

bs_40032.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_40032

