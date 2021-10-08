local bs_203206 = class("bs_203206", LuaSkillBase)
local base = LuaSkillBase
bs_203206.config = {buff_doubleAttack = 1121, buffId_198 = 198}
bs_203206.ctor = function(self)
  -- function num : 0_0
end

bs_203206.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_203206_1", 1, self.OnAfterBattleStart)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_203206_2", 1, self.AfterPlaySkill)
end

bs_203206.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_198, 1, nil, true)
  self.timer203206 = LuaSkillCtrl:StartTimer(nil, (self.arglist)[1], function()
    -- function num : 0_2_0 , upvalues : _ENV, self
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
    if targetlist.Count < 1 then
      return 
    end
    for i = 0, targetlist.Count - 1 do
      local target = (targetlist[i]).targetRole
      if target.belongNum == (self.caster).belongNum and target.camp == (self.caster).camp then
        LuaSkillCtrl:CallBuff(self, target, (self.config).buff_doubleAttack, 1)
      end
    end
  end
, self, -1)
end

bs_203206.AfterPlaySkill = function(self, skill, role)
  -- function num : 0_3 , upvalues : _ENV
  if skill.isCommonAttack and role.belongNum == (self.caster).belongNum and role.camp == (self.caster).camp then
    local restTier = role:GetBuffTier((self.config).buff_doubleAttack)
    if restTier > 0 then
      LuaSkillCtrl:DispelBuff(self.caster, (self.config).buff_doubleAttack, 0, true)
    end
  end
end

bs_203206.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
  if self.timer203206 ~= nil then
    (self.timer203206):Stop()
    self.timer203206 = nil
  end
end

return bs_203206

