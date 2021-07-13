-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_100601 = class("bs_100601", LuaSkillBase)
local base = LuaSkillBase
bs_100601.config = {buffId_50 = 50, audioId1 = 32, effectId_up = 10031, effectId_down = 10032, buff_50_time = 15, buffId_115 = 115, 
HurtConfig = {hit_formula = 0, basehurt_formula = 10079, crit_formula = 0, crithur_ratio = 0}
, effectId_ex = 10027}
bs_100601.ctor = function(self)
  -- function num : 0_0
end

bs_100601.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
  self:AddSetHurtTrigger("bs_100601_2", 1, self.OnSetHurt, nil, self.caster)
end

bs_100601.OnSetHurt = function(self, context)
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
      self:OnSkillTake()
      if (self.arglist)[2] > 0 then
        LuaSkillCtrl:CallBuff(self, context.sender, (self.config).buffId_115, 1, (self.arglist)[3])
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, context.sender)
        LuaSkillCtrl:PlayAuHit(self, context.sender)
        LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig, nil, false)
        skillResult:EndResult()
        LuaSkillCtrl:CallEffect(context.sender, (self.config).effectId_ex, self)
      end
      do
        LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId_up, self)
        LuaSkillCtrl:CallBreakAllSkill(self.caster)
        LuaSkillCtrl:SetRolePos(grid, self.caster)
        LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_50, 1, (self.config).buff_50_time, true)
        LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId_down, self)
        LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId1)
      end
    end
  end
end

bs_100601.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_100601

