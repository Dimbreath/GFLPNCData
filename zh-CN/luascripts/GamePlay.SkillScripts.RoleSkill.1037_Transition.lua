-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1037 = class("bs_1037", LuaSkillBase)
local base = LuaSkillBase
bs_1037.config = {buffId = 117, audioId1 = 32}
bs_1037.ctor = function(self)
  -- function num : 0_0
end

bs_1037.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.SetHurt, "bs_1037_2", 1, self.OnSetHurt)
end

bs_1037.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if context.target == self.caster and self:IsReadyToTake() and context.hurt ~= 0 then
    context.hurt = context.hurt * (1000 - (self.arglist)[1]) // 1000
    if context.hurt < 0 then
      context.hurt = 0
    end
    local grid = LuaSkillCtrl:FindEmptyGrid(function(x, y)
    -- function num : 0_2_0
    do return x <= 2 end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    if grid ~= nil then
      LuaSkillCtrl:CallEffect(self.caster, 10031, self)
      LuaSkillCtrl:CallBreakAllSkill(self.caster)
      LuaSkillCtrl:SetRolePos(grid, self.caster)
      LuaSkillCtrl:CallBuff(self, self.caster, 50, 1, 15)
      LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.arglist)[3], (self.arglist)[4])
      LuaSkillCtrl:CallEffect(self.caster, 10032, self)
      self:OnSkillTake()
      if (self.config).audioId1 ~= nil then
        ((self.caster).auSource):PlayAudioById((self.config).audioId1)
      end
    end
  end
end

bs_1037.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_1037

