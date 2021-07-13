-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_100401 = class("bs_100401", LuaSkillBase)
local base = LuaSkillBase
bs_100401.config = {buffId_64 = 64, buffId_239 = 239, buffId_121 = 121, buffId_121_time = 30}
bs_100401.ctor = function(self)
  -- function num : 0_0
end

bs_100401.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_100401_3", 1, self.OnAfterHurt, self.caster)
  self:AddSetHurtTrigger("bs_100401_4", 1, self.OnSetHurt, self.caster, nil, nil, nil, nil, nil, 9)
  self.attackNum = 0
end

bs_100401.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if context.sender == self.caster and (context.skill).isCommonAttack then
    self.attackNum = self.attackNum + 1
    if (self.arglist)[3] <= self.attackNum then
      local grid = LuaSkillCtrl:CallFindEmptyGridNearest(self.caster)
      if grid ~= nil then
        self:CallCasterWait(999)
        LuaSkillCtrl:CallBreakAllSkill(self.caster)
        LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_121, 1, (self.config).buffId_121_time, true)
        LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_239, 1, (self.arglist)[1], true)
        LuaSkillCtrl:MoveRoleToTarget(self, grid, self.caster, false, self.OnArrive)
      end
    end
  end
end

bs_100401.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  -- function num : 0_3 , upvalues : _ENV
  if sender == self.caster and not isMiss and isCrit and (self.caster):GetBuffTier((self.config).buffId_64) > 0 then
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId_64, 0, true)
  end
end

bs_100401.OnArrive = function(self, grid, role, x, y)
  -- function num : 0_4 , upvalues : _ENV
  self:OnSkillTake()
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CancleCasterWait()
  self.attackNum = 0
  if (self.arglist)[2] >= 1 and (self.caster):GetBuffTier((self.config).buffId_64) <= 0 then
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_64, 1)
  end
end

bs_100401.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_100401

