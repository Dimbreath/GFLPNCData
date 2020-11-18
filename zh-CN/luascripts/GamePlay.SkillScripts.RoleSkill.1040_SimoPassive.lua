-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1040 = class("bs_1040", LuaSkillBase)
local base = LuaSkillBase
bs_1040.config = {buffId = 64, buffId1 = 50}
bs_1040.ctor = function(self)
  -- function num : 0_0
end

bs_1040.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_1040_3", 1, self.OnAfterHurt)
  self.attackNum = 0
end

bs_1040.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and not isMiss then
    if skill.isCommonAttack then
      self.attackNum = self.attackNum + 1
      if (self.arglist)[3] <= self.attackNum then
        local grid = LuaSkillCtrl:FindEmptyGrid(function(x, y)
    -- function num : 0_2_0
    do return x <= 2 end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
        if grid ~= nil then
          LuaSkillCtrl:CallBreakAllSkill(self.caster)
          LuaSkillCtrl:CallBuff(self, self.caster, 121, 1, 30)
          LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId1, 1, (self.arglist)[1])
          LuaSkillCtrl:MoveRoleToTarget(self, grid, self.caster, true, self.OnArrive)
        end
      end
    end
    do
      if isCrit and (self.caster):GetBuffTier((self.config).buffId) > 0 then
        LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0)
      end
    end
  end
end

bs_1040.OnArrive = function(self, grid, role, x, y)
  -- function num : 0_3 , upvalues : _ENV
  self:OnSkillTake()
  self.attackNum = 0
  if (self.arglist)[2] == 1 and (self.caster):GetBuffTier((self.config).buffId) <= 0 then
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, 1)
  end
end

bs_1040.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_1040

