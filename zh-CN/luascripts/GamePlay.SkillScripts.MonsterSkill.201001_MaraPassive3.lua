-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_40032 = class("bs_40032", LuaSkillBase)
local base = LuaSkillBase
bs_40032.config = {buffId = 164, effectId = 10240, buffId124 = 124}
bs_40032.ctor = function(self)
  -- function num : 0_0
end

bs_40032.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.SetHurt, "bs_40032_2", 1, self.OnSetHurt)
end

bs_40032.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if context.target == self.caster and context.sender ~= self.caster and LuaSkillCtrl:CallRange(1, 1000) <= (self.arglist)[1] and (context.sender).roleType == 1 and (context.skill).isCommonAttack then
    context.hurt = 0
    local grid = LuaSkillCtrl:FindEmptyGrid(function(x, y)
    -- function num : 0_2_0
    do return x >= 0 end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    if grid ~= nil then
      LuaSkillCtrl:CallEffect(context.sender, 10263, self)
      LuaSkillCtrl:SetRolePos(grid, context.sender)
      LuaSkillCtrl:CallEffect(context.sender, 10264, self)
    end
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, 1, nil, true)
    LuaSkillCtrl:CallBuff(self, context.sender, (self.config).buffId, 1, nil, true)
    LuaSkillCtrl:CallBuff(self, context.sender, (self.config).buffId124, 1, 1, true)
  end
end

bs_40032.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_40032

